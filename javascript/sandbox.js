(function(){
        var flag = true;
        Event.observe(window,'load',function(){
            if(flag){
                document.fire('dom:loaded');
                document.stopObserving('dom:loaded');
            }
        });
        document.observe('dom:loaded',function(evt){
            flag = false;
        });
})();

document.observe('dom:loaded', function () {
    alert("OK");
});
