<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>



<style>
#artistTable tr:nth-child(odd) {
	background: rgba(139, 176, 221, 0.3);
}

#artistHeader {
	padding:1%;
	text-align: center;
	margin-left : 25%;
	margin-right : 25%;
	margin-bottom:-1.5%;
	margin-top:-5%;
	width: 50%;
	background-color: rgba(255, 255, 255, 0.7);
}

#artistHeader h1{
	padding:1%;
	font-weight:bold;
	font-size:300%;
}

#createArtistContainer {
	margin: 0 25%;
	width: 50%;
	background-color: rgba(255, 255, 255, 0.7);
	height: 90%%;
	padding: 2%;
	overflow: auto;
	overflow-x: hidden;
}

input[type=button], input[type=hidden], input[type=submit] {
	width: 30%;
	display: inline-block
}

#asd {
	margin-left: 30;
}

#Apasa-ma {
	margin-left: 30;
}

#artistNameCell {
	text-align: center;
	padding-left: 1%;
	width: 30%;
	font-weight: bold;
	font-size: 120%;
}



#artistImageCell {
	text-align: left;
	width: 30%;
	height: 10%;
}

#artistImage {
	display: block;
	width: 100%;
	vertical-align: bottom;
}

#artistButtonCell {
	width: 60%;
}
</style>

<br>
<div id="artistHeader">
<h1>Performers</h1>
</div>
<div class="col-sm-6" id="createArtistContainer">
	<center>
	
</center>
	<table align="center" id="artistTable">
		<c:forEach items="${artists}" var="artist">
			<tr id="${artist.id}">
				<td id="artistImageCell"><img id="artistImage"   src="${artist.imageBase64}"/></td>
				<td id="artistNameCell">${artist.name}</td>
				<td id="artistButtonCell">
					<div style="padding-top:10px">
						<form action="../artists/updateArtist" method="POST" style="display: inline;">
							<input type="hidden" name="idValue" value="${artist.id}"/>
							<input type="submit" value="Update" class="btn-success" id="asd"/>
						</form>

						<form action="../artists/removeArtist" method="POST" style="display: inline;">
							<input type="hidden" name="idValue" value="${artist.id}">
							<input type="button" value="Delete" id="Apasa-ma" class="btn-danger" onclick="deleteArtistById('${artist.id}')" />
						</form>
					</div>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>


<script type="text/javascript">
	function deleteArtistById(id) {
		$.ajax({
			url : "../artists/removeArtist",
			data : "idValue=" + id,
			success : function(result) {
				if (result.indexOf("success") != -1) {
					$("#" + id).remove();
					$("#artist-text").html("The Artist has been deleted!");
				} else {
					$("#artist-text").html("The Artist has not been deleted!");
				}
				$('#myModal').modal('show');
			}
		});
	}
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
				<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
			</div>
		</div>
	</div>
</div>

