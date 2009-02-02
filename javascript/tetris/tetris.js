window.addEventListener("load", function() { Tetris.onload(); }, false);

var BlockModels = [ { shape: [[1,1,1,1]], color : "red"},
		    { shape: [[1,1,0],[0,1,1]], color : "blue"},
		    { shape: [[0,1,1],[1,1,0]], color : "yellow"},
		    { shape: [[1,1,1],[0,1,0]], color : "green" },
		    { shape: [[1,1,1],[0,0,1]], color : "violet" },
		    { shape: [[1,1],[1,1]], color : "orange" },
		    { shape: [[1,1,1],[1,0,0]], color : "gray"} ];

var BlockProperties = {
    width : '19px',
    height : '19px',
    position : 'absolute',
    borderColor : 'black',
    borderStyle : 'solid',
    borderWidth : '1px'
};

var FrameProperties = {
    horizontalNum : 10,
    verticalNum : 25
};

function Frame() {
    var p = FrameProperties;
    var div = document.createElement('div');
    Object.extend(div.style, {
	        position : "absolute",
		width : (p.horizontalNum * 20 + 1) + 'px',
		height : (p.verticalNum * 20 + 1) + 'px',
		borderStyle : 'double',
		borderWidth : '3px'
		});
    this.element = div;
    this.values = new Array(p.verticalNum);
    for (var i=0, l=p.verticalNum;i<l;++i) {
	this.values[i] = new Array(p.horizontalNum);
    }
}

Object.extend(Frame.prototype, {
    putBlocks : function (blocks) {
        for (var i=0, l=blocks.es.length;i<l;++i) {
	    this.element.appendChild(blocks.es[i].e);
        }
    },
    colisionp : function(blocks, dx, dy) {
        var fp = FrameProperties;
	for (var i=0, l=blocks.es.length;i<l;++i) {
	    var x = blocks.es[i].x + dx;
	    var y = blocks.es[i].y + dy;
	    if (x >= fp.horizontalNum || y >= fp.verticalNum ||
		x < 0 || y < 0) {
		return true;
	    }
	    else if (this.values[y][x]) {
		return true;
	    }
	}
	return false;
    },
    colisionp2 : function(x, y) {
        var fp = FrameProperties;
	if (x >= fp.horizontalNum || y >= fp.verticalNum ||
	    x < 0 || y < 0) {
	    return true;
	}
	else if (this.values[y][x]) {
	    return true;
	}
	return false;
    },
    fixBlocks : function(blocks) {
	var checklist = [];
	for (var i=0, l=blocks.es.length;i<l;++i) {
	    var x = blocks.es[i].x;
	    var y = blocks.es[i].y;
	    this.values[y][x] = blocks.es[i];
	    checklist.push(y);
	}
	checklist = checklist.uniq();
	var deletelist = [];
	for (i=0,l=checklist.length;i<l;++i) {
	    if (this.checkRow(checklist[i])) {
		deletelist.push(checklist[i]);
	    }
	}
	this.deleteRows(deletelist);
    },
    checkRow : function(index) {
	for (var i=0, l=this.values[index].length;i<l;i++) {
	    if (!this.values[index][i]) {
		return false;
	    }
	}
	return true;
    },
    deleteRows : function(indexes) {
	indexes.sort();
	for (var i=0,l=indexes.length;i<l;++i) {
	    for (var j=0,ll=this.values[indexes[i]].length;j<ll;++j) {
		this.element.removeChild(this.values[indexes[i]][j].e);
	    }
	}
	var d = indexes.length;
	var dp = d - 2, dd = 1;
	for (i=indexes[d-1];i>=d;--i) {
	    if (dp >= 0) {
		while ((i-dd)==indexes[dp]) {
		    --dp;
		    ++dd;
		}
	    }
	    for (j=0;j<this.values[i].length;++j) {
		if (this.values[i-dd][j]) {
		    this.values[i-dd][j].move(0,dd);
		    this.values[i][j] = this.values[i-dd][j];
		}
		else {
		    this.values[i][j] = null;
		}
	    }
	}
	for (i=0;i<d;++i) {
	    for (j=0;j<this.values[i].length;++j) {
		this.values[i][j] = null;
	    }
	}
    }
});

function Block(color, x, y) {
    this.e = document.createElement('div');
    this.x = x; this.y = y;
    Object.extend(this.e.style, BlockProperties);
    this.e.style.backgroundColor = color;
    this.e.style.top = (y * 20) + 'px';
    this.e.style.left = (x * 20) + 'px';
}

Object.extend(Block.prototype, {
    getElement : function () {
        return this.e;
    },
    move : function(dx, dy) {
	this.y += dy; this.x += dx;
	this.e.style.top = (this.y * 20) + 'px';
	this.e.style.left = (this.x * 20) + 'px';
    }
});

function Blocks(model, x, y) {
    var shape = model.shape;
    this.model = model;
    this.es = [];
    if (!x && x!=0) { 
	x = Math.floor(FrameProperties.horizontalNum/2
		       - (model.shape[0].length/2)); 
    }
    if (!y && y!=0) { 
	y = 0; 
    }
    for (var i=0, l=shape.length; i<l; ++i) {
	for (var j=0, ll=shape[i].length; j<ll; ++j) {
	    if (shape[i][j]) {
		var block = new Block(model.color, x+j, y+i);
		this.es.push(block);
	    }
	}
    }
}

Blocks.prototype.move = function (dx, dy) {
    for (var i=0, l=this.es.length;i<l;++i) {
	this.es[i].move(dx, dy);
    }
};

Blocks.prototype.rotate = function(frame) {
    var col = this.model.shape[0].length;
    var row = this.model.shape.length;

    var model = new Array(col);
    for (var i=0;i<col;++i) {
	model[i] = new Array(row);
	for (var j=0;j<row;++j) {
	    model[i][j] = this.model.shape[j][col-i-1];
	}
    }

    var x = 0, y=0;
    for (i=0;i<this.es.length;++i) {
	x += this.es[i].x + 1;
	y += this.es[i].y + 1;
    }
    x = x/this.es.length;
    y = y/this.es.length;

    var needs = [];
    for (i=0;i<col;++i) {
	for (j=0;j<row;++j) {
	    if (model[i][j]) {
		var nx = Math.round(x+j-model[0].length/2-1);
		var ny = Math.round(y+i-model.length/2-1);
		if (frame.colisionp2(nx, ny)) {
		    return;
		}
		needs.push({x:nx, y:ny});
	    }
	}
    }

    this.model.shape = model;
    for (i=0;i<needs.length;++i) {
	this.es[i].x = needs[i].x;
	this.es[i].y = needs[i].y;
	this.es[i].e.style.left = (needs[i].x * 20) + 'px';
	this.es[i].e.style.top = (needs[i].y * 20) + 'px';
    }
};

var Tetris = {

    onload : function() {
	var body = document.getElementsByTagName('body')[0];
	var frame = new Frame;
	this.frame = frame;
	body.appendChild(frame.element);
	this.genBlocks();
//	Event.observe(document, "keypress", function(e) {Tetris.keyObserver(e);});
	document.addEventListener("keypress", function(e) {Tetris.keyObserver(e);}, false);
	if (Prototype.Browser.WebKit) {
	    Event.KEY_LEFT = 63234;
	    Event.KEY_RIGHT = 63235;
	    Event.KEY_UP = 63232;
	    Event.KEY_DOWN = 63233;
	}
	this.executer = new PeriodicalExecuter(this.dropBlocks.bind(this), 0.5);
    },

    keyObserver : function(e) {
	var frame = this.frame;
	var blocks = this.curr;
	var dx = 0, dy = 0;

	switch(e.keyCode) {
	case Event.KEY_LEFT:
	    dx = -1; break;
	case Event.KEY_RIGHT:
	    dx = 1; break;
	case Event.KEY_DOWN:
	    dy = 1; break;
	case Event.KEY_UP:
	    blocks.rotate(frame);
	}
	if (!frame.colisionp(blocks, dx, dy)) {
	    blocks.move(dx, dy);
	}
    },

    genBlocks : function() {
	var index = ~~(Math.random()*BlockModels.length);
	var blocks = new Blocks(BlockModels[index]);
	this.curr = blocks;
	this.frame.putBlocks(blocks);
	if (this.frame.colisionp(blocks, 0, 0)) {
	    this.gameOver();
	    return false;
	}
	return true;
    },

    dropBlocks : function() {
	var frame = this.frame;
	var blocks = this.curr;

	if (frame.colisionp(blocks, 0, 1)) {
	    this.executer.stop();
	    frame.fixBlocks(blocks);
	    if (this.genBlocks()) {
		this.executer = new PeriodicalExecuter(this.dropBlocks.bind(this), 0.5);
	    }
	}
	else {
	    blocks.move(0, 1);
	}
    },

    gameOver : function() {
	this.dump("Game Over\n");
    },

    _console : null,

    _makeConsole : function() {
	var body = document.getElementsByTagName('body')[0];
        var div = document.createElement('div');
        var pre = document.createElement('pre');
	var styles = {	backgroundColor:'black', 
			position : "absolute",
			color:"yellow", 
			padding:'2px',
			width : '200px',
			height : '100px',
			left : '80%',
			top : '80%',
			overflow : 'auto' };
        div.appendChild(pre);
        Object.extend(div.style, styles);
        body.appendChild(div);
        this._console = pre;
    },

    dump : function (str) {
        if (!this._console) {
            this._makeConsole();
        }
        this._console.innerHTML += str;
    }

};
