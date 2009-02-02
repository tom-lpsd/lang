function Console (x, y) {
    var console = document.createElement('pre');
    console.style.width = x || 400;
    console.style.height = y || 300;
    console.style.color = 'yellow';
    console.style.backgroundColor = 'black';
    console.style.overflow = 'auto';
    console.innerHTML = '';
    document.getElementsByTagName('body')[0].appendChild(console);
    this.elem = console;
};

Console.prototype.writeln = function (str) {
    var console = this.elem;
    console.innerHTML += str + '\n';
    console.scrollTop += console.style.height;
};

Console.prototype.write = function (str) {
    var console = this.elem;
    console.innerHTML += str;
    console.scrollTop += console.style.height;
};

function string_of_props(e) { // for debugging
    var str = "";
    for (var i in e) {
	str += i + " ";
    }
    return str;
}

var console = null;
function print(str) {
    if (console == null) {
	console = new Console(500, 500);
    }
    console.writeln(str);
}
