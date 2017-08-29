function showPicture(input) {
	console.log(document.getElementById("img"));
	if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#img')
                .attr('src', e.target.result)
                .width(150);
        };
        console.log(input.files[0]);
        reader.readAsDataURL(input.files[0]);
    }
	
	var files = document.getElementById('file').files;
	if (files.length > 0) {
		getBase64(files[0]);
	}
}

function getBase64(file) {
	   var reader = new FileReader();
	   reader.readAsDataURL(file);
	   reader.onload = function () {
	     console.log(reader.result);
	     document.getElementById("realImageBase64").value = reader.result;
	   };
	   reader.onerror = function (error) {
	     console.log('Error: ', error);
	   };
	}

