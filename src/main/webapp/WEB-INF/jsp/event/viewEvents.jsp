<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: info
  Date: 17.08.2017
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<style>

img {
	height: 150px;
	width: 230px;
}

h3 {
	text-align:center;
}

#ticketTable {
	background-color: rgba(255, 255, 255, 0.7);
}

#ticketTable thead {
background-color: rgba(255, 255, 255, 0.2);
	 font-weight: 900;
}

#ticketTable thead,#ticketTable td {
	text-align: center;
	padding: 8px;
		vertical-align: middle;
}

.myDiv {
	text-align: center;
	margin-left: 18%;
	margin-right: 18%;
	width: 70%;
}

#eventHeader {
	text-align: center;
	margin-left: 18%;
	margin-right: 18%;
	width: 70%;
	background-color: rgba(255, 255, 255, 0.7);
}

#eventHeader h3 {
	font-weight: bold;
	font-size: 250%;
	margin-top:-1%;
	padding: 1%;
}

</style>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<spring:url value="/" var="externalAddress"/>
<div id="eventHeader">
	<h3>Events</h3>
</div>
<div class="myDiv">
    <table id="ticketTable" class="table table-striped table-hover">
        <thead>
        <tr>
            <td>Image</td>
            <td>Event</td>
            <td>Location</td>
            <td>StartDate / EndDate</td>
            <td>Performers</td>
            <td>Price (Lei)</td>
            <td>Tickets</td>
        </tr>
        </thead>
        <c:forEach items="${events}" var="event">

            <tr>
                <td width="200"><img width="200" src="${event.imageBase64}"/></td>
                <td>${event.name}</td>
                <td>${event.location}</td>
                <td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${event.startDate}"/>
                    <b> / </b>
                    <fmt:formatDate pattern = "yyyy-MM-dd" value = "${event.endDate}"/>
                </td>
                <td>
                    <a href="${externalAddress}client/viewArtistsByEvent/${event.id}">View Upcoming Performers</a>
                </td>
                <td>${event.price}</td>
                <td>
                    <a href="${externalAddress}tickets/${event.id}/createTicket">Buy Tickets</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
