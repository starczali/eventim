<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
function deleteCategoryById(id){
	 $.ajax({
     	url: "../categories/removeCategory",
     	data: "idValue=" + id, 
     	success: function(result){
	        	if (result.indexOf("success") != -1) {
	        		$("#" + id).remove();
	        		$("#category-text").html("Category has been deleted!");
	        	} else {
	        		$("#category-text").html("Category has not been deleted!");
	        	}
	        	$('#myModal').modal('show');
     }});
}
</script>

<style>

h3{
width: 40%;
background-color:rgba(255,255,255,0.7);
font-weight:bold;
font-size:300%;
padding:1%;
margin-top:-3%;
}


#tableOfCategories tr:nth-child(odd) {
	background: rgba(139, 176, 221, 0.3);
}

#categoryListContainer {

	margin: 0 30%;
	width: 40%;
	font-size: 110%;
	background-color: rgba(255, 255, 255, 0.7);
	heigth: 95%;
	overflow: auto;
	overflow-x: hidden;
	height:87%;
}

.col-sm-3 {
	margin-top: -15%;

}

#tableOfCategories{
	width:90%;
	
	margin:1% 5%;
}


#categoryNameCell{
	width:30%;
	
	text-align:center;
}

input[type=button], input[type=hidden], input[type=submit] {
	width: 30%;
	display: inline-block
}

#categoryManageCell{

	width:70%;
	text-align:center;
	
	
}
</style>
<center>
	<h3>List of Categories</h3>
</center>
<div  id="categoryListContainer">
	<table  id="tableOfCategories">
		<c:forEach items="${categories}" var="category">
			<tr id="${category.id}">
				<td id="categoryNameCell"><br> <label class="col-sm-9"> ${category.type} <br></label>
				</td>
				<td id="categoryManageCell">
				
					<form action="../categories/updateCategory" method="POST"
						style="display: inline;">
						<input type="hidden" name="idValue" value="${category.id}">
						<input type="submit" value="Update" class="btn-success" />
					</form>
					<form action="../categories/removeCategory" method="POST"
						style="display: inline;">
						<input type="hidden" name="idValue" value="${category.id}">
						<input type="button" value="Delete" class="btn-danger"
							onclick="deleteCategoryById('${category.id}')" />
					</form>	
				</td>
			</tr>
		</c:forEach>
	</table>
</div>


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
				<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
			</div>
		</div>
	</div>
</div>
