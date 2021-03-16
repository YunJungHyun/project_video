<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="search-box">
	<form class="mt-4 search-form">
		<input id="search" name="search" class="col-lg-10 search-input"
			type="search" placeholder="영상 제목을 입력해주세요.">
		<button class="search-btn" type="submit">
			<i class="fas fa-search"></i>
		</button>
	</form>
</div>


<div class="accordion" id="left-menu-accordion">

	<div class="card">
		<div class="card-header left-card-header" id="menu-head-1">

			<a href="#" class="list-group-item " id="#" data-toggle="collapse"
				data-target="#menu-1" aria-expanded="false" aria-controls="menu-1">
				즐겨 찾기</a>

		</div>
		<div id="menu-1" class="collapse fav-slide" aria-labelledby="menu-head-1"
			data-parent="#left-menu-accordion">
			<div class="card-body">
				
				<div id="favNone">즐겨찾기한 게시물이 없습니다.</div>
				
				<div id="fav-slide" class="carousel vert slide" data-ride="carousel" data-interval="false">
				
					<div class="carousel-inner fav-left-inner"></div>
					
					<a class="carousel-control-up" href="#fav-slide"
						role="button" data-slide="prev"> <span
						class="fas fa-angle-up  fa-2x" aria-hidden="true"></span> <span
						class="sr-only">Previous</span> 
					</a> 
					<a class="carousel-control-down" href="#fav-slide"
						role="button" data-slide="next"> 
						<span class="fas fa-angle-down fa-2x" aria-hidden="true"></span> 
						<span class="sr-only">Next</span>
					</a> 
				</div>
				
				

			</div>
		</div>
	</div>

	<div class="card">
		<div class="card-header left-card-header" id="menu-head-2">

			<a href="#" class="list-group-item" id="#" data-toggle="collapse"
				data-target="#menu-2" aria-expanded="false" aria-controls="menu-2">
				오늘 본 게시물</a>

		</div>
		<div id="menu-2" class="collapse recently-slide"
			aria-labelledby="menu-head-2" data-parent="#left-menu-accordion">
			<div class="card-body">

				<div id="recentlyNone">
					<span>최근 본 게시물이 없습니다.</span>
				</div> 


				<div id="recently-slide" class="carousel vert slide" data-ride="carousel" data-interval="false">
				
					<div class="carousel-inner recently-left-inner"></div>
					
					<a class="carousel-control-up" href="#recently-slide"
						role="button" data-slide="prev"> <span
						class="fas fa-angle-up  fa-2x" aria-hidden="true"></span> <span
						class="sr-only">Previous</span> 
					</a> 
					<a class="carousel-control-down" href="#recently-slide"
						role="button" data-slide="next"> 
						<span class="fas fa-angle-down fa-2x" aria-hidden="true"></span> 
						<span class="sr-only">Next</span>
					</a> 
				</div>

			</div>
		</div>
	</div>

</div>


<script type="text/javascript">

	$("#menu-head-1").on("click",function(){
		
		var gui = "${gui.userid}";
		
		if(gui == ""){
			alert("로그인 후 이용가능합니다.");
			return false;
		}
	})
	$(".carousel-control-up").on("click", function() {

		var up = $(this).attr("id");

		if (up == "favUp") {
			if ($(".f-slide-body").children().first().hasClass("active")) {

				$(this).removeAttr("href");
			} else {

				$(this).attr("href", "#f-nav-slide");
			}
		} else if (up == "recenUp") {
			if ($(".slide-body").children().first().hasClass("active")) {

				$(this).removeAttr("href");
			} else {

				$(this).attr("href", "#nav-slide");
			}
		}
	})
	$(".carousel-control-down").on("click", function() {

		var down = $(this).attr("id");
		if (down == "favDown") {

			if ($(".f-slide-body").children().last().hasClass("active")) {

				$(this).removeAttr("href");
			} else {

				$(this).attr("href", "#f-nav-slide");
			}

		} else if (down == "recenDown") {

			if ($(".slide-body").children().last().hasClass("active")) {

				$(this).removeAttr("href");
			} else {

				$(this).attr("href", "#nav-slide");
			}
		}
	})
</script>