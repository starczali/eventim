<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${not empty errorMessage}">
	<label><b>${errorMessage}</b></label>
</c:if>

<style>
#createArtistContainer {
	margin-left:30%;
	width: 40%;
	height: auto;
 	background-color:rgba(255,255,255,0.7);
}

input[type=text] {
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
	width:40%;
	font-size: 120%;
}
</style>
<div class="col-sm-6" id="createArtistContainer">
<center><h3>Update Artist</h3></center><br>
	<form:form modelAttribute="artist" action="processUpdateArtist"
		id="myForm" cssClass="form-horizontal">
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1">New name: </label>
			<form:input path="name" class="col-sm-7" />
		</div>

		<div class="form-group" >
			<label class="col-sm-3 col-sm-offset-1">Picture:</label>
			<form:input type="file" path="image" id="file"
				onchange="showPicture(this);" />
			<input type="hidden" name="imageBase64" id="realImageBase64" value="${artist.imageBase64}"/>
			<br>
			<center><img  id="img" src="${artist.imageBase64}"  width=150px height=100px/></center>
		</div>

		<input type="hidden" name="id" value="${artist.id}" />

		<center><input type="button" value="Update" class="btn-success" id="Apasa-ma" style="margin-left: 10%;"/></center>


		<script type="text/javascript">
			function redirect() {
				var url = "../artists/listArtists";
				window.location.href = url;
			}
		</script>
	</form:form>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#Apasa-ma").click(function() {
			$.ajax({
				url : "processUpdateArtist",
				data : $("#myForm").serialize(),
				processData: false,
				type: "POST",
				success : function(result) {
					if (result.indexOf("Succes") != -1) {
						$("#artist-text").html("The Artist has been updated!");
					} else {
						$("#artist-text").html("The Artist has not been updated!");
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
				<h4 class="modal-title">Succes</h4>
			</div>
			<div class="modal-body">
				<p id="artist-text"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal"
					onClick="redirect()">OK</button>
				<script type="text/javascript">
					function redirect() {
						var url = "../artists/listArtists";
						window.location.href = url;
					}
				</script>
			</div>
		</div>
	</div>
</div>


