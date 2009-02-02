var Hello = {
    init : function() { },
    hello : function() {
	var hxp = Components.classes['@tom-lpsd.dyndns.org/helloXPCOM;1'].getService(Components.interfaces.nsIHelloXPCOM);
	alert(hxp.hello());
    }
};


