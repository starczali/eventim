<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${not empty errorMessage}">
	<label><b>${errorMessage}</b></label>
</c:if>

<style>
	body {
	
	
	overflow:hidden;
}

h1{
	width: 60%;
	margin: 0 20%;
	text-align:center;
	background-color: rgba(255,255,255,0.7);
}

#eventCreateContainer {
	padding: 0 3%;
	background-color: rgba(255, 255, 255, 0.7);
	width: 60%;
	margin:0 20%;
	font-size: 100%;
	overflow:auto;
	overflow-x:hidden;
	height:95%;
}

#eventCreateContainer img{
	width:15%;
	height:10%;	
}

.col-sm-9 {
	padding: 1%
}

.col-sm-6 {
	padding: 1%
}

input[type=datetime-local] {
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

input[type=text] {
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

select {
	width: 100%;
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

input[type=button], input[type=submit], input[type=reset] {
	background-color: #4CAF50; /* Green */
	width:20%;
	
	border: none;
	color: white;
	padding: 1%;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 0 40%;
}
#endD{
	cursor:pointer;
}
</style>
<h1 align="center">Update ${event.name}</h1>
<div id="eventCreateContainer">
	
	

<form:form modelAttribute="event" action="../event/processUpdateEvent"
	method="POST" id="myForm" cssClass="form-horizontal">
	
	
	
	<br>
	<div class="form-group">
	<label class="col-sm-3">New Name: </label>
	<form:input path="name" cssClass="col-sm-9"/>
	<input type="hidden" name="id" value="${event.id}" />
	</div>
	
	<br>
	
	
	<div class="form-group">
	<label class="col-sm-3">Start Date: </label>
	<form:input path="startDate" cssClass="col-sm-9"/>
	</div>
	
	<br>
	
	<div class="form-group">
	<label class="col-sm-3">Location:</label>
	<form:input path="location" cssClass="col-sm-9"/>
	</div>
	
	<br>
	
	<div class="form-group">
	<label class="col-sm-3">End Date: </label>
	<form:input path="endDate" cssClass="col-sm-9"/>
	</div>
	
	<br>
	
	<div class="form-group">
	<label class="col-sm-3">Artists: </label>
	<c:set var="csvEvents" value=""/>
	<c:forEach items="${event.artists}" var="artist">
		<c:set var="csvEvents" value="${artist.id},${csvEvents}"/>
	</c:forEach>
	<input type="hidden" id="csvList" value="${csvEvents}"/>
	<form:select path="artists" cssClass="col-sm-9" id="myMultiSelect">
		<form:options items="${artists}" itemValue="id" itemLabel="name"></form:options>
	</form:select>
	</div>
	<br>

	<div class="form-group">
	<label class="col-sm-3">Categories: </label>
	<form:select path="category" cssClass="col-sm-9" >
		<form:options items="${categories}" itemValue="id" itemLabel="type"></form:options>
	</form:select>
	</div>
	
	<br>
	<div class="form-group">
	<label class="col-sm-3">Price: </label>
	<form:input path="price" cssClass="col-sm-9"/>
	</div>
	<br>
	<br>
	<div class="form-group">
		<label class="col-sm-3">Picture:</label>
		<form:input type="file" path="" id="file" onchange="showPicture(this);" />
		<input type="hidden" name="imageBase64" id="realImageBase64" value="${event.imageBase64}"/>
		<img id="img" src="${event.imageBase64}" width=150px height=100px />
	</div>
		<center>
	<input onclick="document.body.style.cursor='wait'" type="button" value="Update" id="Apasa-ma" />
		</center>
		<br>
	
</form:form>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$("#myMultiSelect").multiselect({
	    allSelectedText: 'All selected',
	    selectAllNumber: false,
	    disableIfEmpty: true,
	    disabledText: 'None available',
	    nonSelectedText: 'None selected'
	});
	var csvEvents = $("#csvList").val();
	if (csvEvents.length > 0) { 
		csvEvents = csvEvents.substring(0, csvEvents.length -1);
		var artistList = csvEvents.split(",");
		for (i = 0; i < artistList.length; i++) { 
			$("#myMultiSelect").multiselect('select', artistList[i]);
			}
	}
	
    $("#Apasa-ma").click(function(){
        $.ajax({
        	url: "../event/processUpdateEvent",
        	data: $("#myForm").serialize(), 
        	processData: false,
			type: "POST",
        	success: function(result){
	        	if (result.indexOf("success") != -1) {
	        		$("#event-text").html("Event has been updated!");
	        	} else {
	        		$("#event-text").html("Event has not been updated!");
	        	}
	        	$('#myModal').modal('show');
        }});
    });
});
</script>



<!-- Modal -->
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
        <button type="button" onclick="reload()" class="btn btn-default" data-dismiss="modal">OK</button>
        <script type="text/javascript">
		function reload(){
				window.location.href = "../event/listEvents";
		}
		</script>
      </div>
    </div>
   </div>
</div>
