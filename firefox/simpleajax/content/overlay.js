var SimpleAjax = {
    openDialog : function() {
	window.openDialog('chrome://simpleajax/content/dialog.xul',
			  "Dialog", "chrome,centerscreen,modal");
    },

    bind : function(func,param) {
	return function() {
	    func(param);
	};
    },

    send : function(message) {
	var send = function(message) {
	    var req = new XMLHttpRequest;
	    req.open("POST", "http://localhost/~tom/echo.cgi", true);
	    req.onreadystatechange = function() {
		if (req.readyState == 4) {
		    if (req.status == 200) {
			var text = req.responseText.replace(/\n*$/, "");
			alert("Server reponse is \"" + text + "\".");
		    }
		}	    
	    };
	    req.send(message);
	};
	window.setTimeout(this.bind(send,message), 0);
    }
};
