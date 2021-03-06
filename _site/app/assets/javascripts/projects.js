// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function projects_on_ready() {
	$("textarea.answer").focus(function() {
		$(this).prev(".question").addClass("focused");
	});

	$("textarea.answer").blur(function() {
		$(this).prev(".question").removeClass("focused");
	});
	$("textarea.answer:focus").focus();

	$("[data-status-update]").each(function(){
	  $(this).change(function() {
		$(this).parents("form").submit();
	  });
	});
}

$(document).ready(projects_on_ready);
$(document).on("page:load", projects_on_ready);
