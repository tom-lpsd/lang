$(document).ready(function(){
	$("a").click(function(){
		$(this).hide("slow");
		return false;
	    });
	$.get('index.html', function(x) {alert(x);});
	$("#sample").css('position', 'absolute');
	$("#sample").mousedown(function(e) {
		var origX = e.offsetX || e.layerX;
		var origY = e.offsetY || e.layerY;
		var self = this;
		$('html').mousemove(function(e) {
			$(self).css('left', e.pageX - origX);
			$(self).css('top', e.pageY - origY);
		    });
		$('html').one('mouseup', function() { 
			$(this).unbind('mousemove');
		    });
	    });
	var cnt = 0;
	$("#sample").dblclick(function(e) { 
		$("#console").html(cnt++); 
		return false; 
	    });
    });
