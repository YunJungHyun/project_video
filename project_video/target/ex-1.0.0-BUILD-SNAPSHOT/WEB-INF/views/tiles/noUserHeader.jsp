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
					<a class="dropdown-item" href="#" onclick="myRecentlyList('all')">오늘
						본 게시물</a> <a class="dropdown-item" id="videoInsertBtn" href="#">게시물
						등록</a>

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
		<form class="form-inline container my-3">
			<input name="search" class="form-control col-sm-10" type="search"
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
				<button type="button" id="signUpModal" class="btn btn-primary">회원가입</button>
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
				<form id="signUpForm" name="signUpForm">
					<div class="form-group">
						<label>아이디</label> <input type="text" class="form-control"
							id="signUp-userid" name="userid" placeholder="ID"> <small
							id="idCheck" class="form-text"></small>
					</div>
					<div class="form-group">
						<label>이름</label> <input type="text" class="form-control"
							id="signUp-uname" name="uname" placeholder="USERNAME">
					</div>
					<div class="form-group">
						<label>비밀번호</label> <input type="password" class="form-control"
							id="signUp-userpw" name="userpw" placeholder="PASSWORD">
					</div>
					<div class="form-group">
						<label>E-mail</label> <input type="email" class="form-control"
							id="signUp-uemail" name="uemail"
							placeholder="email @ example.com">
					</div>
					<div class="form-group">
						<label>휴대전화 번호</label>
						<div class="form-group">
							<input id="signUp-uphn" class="form-control" type="text"
								name="uphn" placeholder="010123456789" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="signUpBtn" class="btn btn-primary">확인</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div> 

<div class="page-top-btn" onclick="window.scrollTo(0,0)">
	<img src="resources/img/upwards-arrow.png" />
</div>


<!-- js -->
<script type="text/javascript">
	$(document).ready(function() {

		var idCheckValue = false;
		var userid = "${gui.userid}";
		var idRegExp = /^[a-zA-z0-9]{4,12}$/; //아이디 유효성 검사
		var nameRegExp=  /^[가-힣]+$/; //이름 유효성 검사 > 한글만 입력
		var emailRegExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var phnRegExp = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;

		 
		/* 비로그인시 게시물등록 클릭 */
		$("#videoInsertBtn").on("click", function() {

			if (userid == "") {

				alert("로그인 후 이용가능합니다.");

			}
		})

		/* 비로그인시 게시물등록 클릭 끝*/

		$("#signUpModal").on("click", function() {

			$('#loginFormModal').modal('hide');

			$('#signUpFormModal').modal('show');
		})

		$("#signUpBtn").on("click", function() {

			if (idCheck == false) {

				alert("사용하실 아이디를 다시 입력해주세요.");
				$("#signUp-userid").focus();
				return false;
			}

			if ($("#signUp-userid").val() == "") {

				alert("사용하실 아이디를 입력해주세요.");
				$("#signUp-userid").focus();
				return false;
			}

			if ($("#signUp-uname").val() == "") {

				alert("이름을 입력해주세요.");
				$("#signUp-uname").focus();
				return false;
			}
			if(!nameRegExp.test($("#signUp-uname").val())){
				alert("회원님의 이름을 공백없이 정확히 입력해주세요.");
				$("#signUp-name").val("");
				$("#signUp-name").focus();
				return false;
			}
			

			if ($("#signUp-userpw").val() == "") {

				alert("사용하실 비밀번호를 입력해주세요.");
				$("#signUp-userpw").focus();
				return false;
			}
			
			
			 var pw = $("#signUp-userpw").val();
	
			 if(pw.length < 8 || pw.length > 20){
			 	 alert("8자리 ~ 20자리 이내로 입력해주세요.");
			 	$("#signUp-userpw").focus();
			 	 return false;
			}else if(pw.search(/\s/) != -1){
			 	 alert("비밀번호는 공백 없이 입력해주세요.");
			 	$("#signUp-userpw").focus();
			 	 return false;
			}
			
			if ($("#signUp-uemail").val() == "") {

				alert("사용하시는 이메일을 입력해주세요.");
				$("#signUp-uemail").focus();
				return false;
			}
			
			if(!emailRegExp.test( $("#signUp-uemail").val() ) ){
				
				alert("이메일을 정확히 입력해주세요.");
				$("#signUp-uemail").focus();
				return false;
			}
			
			if ($("#signUp-uphn").val() == "") {

				alert("사용하시는 휴대전화번호를 입력해주세요.");
				$("#signUp-uphn").focus();
				return false;
			}
			
			if(!phnRegExp.test( $("#signUp-uphn").val() ) ){
				
				alert("사용하시는 휴대전화번호를 '-' 없이 정확히 입력해주세요 .");
				$("#signUp-uphn").focus(); 
				return false;
				
			}
			
			
			var queryString = $("form[name=signUpForm]").serialize();
			//alert(queryString);
			
			$.ajax({
				
				
				url : "signUp.do",
				data : queryString,
				type : "post",
				dataType : 'text',
				success : function(data){
					if(data >=1){
						alert("회원가입 성공하였습니다.!");
						
						window.location.reload();
					}
				},error : function(){
					alert("error");		
				}
			}) 
					 
		})

		$("#signUp-userid").blur(function() {

			if ($("#signUp-userid").val() != "") {


				if (!idRegExp.test( $("#signUp-userid").val() ) ) {
					alert("아이디는 영문 대소문자와 숫자 4~12자리로 입력해야합니다!");
					$("#signUp-userid").val("");
					$("#idCheck").css("display","none");
					$("#signUp-userid").focus();
					return false;
				}
				
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
							idCheck = false;

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
