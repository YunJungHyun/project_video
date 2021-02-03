<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="search-container mb-3 ">
	<div class="input-group col-sm-6 ">
		<input type="text" class="form-control" placeholder="영상 검색" >
		<div class="input-group-append">
			<span class="input-group-text">검색</span>
		</div>
	</div>
	<div class="input-group col-sm-6 justify-content-end">
		<span class="input-group-text spanBtn">&lt;</span>
		<span class="input-group-text ">PAGE</span>
		<span class="input-group-text spanBtn">&nbsp;&nbsp;&nbsp;&gt;</span>
	</div>
</div>
<div class="genre-container col-12">
	
	<div class="genre-box">
		<c:forEach items="${glist }" var="glist">
			<button class="btn btn-outline-secondary">${ glist.gname}</button>
			
		</c:forEach>
	
	</div>
</div>

<div class="main-content col-12">
	<div class="accodion" id="accordionExample">
		<div class="card">
			<div class="card-header" id="headingOne">
				<h2 class="mb-0">
					<button class="btn btn-link" type="button" data-toggle="collapse"
						data-target="#collapseOne" aria-expanded="true"
						aria-controls="collapseOne">ex title</button>
				</h2>
			</div>

			<div id="collapseOne" class="collapse show"
				aria-labelledby="headingOne" data-parent="#accordionExample">
				<div class="card-body">card-body</div>
			</div>
		</div>
	</div>
</div>
