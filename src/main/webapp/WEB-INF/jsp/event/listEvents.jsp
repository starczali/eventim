<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script type="text/javascript">
function deleteEvent(id){
	 $.ajax({
     	url: "../event/removeEvent",
     	data: "idValue=" + id, 
     	success: function(result){
	        	if (result.indexOf("success") != -1) {
	        		$("#" + id).remove();
	        		$("#event-text").html("Event has been deleted!");
	        	} else {
	        		$("#event-text").html("Event has not been deleted!");
	        	}
	        	$('#myModal').modal('show');
     }});
}
</script>

<style>

h1 {
	text-align:center;
	background-color: rgba(255, 255, 255, 0.7);
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	font-size:300%;
	margin-top: -2%;
}

#tableOfEventList tr:nth-child(odd) {
	background: rgba(139, 176, 221, 0.3);
}

#manageEventsContainer {
	width: 45%;
	
	margin-left: 25%;
	margin-right: 25%;
	background-color: rgba(255, 255, 255, 0.8);
	height: 90%;
	padding: 2%;
	overflow: auto;
	overflow-x: hidden;
}

#manageEventsContainer img{
	display:block;
	width:100%;
	height:auto;
	
}

form {
	display: inline;
}

#tableOfEventList{
	width:100%;
	
}






#nameOfEventCell{
	
	text-align:center;
	font-weight:bold;
	
}

#manageEventCell{
	text-align:center;
}
</style>

<h1 align="center"><b>List of Events</b></h1>
<div id="manageEventsContainer">

<table align="center" id="tableOfEventList">
		<c:forEach items="${events}" var="event">
			<tr id="${event.id}" style="height: 10%;">
				<td id="imageOfEventCell" style="width: 40%;"><img  src="${event.imageBase64}"/></td>
				<td id="nameOfEventCell" style="width: 20%;"><br><label>${event.name}</label></td>
				<td id="manageEventCell" style="width: 40%;">
					<form action="../event/updateEvent" method="POST">
						<input type="hidden" name="idValue" value="${event.id}">
						<input type="submit" value="Update" class="btn-success" />
					</form>
					<form action="../event/removeEvent" method="POST">
						<input type="hidden" name="idValue" value="${event.id}">
						<input type="button" value="Delete" class="btn-danger" onclick="deleteEvent('${event.id}')"/>
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>

<!-- Modal -->

</div>
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">success</h4>
      </div>
      <div class="modal-body">
        <p id="event-text"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
      </div>
    </div>
   </div>
   </div>

