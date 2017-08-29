<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<style>

h3 {
color: white;
}
href {
color: white;
}
text{
color: white;
}
</style>
<div class="container" style="max-width:84%; vertical-align:top; ">
	<h3>Welcome to Event Master</h3>
	<br>
	<div id="myCarousel" class="carousel slide" data-ride="carousel" style="max-width: 1024p�; max-height: 562px">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
			<li data-target="#myCarousel" data-slide-to="3"></li>
			<li data-target="#myCarousel" data-slide-to="4"></li>
			<li data-target="#myCarousel" data-slide-to="5"></li>
			<li data-target="#myCarousel" data-slide-to="6"></li>
		</ol>
		
		<!-- Wrapper for slides -->
		<div class="carousel-inner">
			<div class="item active">
				<img src="https://sarahjanek.files.wordpress.com/2017/04/bereczky_sacc81ndor_ec_day3-179.jpg" alt="Eventim2.0"
					style="width: 1024p�; height: 562px; width:100%">
				<div class="carousel-caption">
					<h3>Welcome to Event-Master!</h3>
				</div>
			</div>
		
		
			<!-- Events from database -->
			<c:forEach items="${events}" var="event">
					<div class="item">
					<a href="../tickets/${event.id}/createTicket">
						<img src="${event.imageBase64}" alt="${event.name}" style="width: 1024p�; height: 562px; width:100%">
						<div class="carousel-caption">
							<h3>${event.name}</h3>
							<a href="../tickets/${event.id}/createTicket" style="color: white; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
}">Buy Tickets now!</a>
						</div>
						</a>
					</div>
					
			</c:forEach>
		</div>

		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</div>
