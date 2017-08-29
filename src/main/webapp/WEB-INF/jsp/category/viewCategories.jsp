<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
h3 {
	width: 40%;
	background-color: rgba(255, 255, 255, 0.7);
	font-size: 250%;
	padding: 1%;
	margin-top: -3%;
	font-weight: bold;
}

#tableOfCategories tr:nth-child(odd) {
	background: rgba(139, 176, 221, 0.3);
}

#categoryListContainer {
	margin: 0 30%;
	width: 40%;
	background-color: rgba(255, 255, 255, 0.7);
	height: 90%;
	overflow: auto;
	overflow-x: hidden;
	padding: 1%;
}

.col-sm-3 {
	margin-top: -15%;
}


#tableOfCategories {
	width: 60%;
	margin: 1% 20%;
	font-size: 120%;
}

#tabelOfCategories td{
border: 1px solid black;
}

#categoryListContainer > a{
 font-weight: 700;
    color: #245986;
}

a:hover {
	 color: #0f3d63;
	 text-decoration: underline;
}

#categoryNameCell {
	width: 50%;
	vertical-align:middle;
	text-align: center;
	padding: 2%;
	font-size: 110%;
	font-weight: bold;

}

#categoryLink{
	width: 50%;
	text-align: center;
}

input[type=button], input[type=hidden], input[type=submit] {
	width: 45%;
	display: inline-block
}

#categoryManageCell {
	width: 70%;
	text-align: center;
}
</style>

<center>
	<h3>List of Categories</h3>
</center>
<div id="categoryListContainer">
	<%@ page contentType="text/html;charset=UTF-8" language="java"%>
	<table id="tableOfCategories">
		<c:forEach items="${categories}" var="category">
			<tr>
				<td id="categoryNameCell"> <label class="col-sm-9">${category.type}</label></td>
				<td id="categoryLink"><a href="../client/getEventsByCategory/${category.id}">View
						Events</a></td>
			</tr>
		</c:forEach>
	</table>
</div>