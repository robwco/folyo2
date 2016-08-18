function on_ready() {
	$("[data-category-filter]").each(function(){
	  $(this).change(function() {
		  var category_id = $(this).val();
		  var base_path = document.location.href.replace(document.location.search, "");
		  if (category_id) {
			document.location = base_path + "?category_id=" + category_id
		  } else {
			document.location = base_path
		  }
	  });
	});
}

$(document).ready(on_ready);
$(document).on('page:load', on_ready);
