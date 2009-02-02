var nat = [1, function (x) { return [x + 1, arguments.callee]; }];

var prime = [2, function (prime) {
	prime++;
    outloop:
	while(true) {
	    for(var i=2;i<=Math.sqrt(prime);i++) {
		if (prime % i == 0) {
		    prime++;
		    continue outloop;
		}
	    }
	    return [prime, arguments.callee];
	}
    }];

function next(n) {
    return n[1](n[0]);;
}

function pos(ix, n) {
    for (var i=0;i<ix;i++) {
	n = next(n);
    }
    return n[0];
}

function take(n, inflist) {
    var ary = [];
    for (var i=0;i<n;i++) {
	ary.push(inflist[0]);
	inflist = next(inflist);
    }
    return ary;
}

function map(func, n) {
    var succ = function (n) {
	return function (_) {
	    n = next(n);
	    return [func(n[0]), succ(n)];
	};
    };
    return [func(n[0]), succ(n)];
}

var evens = map (function(x) { return x*2; }, nat);
var prime_squares = map (function(x) { return x*x; }, prime);

print(take(10, nat));
print(take(10, prime));

print(take(10, evens));
print(take(10, prime_squares));

print(pos(10, nat));
print(pos(99, prime));

var fib = [0, function (x) { 
	var succ = function (x) {
	    return function(y) {
		return [x+y, succ(y)];
	    };
	};
	return [x+1, succ(x)];
    }];

print(take(10, fib));
print(pos(99, fib));
