function test1() {
    alert("test1");
}

function test2() {
    alert("test2");
}

function test3() {
    alert("test3");
}

var defer = function(f) {
  var fs = [];
  if (f) fs.push(f);
  var deferred = function(f) {
    if (f) fs.push(f);
    setTimeout(function() {
      while (fs.length) {
        var f = fs.shift()();
        if (f && f.isdeferred) {
          setTimeout(arguments.callee, 0);
          break;
        }
      }
    }, 0);
    return function(f) {
      if (f) fs.push(f);
      return arguments.callee;
    }
  };
  deferred.isdeferred = true;
  return deferred;
};

window.onload = function() {
    (function (f) {
	test1();
	return defer(f);
    })
    (function (f) {
	test2();
	return f;
    })
    (function (f) {
	test3();
	return f;
    })();
};

