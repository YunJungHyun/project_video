<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Project_video</title>

<!-- bootstrap 4.3.1 css   -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<!-- 내가 설정한 css  -->
<link type="text/css" rel="stylesheet"
	href="<c:url value='resources/css/css.css'/>" />


<!-- icon  -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">

</head>
<c:if test="${message eq 'loginSuccess' }">
	<script type="text/javascript">
		alert("로그인 되었습니다.");
	</script>
</c:if>
<c:if test="${message eq 'videoRegSuccess' }">
	<script type="text/javascript">
		alert("게시물이 등록되었습니다.");
	</script>
</c:if>
<c:if test="${message eq 'videoRegFail' }">
	<script type="text/javascript">
		alert("게시물이 등록실패하였습니다.");
	</script>
</c:if>
<c:if test="${message eq 'logoutSuccess' }">
	<script type="text/javascript">
		alert("로그아웃 되었습니다.");
	</script>
</c:if>
<c:if test="${message eq 'loginFail'}">
	<script type="text/javascript">
		alert("로그인 실패하였습니다.");
	</script>
</c:if>
<body>

	<!-- bootstrap 4.3.1 js  -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

	<!-- youtube api  -->
	<script src="http://www.youtube.com/iframe_api"></script>

	<div class="headerBox">


		<c:if test="${gui == null}">
			<tiles:insertAttribute name="noUserHeader" />
		</c:if>
		<c:if test="${gui != null}">
			<tiles:insertAttribute name="userHeader" />
		</c:if>
	</div>
	<div class="container mainContainer">

		<div class="row">

			<div class="left-menuBox col-lg-3">
				<tiles:insertAttribute name="left-menu" />
			</div>

			<div class="mainBox col-lg-9">
				<tiles:insertAttribute name="body" />
			</div>



		</div>
	</div>

	<%-- <div class="footerBox">
			<tiles:insertAttribute name="footer" />
	</div> --%>

</body>
</html>



<script type="text/javascript">	
/* 즐겨찾기  */
function favorites(unum, bnum ,chk){
	
	//alert(unum +","+bnum);
	
	if(unum == ""){
		
		alert("로그인 후 이용해주세요.");
		return false;
	}
	else{
		
		$.ajax({
			
			url : "favorites.do",
			data : {
				
				"bnum" : bnum,
				"chk" : chk
			},
			type : "POST",
			dataType : "TEXT",
			success : function(data){
				if(data == "add"){
					
					alert("즐겨찾기 추가되었습니다.");
				}else{
					
					alert("즐겨찾기 해제되었습니다.");
					
				}
				window.location.href="mainView.do";
				
				
			},error : function(){
				alert("error");
			}
				
		})
		
	}
	
}



/* 즐겨 찾기 끝  */
/* 쿠키 생성  */
$(document).ready(function(){
	
	refresh();

})
	
function add_cookie(vnum,exdays){


	var cmap = "{"+vnum+"}";
	setCookie(cmap,exdays);
	

	$("#vnum").val(document.cookie);
}

function setCookie( cmap , exdays){
	
	var chk = document.cookie.indexOf(cmap);
	
	if(exdays!=""){
		var day = new Date();
		day.setTime(day.getTime() + (exdays * 24 * 60 * 60 * 1000));
		var expires="; expires="+date.toGMTString();
	}else{
		
		var expires="";
	}			
	//alert(chk);  
	if(chk == -1){
		
		if(document.cookie ==""){
			document.cookie +=cmap+expires+"; path=/"; 
		
		}else{
			document.cookie += "&"+cmap+expires+"; path=/";
		}
		//alert(document.cookie);
	}else{
		
	
		document.cookie = 	document.cookie.replace(cmap+"&",""); 
		document.cookie += "&"+cmap+expires+"; path=/";
	}
	
	refresh();
	
}

function refresh(){
	//alert("refresh");

var gui = "${gui}";
	
if(gui ==""){
	
	$("#guiNone").css("display","block");
	$("#favNone").css("display","none");
	$("#f-nav-slide").css("display","none");
	
	
}else{
	
	if("${gui.favorites}" == "/"){
		
		$("#guiNone").css("display","none");
		$("#favNone").css("display","block");
		$("#f-nav-slide").css("display","none");
	}else{
		
		$("#guiNone").css("display","none");
		$("#favNone").css("display","none");
		$("#f-nav-slide").css("display","block");
		
		$.ajax({
			
			url : "favList.do",
			type : "get",
			dataType :"json",
			data:{
				
				"fav" : "${gui.favorites}"
			},
			success : function(data){
				
				var length = data.length
				
				var output ="";
				var k = 0;
				var i = 0;
				var l =0;
				
				for(var j=0; j < Math.ceil(length/3); j++){
					
					if(k>0){
						i=l;
					}
					
					output+="<div class='carousel-item'>";
					output+="<div class='favView-box'>";
					for(i ; i <length ;i++){
						if(data[i] ==null){
							if(k< l+3){
							output+="<div class='favView emptyBoard' id='empty-"+i+"'>";
							output+="<img src='resources/img/no-video.png'>";
							output+="<span class='slide-item-title'>삭제된 게시물 입니다.</span>";				
							output+="</div>";
								k++;
							}else{
							
								l+=3;
								break;
							}
						}else{
							var vurl = data[i].vurl;
							var vtitle =data[i].vtitle;
							var videoIdArray=vurl.split("/");
							var videoId = videoIdArray[3];
					
							if(k< l+3){
							
						
							output+="<div class='favView favBoard' id='fav-"+i+"'>";
							output+="<img src='https://img.youtube.com/vi/"+videoId+"/mqdefault.jpg'>";
							output+="<span class='slide-item-title'>"+vtitle+"</span>";				
							output+="</div>";
								k++;
							}else{
							
								l+=3;
								break;
							}
						}
					}
					output +="</div>";
					output +="</div>";
					
				}

				$(".f-slide-body").html(output);
				$(".f-slide-body").children().first().addClass("active");
				
			},error : function(){
				alert("error");
			}
			
		})
	}
}

	
if(document.cookie==""){ 
	//alert("쿠키없음");
	
	$("#recentlyNone").css("display","block");
	$("#nav-slide").css("display","none");
}else{
	
	$("#recentlyNone").css("display","none");
	$("#nav-slide").css("display","block");
$.ajax ({
		
		url : "recentlyList.do",
		type :"GET",
		data :{
			
			"cookie" :document.cookie
		},
		dataType:"json",
		success : function(data){
			//	var x =data;
			var length = data.mlist.length;
			//alert(length);
			var output="";
			var k =0;
			var i =0;
			var l =0;
		
			for(var j=0; j < length/3 ;j++){
				
				
				
				if(k>0){
					
					i = l;
				}
				output+="<div class='carousel-item'>";
				output+="<div class='recentlyView-box'>";
				
				
				for( i ; i < length ; i++){
					
					
					if(data.mlist[i] ==null){
						if(k< l+3){
						output+="<div class='recentlyView'>";
						output+="<img src='resources/img/no-video.png'>";
						output+="<span class='slide-item-title'>삭제된 게시물 입니다.</span>";				
						output+="</div>";
							k++;
						}else{
						
							l+=3;
							break;
						}
					}else{
					var vurl = data.mlist[i].vurl;
					var vtitle =data.mlist[i].vtitle;
					var videoIdArray=vurl.split("/");
					var videoId = videoIdArray[3];
					
					
					if(k < l+3){
							
						output+="<div class='recentlyView'>";
						output+="<img src='https://img.youtube.com/vi/"+videoId+"/mqdefault.jpg'>";
						output+="<span class='slide-item-title'>"+vtitle+"</span>";				
						output+="</div>";
				
						k++;
					}else{
						
						l+=3;
						break;
					}
					}
				}
				
				output +="</div>";
				output +="</div>";
			}
			
			$(".slide-body").html(output);
			$(".slide-body").children().first().addClass("active");
			
			
			//alert($(".carousel-item").length);
		},error : function(){
			alert("error");
		}
	})
	}
}



function getCookie(cname){
	
	var i, x, y, arrayCookies = document.cookie.split(";");
	
	for(i = 0 ; i< arrayCookies.length; i++){
		//cname추출
		x = arrayCookies[i].substr(0, arrayCookies[i].indexOf("="));
       	//cvalue 추출
		y = arrayCookies[i].substr(arrayCookies[i].indexOf("=") + 1);
      	//문자제거
       	x = x.replace(/^\s+|\s+$/g, "");

         if (x == cname) {
               return unescape(y);
         }
		
	}
}
  
/* 쿠키 생성  끝 */

/* 게시물 클릭  */
function videoClick(vnumData , vurlData,bnumData, clickObjeck){
	
	
	var vnum = vnumData;
	var vurl = vurlData;
	var bnum = bnumData;
	
	var player ="player-"+vnum;
	
	var co = clickObjeck;
	var openChk = $("#videoBox-"+vnum).hasClass("open");
	

	//alert("vnum:"+vnum +"/ vurl :"+vurl+"/ player: "+player+"/ openChk:"+openChk+"/ bnum:"+bnum+"/ co:"+co);
	
	$(".videoBox").each(function(){
		
		if($(".videoBox").hasClass("open")){
			//alert("열려있는 아코디언있음");
			var rePlayer = $(".open").children().attr("id");
			var str =$(".open").attr("id");
			//alert(rePlayer);
			$("#"+str).removeClass("open");
			$("#"+str).children().replaceWith("<div id="+rePlayer+"></div>");
			$(".comment-"+vnum).removeClass("show"); 
		}
	})
	 
	if(openChk == false){
		
		$.ajax({

			url : "getOneBoard.do",
			type : "POST",
			dataType : "json",
			data : {

				'vnum' : vnum,
				'vurl' : vurl
			},
			success : function(data) {
				//alert(data.videoId);  
				var vnum = data.map.vnum;
				
				$(".video-box-player-"+vnum).addClass("open");
				
				//타이틀을 클릭해서 이벤트가 발생했다면 댓글창을 같이 보여준다.
				 if(co=="titleClick"){
					//alert("titleClick");
					$(".comment-"+vnum).addClass("show");
					replyList(bnum);
				
				} 
			
				youTube_player = new YT.Player(player, {

					height : '350px',
					width : '100%',
					videoId : data.videoId

				}) 
				
				
			},
			error : function(error) {
				alert("error");
			}

		})
		
		viewCntUp(bnum);
		/* 쿠키적용 함수  */
		
		add_cookie(vnum ,"");
	}
}

/* 게시물 클릭 끝  */

/* 댓글 등록 */
function insertReply(bnumData){
	
	
	var gui = "${gui}";
 	
 	if( gui == ""){
 		
 		alert("로그인 후 이용해주세요.");
 		return false;
 	}
	
	var bnum =bnumData;
	var replyText = $("#replyText-"+bnum).val();

	//alert(bnum);

	$.ajax({

		url : "insertReply.do",
		type : "post",
		dataType : "text",
		data : {
			"replyText" : replyText,
			"bnum" : bnum
		},
		success : function(data) {

			//alert(data);
			replyList(bnum);
		},
		error : function() {
			alert("error");
		}

	})
 	
}

/* 댓글 등록 끝  */


/* 댓글 리스트 보기 */
function replyList(data){
	//alert(data);
	var bnum = data;
	var userid = "${gui.userid}";
	//alert(userid);
	$.ajax({
		type:"get",
		url : "replyList.do?bnum="+bnum,
		type : "json",
		success : function(result){
			
			//alert(JSON.stringify(result));
			var output ="";
			
			for (var i in result){
				
				if(result[i].rnum == 0){
					output +=" <div class='row replyOneLine-row'>"
					output += "<div class='reply-box border rounded-lg' id='reply-"+result[i].rpnum+"' >";
					output += "<div class='reply-replyer-box'>"+result[i].replyer;
					
					if(result[i].replyer == userid){
						output += "<button class='btn badge'>삭제</button>";
						output += "<button class='btn badge'>수정</button>";
					}
					output +="</div>";
					output += "<div class='reply-text-box'>"+result[i].replyText+"<button class='btn badge btn-outline-dark reReply-Btn' onclick='reCommentBox("+result[i].rpnum+","+result[i].rnum+","+result[i].bnum+",0)'>답글</button></div>";  
					output +="</div>";																																			
					output += "</div>";
					output +="<div id='reReply-"+result[i].bnum+"-"+result[i].rpnum+"'></div>";
				}
				
				if(result[i].rnum != 0){
					output +="<div class='row reReplyOneLine-row'>";
					output += "<i class='col-xl-1 col-lg-1 reply-icon'> &#10551;</i>";
					output += "<div class='border rounded-lg col-xl-11 col-lg-11 reReply-box-child'>";
					output += "<div class='reply-replyer-box'>"+result[i].replyer;
					
					if(result[i].replyer == userid){
						output += "<button class='btn badge'>삭제</button>";
						output += "<button class='btn badge'>수정</button>";
					}
					output += "</div>";
					output += "<div class='reply-text-box'>"+result[i].replyText+"</div>"; 
					output += "</div>";
					output += "</div>";
					output +="<div id='reReply-"+result[i].bnum+"-"+result[i].rpnum+"-"+result[i].rnum+"'></div>"
				}; 
			}
			
			$("#replyList-"+bnum).html(output);
		},error :function(){
			
			alert("error");
			
		}
		 
		
	})
}


 
function commentBox(vnum,bnum){
	
	var cmShowChk =$(".comment-"+vnum).hasClass("show");
	if(cmShowChk==false){
		$(".comment-"+vnum).addClass("show");
		
		replyList(bnum);
		
	}else{
		
		$(".comment-"+vnum).removeClass("show");
	}
	
}

/* 댓글 리스트 보기 끝  */

/* 대댓글 입력 창*/ 
function reCommentBox(rpnum ,rnum,bnum ,rnum){
	
	//alert(rnum);
		var output ="";
		output="<div class='row reply-input-group reReply-input-group'>";	
		output+="<div class='col-lg-9'>" 
			output+="<textarea  style='resize: none;' id='replyText-"+bnum+"-"+rpnum+"' class='form-control'  rows='1' placeholder='답글을 입력해주세요.'></textarea>"
		output+="</div>"
		output+="<div class='col-lg-3 reReply-input-btn'>"
			output+="<button type='button' name='boardNum-"+bnum+"' class='btn btn-outline-secondary' onclick='insertReReply("+bnum+","+rpnum+")'>답글 등록</button>"
			output+="<button type='button' class='btn btn-outline-secondary' onclick ='cancel("+rpnum+","+bnum+")'>취소</button>"
		output+="</div></div>"
	  
		if(rnum == 0){
			
			$("#reReply-"+bnum+"-"+rpnum).html(output); 
		} 
		else{
			$("#reReply-"+bnum+"-"+rpnum+"-"+rnum).html(output); 
			
		}
}
/* 대댓글 입력 창 끝*/ 


/* 대댓글 입력 취소  */
function cancel(rpnum, bnum){
	
	$("#reReply-"+bnum+"-"+rpnum).children().replaceWith("");
}
/* 대댓글 입력 취소 끝 */

/* 대댓글 입력  */
function insertReReply(bnumData, rpnumData){
	
	var gui = "${gui}";
 	
 	if( gui == ""){
 		
 		alert("로그인 후 이용해주세요.");
 		return false;
 	}
 	
	var bnum = bnumData;
	var rpnum = rpnumData;
	var replyText =$("#replyText-"+bnum+"-"+rpnum).val();
	
	//alert(bnum +','+rpnum+','+replyText);
	$.ajax({
		
		url : "insertReReply.do",
		type : "post",
		data : {
			"bnum" : bnum,
			"rpnum" : rpnum,
			"replyText" : replyText
			
		},
		dataType : "text",
		success : function(result){
			
			//alert("대댓글 :" +result);
			replyList(bnum);
			
		},error : function(){
			alert("error");
		}
	})
}
/* 대댓글 입력 끝 */



/* 조회수 카운트 */
function viewCntUp(bnum){
	
	$.ajax({
		
		url : "viewCntUp.do",
		data : {
				"bnum" : bnum
			},
		dataType:"text",
		success : function(data){
			
			
			
		},error :function(){
			alert("error");
		}
	})
}
/* 조회수 카운트 끝*/
 

/* 장르 클릭 */
function gnameClick(gnum){
	

	$(".genreBtn").each(function(){
		
	 	var btnClick = 	$(this).hasClass("genreClick");	
	 	if(btnClick==true){
	 		
	 		$(this).removeClass("genreClick");
	 		$(this).css("background-color","");
			$(this).css("color", "#55279a");
	 		
	 	}
	})	
	
	$("#genre-"+gnum).css("background-color", "#55279a5e");
	$("#genre-"+gnum).css("color", "#fff");
	$("#genre-"+gnum).addClass("genreClick");
	
	//alert(con);
	condition();
}
/* 장르 클릭 끝  */

/* 리스트 기준 클릭  */
$(".conBtn").on("click",function(){
		
	$(".conBtn").each(function(){
		
	 	var btnClick = 	$(this).hasClass("conClick");
	 	if(btnClick==true){
	 		
	 		$(this).removeClass("conClick");
	 		$(this).css("background-color","#fff");
	 	}
	})	
	
	$(this).css("background-color", "#ffc107");
	$(this).addClass("conClick");
	
	condition();
})
/* 리스트 기준 클릭  끝*/

/* 보는 기준에 따라 리스트 출력  */
function condition(){
	
	var clickCon = false;
	var clickGenre = false;
	var con = "";
	var gnum = "";
	
	$(".conBtn").each(function(){
		
		var btnClick = 	$(this).hasClass("conClick");	
	 	
		if(btnClick==true){
	 		
	 		//alert("컨디션클릭된것있음");
	 		clickCon= true;
	 		
	 		con = $(this).attr("id");
	 		
	 		if(con=="allCon"){
	 			
	 			location.href="mainView.do";
	 			
	 		}
	 	}
	})
	
	$(".genreBtn").each(function(){
		
		var btnClick = 	$(this).hasClass("genreClick");	
	 	if(btnClick==true){
	 		
	 		//alert("장르클릭된것있음");
	 		clickGenre= true
	 		var gstr = $(this).attr("id");
	 		var gArray = gstr.split("-");
	 		gnum = gArray[1];
	 	}
	})
	
	if(clickCon ==true && clickGenre == true){
		//alert("컨디션 o ,장르 o");
		//alert(con+","+gnum);
		$(".paging-btn").load("mainView.do?con="+con+"&gnum="+gnum+" #paging-btn-group");
		$("#main-content").load("mainView.do?con="+con+"&gnum="+gnum+" #accordion");
	}else if(clickCon == true && clickGenre == false){
		
		//alert("컨디션 o ,장르 x");
		//alert(con+","+gnum);
		
		$(".paging-btn").load("mainView.do?con="+con+" #paging-btn-group");
		$("#main-content").load("mainView.do?con="+con+" #accordion");
	}else if(clickCon == false && clickGenre == true ){
		//alert("컨디션 x ,장르 o");
		//alert(con+","+gnum);
		$(".paging-btn").load("mainView.do?gnum="+gnum+" #paging-btn-group");
		$("#main-content").load("mainView.do?gnum="+gnum+" #accordion");
		
	}else{
		//alert("X");
	}
};


/* 보는 기준에따라 리스트 출력 끝 */

/* 페이징 */
function pageAnchor(data ,view , gnum , con ,nowPage, startPage, lastPage){
					//next , 0 , bnum ,  1 , 10

	 
	var cntPerPage = 10;
	var startPrev = Number(startPage)-1;
	var startNext = Number(startPage)+1;
	var unum = "${gui.unum}";
	
	
	
	//alert(data+","+gnum+","+ con+","+nowPage+","+startPage+","+lastPage ); 
	if(view==""){
		switch(data){
			case "prev" :
				//alert("prev"); 
				if(nowPage != 1){
				//alert("1페이지 아님");
				
				$(".paging-btn").load("mainView.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+"  #paging-btn-group");							
				$("#main-content").load("mainView.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #accordion");
			}
			break;
	
		case "next" :
			if(nowPage != lastPage){
				//alert("다름");
				$(".paging-btn").load("mainView.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+"  #paging-btn-group");
				$("#main-content").load("mainView.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #accordion");
				
			}
			if(nowPage == lastPage){
				//alert("같음");
			}
			break;
	
		}
	}else if (view =="myVideo"){
		
		switch(data){
		case "prev" :
			//alert("prev"); 
			if(nowPage != 1){
			//alert("1페이지 아님");
			
			$(".my-paging-btn").load("myVideo.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&unum="+unum +"  #my-paging-btn-group");							
			$("#my-content").load("myVideo.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&unum="+unum +" #my-accordion");
		}else{
			alert(nowPage);
		}
		break;
 
		case "next" :
		if(nowPage != lastPage){
			//alert("다름");
			$(".my-paging-btn").load("myVideo.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&unum="+unum +"  #my-paging-btn-group");
			$("#my-content").load("myVideo.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&unum="+unum +" #my-accordion");
			
		}
		if(nowPage == lastPage){
			//alert("같음");
		}
		break;

	}
		
	}else if (view =="favVideo"){
		
		switch(data){
		case "prev" :
			//alert("prev"); 
			if(nowPage != 1){
			//alert("1페이지 아님");
			
			$(".myFav-paging-btn").load("myFavVideo.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&unum="+unum +"  #myFav-paging-btn-group");							
			$("#myFav-content").load("myFavVideo.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&unum="+unum +" #myFav-accordion");
		}else{
			alert(nowPage);
		}
		break;
 
		case "next" :
		if(nowPage != lastPage){
			//alert("다름");
			$(".myFav-paging-btn").load("myFavVideo.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&unum="+unum +"  #myFav-paging-btn-group");
			$("#myFav-content").load("myFavVideo.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&unum="+unum +" #myFav-accordion");
			
		}
		if(nowPage == lastPage){
			//alert("같음");
		}
		break;

	}
		
	}
}

/* 페이징 끝  */


function judgment(judg ,bnum){
	
	
	var gui = "${gui}";
 	
 	if( gui == ""){
 		
 		alert("로그인 후 이용해주세요.");
 		return false;
 	}
	
	$.ajax({
		
		url :"boardJudgment.do",
		type : "get",
		data : {
			"judg" : judg,
			"bnum" : bnum	
		},
		dataType : "text",
		success :function(data){
			if(data == 'up'){
				alert("해당 게시물을 좋아합니다.");
			}
			if(data == 'down'){
				
				alert("해당 게시물을 싫어합니다.");
			} 
			if(${pagingMap.gnum}==0){
				window.location.href="mainView.do?nowPage="+${pagingMap.nowPage}+"&cntPerPage="+${pagingMap.cntPerPage};
			}else{
				
				window.location.href="mainView.do?nowPage="+${pagingMap.nowPage}+"&cntPerPage="+${pagingMap.cntPerPage}+"&gnum="+${pagingMap.gnum};
			}
				
		},error : function(error){
			
			alert("error");
		}
	})
	
}



 
</script>