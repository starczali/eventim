<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<c:if test="${not empty errorMessage}">
	<label><b style="color: red"><center>${errorMessage}</center></b></label>
</c:if>
<style>
body {
	
	background-size: 100% 100%;
	overflow:hidden;
}

#eventCreateContainer {
	padding: 0 3%;
	background-color: rgba(255, 255, 255, 0.7);
	width: 60%;
	margin:0 20%;
	font-size: 100%;
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
	border: none;
	color: white;
	padding: 1%;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin-left: -10%
}
#endD{
	cursor:pointer;
}
</style>
<script type="text/javascript">
$(function() {
	  $('#endD').datetimepicker({
       format: "DD.MM.YYYY"
      });
	  $('#startD').datetimepicker({
	       format: "DD.MM.YYYY"
	      });
});

</script>
<div class="col-sm-6" id="eventCreateContainer">
	<center>
		<h1 style="margin-bottom: 5%;">Create New Event</h1>
	</center>
	<form:form modelAttribute="event" action="../event/processEvent"
		method="POST" id="myForm" cssClass="form-horizontal">

		<div class="form-group">
			<label class="col-sm-3">Name:</label>
			<form:input path="name" cssClass="col-sm-9" />
		</div>

		<br>

		<div class="form-group">
			<label class="col-sm-3">Location:</label>
			<form:input path="location" cssClass="col-sm-9" />
		</div>

		<br>

		<div class="form-group">
			<label class="col-sm-3">Start Date:</label>
			<form:input id="startD" path="startDate" cssClass="col-sm-9" />
		</div>
		
		<br>

		<div class="form-group">
			<label class="col-sm-3">End Date:</label>
			<form:input id="endD" path="endDate" cssClass="col-sm-9" />
		</div>

		<br>

		<div class="form-group">
			<label class="col-sm-3">Artists:</label>
			<form:select path="artists" cssClass="col-sm-9" id="myMultiSelect">
				<form:options items="${artists}" itemValue="id" itemLabel="name"></form:options>
			</form:select>
		</div>

		<br>

		<div class="form-group">
			<label class="col-sm-3">Categories:</label>
			<form:select path="category" cssClass="col-sm-9">
				<form:options items="${categories}" itemValue="id" itemLabel="type"></form:options>
			</form:select>

		</div>

		<br>

		<div class="form-group">
			<label class="col-sm-3">Price:</label>
			<form:input path="price" class="col-sm-9" />
		</div>
		<br>
		<br>
		<div class="form-group">
			<label class="col-sm-3">Picture:</label>
			<form:input type="file" path="" id="file" onchange="showPicture(this);" />
			<input type="hidden" name="imageBase64" id="realImageBase64"/>
			<img id="img" src="#" alt="No picture selected" />
		</div>
		<center>
			<input type="button" value="Submit"  id="submitButton" />
		</center>
		<br>

	</form:form>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#myMultiSelect").multiselect({
		    allSelectedText: 'All selected',
		    selectAllNumber: false,
		    disableIfEmpty: true,
		    disabledText: 'None available',
		    nonSelectedText: 'None selected'
		});
		$("#submitButton").click(function() {
			$.ajax({
				url : "../event/processEvent",
				data : $("#myForm").serialize(),
				processData: false,
				type: "POST",
				success : function(result) {
					if (result.indexOf("success") != -1) {
						$("#event-text").html("Event has been saved!");
					} else {
						$("#event-text").html("Event has not been saved!");
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
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">success</h4>
			</div>
			<div class="modal-body">
				<p id="event-text"></p>
			</div>
			<div class="modal-footer">
				<button type="button" value="Refresh Page" onClick="history.go(0)"
					class="btn btn-default" data-dismiss="modal">OK</button>
			</div>
		</div>
	</div>
</div>
