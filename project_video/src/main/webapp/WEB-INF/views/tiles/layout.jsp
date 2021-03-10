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
<link type="text/css" rel="stylesheet"
	media="screen and (min-width:992px)"
	href="<c:url value='resources/css/lgcss.css'/>" />
<link type="text/css" rel="stylesheet"
	media="screen and (min-width:768px) and (max-width:991px)"
	href="<c:url value='resources/css/mcss.css'/>" />
<link type="text/css" rel="stylesheet"
	media="screen and (min-width:576px) and (max-width:767px)"
	href="<c:url value='resources/css/scss.css'/>" />
<link type="text/css" rel="stylesheet"
	media="screen and (max-width:575px)"
	href="<c:url value='resources/css/excss.css'/>" />

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
		<input type="hidden" id="cookie">

		<div class="row">
			<div class="left-menuBox col-lg-3 ">
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
$(document).ready(function(){
	
	
	
	var userid = "${gui.userid}";
	var width =document.body.clientWidth;
	
	if(userid == ""){
		userid="none";
		//alert(userid);
	}
	if(width <= 991){
		$(window).scroll(function(){
		
			var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
			var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
			var mainContainerHeight = $('.mainContainer').height(); //문서 전체 내용을 갖는 div의 높이
			
			if(scrollT >= 10){
				
				$(".page-top-btn").css("display","block");
			}else{
				
				$(".page-top-btn").css("display","none");
			}
			
			if(scrollT + scrollH +1 >= mainContainerHeight) { // 스크롤바가 아래 쪽에 위치할 때
		 		var vlistSize ="${pagingMap.vlistSize}";	
				var searchTxt ="${pagingMap.searchTxt}";
		 		pageAnchorSmall(vlistSize ,searchTxt);
		
			}	
		})
	}
	favRefresh(userid,width);
	recentlyRefresh(userid,width);

})
/* 화면 크기 조절  */
$(window).resize(function(){
	
	var userid = "${gui.userid}";
	var width =document.body.clientWidth;
	if(userid == ""){
		userid="none";
		//alert(userid);
	}
	
	favRefresh(userid,width);
	recentlyRefresh(userid,width);
	
})


/*즐겨찾기 새로고침 */
function favRefresh(userid, width){
	//alert(userid+","+width);
	
	var favList ="${gui.favorites}";
	if(width <= 991){
		
		if(favList =="/"){
			
			$("#favoritesNone-sm").css("display" ,"block");
		
		}else{
			
			$("#favoritesNone-sm").css("display" ,"none");
			
			$.ajax({
				
				url : "favList.do",
				type : "get",
				dataType :"json",
				data:{
					
					"fav" : favList
				},
				success : function(data){
					var length = data.length
					
					
					var output ="";
					var h = 0;
					
					var i = 0;
					
					var j =0;
					var k =0;
					var l =0;
					
					output += "<div id='favorites-sm-slide' class='carousel slide' data-ride='carousel' data-interval='false'>"
					
					output +="<div class='carousel-inner favorites-inner'>"
					
					for(i ; i <Math.ceil(length/3); i++){
						output+="<div class='carousel-item'>";
							output+="<div class='favList'>";
							for(j ; j <length;j++){
								
								if(data[j] ==null){
									if(k< l+3){
										output +="<div class='item-emptyBoard col-4' id='favEmpty-"+j+"'>"
										output +="<img src='resources/img/no-video.png'>"
										output +="<span class='favList-name'>삭제된 게시물 입니다.</span>";
										output +="</div>"
										k++;
									}else{
									
										l+=3;
										break;
									}
								}else{
									
									var vurl = data[j].vurl;
									var vtitle =data[j].vtitle;
									var videoIdArray=vurl.split("/");
									var videoId = videoIdArray[3];
									var vnum = data[j].vnum;
									if(k < l+3){
										output +="<div class='favList-item col-4' id='fav-"+j+"-"+vnum+"'>"
										output +="<img src='https://img.youtube.com/vi/"+videoId+"/mqdefault.jpg'>"
										output +="<span class='favList-name'>"+vtitle+"</span>";
										output +="</div>"
										k++;
									}else{
									
										l+=3;
										break;
									}
								
								}
								
							}
							output+="</div>";
						output+="</div>";
					}
					
					output +="</div>";
					
					output += "<ol class='carousel-indicators'>"
					for(h ; h <Math.ceil(length/3); h++){
							output+= "<li data-target='#favorites-sm-slide' data-slide-to='"+h+"' class='active'>";
							
						} 
					output +="</ol>";
					
					output+="<a class='carousel-control-prev' href='#favorites-sm-slide' role='button' data-slide='prev'>"
					output+="<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Previous</span>";
					output+="</a>";
					
					output+="<a class='carousel-control-next' href='#favorites-sm-slide' role='button' data-slide='next'>"
					output+="<span class='carousel-control-next-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Next</span>";
					output+="</a>";
					
					output +="</div>";
					
					
					
					
					$(".favorites-sm").html(output);
					$(".favorites-inner").children().first().addClass("active");
					
				},error : function(){
					alert("error");
				}
				
			})
			
			
		}	
	}
	
}

function recentlyRefresh(userid, width){
	//alert(userid +" , "+ width+" , "+document.cookie);
	var cookieList =document.cookie;
	
	
	if(width<=991){
		//alert("991이하");
		if(cookieList.indexOf(userid) == -1){
			//alert("block");
			$("#recentlyNone-sm").css("display" ,"block");
		}
		else{
			
			$("#recentlyNone-sm").css("display" ,"none");
			
			var cookie ="";
			
			if(cookieList.indexOf(";") != -1){
				var cookieArray = cookieList.split(";");
				
				for( var  i = 0 ; i < cookieArray.length ;i++){ 
					
					var chk = cookieArray[i].includes(userid);
					
					
					if(chk == true ){
						var updateArray = cookieArray[i].replace(userid+"=","");
						var updateArray2 = updateArray.replace(";","");
						cookie = updateArray2.split("%2C");
						
			 			
					}  
					
				}
			
			}else{
				
				var updateArray = document.cookie.replace(userid+"=","");
				cookie = updateArray.split("%2C");	
				
			}
			
			
			 //cookie 값이 한번에 안넘어가서 hidden input으로 받은다음 value를 넘겨줌
			 
			$("#cookie").val(cookie);
			
			var cookie = $("#cookie").val();
			
			
			$.ajax ({
				
				url : "recentlyList.do",
				type :"GET",
				data :{
					
					"cookie" : cookie 
				},
				dataType:"json",
				success : function(data){
					//	var x =data;
					var length = data.mlist.length;
					

					var output ="";
					var h = 0;
					
					var i = 0;
					
					var j =0;
					var k =0;
					var l =0;
					
					output += "<div id='recently-sm-slide' class='carousel slide' data-ride='carousel' data-interval='false'>"
					
					output +="<div class='carousel-inner recently-inner'>"
					
					for(i ; i <Math.ceil(length/3); i++){
						output+="<div class='carousel-item'>";
							output+="<div class='recentlyList'>";
							for(j ; j <length;j++){
								
								if(data.mlist[j] ==null){
									if(k< l+3){
										output +="<div class='item-emptyBoard col-4' id='recentlyEmpty-"+j+"'>"
										output +="<img src='resources/img/no-video.png'>"
										output +="<span class='recentlyList-item-name'>삭제된 게시물 입니다.</span>";
										output +="</div>"
										k++;
									}else{
									
										l+=3;
										break;
									}
								}else{
								
								
								var vurl = data.mlist[j].vurl;
								var vtitle =data.mlist[j].vtitle;
								var videoIdArray=vurl.split("/");
								var videoId = videoIdArray[3];
								
								if(k < l+3){
									output +="<div class='recentlyList-item col-4' id='recently-"+j+"'>"
									output +="<img src='https://img.youtube.com/vi/"+videoId+"/mqdefault.jpg'>"
									output +="<span class='recentlyList-name'>"+vtitle+"</span>";
									output +="</div>"
									k++;
								}else{
									
									l+=3;
									break;
								}
								}
							}
							output+="</div>";
						output+="</div>";
					}
					
					output +="</div>";
					
					output += "<ol class='carousel-indicators'>"
					for(h ; h <Math.ceil(length/3); h++){
							output+= "<li data-target='#recently-sm-slide' data-slide-to='"+h+"' class='active'>";
							
						} 
					output +="</ol>";
					
					output+="<a class='carousel-control-prev' href='#recently-sm-slide' role='button' data-slide='prev'>"
					output+="<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Previous</span>";
					output+="</a>";
					
					output+="<a class='carousel-control-next' href='#recently-sm-slide' role='button' data-slide='next'>"
					output+="<span class='carousel-control-next-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Next</span>";
					output+="</a>";
					
					output +="</div>";
					
					
					
					
					$(".recently-sm").html(output);
					$(".recently-inner").children().first().addClass("active");
					
					
					//alert($(".carousel-item").length);
				},error : function(){
					alert("error");
				}
			})
			
			
		}
	}
}

/* 오늘 본게시물 슬라이드 아이템 클릭  */
$(document).on("click", ".recentlyList-item", function() {
	var recentlyId = $(this).attr("id");
	var rArray = recentlyId.split("-");
	var reNum = rArray[1];

	//alert("renum :" + reNum);
	myRecentlyList(reNum);
})

function myRecentlyList(reNum) {
	var cookie = $("#cookie").val();
	//alert(reNum+","+cookie);
	if(reNum !=""){
		window.location.href = "myRecentlyVideo.do?reNum=" + reNum + "&cookie="+ cookie;
	}else{
		
		window.location.href = "myRecentlyVideo.do?cookie="+ cookie;
	}
}
/* 오늘 본게시물 슬라이드 아이템 클릭  끝 */

/* 즐겨찾기, 최근본 게시물 삭제된 게시물 처리  */
$(document).on("click", ".item-emptyBoard", function() {

		var emptyId = $(this).attr("id");
		var eArray = emptyId.split("-");
		var listName = eArray[0];
		var favNum=eArray[1];
		//alert(listName);
		if(listName=="recentlyEmpty"){
			alert("이미 삭제된 게시물 입니다.");
			return false;
		}
		if(listName=="favEmpty"){
			
			var con = confirm("즐겨찾기 목록에서 삭제하시겠습니까?");
			
			if (con == true) {
				$.ajax({

					url : "emptyDelete.do",
					type : "post",
					data : {
						"favNum" : favNum
					},
					success : function() {
						alert("해당 게시물이 즐겨찾기 목록에서 삭제되었습니다.");
						window.location.href = "mainView.do";
					},
					error : function() {
						alert("error");
					}
				})
			}else{
				
				return false;
			}
		}
		

		
	})
/* 즐겨찾기, 최근본 게시물 삭제된 게시물 처리  */
/* 즐겨찾기 슬라이드 아이템 클릭  */
$(document).on("click", ".favList-item", function() {
	var favId = $(this).attr("id");
	var fArray = favId.split("-");
	var favNum = fArray[1];
	var favVnum = fArray[2];

	myFavList(favNum,favVnum);
})

function myFavList(favNum, favVnum) {
	var gui = "${gui}";
	if (gui == "") {

		alert("로그인 후 이용해주세요.");
		return false;
	}
	//alert(favNum);
	if(favNum != ""){
		window.location.href = "myFavVideo.do?favNum="+favNum+"&favVnum="+favVnum;
	}else{
		
		window.location.href = "myFavVideo.do";
		
	}
}

/* 즐겨찾기 슬라이드 아이템 클릭  끝*/



/* 쿠키 생성  */
function add_cookie(vnum){
	
	//alert("add_cookie : " +vnum);
	var userid ="${gui.userid}";
	if (userid==""){
		
		userid= "none"; 
	}
	var width = document.body.clientWidth;
	
	$.ajax({
		
		url : "setCookie.do",
		data : {
			
			"vnum" : vnum
		
		},
		success:function(){
			
			recentlyRefresh(userid,width);
		
		},error:function(){
			
			
		}
		
		
	})
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
			var array= rePlayer.split("-");//vnum
			
			$("#img-"+array[1]).css("filter","unset");
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
		
		$("#img-"+vnum).css("filter","brightness(50%)");
		viewCntUp(bnum);
		/* 쿠키적용 함수  */
		add_cookie(vnum);
		
		fnMove(vnum);
		
	}
}

/* 게시물 클릭 끝  */

/* 원하는 위치에 스크롤  */
function fnMove(vnum){
	
	var offset = $("#img-" + vnum).offset();
	//alert(offset.top);
    $('html, body').animate({scrollTop : offset.top+200}, 400);

}
/* 원하는 위치에 스크롤  */

/* 보는 순서 정렬 */
$(".sort-select").on("change",function(){
	var sort =this.value;
	//alert(con);
	$(".sortBtn-sm").each(function(){
		
		var btnClick = $(this).hasClass("sortClick");
		if(btnClick==true){
			$(this).removeClass("sortClick");
		}
	})
	
	$("#"+sort+"-sm").addClass("sortClick");
	
	
	sessionStorage.setItem("sort", sort);
	
	condition();
	
})
/* 보는 순서 정렬 끝 */

/* 장르 클릭 */
function genreClick(gnum){
	
	//alert(gnum);
	$(".genreBtn").each(function(){	
	 	var btnClick = 	$(this).hasClass("genreClick");	
	 	if(btnClick==true){	
	 		$(this).removeClass("genreClick");	
	 	}
	})	
	
	$("#genre-"+gnum).addClass("genreClick");
	
	sessionStorage.setItem("gnum", gnum);
	
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
	
	var searchTxt = "${pagingMap.searchTxt}";
	var gnumCheck = sessionStorage.getItem("gnum");
	var sortCheck = sessionStorage.getItem("sort");
	
	var hasGCnt= 0;
	var hasSCnt= 0;
	
	/* session 중복 처리  */
	$(".genreBtn").each(function(){
		
		var has =$(this).hasClass("genreClick");
		
		if(has == true){
			hasGCnt += 1;
		}
	})
	if(hasGCnt== 0 ){
		
		sessionStorage.removeItem("gnum");
		gnumCheck =null;
	}
	
	$(".sortBtn-sm").each(function(){
		
	var has =$(this).hasClass("sortClick");
		
		if(has ==true){
			hasSCnt += 1;
		}
	})
	
	if(hasSCnt==0){
		
		sessionStorage.removeItem("sort");
		sortCheck =null;
	}
	/* session 중복 처리  */

	
	$(".paging-btn").load("mainView.do?search="+searchTxt+"&sort="+sortCheck+"&gnum="+gnumCheck+" #paging-btn-group");
	$("#main-content").load("mainView.do?search="+searchTxt+"&sort="+sortCheck+"&gnum="+gnumCheck+" #accordion");
	
   
};


/* 보는 기준에따라 리스트 출력 끝 */

/* small size 페이징  */
function pageAnchorSmall(vlistSize , searchTxt){
	var addSize = Number(vlistSize)+10;
	var sort = sessionStorage.getItem("sort");
	var gnum = sessionStorage.getItem("gnum");
	//alert(addSize);
	
	$("#main-content").load("mainView.do?search="+searchTxt+"&sort="+sort+"&gnum="+gnum+"&end="+addSize+" #accordion");
	
	
}
/* small size 페이징  */
 

/* 페이징 */
function pageAnchor(data ,view ,searchTxt ,gnum , con ,nowPage, startPage, lastPage){
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
				 
				$(".paging-btn").load("mainView.do?search="+searchTxt+"&nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+"  #paging-btn-group");							
				$("#main-content").load("mainView.do?search="+searchTxt+"&nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #accordion");
			}
			break;
	
		case "next" :
			if(nowPage != lastPage){
				//alert("다름");
				$(".paging-btn").load("mainView.do?search="+searchTxt+"&nowPage="+startNext+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+"  #paging-btn-group");
				$("#main-content").load("mainView.do?search="+searchTxt+"&nowPage="+startNext+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #accordion");
				
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
		
	}else if (view =="recentlyVideo"){
		
		switch(data){
		case "prev" :
			//alert("prev"); 
			if(nowPage != 1){
			//alert("1페이지 아님");
			
			$(".myRecently-paging-btn").load("myRecentlyVideo.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&unum="+unum +"  #myRecently-paging-btn-group");							
			$("#myRecently-content").load("myRecentlyVideo.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&unum="+unum +" #myRecently-accordion");
		}else{
			alert(nowPage);
		}
		break;
 
		case "next" :
		if(nowPage != lastPage){
			//alert("다름");
			$(".myRecently-paging-btn").load("myRecentlyVideo.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&unum="+unum +"  #myRecently-paging-btn-group");
			$("#myRecently-content").load("myRecentlyVideo.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&unum="+unum +" #myRecently-accordion");
			
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

/* 화면 작을때 댓글 클릭  */
	$(document).on("click", ".reply-cnt", function(){
	
		//alert("hi");
		var replyId =$(this).attr("id");
		
		var reArray =replyId.split("-");
		
		var bnum = reArray[2];
		var vnum =reArray[3];
		
		commentBox(vnum, bnum);
	})
/* 화면 작을때 댓글 클릭 끝  */ 

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
					output +=" <div class='replyOneLine-row'>"
					output += "<div class='reply-box' id='reply-"+result[i].rpnum+"' >";
					output += "<div class='reply-replyer-box'>"+result[i].replyer;
					
					if(result[i].replyer == userid){
						output += "<button class='btn badge myReply-Update-Btn'>삭제</button>";
						output += "<button class='btn badge myReply-Update-Btn'>수정</button>";
					}
					output +="</div>";
					output += "<div class='reply-text-box'>"+result[i].replyText+"<button class='btn badge reReply-badge-btn' onclick='reCommentBox("+result[i].rpnum+","+result[i].rnum+","+result[i].bnum+",0)'>답글</button></div>";  
					output +="</div>";																																			
					output += "</div>";
					output +="<div id='reReply-"+result[i].bnum+"-"+result[i].rpnum+"'></div>";
				}
				
				if(result[i].rnum != 0){
					output +="<div class='reReplyOneLine-row'>";
					output += "<i class='col-lg-1 col-1 reply-icon'> &#10551;</i>";
					output += "<div class='col-lg-11 col-11 reReply-box-child'>";
					output += "<div class='reply-replyer-box'>"+result[i].replyer;
					
					if(result[i].replyer == userid){
						output += "<button class='btn badge myReply-Update-Btn'>삭제</button>";
						output += "<button class='btn badge myReply-Update-Btn'>수정</button>";
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
		output="<div class='row reReply-input-group'>";	
		output+="<div class='col-lg-9 col-8 reReply-input'>" 
			output+="<textarea  style='resize: none;' id='replyText-"+bnum+"-"+rpnum+"' class='form-control'  rows='1' placeholder='답글을 입력해주세요.'></textarea>"
		output+="</div>"
		output+="<div class='col-lg-3 col-4 reReply-input-btn'>"
			output+="<button type='button' name='boardNum-"+bnum+"' class='btn reReply-btn col-lg-7 col-7' onclick='insertReReply("+bnum+","+rpnum+")'>답글 입력</button>"
			output+="<button type='button' class='btn reReply-cancle-btn col-lg-5 col-5' onclick ='cancel("+rpnum+","+bnum+")'>취소</button>"
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
/* scroll paging */


</script>