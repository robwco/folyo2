var page_ready = function() {
	$(".textarea-wrap textarea[data-max-characters]").each(function() {
		var counter = $(this).parents(".textarea-wrap").find(".counter");
		$(this).keyup(function() {
			var remaining = $(this).data("max-characters") - $(this).val().length;
			counter.text("" + remaining + " characters left");
		});
	});
};

$(document).ready(page_ready);
$(document).on("page:load", page_ready);
