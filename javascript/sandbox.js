document.observe("dom:loaded", function () {
	$$(".foo").each(function(element) {
		element.observe("click", function(){alert("OK");    $("a").hide();});
	    });
	$('b').observe('click', function () {
		alert("Fooo");
	    });
	$('c').observe('click', function () {
		alert('Barrrr');
	    }, false);
    });
