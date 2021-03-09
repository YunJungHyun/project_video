<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="search-box">
	<form class="my-4 search-form">
		<input id="search" name="search" class="col-lg-10 search-input"
			type="search" placeholder="영상 제목을 입력해주세요.">
		<button class="search-btn col-lg-2" type="submit">
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
			<!-- fav 나머지값  -->
			<c:set var="rval" value="${fn:length(fvlist)%3}" />
			<!--  fav 몫  -->
			<fmt:parseNumber var="quo" value="${fn:length(fvlist)/3 }"
				integerOnly="true" />
			<!-- fav 나머지가 3으로 나눠떨어질경우 or 안떨어질경우  -->
			<c:choose>
				<c:when test="${rval == 0 }">
					<c:set var="len" value="${quo}" />
				</c:when>
				<c:when test="${rval > 0}">
					<c:set var="len" value="${quo+1}" />
				</c:when>
			</c:choose>

		</div>
		<div id="menu-1" class="collapse" aria-labelledby="menu-head-1"
			data-parent="#left-menu-accodion">
			<div class="card-body">
				<div id="guiNone">로그인 후 이용 가능합니다.</div>
				<div id="favNone">즐겨찾기한 게시물이 업습니다.</div>
				<div id="f-nav-slide" class="carousel vert slide "
					data-ride="carousel" data-interval="false">

					<a class="carousel-control-up " href="#f-nav-slide" role="button"
						data-slide="prev" id="favUp"> <span
						class="fas fa-angle-up  fa-2x" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a>

					<div class="carousel-inner f-slide-body"></div>

					<a class="carousel-control-down" href="#f-nav-slide" role="button"
						data-slide="next" id="favDown"> <span
						class="fas fa-angle-down fa-2x" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>

			</div>
		</div>
	</div>

	<div class="card">
		<div class="card-header left-card-header" id="menu-head-2">

			<a href="#" class="list-group-item" id="#" data-toggle="collapse"
				data-target="#menu-2" aria-expanded="false" aria-controls="menu-2">
				최근 본 영상</a>

		</div>
		<div id="menu-2" class="collapse recently-slide "
			aria-labelledby="menu-head-2" data-parent="#left-menu-accodion">
			<div class="card-body">

				<div id="recentlyNone">
					<h1>최근 본 게시물이 없습니다.</h1>
				</div>

				<div id="nav-slide" class="carousel vert slide" data-ride="carousel"
					data-interval="false">

					<a class="carousel-control-up " href="#nav-slide" role="button"
						data-slide="prev" id="recenUp"> <span
						class="fas fa-angle-up  fa-2x" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a>

					<!-- Wrapper for slides -->
					<div class="carousel-inner slide-body"></div>

					<a class="carousel-control-down" href="#nav-slide" role="button"
						data-slide="next" id="recenDown"> <span
						class="fas fa-angle-down fa-2x" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>

				</div>



			</div>
		</div>
	</div>

</div>


<script type="text/javascript">
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