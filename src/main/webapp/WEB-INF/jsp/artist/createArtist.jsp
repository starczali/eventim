<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<style>
#createArtistContainer {
	margin:0 30%;
	width: 40%;
	background-color: rgba(255, 255, 255, 0.7);
	height: auto;
	padding: 2%;
	overflow: auto;
	overflow-x: hidden;
}



input[type=button], input[type=submit], input[type=reset] {
    text-align: center;
    text-decoration: none;
    
    font-size: 16px;
    

}
input[type=text]{
    
    border: none;
    padding: 1%;
    border-radius: 4px;
    background-color: #f1f1f1;
}

</style>
<div class="col-sm-6" id="createArtistContainer">
	<center>
		<h3>Create new Performer</h3>
	</center>
	<br>
	<form:form modelAttribute="artist" action="processArtist" id="myForm">
		<div class="form-group" id="">
			<label class="col-sm-3">Performer name:</label>
			<form:input path="name" cssClass="col-sm-6" />
			<br /> <br /> <br>
			<div class="form-group">
				<label class="col-sm-3">Picture:</label>

				<center>
					<form:input type="file" path="" class="col-sm-6" id="file"
						onchange="showPicture(this);" />

					<input type="hidden" name="imageBase64" id="realImageBase64" /> <img
						id="img" src="#" align="left" />
			</div>
			<br> <br> <input align="center" type="button" value="Save"
				class="btn-success col-sm-offset-5" id="Apasa-ma" />
		</div>

	</form:form>

</div>


<script type="text/javascript">
	$(document).ready(function() {
		$("#Apasa-ma").click(function() {
			$.ajax({
				url : "processArtist",
				data : $("#myForm").serialize(),
				processData: false,
				type: "POST",
				success : function(result) {
					if (result.indexOf("Succes") != -1) {
						$("#artist-text").html("The Artist has been saved!");
					} else {
						$("#artist-text").html("The Artist has not been saved!");
					}
					$('#myModal').modal('show');
				}
			});
		});
	});
</script>


<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				
				<h4 class="modal-title">Created Artist</h4>
			</div>
			<div class="modal-body">
				<p id="artist-text"></p>
			</div>
			<div class="modal-footer">
			<button type="button" value="Refresh Page" onClick="history.go(0)"
				 class="btn btn-default" data-dismiss="modal">OK</button>
			</div>
		</div>
	</div>
</div>

