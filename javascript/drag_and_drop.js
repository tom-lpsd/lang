window.onload = function () {
    var console = new Console(200,100);
    console.writeln("foo");

    var box = document.createElement('div');
    box.innerHTML = "This is draggable object.";
    box.style.backgroundColor = 'yellow';
    box.style.width = 100;
    box.style.height = 100;
    box.style.position = 'absolute';
    box.style.borderWidth = 1;
    box.style.borderStyle = 'solid';
    box.style.padding = 10;

    var html = document.getElementsByTagName('html')[0];
    box.onmousedown = function (event) {
	box.x = event.layerX;
	box.y = event.layerY;
	html.onmousemove = function (event) {
	    box.style.top = event.pageY - box.y;
	    box.style.left = event.pageX - box.x;
	};
    };
    html.onmouseup = function () {
	html.onmousemove = null;
    };

    var body = document.getElementsByTagName('body')[0];
    body.appendChild(box);
};

function Console (x, y) {
    var console = document.createElement('pre');
    console.style.width = x || 400;
    console.style.height = y || 300;
    console.style.color = 'yellow';
    console.style.backgroundColor = 'black';
    console.style.overflow = 'auto';
    console.innerHTML = '$ ';
    document.getElementsByTagName('body')[0].appendChild(console);
    this.elem = console;
};

Console.prototype.writeln = function (str) {
    var console = this.elem;
    console.innerHTML += str + '\n$ ';
    console.scrollTop += console.style.height;
};


function string_of_props(e) { // for debugging
    var str = "";
    for (var i in e) {
	str += i + " ";
    }
    return str;
}
