function on_ready() {
	function countChars(text, counter) {
	  var max = parseInt(text.data('max-characters'),10);
	  var chars = text.val().length;

	  counter.text((max - chars) + " characters left");

	  if ((max - chars) < 0) {
		counter.css('color', '#d9666a');
	  } else {
		counter.css('color', '#000');
	  }
	}

	$("[data-max-characters]").each(function(){
	  var counterElem = $("<div class='counter'></div>");
	  counterElem.width($(this).width()).css('padding', $(this).css('padding')).css('margin', $(this).css('margin'));
	  counterElem.css('padding-top', '0px').css('padding-bottom','0px');

	  $(this).after(counterElem);
	  countChars($(this), counterElem);

	  $(this).keyup(function() {
		countChars($(this), counterElem);
	  });
	});
}

$(document).ready(on_ready);
$(document).on('page:load', on_ready);
