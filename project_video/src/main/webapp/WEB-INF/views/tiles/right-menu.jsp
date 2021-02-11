<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<div class="right-menu-title">
	<label class="menu-title">
		최근 본 게시물 
	</label>
	<%-- <input type="text" id="vnum"> 
	${vlist.size()}  --%>
</div>
<div id="nav-slide" class="carousel vert slide" data-ride="carousel" data-interval="false">
	
	<a class="carousel-control-up" href="#nav-slide" role ="button" data-slide="prev">
		<span class="fas fa-angle-up  fa-2x" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>

	<!-- Wrapper for slides -->
	<div class="carousel-inner slide-body" >
		
		<div class="carousel-item active">
			<div class="fill">
				<!-- 반복  -->
			
				<div class="recentlyView-box">
					<div id="right-menu-list"></div>
				</div>
			
			</div>
		</div>
	</div>
	
	<a class="carousel-control-down" href="#nav-slide" role ="button" data-slide="next">
		<span class="fas fa-angle-down fa-2x" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>

</div>

