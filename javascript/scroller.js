$(function () {

      var ge = function (x) {
	  return function (ix) {
	      if (ix >= x) return true;
	      return false;
	  };
      };

      var not = function (f) {
	  return function (x) {
	      if (f(x)) return false;
	      return true;
	  };
      };

      var display = $("#display");

      var hover_in = function () {
	  $(".visualizer > li").css("opacity", 0.4);
	  $(this).css("opacity", 1.0);
	  display.text($(this).text());
      };

      var hover_out = function () {
	  $(".visualizer > li").css("opacity", 1.0);
      };

      $(".visualizer > li").hover(hover_in, hover_out);

      var num = 4;
      var rest = $(".visualizer > li").filter(ge(num)).hide().remove();

      $("#right").one('click',
	  function(){
	      var func = arguments.callee;
	      $(".visualizer > li")
		  .filter(ge(num-1))
		  .fadeOut('normal',
			   function () {
			       var s = $(this).remove();
			       $(rest.get(rest.length-1))
				   .prependTo(".visualizer").hover(hover_in, hover_out);
			       $(rest.get(rest.length-1))
				   .show('slow',
					 function () {
					     rest = s.add(rest).filter(not(ge(rest.length)));
					     $("#right").one('click', func);
					 });
			   });
	  });

      $("#left").one('click',
	  function(){
	      var func = arguments.callee;
	      $(".visualizer > li")
		  .filter(not(ge(1)))
		  .hide('slow',
			   function () {
			       var s = $(this).remove();
			       $(rest.get(0))
				   .appendTo(".visualizer").hover(hover_in, hover_out);;
			       $(rest.get(0))
				   .fadeIn('slow',
					 function () {
					     rest = rest.add(s).filter((ge(1)));
					     $("#left").one('click', func);
					 });
			   });
	  });

  });
