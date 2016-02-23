$(function() {
	$('#post_image').on('change', function(event) {
		var files = event.target.files;
		var image = files[0];
		var reader = new FileReader();
		reader.onload = function(file) {
			var img = new Image();
			console.log(file);
			img.src = file.target.result;
			$('.post_image_class').html(img);
		}
		reader.readAsDataURL(image);
		console.log(files);
	});

	$('form').on('click', '.post_image_class img', function(e) {
		$('#post_image').click();
	});
})