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
})