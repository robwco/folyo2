var replies_on_ready = function() {
	$(".textarea-wrap textarea[data-max-characters]").each(function() {
		var counter = $(this).parents(".textarea-wrap").find(".counter");
		$(this).keyup(function() {
			var remaining = $(this).data("max-characters") - $(this).val().length;
			counter.text("" + remaining + "");
		});
	});
};

$(document).ready(replies_on_ready);
$(document).on("page:load", replies_on_ready);
