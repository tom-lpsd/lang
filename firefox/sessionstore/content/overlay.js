var gSessionStore = {

_dir : null,

init : function () 
{
    var dirSvc = Components.classes['@mozilla.org/file/directory_service;1']
                 .getService(Components.interfaces.nsIProperties);
    this._dir = dirSvc.get("ProfD", Components.interfaces.nsILocalFile);
    this._dir.append("sessionstore");
    if(!this._dir.exists())
	this._dir.create(this._dir.DIRECTORY_TYPE, 0700);
},

uninit : function()
{
    this._dir = null;
},

save : function(event)
{
    event.stopPropagation();
    var ss = Components.classes['@mozilla.org/browser/sessionstore;1']
             .getService(Components.interfaces.nsISessionStore);
    var state = ss.getBrowserState();
    var fileName = "session_" + Date.now() + ".js";
    var file = this._dir.clone();
    file.append(fileName);
    this._writeFile(file, state);
},

restore : function(event)
{
    var fileName = event.target.getAttribute("fileName");
    var file = this._dir.clone();
    file.append(fileName);
    var state = this._readFile(file);
    var ss = Components.classes['@mozilla.org/browser/sessionstore;1']
             .getService(Components.interfaces.nsISessionStore);
    ss.setWindowState(window, state, true);
},

clear : function(event)
{
    event.preventBubble();
    var prefSvc = Components.classes['@mozilla.org/preferences-service;1']
                  .getService(Components.interfaces.nsIPrefService);
    var prefBranch = prefSvc.getBranch("extensions.sessionstore.");
    if (prefBranch.getBoolPref("warnOnClear") == true) {
	if (window.confirm("Really?") == false)
	    return;
    }
    var fileEnum = this._dir.directoryEntries;
    while (fileEnum.hasMoreElements()) {
	var file = fileEnum.getNext().QueryInterface(Components.interfaces.nsIFile);
	file.remove(false);
	dump("SessionStore> clear: " + file.leafName + "\n");
    }
},

createMenu : function(event) 
{
    var menupopup = event.target;
    for (var i = menupopup.childNodes.length -1; i>=0; i--) {
	var node = menupopup.childNodes[i];
	if (node.hasAttribute("fileName"))
	    menupopup.removeChild(node);
    }
    var fileEnum = this._dir.directoryEntries;
    while (fileEnum.hasMoreElements()) {
	var file = fileEnum.getNext().QueryInterface(Components.interfaces.nsIFile);
	var re = new RegExp("^session_(\\d+)\.js$");
	if (!re.test(file.leafName))
	    continue;
	var dateTime = new Date(parseInt(RegExp.$1, 10)).toLocaleString();
	var menuitem = document.createElement("menuitem");
	menuitem.setAttribute("label", dateTime);
	menuitem.setAttribute("fileName", file.leafName);
	menupopup.insertBefore(menuitem, menupopup.firstChild.nextSibling.nextSibling);
    }
},

_readFile : function(aFile) 
{
    try {
	var stream = Components.classes['@mozilla.org/network/file-input-stream;1'].
	           createInstance(Components.interfaces.nsIFileInputStream);
	stream.init(aFile, 0x01, 0, 0);
	var cvstream = Components.classes['@mozilla.org/intl/converter-input-stream;1'].
	              createInstance(Components.interfaces.nsIConverterInputStream);
	cvstream.init(stream, "UTF-8", 1024, Components.interfaces.nsIConverterInputStream.DEFAULT__REPLACEMENT_CHARACTER);
	var content = "";
	var data = {};
	while (cvstream.readString(4096, data)) {
	    content += data.value;
	}
	cvstream.close();
	return content.replace(/\r\n?/g, "\n");
    }

    catch (ex) { }
    return null;
},

_writeFile : function(aFile, aData) 
{
    var stream = Components.classes['@mozilla.org/network/safe-file-output-stream;1'].
	           createInstance(Components.interfaces.nsIFileOutputStream);
    stream.init(aFile, 0x02 | 0x08 | 0x02, 0600, 0);
    var converter = Components.classes['@mozilla.org/intl/scriptableunicodeconverter'].
                    createInstance(Components.interfaces.nsIScriptableUnicodeConverter);
    converter.charset = "UTF-8";
    var convertedData = converter.ConvertFromUnicode(aData);
    convertedData += converter.Finish();
    stream.write(convertedData, convertedData.length);
    if (stream instanceof Components.interfaces.nsISafeOutputStream) {
	stream.finish();
    }
    else {
	stream.close();
    }
}

};

window.addEventListener(
    "load",
    function(){ gSessionStore.init(); },
    false);

window.addEventListener(
    "unload",
    function(){ gSessionStore.uninit(); },
    false);
