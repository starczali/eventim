<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
#tableOfLocations tr:nth-child(odd) {
	background: rgba(139, 176, 221, 0.3);
	text-align: center;

}


#locationHeader {
	text-align: center;
	margin-left: 30%;
	margin-right: 30%;
	margin-top:-5%;

	width: 40%;
	background-color: rgba(255, 255, 255, 0.7);
}

#locationHeader h3 {
	padding: 2%;
	font-size: 250%;
	font-weight: bold;
}

#locationContainer {
	margin: 0 30%;
	width: 40%;
	background-color: rgba(255, 255, 255, 0.7);
	height: 90%;
	padding: 1%;
	overflow: auto;
	overflow-x: hidden;
}

input[type=button], input[type=hidden], input[type=submit] {
	width: 30%;
	display: inline-block
}


#locationContainer > a{
	font-weight: none;
	width: 50%;
	text-align: center;

}

a:hover {
	 color: #0f3d63;
	 text-decoration: underline;
}

#locationCell {
	text-align: center;
	padding-left: 1%;
	width: 50%;
	font-weight: bold;
	font-size: 120%;
	padding:2%;
}



#locationLink {
	width: 50%;
	padding: 2%;
	text-align: center;
	font-size: 120%;

}
</style>

<br>


<div id="locationHeader">
	<h3>Events Locations</h3>
</div>


<div class="col-sm-6" id="locationContainer">
<table id="tableOfLocations" align="center">
    <c:forEach items="${locations}" var="location">
        <tr id="${location}">
            <td id="locationCell">${location}</td>
            <td id="locationLink">
                <a  href="../client/getEventsByLocation/${location}">
                	  View Events
                </a>
            </td>
        </tr>
    </c:forEach>
</table>
</div>

