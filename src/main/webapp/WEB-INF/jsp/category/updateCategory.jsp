<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="../../tiles/includes.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${not empty errorMessage}">
	<label><b>${errorMessage}</b></label>
</c:if>
<style>
#categoryUpdateContainer{
width:30%;
font-size:110%;

background-color:rgba(255,255,255,0.6);
height:100%;
padding:2%;
margin:0 35%;
}

#myForm{
	width:100%;
}

.col-sm-5{
margin-bottom:1%;

}

input[type=text]{
 
    
    border: none;
    padding: 1%;
    border-radius: 4px;
    background-color: #f1f1f1;
}

select {
    width: 100%;
    padding: 1%;
    border: none;
    border-radius: 4px;
    background-color: #f1f1f1;
}

input[type=button], input[type=submit], input[type=reset] {
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
}
</style>

<div style="    text-align: center;
    margin: 0 auto;">
<div class="col-sm-5" id="categoryUpdateContainer">
<center><h3>Update Category</h3></center>
<br>
<form:form modelAttribute="category"
	action="../categories/processUpdateCategory" method="POST" id="myForm" cssClass="form-horizontal">
	<div class="form-group">
	<label class="col-sm-5">New type: </label>
	<form:input cssClass="col-sm-5" path="type"/>
	</div>
	<input type="hidden" name="id" value="${category.id}"/>
	<br>
	<input type="button" value="Update" id="Apasa-ma" class="btn-success col-sm-1.5 col-sm-offset-0"/>
</form:form>
</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
    $("#Apasa-ma").click(function(){
        $.ajax({
        	url: "../categories/processUpdateCategory",
        	data: $("#myForm").serialize(), 
        	success: function(result){
	        	if (result.indexOf("success") != -1) {
	        		$("#category-text").html("Category has been updated!");
	        	} else {
	        		$("#category-text").html("Category has not been updated!");
	        	}
	        	$('#myModal').modal('show');
        }});
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
        <h4 class="modal-title">Status</h4>
      </div>
      <div class="modal-body">
        <p id="category-text"></p>
      </div>
      <div class="modal-footer">
        <button type="button" onclick="reload()" class="btn btn-default" data-dismiss="modal">OK</button>
        <script type="text/javascript">
		function reload(){
				window.location.href = "../categories/listCategories";
		}
		</script>
      </div>
    </div>
   </div>
</div>

