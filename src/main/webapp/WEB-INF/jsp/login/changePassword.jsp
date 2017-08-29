<%--
  Created by Eclipse.
  User: info
  Date: 10.08.2017
  Time: 12:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#click")
								.click(
										function() {
											$
													.ajax({
														url : "forgotPassword",
														data : $("#myForm")
																.serialize(),
														success : function(
																result) {
															if (result
																	.indexOf("Success") != -1) {
																$(
																		"#artist-text")
																		.html(
																				"An eMail with the new password has been sent.");
															} else {
																$(
																		"#artist-text")
																		.html(
																				"Password change was unsuccessful. Try again or register.");
															}
															$('#myModal')
																	.modal(
																			'show');
														}
													});
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
				<p id="artist-text"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
			</div>
		</div>
	</div>
</div>

<style>
#changePass {
	margin: 0 20%;
	width: 60%;
	background-color: rgba(255, 255, 255, 0.8);
	heigth: 100%;
	padding: 2%;
	width: 60%;
	font-size: 110%;
}

input[type=email] {
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
	margin-left: -2%
}

input[type=button], input[type=submit], input[type=reset] {
	background-color: #4CAF50;
	color: White;
	border-radius: 15% 15%;
	text-align: center; margin-left : 2%;
	margin-top: -0.5%;
	margin-left: 2%;
}
</style>

<div class="col-sm-6" id="changePass">

	<h3 align="center">Change Password</h3>
	<br> <br>
	<h4 align="left">A new Password will be sent to your email.</h4>




	<br>
	<form method="POST" class="form-horizontal" action="forgotPassword"
		id="myForm" class="form-horizontal">
		<div class="form-group">
			<label class="col-sm-5">Enter your registered email here:</label> <input
				class="col-sm-5" type="email" name="email" /> <input
				class="col-sm-2 " type="button" value="Send" id="click" />
		</div>
		<br /> <a href="loginUri"> Go Back to login page</a>
	</form>
</div>
