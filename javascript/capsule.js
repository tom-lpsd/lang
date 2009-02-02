var Dictionary = function() {
    var self = function(k, v) {
	var state = self.state;
	if (v === undefined) {
	    return state(k);
	}
	else {
	    self.state = state(k) === v ? state : function(a) { return a === k ? v : state(a) }
	    return v;
	}
    };
    self.state = function(k) { return undefined };
    return self;
};

var Class = {
    'create': function (proto) {
	var repos = new Dictionary;

	var Proto = function () {};
	Proto.prototype = proto;

	var klass = function () {
	    repos(this, new Proto);
	    proto.initialize.apply(repos(this), arguments);
	};

	for (var i in proto) {
	    if (i == 'initialize') continue;
	    if (typeof proto[i] == 'function') {
		klass.prototype[i] = function (ix) {
		    return function () {
			return proto[ix].apply(repos(this), arguments);
		    };
		}(i);
	    }
	}

	klass.extend = function (obj) {
	    for (var i in obj) {
		if (typeof obj[i] == 'function') {
		    klass.prototype[i] = function (ix) {
			return function () {
			    return obj[ix].apply(repos(this), arguments);
			};
		    }(i);
		    Proto.prototype[i] = obj[i];
		}
	    }
	};

	return klass;
    }
};

function main () {
    var Foo = Class.create({
	'initialize' : function (x) {
	    this.x = x;
	},
	'getX' : function () {
	    return this.x;
	},
	'setX' : function (x) {
	    this.x = x;
	},
	'foo' : function () {
	    print(this.getX());
	}
    });

    var foo = new Foo(100);

    print(foo.getX()); // 100
    print(foo.x);      // undefined
    foo.setX(300);
    foo.foo();

    Foo.extend({
	    'printX' : function () {
		print(this.x);
	    }
	});

    foo.printX(); // 100

    var foo2 = new Foo(200);
    foo2.printX();
    foo.printX();
    var foo3 = new Foo(-100);
    print(foo3.getX());
    foo3.setX(-200);
    foo3.foo();
}

try {
    window.onload = main;
} catch (e) {
    main();
}
