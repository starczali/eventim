<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<jsp:include page="includes.jsp"/>
<table style="width:100%; height: 100%;">
    <tr style="vertical-align: top;">
        <td>
            <tiles:insertAttribute name="header" />
        </td>
    </tr>
    <tr style="height: 80%;vertical-align: top;">
        <td>
            <tiles:insertAttribute name="body" />
        </td>
    </tr>
    <tr>
        <td>
            <tiles:insertAttribute name="footer" />
        </td>
    </tr>
</table>