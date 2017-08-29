<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<jsp:include page="includes.jsp" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="externalAddress"/>
<style>
body {
	background-image:
		url('${externalAddress}resources/img/background.jpg');
	background-size: 100% 100%;
	width: 100%;
}
</style>
<table style="width: 100%; height: 100%;">
	<tr style="vertical-align: top;">
		<td><tiles:insertAttribute name="header" /></td>
	</tr>
	<tr style="height: 80%; vertical-align: top;">
		<td><tiles:insertAttribute name="body" /></td>
	</tr>
	<tr>
		<td><tiles:insertAttribute name="footer" /></td>
	</tr>
</table>