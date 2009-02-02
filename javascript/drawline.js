var prev;
var body;
var elems = [];
var ix = 0;
var num = 2000;

window.onload = function () {
    var html = document.getElementsByTagName('html')[0];
    html.onmousedown = function () {
	html.onmouseup = function () {
	    html.onmousemove = null;
	    prev = null;
	}
	html.onmousemove = function (event) {
	    var point = [event.pageX, event.pageY];
	    if (prev != null) {
		drawline(prev, point);
	    }
	    prev = point;
	};
    };
    body = document.getElementsByTagName('body')[0];
    for (var i=0;i<num;i++) {
	var pix = document.createElement('div');
	elems.push(pix);
	with (pix.style) {
	    width = 3;
	    height = 3;	
	    position = 'absolute';
	    backgroundColor = 'black';
	}
    }
};

function drawpixel (point) {
    var index = ix++%num;
    elems[index].style.top = point[1];
    elems[index].style.left = point[0];
    body.appendChild(elems[index]);
}

function drawline (start, end) {
    var xdist = start[0] - end[0];
    var ydist = start[1] - end[1];
    var distance = Math.sqrt(xdist*xdist+ydist*ydist);
    var samples = distance/1;
    var xunit = xdist/samples;
    var yunit = ydist/samples;
    for (var i=0;i<parseInt(samples);i++) {
	drawpixel(start);
	start[0] -= xunit;
	start[1] -= yunit;
    }
}
