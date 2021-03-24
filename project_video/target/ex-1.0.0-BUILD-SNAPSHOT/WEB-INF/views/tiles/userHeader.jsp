<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="mainView.do">YOONPLAYER</a>
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
					<a class="dropdown-item" href="#" data-toggle="modal"
						data-target="#myUserInfoModal">나의 회원 정보</a> <a
						class="dropdown-item" href="#" onclick="myBoard()">내가 작성한 게시글</a>
					<hr>
					<a class="dropdown-item" href="#" data-toggle="modal"
						data-target="#videoRegFormModal">게시물 등록</a> <a
						class="dropdown-item" href="#" onclick="myRecentlyList('all')">오늘
						본 동영상</a> <a class="dropdown-item" href="#" onclick="myFavList()">즐겨
						찾기한 동영상</a>
					<hr>
					<a class="dropdown-item logoutBtn" href="#">로그아웃</a>
				</div>

			</div>

		</div>
		<div class="collapse navbar-collapse" id="navbar-menu">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item ">

					<div class="dropdown active">
						<a class="nav-link  btn btn-outline" href="#"
							data-toggle="dropdown" data-target=""> 내 정보 </a>
						<div class="dropdown-menu" aria-labelledby="dropdownMenu">
							<button type="button" data-toggle="modal"
						data-target="#myUserInfoModal" class="dropdown-item">나의 회원 정보</button>
							<button type="button" class="dropdown-item"
								onclick="myBoard(${gui.unum })">내가 작성한 게시글</button>
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
	<div class="collapse navbar-collapse" id="searchTool">
		<form class="form-inline container my-3">
			<input name="search" class="form-control col-sm-10" type="search"
				placeholder="게시글 제목을 입력해주세요." aria-label="Search">
			<button class="btn " type="submit">검색</button>
		</form>
	</div>
</nav>
<!-- 나의 회원 정보 modal  -->
<div class="modal fade" id="myUserInfoModal" tabindex="-1" role="dialog"
	aria-labelledby="myUserInfoModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myUserInfoModalLabel">내 정보</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="updateForm" name="updateForm">
					<div class="form-group">
						<label for="userid">아이디 </label> <input type="text"
							class="form-control" id="update-userid" name="userid"
							value="${gui.userid }" readonly>
					</div>
					<div class="form-group">
						<label for="uname">이름</label> <input type="text"
							class="form-control" id="update-uname" name="uname"
							value="${gui.uname}" readonly>
					</div>
					<div class="form-group ">
						<label for="upw">비밀번호</label> <input type="password"
							class="form-control" id="update-userpw" name="userpw"
							value="${gui.userpw}">
					</div>

					<div class="form-group ">
						<label for="upw">이메일</label> <input type="email"
							class="form-control" id="update-uemail" name="uemail"
							value="${gui.uemail}">
					</div>
					<div class="form-group ">
						<label for="upw">휴대전화 번호</label> <input type="text"
							class="form-control" id="update-uphn" name="uphn"
							value="${gui.uphn}">
					</div>


					<button type="button" class="btn btn-primary" id="myInfoUpdate">내
						정보 수정</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</form>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>
<!-- 나의 회원 정보 modal 끝-->


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
						<label>LINK</label> 
						<input type="text" id="reg-vurl"
							class="form-control" name="vurl"
							placeholder="https://youtube/~~">
							
						<input type="hidden" id="reg-videoid" name="videoid" value=""/>
					</div>
					<div class="form-group regThumImgBox">
						<label>썸네일</label>
						<div class="regThumImg">
							<img id="regImg"/> 
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label>제목</label> <input type="text" id="reg-vtitle"
								class="form-control" name="vtitle" placeholder="TITLE">
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
							class="form-control" id="reg-vpw" name="vpw"
							placeholder="LINK PASSWORD">
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

<div class="page-top-btn" onclick="window.scrollTo(0,0)">
	<img src="resources/img/upwards-arrow.png" />
</div>

<script type="text/javascript">
	
	$(document).ready(function(){
		var emailRegExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var phnRegExp = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
		
		
		$("#update-userpw").on("click", function(){
			
			var con = confirm("비밀번호를 변경하시겠습니까?");
			if(con == true){
				
				$(this).focus();
			}else{
				
				$(this).blur();
			}
		})
		$("#update-uemail").on("click", function(){
			
			var con = confirm("이메일을 변경하시겠습니까?");
			if(con == true){
				
				$(this).focus();
			}else{
				
				$(this).blur();
			}
		})
		$("#update-uphn").on("click", function(){
			
			var con = confirm("휴대전화번호를 변경하시겠습니까?");
			if(con == true){
				
				$(this).focus();
			}else{
				
				$(this).blur();
			}
		})

		$("#myInfoUpdate").on("click", function() {


			if ($("#update-userpw").val() == "") {

				alert("변경하실 비밀번호를 입력해주세요.");
				$("#update-userpw").focus();
				return false;
			}
			 
			 var pw = $("#update-userpw").val();

			 if(pw.length < 8 || pw.length > 20){
			 	 alert("8자리 ~ 20자리 이내로 입력해주세요.");
			 	$("#update-userpw").focus();
			 	 return false;
			}else if(pw.search(/\s/) != -1){
			 	 alert("비밀번호는 공백 없이 입력해주세요.");
			 	$("#update-userpw").focus();
			 	 return false;
			}
			
			if ($("#update-uemail").val() == "") {

				alert("이메일을 입력해주세요.");
				$("#update-uemail").focus();
				return false;
			}
			
			if(!emailRegExp.test( $("#update-uemail").val() ) ){
				
				alert("변경하실 이메일을 정확히 입력해주세요.");
				$("#update-uemail").focus();
				return false;
			}
			
			if ($("#update-uphn").val() == "") {

				alert("휴대전화번호를 입력해주세요.");
				$("#update-uphn").focus();
				return false;
			}
			
			if(!phnRegExp.test( $("#update-uphn").val() ) ){
				
				alert("변경하실 휴대전화번호를 '-' 없이 정확히 입력해주세요 .");
				$("#update-uphn").focus(); 
				return false;
				
			}
			
			
			var queryString = $("form[name=updateForm]").serialize();
			//alert(queryString);
			
			$.ajax({
				
				
				url : "userUpdate.do",
				data : queryString,
				type : "post",
				dataType : 'text',
				success : function(data){
					if(data >=1){
						alert("회원정보가 수정되었습니다.");
						
						window.location.reload();
					}
				},error : function(){
					alert("error");		
				}
			})  
					
		})

		$("#reg-vurl").blur(function(){
			
			var vurlRegExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
			var matchs = $("#reg-vurl").val().match(vurlRegExp);
			//alert(matchs[7]);
			if($("#reg-vurl").val()!=""){
				
				if(!vurlRegExp.test( $("#reg-vurl").val()) ){
				 
					alert("유튜브 동영상 URL을 정확히 입력해주세요.");
					$("#reg-vurl").val("");
					$("#reg-vurl").focus();
					return false;
			 	}else{
				 
				
					$("#reg-videoid").val(matchs[7]); 
					$("#regImg").attr("src","https://img.youtube.com/vi/"+matchs[7]+"/mqdefault.jpg");	
					$(".regThumImgBox").css("display","block");
				
				 }
			}
		})
		  
		$("#videoReg").on("click" , function(){
			
			 if($("#reg-vurl").val()== ""){
					alert("동영상 URL을 입력해주세요.");
					return false;
				} 
			 
			if($("#reg-vtitle").val()== ""){
				alert("동영상 제목을 입력해주세요.");
				return false;
			}
			if($('#gnum > option:selected').val() == '') { 
			    alert("동영상 종류를 선택해주세요.");
			
				return false;
			}
			if($("#reg-vpw").val()== ""){
				alert("동영상 비밀번호를 입력해주세요.");
				return false;
			}
			
			
			var queryString = $("form[name=videoRegForm]").serialize() ;
			
			 
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
	
		var unum = "${gui.unum}";
		
		//alert(unum);
		if( unum == ""){
	 		
	 		alert("로그인 후 이용해주세요.");
	 		return false;
	 	}
		//alert(unum);
		window.location.href="myVideo.do?unum="+unum; 
	}
	
	
	  function imgError(){
		  
		  var mv = document.getElementById("regImg");
		  
		  //alert("mv :" +mv);
			
	  }

	  
	
		
</script>