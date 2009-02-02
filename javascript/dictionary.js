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

var dict = new Dictionary;

