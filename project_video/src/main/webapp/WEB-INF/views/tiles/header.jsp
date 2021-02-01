<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand" id="navbar-brand" href="#page-top">
			YOONPLAYER </a>

		<ul class="nav justify-content-end">
			<li class="nav-item">
				<a class="nav-link nav-btn" data-toggle="modal" id="loginBtn" data-target="#loginFormModal" href="#">LOGIN</a>
			</li>
		</ul>
	</div>
</nav> 


<!-- login modal  -->
<div class="modal fade" id="loginFormModal" tabindex="-1" role="dialog" aria-labelledby="loginFormMoallabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginFormModallabel">로그인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<form id="loginForm" action="login.do" method="POST">
			<div class="form-group"> 
				<label>아이디</label>
				<input type="text" class="form-control"  name="userid" placeholder="ID">
			</div>
			<div class="form-group"> 
				<label>비밀번호</label>
				<input type="password" class="form-control" name="userpw" placeholder="PASSWORD">
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
<div class="modal fade" id="signUpFormModal" tabindex="-1" role="dialog" aria-labelledby="signUpFormModallabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header"> 
        <h5 class="modal-title" id="signUpFormModallabel">회원가입</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<form id="signUpForm" >
			<div class="form-group"> 
				<label>아이디</label>
				<input type="text" class="form-control" id="signUp-userid" name="userid" placeholder="ID">
			</div>
			<div class="form-group"> 
				<label>이름</label>
				<input type="password" class="form-control"  name="uname" placeholder="USERNAME">
			</div>
			<div class="form-group"> 
				<label>비밀번호</label>
				<input type="password" class="form-control" name="userpw" placeholder="PASSWORD">
			</div>
			<div class="form-group"> 
				<label>E-mail</label>
				<input type="password" class="form-control" name="uemail" placeholder="PASSWORD">
			</div>
			<div class="form-group"> 
				<label>전화번호</label>
				<input type="password" class="form-control"  name="uphn" placeholder="PASSWORD">
			</div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"  >확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!-- js -->
<script type="text/javascript">
	 

$(document).ready(function(){
	
	
	$("#signUp").on("click",function(){
		
	  
		$('#loginFormModal').modal('hide');
		
		$('#signUpFormModal').modal('show');
			
	})
	
	$("#signUp-userid").blur(function(){
			
		if($("#signUp-userid").val() != ""){
			
			var userid = $("#signUp-userid").val();
			
			$.ajax({
				
				type: "POST",
				url: "idCheck.do",
				dataType: "text",
				data : { 
					
					"userid" : userid
				},
				success: function(){
					
				},
				error : function(){
					
					alert("error");
					
				}
			})
			
			
		}
	})
	
})
</script>
