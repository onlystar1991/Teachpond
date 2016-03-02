$(function() {
	$('#profile_avatar').on('change', function(event) {
		var files = event.target.files;
		var image = files[0];
		var reader = new FileReader();
		reader.onload = function(file) {
			var img = new Image();
			console.log(file);
			img.src = file.target.result;
			$('.avatar_class').html(img);
			console.log(img);
		}
		reader.readAsDataURL(image);
		console.log(files);
	});
	
	$('form').on('click', '.avatar_class img', function(e) {
		$('#profile_avatar').click();
	})

	$("#profile_country").on('change', function(event) {
		var input_country = $(this);
		$.getJSON('/location/' + $(this).val(), function (data) {
			$("#profile_city").autocomplete({
		      source: data
		    });
		})
	})
	
	$.getJSON('/location/' + $("#profile_country").val(), function (data) {
		$("#profile_city").autocomplete({
	      source: data
	    });
	})
})