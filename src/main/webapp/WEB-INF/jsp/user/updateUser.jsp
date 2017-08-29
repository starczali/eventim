<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: info
  Date: 16.08.2017
  Time: 09:49
  To change this template use File | Settings | File Templates.
--%>
<style>
#eventCreateContainer {
	margin-left: 30%;
	margin-right: 30%;
	width: 40%;
	font-size:110%;
	background-color: rgba(255, 255, 255, 0.85);
	height: 50%;
	padding: 2%;
}
</style>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div  id="eventCreateContainer">
<h3 class="col-md-offset-5">User Details</h3>
<div class="col-sm 0">
    <c:if test="${not empty message}">
        <label>${message}</label><br>
    </c:if>
    <form:form modelAttribute="user" action="../client/updateUser" method="POST" class="form-hotizontal">
        <input hidden name="id" value="${pageContext['request'].userPrincipal.principal.id}"/>
        <div class="form-group">
            <label class="col-sm-3" for="username">Username:</label>
            <div class="col-sm-9">
                <input id="username" name="name" class="form-control" value="${pageContext['request'].userPrincipal.principal.name}" onfocus="blur()"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3" for="pass">Password:</label>
            <div class="col-sm-9">
                <input id="pass" name="password" class="form-control" type="password" placeholder="********"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3" for="em">Email:</label>
            <div class="col-sm-9">
                <input id="em" name="email" class="form-control" value="${pageContext['request'].userPrincipal.principal.email}"/>
            </div>
        </div>
        <input name="type" value="${pageContext['request'].userPrincipal.principal.type}" hidden/>
        <input type="submit" style="margin-left: 27%; margin-top: 2%" class="btn btn-success col-sm-3" value="Save"/><br>
    </form:form>
</div>
</div>