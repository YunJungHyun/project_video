<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<div class="paging-box">


	<div class="col-lg-4 con-btn-group">
		<a href="#" class="conBtn" id="allCon">전체보기</a> <a href="#"
			class="conBtn" id="latestCon">최신</a> <a href="#" class="conBtn"
			id="viewcnt">조회수</a> <a href="#" class="conBtn" id="upcnt">좋아요</a>
	</div>

	<div class="paging-btn  col-lg-auto ml-auto">
		<div id="paging-btn-group" class="btn-group" role="group"
			aria-label="Basic example">
			<button id="prev" type="button" class="btn btn-secondary"
				onclick="pageAnchor('prev','${pagingMap.gnum}','${pagingMap.con}','${pagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage}')">
				<i class="fas fa-caret-left"></i>
			</button>
			<span class="btn btn-secondary"><b>${pagingVO.nowPage}</b></span>
			<button id="next" type="button" class="btn btn-secondary"
				onclick="pageAnchor('next','${pagingMap.gnum}','${pagingMap.con }','${pagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage }')">
				<i class="fas fa-caret-right"></i>
			</button>
		</div>
	</div>

	

</div>

<div class="genre-container my-3">
	<div class="genre-box col-12">
		<c:forEach items="${glist }" var="glist">
			<button class="btn btn-outline-secondary genreBtn col-lg-2"
				id="genre-${glist.gnum }" onclick="gnameClick('${glist.gnum}')">${glist.gname}</button>
		</c:forEach>
	</div>
</div>

<div class="main-content" id="main-content">
	<div class="accordion" id="accordion">

		<c:forEach items="${vlist}" var="vlist">
			<div class="card">
				<div class="card-header" id="heading-${vlist.RN }">
					<div class="row">
						<div class="col-lg-4  col-md-6 align-self-center video-img-box"
							data-toggle="collapse" data-target="#collapse-${vlist.RN}"
							aria-expanded="false" aria-controls="collapse-${vlist.RN}">

							<c:set var="strArray" value="${fn:split(vlist.vurl,'/')}" />
							<c:forEach items="${strArray }" var="videoId" varStatus="g">
								<c:if test="${g.count == 3}">
									<img src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg"
										onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','imgClick')">
								</c:if>
							</c:forEach>
						</div>

						<div class="col-lg-8 col-md-6 video-info-box">
							<div class="row video-info-row">
								<h1 class="video-title" data-toggle="collapse"
									data-target="#collapse-${vlist.RN}" aria-expanded="false"
									aria-controls="collapse-${vlist.RN }"
									onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','titleClick')">

									${vlist.vtitle} <span class="badge">조회수 :
										${vlist.viewcnt} &nbsp;</span>
								</h1>
								<h1 class="video-info">
									작성자 : ${vlist.userid } <span class="badge badge-info"><a
										href="#">LINK</a></span>
								</h1>


								<div class="row btn-box-row">

									<div class="btn-comment-box">
										<button class="btn btn-outline-dark info-inner-btn"
											id="replyBtn-${vlist.bnum }"
											onclick="commentBox('${vlist.vnum}','${vlist.bnum }')">
											댓글 (0)
											<c:forEach items="${rlist }" var="rlist">
												<c:if test="${vlist.bnum == rlist.bnum }">
													<script>
											$("#replyBtn-"+${vlist.bnum}).html("댓글 ("+${rlist.bnumCnt}+")");
										</script>
												</c:if>
											</c:forEach>
										</button>
									</div>

									<div class="btn-like-box">
										<button class="btn btn-outline-success info-inner-btn"
											onclick="judgment('up','${vlist.bnum}')">
											좋아요 <i class="fas fa-thumbs-up"></i> ${vlist.upcnt }
										</button>
										<button class="btn btn-outline-danger info-inner-btn"
											onclick="judgment('down','${vlist.bnum}')">
											싫어요 <i class="fas fa-thumbs-down"></i> ${vlist.downcnt }
										</button>
									</div>

								</div>
							</div>

						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- card-header -->

				<div id="collapse-${vlist.RN}"
					class="collapse colllapse-${vlist.vnum}"
					aria-labelledby="heading-${vlist.RN }" data-parent="#accordion">
					<div class="card-body">

						<div id="videoBox-${vlist.vnum}"
							class="videoBox video-box-player-${vlist.vnum}">
							<div id="player-${vlist.vnum}"></div>
						</div>
					</div>
				</div>
				<!-- reply  -->
				<div class="collapse comment-${vlist.vnum}"
					aria-labelledby="heading-${vlist.RN }" data-parent="#accordion">
					<div class="card-body">
						<div class="container">
							<div class="row reply-input-group">
								<div class="reply-input col-lg-10">
									<textarea style="resize: none;" id="replyText-${vlist.bnum}"
										class="form-control" rows="1" placeholder="댓글을 입력해주세요."></textarea>
								</div>
								<div class="reply-input-btn parentBtn col-lg-2">

									<button type="button" name="boardNum-${vlist.bnum }"
										class="btn btn-dark" onclick="insertReply('${vlist.bnum}')">댓글
										등록</button>
								</div>
							</div>
						</div>
						<hr>
						<div class="reply-list-group container">
							<div id="replyList-${vlist.bnum }" class="row replyList-row"></div>
						</div>
					</div>
				</div>



			</div>
		</c:forEach>
	</div>
</div>




<script type="text/javascript">	
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
if(document.cookie==""){ 
	//alert("쿠키없음");
	
	$("#recentlyNone").css("display","block");
	$("#nav-slide").css("display","none");
}else{
	$("#recentlyNone").css("display","none");
	$("#nav-slide").css("display","block");
$.ajax ({
		
		url : "rightMenuList.do",
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
				output+="<ul class='recentlyView-box list-group'>";
				
				for( i ; i < length ; i++){
					
					var vurl = data.mlist[i].vurl;
					var vtitle =data.mlist[i].vtitle;
					var videoIdArray=vurl.split("/");
					var videoId = videoIdArray[3];
					
					
					if(k < l+3){
							
						output+="<li class='list-group-item'>";
						output+="<img src='https://img.youtube.com/vi/"+videoId+"/mqdefault.jpg'>";
						output+="<label>"+vtitle+"</label>";				
						output+="</li>";
				
						k++;
					}else{
						
						l+=3;
						break;
					}
				}
				
				output +="</ul>";
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
					output += "<div class='reply-replyer-box'>"+result[i].replyer+"</div>";
					output += "<div class='reply-text-box'>"+result[i].replyText+"<button class='btn badge btn-outline-dark reReply-Btn' onclick='reCommentBox("+result[i].rpnum+","+result[i].rnum+","+result[i].bnum+",0)'>답글</button></div>";  
					output +="</div>";																																			
					output += "</div>";
					output +="<div id='reReply-"+result[i].bnum+"-"+result[i].rpnum+"'></div>";
				}
				
				if(result[i].rnum != 0){
					output +="<div class='row reReplyOneLine-row'>";
					output += "<i class='col-xl-1 reply-icon'> &#10551;</i>";
					output += "<div class='border rounded-lg col-xl-11 reReply-box-child'>";
					output += "<div class='reply-replyer-box'>"+result[i].replyer+"</div>";
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
function pageAnchor(data , gnum , con ,nowPage, startPage, lastPage){
					//next , 0 , bnum ,  1 , 10
	var cntPerPage = 10;
	var startPrev = Number(startPage)-1;
	var startNext = Number(startPage)+1;
	
	 //alert(data+","+gnum+","+ con+","+nowPage+","+startPage+lastPage ); 
	//alert(lastPage);
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