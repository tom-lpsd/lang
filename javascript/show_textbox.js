window.onload = function () {
    var html = document.getElementsByTagName('html')[0];
    var body = document.getElementsByTagName('body')[0];

    html.onmousedown = function (event) {
	var text = document.createElement('textarea');
	var bbox = document.createElement('div');
	var button = document.createElement('input');
	var form = document.createElement('form');	

	form.style.position = 'absolute';
	form.x = event.layerX;
	form.y = event.layerY;
	form.style.top = event.pageY;
	form.style.left = event.pageX;
	form.appendChild(text);
	form.appendChild(bbox);

	text.style.backgroundColor = 'yellow';
	bbox.style.textAlign = 'right';
	bbox.appendChild(button);
	button.type = "button";
	button.value = "fix";
	button.onclick = function () {
	    fix(form);
	};
	
	html.onmousemove = function (event) {
	    if (!form.e) {
		body.appendChild(form);
		form.e = true;
	    }
	    var x = event.pageX - form.x;
	    var y = event.pageY - form.y;
	    if (x < 0) {
		form.style.left = event.pageX;
		text.style.width = -x;
	    } else {
		text.style.width = x;
	    }
	    if (y < 0) {
		form.style.top = event.pageY;
		text.style.height = -y;
	    } else {
		text.style.height = y;
	    }
	};
	html.onmouseup = function () {
	    html.onmousemove = null;
	};
    };
};

function fix(form) {
    var body = document.getElementsByTagName('body')[0];
    var div = document.createElement('div');
    var tbox = form.firstChild;
    div.innerHTML = tbox.value;
    with (div.style) {
	position = 'absolute';
	borderStyle = 'solid';
	borderWidth = 1;
	backgroundColor = "yellow";
	top = form.style.top;
	left = form.style.left;
	width = tbox.style.width;
	height = tbox.style.height;
	overflow = 'auto';
    }
    body.removeChild(form);
    body.appendChild(div);
}
