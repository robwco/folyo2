function on_ready() {
	$("[data-preview-image-target]").each(function(){
		var target = $("#" + $(this).data("preview-image-target"));
		if (target) {
		  $(this).on('change', function(event) {
			var files = event.target.files;
			var image = files[0]
			// here's the file size
			console.log(image.size);
			var reader = new FileReader();
			reader.onload = function(file) {
			  target.attr('src', file.target.result);
			  target.show();
			}
			reader.readAsDataURL(image);
			console.log(files);
		  });

		}
	});
};
$(document).ready(on_ready);
$(document).on('page:load', on_ready);
