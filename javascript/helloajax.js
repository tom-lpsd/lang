function hello() {
    //    var request = new ActiveXObject("Msxml2.XMLHTTP"); // IEはこっち．
    var request = new XMLHttpRequest();
    request.open("GET","hello.txt",true);
    request.onreadystatechange = function() {
	if(request.readyState == 4) {
	    document.getElementById('message').innerHTML = request.responseText;
	}
    }
    request.send(null);
}