<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
.myDiv {
	background-color: white;
}

#ticketTable th,#ticketTable td {
	text-align: center;
	padding: 8px;
}

#ticketTable tr {
	background: rgba(0, 0, 0, 0.1);
}

#ticketTable tr:nth-child(even) {
	background: rgba(0, 0, 0, 0.3);
}

#ticketTable th {
	background-color: #272f3d;
	color: white;
}

h1 {
	margin-left: 41%;
}

</style>

<body>
	<h1>Your tickets</h1>
	<c:if test="${not empty errorMessage}">
		<label><b>${errorMessage}</b></label>
	</c:if>
	<div class="myDiv">
		<div class="myTicket col-sm-7 col-sm-offset-3">
			<table id="ticketTable">
				<tr >
					<th><b>Barcode</b></th>
					<th><b>Event Name</b></th>
					<th><b>Location</b></th>
					<th><b>Available until</b></th>
					<th><b>Price</b></th>
					<th></th>
				</tr>
				<c:forEach items="${tickets}" var="ticket">
					<tr id="${ticket.id}">
						<td>${ticket.barcode}</td>
						<td>${ticket.event.name}</td>
						<td>${ticket.event.location}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${ticket.event.endDate}" /></td>
						<td>${ticket.event.price}</td>
						<td><input class="btn-danger" type="button" value="Refund"
							onclick="refundTicket(${ticket.id});" /></td>
					</tr>
				</c:forEach>
			</table>
			<input type="hidden" id="eventID" value="${tickets[0].event.id}"/>
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
