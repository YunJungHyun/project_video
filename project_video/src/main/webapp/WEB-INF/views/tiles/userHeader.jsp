<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="#">YOONPLAYER</a>



		<button class="navbar-toggler" type="button" data-toggle="collapse"
			aria-controls="navbar-menu" data-target="#navbar-menu"
			aria-expanded="false" aria-label="Toggle navigation">

			<span class="navbar-toggler-icon"></span>
		</button>


		<div class="collapse navbar-collapse" id="navbar-menu">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item ">

					<div class="dropdown active">
						<a class="nav-link  btn btn-outline" href="#"
							data-toggle="dropdown" data-target=""> 내 정보<span
							class="sr-only">(current)</span>
						</a>
						<div class="dropdown-menu" aria-labelledby="dropdownMenu">
							<button type="button" class="dropdown-item">나의 회원 정보</button>
							<button type="button" class="dropdown-item" onclick="myBoard()">내가 작성한 게시글</button>
							<button type="button" class="dropdown-item logoutBtn">로그아웃</button>
						</div>
					</div>
				</li>
				<li class="nav-item active"><a
					class="nav-link btn btn-outline " data-toggle="modal"
					data-target="#videoRegFormModal" href="#">게시물 등록</a></li>
			</ul>
		</div>





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
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="videoRegForm" name="videoRegForm">
					<input type="hidden" id="userid" name="userid"
						value="${gui.userid }">
					<div class="form-group">
						<label>LINK</label> <input type="text" class="form-control"
							name="vurl" placeholder="https://example.com">
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label>제목</label> <input type="text" class="form-control"
								name="vtitle" placeholder="TITLE">
						</div>
						<div class="form-group col-md-6">
							<label>종류 선택</label> <select class="form-control" id="gnum"
								name="gnum">
								<option value="">선택</option>
								<c:forEach items="${glist}" var="glist">
									<option value="${glist.gnum}">${glist.gname}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label>동영상 비밀번호</label> <input type="password"
							class="form-control" name="vpw" placeholder="LINK PASSWORD">
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
		
		$(".logoutBtn").on("click" , function(){
			
			window.location.href="logout.do";
			
		})
	})
	
	function myBoard(){
		
		window.location.href="myBoard.do";
	}
</script>