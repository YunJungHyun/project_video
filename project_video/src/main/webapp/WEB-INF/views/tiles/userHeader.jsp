<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand" id="navbar-brand" href="#page-top">
			YOONPLAYER </a>
		
		<ul class="nav justify-content-end">
			<li class="nav-item">
				<a class="nav-link nav-btn" data-target="#videoRegFormModal" data-toggle="modal" href="#">게시물 등록</a>
			</li>
			&nbsp;
			<li class="nav-item ">
				<div class="dropdown">
					<a class="nav-link nav-btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" href="#">내정보</a>
					<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
						<button class="dropdown-item" type="button">나의 회원 정보</button>
						<button class="dropdown-item" type="button">내가 작성한 게시글</button>		
						<button class="dropdown-item" id="logoutBtn" type="button">로그아웃</button>		
					</div>
				</div>
			
			</li>
		</ul>
		
	</div> 
</nav> 
 

<!-- Modal -->
<div class="modal fade" id="videoRegFormModal" tabindex="-1"
	role="dialog" aria-labelledby="videoRegFormModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="videoRegFormModalLabel">게시글 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="videoRegForm" name="videoRegForm">
					<div class="form-group">
						<label>LINK</label> 
						<input type="text" class="form-control" name="vurl" placeholder="https://example.com">
					</div> 
					<div class="form-group">
						<label>제목</label> 
						<input type="text" class="form-control" name="vtitle" placeholder="TITLE">
					</div>
					<div class="form-group">
						<label>동영상 비밀번호</label> 
						<input type="password" class="form-control" name="vpw" placeholder="LINK PASSWORD">
					</div>
					<input type="hidden" name="unum" value="${gui.unum }">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="videoReg" class="btn btn-primary">등록</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#videoReg").on("click" , function(){
			
			var queryString = $("form[name=videoRegForm]").serialize() ;
			
			//alert(queryString);
			 
			$.ajax({
				
				type :"POST",
				url : "videoReg.do",
				data : queryString,
				dataType : "text",
				success: function(data){
					
					
					if(data == 'success'){
						
						alert("게시글이 등록되었습니다.");
						
						window.location.href="mainView.do";
				
					}else{
						
						 
					}
					
					
				},error : function(){
					
					alert("error");
				}
			})
			
		})
		
		$("#logoutBtn").on("click" , function(){
			
			window.location.href="logout.do";
			
		})
	})
</script>