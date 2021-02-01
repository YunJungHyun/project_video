<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand" id="navbar-brand" href="#page-top">
			YOONPLAYER </a>

		<ul class="nav justify-content-end">
			<li class="nav-item">
				<a class="nav-link nav-btn" data-toggle="modal" data-target="#loginFormModal" href="#">LOGIN</a>
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
				<input type="text" class="form-control" id="userid" name="userid" placeholder="ID">
			</div>
			<div class="form-group"> 
				<label>비밀번호</label>
				<input type="password" class="form-control" id="userpw" name="userpw" placeholder="PASSWORD">
			</div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" id="signUp" class="btn btn-primary" data-toggle="modal" data-target="#signUpFormModal">회원가입</button>
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
		<form id="loginForm" action="login.do" method="POST">
			<div class="form-group"> 
				<label>아이디</label>
				<input type="text" class="form-control" id="userid" name="userid" placeholder="ID">
			</div>
			<div class="form-group"> 
				<label>비밀번호</label>
				<input type="password" class="form-control" id="userpw" name="userpw" placeholder="PASSWORD">
			</div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="submit" form="loginForm" class="btn btn-primary">확인</button>
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
})
</script>
