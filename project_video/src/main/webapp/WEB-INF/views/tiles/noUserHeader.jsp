<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="mainView.do">YOON PLAYER</a>
		<div class="nav-sm">
			<div class="navbar-toggler">
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#searchTool" aria-controls="searchTool"
					aria-expanded="false" aria-label="Toggle navigation">
					<i class="fas fa-search search-icon-sm"></i>
				</button>
			</div>

			<div class="dropdown">
				<button class="navbar-toggler" type="button" id="dropdownMenuButton"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="dropdown-menu dropdown-menu-right right-hamburger"
					aria-labelledby="dropdownMenuButton">
					<a class="dropdown-item" href="#" onclick="myRecentlyList()">오늘 본 게시물</a>
					<a class="dropdown-item" id="videoInsertBtn" href="#">게시물 등록</a>

					<hr>
					<a class="dropdown-item" href="#" data-toggle="modal"
						data-target="#loginFormModal">로그인</a>
				</div>
			</div>

		</div>
		<div class="collapse navbar-collapse">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a
					class="nav-link btn btn-outline navbtn" href="#"
					data-toggle="modal" data-target="#loginFormModal">LOGIN </a></li>
			</ul>
		</div>


	</div>

	<div class="collapse navbar-collapse" id="searchTool">
		<form class="form-inline my-3">
			<input name="search" class="form-control" type="search"
				placeholder="게시글 제목을 입력해주세요." aria-label="Search">
			<button class="btn " type="submit">검색</button>
		</form>
	</div>
</nav>


<!-- login modal  -->
<div class="modal fade" id="loginFormModal" tabindex="-1" role="dialog"
	aria-labelledby="loginFormMoallabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginFormModallabel">로그인</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="loginForm" action="login.do" method="POST">
					<div class="form-group">
						<label>아이디</label> <input type="text" class="form-control"
							name="userid" placeholder="ID">
					</div>
					<div class="form-group">
						<label>비밀번호</label> <input type="password" class="form-control"
							name="userpw" placeholder="PASSWORD">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="signUp" class="btn btn-primary">회원가입</button>
				<button type="submit" form="loginForm" class="btn btn-primary">확인</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>


<!-- SignUp modal  -->
<div class="modal fade" id="signUpFormModal" tabindex="-1" role="dialog"
	aria-labelledby="signUpFormModallabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="signUpFormModallabel">회원가입</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="signUpForm">
					<div class="form-group">
						<label>아이디</label> <input type="text" class="form-control"
							id="signUp-userid" name="userid" placeholder="ID"> <small
							id="idCheck" class="form-text"></small>
					</div>
					<div class="form-group">
						<label>이름</label> <input type="text" class="form-control"
							name="uname" placeholder="USERNAME">
					</div>
					<div class="form-group">
						<label>비밀번호</label> <input type="password" class="form-control"
							name="userpw" placeholder="PASSWORD">
					</div>
					<div class="form-group">
						<label>E-mail</label> <input type="email" class="form-control"
							name="uemail" placeholder="email @ example.com">
					</div>
					<div class="form-group">
						<label>전화번호</label>
						<div class="form-group row">
							<select class="form-control col-md-3 uph">
								<option value="">선택</option>
								<option value="">010</option>
								<option value="">011</option>
								<option value="">016</option>
								<option value="">019</option>
							</select><input type="text" class="form-control col-md-4 uph" name="uphn"><input
								type="text" class="form-control col-md-4 uph" name="uphn">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">확인</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>


<!-- js -->
<script type="text/javascript">
	$(document).ready(function() {
		var idCheckValue = false;
		var userid = "${gui.userid}";
		/* 비로그인시 게시물등록 클릭 */
		$("#videoInsertBtn").on("click", function() {

			if (userid == "") {

				alert("로그인 후 이용가능합니다.");

			}

		})
		/* 비로그인시 게시물등록 클릭 끝*/

		$("#signUp").on("click", function() {

			$('#loginFormModal').modal('hide');

			$('#signUpFormModal').modal('show');

		})

		$("#signUp-userid").blur(function() {

			if ($("#signUp-userid").val() != "") {

				var userid = $("#signUp-userid").val();

				$.ajax({

					type : "POST",
					url : "idCheck.do",
					dataType : "text",
					data : {

						"userid" : userid
					},
					success : function(data) {

						if (data == "YES") {
							$("#idCheck").css("display", "block");
							$("#idCheck").css("color", "red");
							$("#idCheck").text("중복된 아이디입니다.");

						} else {
							$("#idCheck").css("display", "block");
							$("#idCheck").css("color", "green");
							$("#idCheck").text("사용 가능한 아이디입니다.");
							idCheck = true;
						}
					},
					error : function() {

						alert("error");

					}
				})

			}
		})

	})
</script>
