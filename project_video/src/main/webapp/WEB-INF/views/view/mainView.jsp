<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="search-container mb-3 ">
	<div id="search-nav">
		<div class="input-group col-sm-6 ">
			<input type="text" class="form-control" placeholder="영상 검색" >
			<div class="input-group-append">
				<span class="input-group-text">검색</span>
			</div>
			
		</div>
		<div class="input-group col-sm-6 justify-content-end">
			<a id="prev" onclick="pageAnchor('prev','${pagingMap.gnum}','${pagingMap.con}','${pagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage}')" href="#">
				<span class="input-group-text spanBtn">&lt;</span>
			</a>
			<span class="input-group-text ">
				<b>${pagingVO.nowPage}</b>
			</span>
			<a id="next" onclick="pageAnchor('next','${pagingMap.gnum}','${pagingMap.con }','${pagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage }')" href="#">
				<span class="input-group-text spanBtn">&nbsp;&nbsp;&nbsp;&gt;</span>
			</a>	
		</div>
	</div>
</div>

<div class="genre-container col-12">
	<div class="genre-box">
		<c:forEach items="${glist }" var="glist">
			<button class="btn btn-outline-secondary genreBtn" id="genre-${glist.gnum }" onclick="gnameClick('${glist.gnum}')">${glist.gname}</button>
		</c:forEach>	
	</div>
</div>

<div class="main-content col-12" id="main-content">
	
	<div class="accordion" id="accordion">
		<c:if test="${vlist.size() ==0}">
			<h1>게시물이없습니다.</h1>
		</c:if>	
		<c:forEach items="${vlist}" var="vlist">
			<div class="card">
				<div class="card-header mqdefault" id="heading-${vlist.RN }" >
					<div class="container">
						<div class="row">
							
							<div class="col-12 col-md-4 align-self-center video-img-box"
								
								data-toggle="collapse" data-target="#collapse-${vlist.RN}"
								aria-expanded="false" aria-controls="collapse-${vlist.RN}"
								>
								
								<c:set var="strArray" value="${fn:split(vlist.vurl,'/')}" />
								<c:forEach items="${strArray }" var="videoId" varStatus="g">
									
									<c:if test="${g.count == 3}">
										<img  src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg" onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','imgClick')">
									</c:if>
							 	</c:forEach> 
								
							</div>
							
							<div class="col-12 col-md-8 video-info-box">
								<label class="video-title" data-toggle="collapse" data-target="#collapse-${vlist.RN}"
									aria-expanded="false" aria-controls="collapse-${vlist.RN }"
									onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','titleClick')">
									${vlist.vtitle}
									<span class="viewCnt">조회수 : ${vlist.viewcnt} &nbsp;</span>
								</label>
									
									<ul class="list-group info-group">
										<li class="list-group-item">작성자 : ${vlist.userid } </li>
										<li class="list-group-item">영상 링크 : ${vlist.vurl } </li>
									</ul>
									
									<div class="btn-box">
										<div class="btn-comment-box">
											<button class="btn btn-outline-dark" id="replyBtn-${vlist.bnum }" onclick="commentBox('${vlist.vnum}','${vlist.bnum }')" > 댓글 (0)
												<c:forEach items="${rlist }" var="rlist">
														<c:if test="${vlist.bnum == rlist.bnum }"> 
															<script>
															 	$("#replyBtn-"+${vlist.bnum} ).html("댓글 ("+${rlist.bnumCnt}+")");
															 </script>
														</c:if>	 
												</c:forEach>
											</button>
										</div>
										<div class="btn-like-box">
											<button class="btn btn-outline-success" onclick="judgment('up','${vlist.bnum}')">좋아요 <i class="fas fa-thumbs-up"></i> ${vlist.upcnt }</button>
											<button class="btn btn-outline-danger" onclick="judgment('down','${vlist.bnum}')">싫어요 <i class="fas fa-thumbs-down"></i> ${vlist.downcnt }</button> 
										</div>
									</div>
							</div>
						</div>
					</div>
				</div>

				<div id="collapse-${vlist.RN}" class="collapse colllapse-${vlist.vnum}" aria-labelledby="heading-${vlist.RN }" data-parent="#accordion">		
					<div class="card-body">

						<div id="videoBox-${vlist.vnum}" class="videoBox video-box-player-${vlist.vnum}">
							<div id="player-${vlist.vnum}"></div>
						</div>		
					</div>
				</div> 
				
				<hr>
				
				<div class="collapse comment-${vlist.vnum}" aria-labelledby="heading-${vlist.RN }" data-parent="#accordion">		
					<div class="card-body">
						<div class="container">
							<div class="reply-input-group row">
								<div class="col-md-10">
									<textarea  style="resize: none;" id="replyText-${vlist.bnum}" class="form-control"  rows="1" placeholder="댓글을 입력해주세요."></textarea>
								</div>
								<div class="col-md-2 reply-input-btn parentBtn">
									
									<button type="button"  name="boardNum-${vlist.bnum }" class="btn btn-dark" onclick="insertReply('${vlist.bnum}')">댓글 등록</button>
								</div>
							</div>
						</div>
						<hr>
						<div class="reply-list-group container">
							<div id="replyList-${vlist.bnum }"></div>
						</div>
					</div>
				</div> 
			</div>
		</c:forEach>
	
	</div> 
</div>




<script type="text/javascript">				
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

					height : '700px',
					width : '100%',
					videoId : data.videoId

				}) 
				
				
			},
			error : function(error) {
				alert("error");
			}

		})
		
		viewCntUp(bnum);
	}
}

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
					output += "<div class='reply-box border rounded-lg' id='reply-"+result[i].rpnum+"' >";
					output += "<div class='reply-replyer-box'>"+result[i].replyer+"</div>";
					output += "<div class='reply-text-box'>"+result[i].replyText+"<button class='btn btn-outline-dark reReply' onclick='reCommentBox("+result[i].rpnum+","+result[i].rnum+","+result[i].bnum+",0)'>답글</button></div>";  
					output +="</div>";																																			
					output +="<div id='reReply-"+result[i].bnum+"-"+result[i].rpnum+"'></div>"
				}
				
				if(result[i].rnum != 0){
					output +="<div class='reReply-box row'>";
					output += "<i class='fas fa-level-up-alt fa-rotate-90 fa-2x col-sm-1 reReplyIcon'></i>";
					output += "<div class='border rounded-lg col-sm reReply-box-child'>";
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

function reCommentBox(rpnum ,rnum,bnum ,rnum){
	
	//alert(rnum);
	var output ="<div class='reReplyContainer reReply-"+bnum+"-"+rpnum+"'>"
		output+="<div class='reply-input-group row'>"
		
		output+="<div class='col-md-10'>"
		output+="<textarea  style='resize: none;' id='replyText-"+bnum+"-"+rpnum+"' class='form-control'  rows='1' placeholder='답글을 입력해주세요.'></textarea>"
		output+="</div>"
		output+="<div class='col-md-2 reply-input-btn'>"
		
		output+="<button type='button' name='boardNum-"+bnum+"' class='btn btn-outline-secondary' onclick='insertReReply("+bnum+","+rpnum+")'>답글 등록</button>"
		output+="<button type='button' class='btn btn-outline-secondary' onclick ='cancel("+rpnum+","+bnum+")'>취소</button>"
		output+="</div></div></div>"
	  
		if(rnum == 0){
			
			$("#reReply-"+bnum+"-"+rpnum).html(output); 
		} 
		else{
			$("#reReply-"+bnum+"-"+rpnum+"-"+rnum).html(output); 
			
		}
}

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
	
	//var con = "${pagingMap.con}";
	//alert(con);
	condition();
}

function pageAnchor(data , gnum , con ,nowPage, startPage, lastPage){
					//next , 0 , bnum ,  1 , 10
	var cntPerPage = 10;
	var startPrev = Number(startPage)-1;
	var startNext = Number(startPage)+1;

	//alert(lastPage);
	switch(data){
		case "prev" :
			//alert("prev"); 
			if(nowPage != 1){
				//alert("1페이지 아님");
				
				$(".search-container").load("mainView.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #search-nav");
				$("#main-content").load("mainView.do?nowPage="+startPrev+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #accordion");
			}
			break;
	
		case "next" :
			if(nowPage != lastPage){
				//alert("다름");
				$(".search-container").load("mainView.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #search-nav");
				$("#main-content").load("mainView.do?nowPage="+startNext+"&cntPerPage="+cntPerPage+"&con="+con+"&gnum="+gnum+" #accordion");
				
			}
			if(nowPage == lastPage){
				//alert("같음");
			}
			break;
	
	}
}

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
		$(".search-container").load("mainView.do?con="+con+"&gnum="+gnum+" #search-nav");
		$("#main-content").load("mainView.do?con="+con+"&gnum="+gnum+" #accordion");
	}else if(clickCon == true && clickGenre == false){
		
		//alert("컨디션 o ,장르 x");
		//alert(con+","+gnum);
		
		$(".search-container").load("mainView.do?con="+con+" #search-nav");
		$("#main-content").load("mainView.do?con="+con+" #accordion");
	}else if(clickCon == false && clickGenre == true ){
		//alert("컨디션 x ,장르 o");
		//alert(con+","+gnum);
		$(".search-container").load("mainView.do?gnum="+gnum+" #search-nav");
		$("#main-content").load("mainView.do?gnum="+gnum+" #accordion");
		
	}else{
		//alert("X");
	}
};


function cancel(rpnum, bnum){
	
	$(".reReply-"+bnum+"-"+rpnum).replaceWith("<div id='reReply-"+bnum+"-"+rpnum+"></div>");
}


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