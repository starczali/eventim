<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<jsp:include page="../../tiles/includes.jsp" />
<title>Eventim - Login</title>
</head>
<body>
	

	<style>
input[type=text] {
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

input[type=password] {
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

#eventCreateContainer {
	margin-left: 25%;
	margin-right: 25%;
	width: 50%;
	font-size:110%;
	background-color: rgba(255, 255, 255, 0.85);
	heigth: 100%;
	padding: 2%;
}

input[type=button], input[type=submit], input[type=reset] {
	background-color: #4CAF50;
	color: White;
	border-radius: 15% 15%;
}
</style>
	<div class="col-sm-6" id="eventCreateContainer">
		<c:if test="${not empty param.failed}">
		<div class="errors">
			<p style="font-weight:bold;color:#ce1c1c;text-align:center">
				<c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
			</p>
		</div>
	</c:if>
		<center>
			<h2 align="center">Login</h2>
			<br> <br>
			<h4 align="left">Enter your credentials to login</h4>
		</center>
		<form method="POST" action="j_spring_security_check"
			class="form-horizontal">
			<div class="form-group">
				<br /> <label class="col-sm-3">Username:</label> <input
					class="col-sm-6" name="userNameParam" type="text"
					value='Enter your username' onclick='this.value = "";' />
			</div>
			<div class="form-group">
				<br /> <label class="col-sm-3">Password:</label> <input
					class="col-sm-6" name="userPasswordParam" type="password"
					placeholder="Enter your password" /> <br> <br> <br>
				<input class="col-sm-2 col-sm-offset-3" type="submit" value="Login" />
			</div>

			<br>
			<div class="form-group">
				<div class="col-sm-offset-3">
					Forgot your password? <a href="changePassword"> Change password
						here!</a>
				</div>
				<br>
				<div class="col-sm-offset-3">
					Not a user yet? <a href='<spring:url value="/client/createUser"/>'> Register here!</a>
				</div>
			</div>
		</form>
	</div>
	<br />
	<br />
</body>
</html>