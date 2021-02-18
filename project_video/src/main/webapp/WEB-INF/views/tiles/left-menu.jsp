<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="search-box">
	<form class="my-4 search-form">

		<input class="col-lg-10 search-input" type="search"
			placeholder="영상 제목 입력해주세요.">
		<button class="search-btn col-lg-2">
			<i class="fas fa-search"></i>
		</button>
	</form>
</div>
<div class="accordion" id="left-menu-accodion">

	<div class="card">
		<div class="card-header left-card-header" id="menu-head-1">

			<a href="#" class="list-group-item" id="#" data-toggle="collapse"
				data-target="#menu-1" aria-expanded="false" aria-controls="menu-1">
				즐겨 찾기</a>

		</div>
		<div id="menu-1" class="collapse" aria-labelledby="menu-head-1"
			data-parent="#left-menu-accodion">
			<div class="card-body">
				<h1>body</h1>
			</div>
		</div>
	</div>

	<div class="card">
		<div class="card-header left-card-header" id="menu-head-2">

			<a href="#" class="list-group-item" id="#" data-toggle="collapse"
				data-target="#menu-2" aria-expanded="false" aria-controls="menu-2">
				최근 본 영상</a>

		</div>
		<div id="menu-2" class="collapse recently-slide" aria-labelledby="menu-head-2"
			data-parent="#left-menu-accodion">
			<div class="card-body">

				<div id="recentlyNone">
					<h1>최근 본 게시물이 없습니다.</h1>
				</div>

				<div id="nav-slide" class="carousel vert slide" data-ride="carousel"
					data-interval="false">

					<a class="carousel-control-up" href="#nav-slide" role="button"
						data-slide="prev"> <span class="fas fa-angle-up  fa-2x"
						aria-hidden="true"></span> <span class="sr-only">Previous</span>
					</a>

					<!-- Wrapper for slides -->
					<div class="carousel-inner slide-body"></div>

					<a class="carousel-control-down" href="#nav-slide" role="button"
						data-slide="next"> <span class="fas fa-angle-down fa-2x"
						aria-hidden="true"></span> <span class="sr-only">Next</span>
					</a>

				</div>



			</div>
		</div>
	</div>

</div>


<script type="text/javascript">
	$(".carousel-control-up").on("click", function() {
	
			//alert("hi");
		if ($(".slide-body").children().first().hasClass("active")) {

			$(".carousel-control-up").removeAttr("href");
		} else {

			$(".carousel-control-up").attr("href", "#nav-slide");
		}
	})
	$(".carousel-control-down").on("click", function() {

		if ($(".slide-body").children().last().hasClass("active")) {

			$(".carousel-control-down").removeAttr("href");
		} else {

			$(".carousel-control-down").attr("href", "#nav-slide");
		}
	})
</script>