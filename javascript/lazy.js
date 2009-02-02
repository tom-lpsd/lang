function Cons (car, cdr) {
    if (car == null || cdr == null) {
	throw "illegal object.";
    }
    this.car = car;
    this.cdr = cdr;
}

function Action (act) {
    if (act == null || !(act instanceof Function)) {
	throw "illegal object.";
    }
    this.action = act;
}

function Thunk (any) {
    if (any instanceof Thunk) {
	this.value = any.value;
	this.evaled = any.evaled;
    } else {
	this.value = any;
	this.evaled = !(any instanceof Action);
    } 
}

var _ = function (f) { return new Thunk(f); };
var thunk = function (f) { return _(new Action(f)); };
var nil = function () { };
var identity = function () { return this; };

Cons.prototype.run = identity;
Number.prototype.run = identity;
String.prototype.run = identity;
Boolean.prototype.run = identity;
Function.prototype.run = identity;
nil.run = identity;
nil.toString = function () { return "nil"; };
Action.prototype.run = function () { 
    return this.action(); 
};

Thunk.prototype.run = function () {
    if (this.evaled) {
	return this.value;
    }
    this.value = this.value.run();
    while (this.value instanceof Thunk) {
	this.value = this.value.run();
    }
    this.evaled = true;
    return this.value;
};

Thunk.prototype.toString = function () {
    return this.run().toString();
};

Cons.prototype.toString = function () {
    var str = "(";
    var car = this.car.run();
    var cdr = this.cdr.run();
    str += car;
    while (cdr instanceof Cons) {
	car = cdr.car.run();
	cdr = cdr.cdr.run();
	if (car != nil) str += " ";
	str += car;
    }
    str += ((cdr == nil) ? "" : " . " + cdr);
    return str + ")";
}

/*** premitives ***/

function cons (car, cdr) {
    return thunk(function () { return new Cons(car, cdr) });
}

function car (val) {
    return thunk(function () {
	    val = val.run();
	    if (val == nil) {
		return nil;
	    }
	    if (!(val instanceof Cons)) {
		throw "car applyed to non-Cons object." + val.constructor;
	    }
	    return val.car;
	});
}

function cdr (val) {
    return thunk(function () {
	    val = val.run();
	    if (val == nil) {
		return nil;
	    }
	    if (!(val instanceof Cons)) {
		throw "cdr applyed to non-Cons object." + val.constructor;
	    }
	    return val.cdr;
	});
}

/*** predicates ***/

function nullp (x) {
    return thunk(function() {
	    return x.run() == nil;
	});
}

function atom (x) {
    return thunk(function () {
	    return !(x.run() instanceof Cons) || nullp(x).run();
	});
}

function listp (xs) {
    return thunk(function () {
	    return xs.run() instanceof Cons || nullp(xs).run();
	});
}

function consp (xs) {
    return thunk(function () {
	    return xs.run() instanceof Cons;
	});
}

/*** operators ***/

function decr (n) {
    return thunk(function () {
	    n = n.run() - 1;
	    return n;
	});
}

function incr (n) {
    return thunk(function () {
	    n = n.run() + 1;
	    return n;
	});
}

function add (x, y) {
    return thunk(function () {
	    return x.run() + y.run();
	});
}

/*** list ***/

function list () {
    var arg = arguments;
    return thunk(function () {
	    var lst = cons(arg[arg.length-1], nil);
	    for (var i=arg.length-2;i>=0;i--) {
		lst = cons(arg[i], lst);
	    }
	    return lst;
	});
}

function nth (n, xs) {
    return thunk(function () {
	    if (n.run() <= 0) {
		return car(xs);
	    }
	    return nth(decr(n), cdr(xs));
	});
}

function last (xs) {
    return thunk(function () {
	    var n = cdr(xs).run();
	    if (n == nil || atom(n).run()) {
		return xs;
	    }
	    return last(n);
	});
}

function snoc (val, lst) {
    return thunk(function () {
	    if (lst.run() == nil) {
		return cons(val, nil);
	    }
	    return cons(car(lst), snoc(val, cdr(lst)));
	});
}

function reverse (lst) {
    return thunk(function () {
	    if (lst.run() == nil) {
		return nil;
	    }
	    return snoc(car(lst), reverse(cdr(lst)));
	});
}

function dup (lst) {
    return thunk(function () {
	    if (lst.run() == nil) {
		return nil;
	    }
	    return cons(car(lst), dup(cdr(lst)));
	});
}

function append (xs, ys) {
    return thunk(function () {
	    if (xs.run() == nil) {
		return dup(ys);
	    }
	    return cons(car(xs), append(cdr(xs), ys));
	});
}

function take (n, lst) {
    return thunk(function () {
	    if (lst.run() == nil || n.run() == 0) {
		return nil;
	    }
	    return cons(car(lst), take(decr(n), cdr(lst)));
	});
}

function drop (n, lst) {
    return thunk(function () {
	    if (lst.run() == nil) {
		return nil;
	    }
	    if (n.run()==0) {
		return lst;
	    }
	    return drop (decr(n), cdr(lst));
	});
}

function map (op, xs) {
    return thunk(function () {
	    if (xs.run() == nil) {
		return nil;
	    }
	    return cons(op.run()(car(xs).run()), map(op, cdr(xs)));
	});
}

function zipWith (op, xs, ys) {
    return thunk(function () {
	    if (xs.run() == nil || ys.run() == nil) {
		return nil;
	    }
	    return cons(op.run()(car(xs).run(), car(ys).run()), 
			zipWith(op, cdr(xs), cdr(ys)));
	});
}

/*** infinity ***/

function cycle (lst) {
    return thunk(function () {
	    return append(lst, cycle(lst));
	});
}

function from (n) {
    return thunk(function () {
	    return cons(n, from(incr(n)));
	});
}

function iterate (f, init) {
    return thunk(function () {
	    var val = f.run()(init.run());
	    return cons(init, iterate(f, val));
	});
}

/*** condition ***/

function _if (pred, t, f) {
    return thunk(function () {
	    if (pred.run()) {
		return t;
	    }
	    return f;
	});
}

/*** io ***/

function _print (x) {
    return thunk(function () {
	    print(x.run());
	});
}

/*** test ***/

var add = function (x, y) { return x + y; };
var fib = thunk(function() {
	return cons(0, cons(1, zipWith(add, fib, cdr(fib))));
    });

function test_cons () {
    var a = cons(1, 2);
    var b = cons(3, a);
    print(a);
    print(b);
}

function test_list () {
    var a = list(1, 2, 3);
    print(a);
}

function test_car () {
    var a = cons(1, 2);
    print(car(a));
    print(cdr(a));
    var b = list(1, 2, 3);
    print(cdr(b));
}

function test_predicate () {
    var a = cons(1, 2);
    print(consp(a));
    print(listp(a));
    print(atom(a));
    print(consp(nil));
    print(listp(nil));
    print(atom(nil));
}

function main () {    
    test_cons();
    test_list();
    test_car();
    test_predicate();
    print(take(10, fib));
    print(nth(99, fib));
    var func1 = function (x, y) { return x + y; };
    var func2 = function (x, y) { return x * y; };
    var f = cons(func1, func2);
    print(zipWith(cdr(f), list(1,2,3), list(2,3,4)));
    print(take(10, from(11)));
    print(take(10, cycle(take(5, fib))));
    var inf = from(1);
    var infs = list(fib, inf, 1);
    print(nth(cdr((cons(1, 2))), infs));
    print(take(10, map(function(x){return x+x;}, from(2))));
    print(cons(nil, 1));
    print(cons(nil, nil));
    print(take(3, iterate(cdr, list(1,2,3,4,5,6))));
}

try {
    window.onload = main;
} catch (e) {
    main();
}
