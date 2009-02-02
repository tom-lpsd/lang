Array.prototype.setGeneral=function(func){
    this.__gen=func;
    return this;
};

Array.prototype.item=function(n){
    if(this.__gen!=undefined){
	var length=this.length;
	for(var i=length-1;i+1<=n;i++){
	    var copy=eval("["+this.toString()+"]");
	    this[i+1]=this.__gen.apply(this,copy.reverse());
	}
	return this[n];
    }else{
	return this[n];
    }
};

var test=[1,2,3].setGeneral(function(x){return x+1;});

var fib=[0,1].setGeneral(function(xn,xn_1){return xn+xn_1;});

print(fib.item(5));
print(fib.item(6));
print(fib[6]);
