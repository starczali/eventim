<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
.form-group:nth-child(odd) {
 	background: rgba(139, 176, 221, 0.3);
}
#createTicketContainer {
	margin-left: 25%;
	margin-right: 25%;
	width: 50%;
	font-size: 110%;
	background-color: rgba(255, 255, 255, 0.85);
	heigth: 100%;
	padding: 2%;
	text-align: center;
}

.buttonTicket {
	width: 73px;
	heigth: 21px;
}

.labelQuantity {
	padding-top: 1%;
}
</style>

<body>
	<div id="createTicketContainer" class="col-sm-6 col-sm-offset-4">

		<c:if test="${not empty errorMessage}">
			<label class="col-sm-3"><b>${errorMessage}</b></label>
		</c:if>
		<h1>Buy your ticket now!</h1>
		<br />
		<br />
		<c:if test="${response=='OK'}">
			<script>
				setTimeout(function() {
					setPopUp("Ticket bought!");
				}, 50);
			</script>
		</c:if>
		<c:if test="${response=='NO'}">
			<script>
				setTimeout(function() {
					setPopUp("Error! Quantity must be a positive number!");
				}, 50);
			</script>
		</c:if>
		<form:form modelAttribute="ticket"
			action="/Eventim2.0/tickets/${ticket.event.id}/createTicket"
			method="POST" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-4 col-sm-offset-1">User Name:</label>
				<div class="col-sm-2">
					<label>${ticket.user.name}</label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 col-sm-offset-1">Event:</label>
				<div class="col-sm-2">
					<label>${ticket.event.name}</label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 col-sm-offset-1">Price:</label>
				<div class="col-sm-2">
					<label>${ticket.event.price}</label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 col-sm-offset-1">Quantity:</label>
				<div class="col-sm-2">
					<form:input name="quantity" path="" cssClass="form-control" />
				</div>
			</div>
			<br />
			<input class="btn-success col-sm-4 col-sm-offset-5 buttonTicket"
				type="submit" value="Buy">
			<input class="col-sm-9" type="hidden" name="user"
				value="${ticket.user.id}" />
			<input class="col-sm-9" type="hidden" name="event"
				value="${ticket.event.id}" />
		</form:form>
	</div>
	</div>
</body>


<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Succes</h4>
			</div>
			<div class="modal-body">
				<p id="ticket-text"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
			</div>
		</div>
	</div>
</div>