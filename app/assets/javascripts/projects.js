// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	$("textarea.answer").focus(function() {
		$(this).prev(".question").addClass("focused");
	});

	$("textarea.answer").blur(function() {
		$(this).prev(".question").removeClass("focused");
	});
});
