<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="search-container mb-3 ">
	<div class="input-group col-sm-6 ">
		<input type="text" class="form-control" placeholder="영상 검색" >
		<div class="input-group-append">
			<span class="input-group-text">검색</span>
		</div>
	</div>
	<div class="input-group col-sm-6 justify-content-end">
		<span class="input-group-text spanBtn">&lt;</span>
		<span class="input-group-text ">PAGE</span>
		<span class="input-group-text spanBtn">&nbsp;&nbsp;&nbsp;&gt;</span>
	</div>
</div>
<br>
<div class="genre-container col-12">
	<div class="genre-box">
		<c:forEach items="${glist }" var="glist">
			
			<button class="btn btn-outline-secondary">${glist.gname}</button>
			
		</c:forEach>
	
	</div>
</div>
<br>
<div class="main-content col-12">

	<div class="accordion" id="accordion">
		<c:forEach items="${vlist}" var="vlist">
			<div class="card" id="${vlist.vnum}" name="${vlist.vurl}">
				<div class="card-header mqdefault" id="heading-${vlist.RN }" >
					<div class="container">
						<div class="row">
							
							<div class="col-12 col-md-4 align-self-center video-img-box"
								
								data-toggle="collapse" data-target="#collapse-${vlist.RN}"
								aria-expanded="false" aria-controls="collapse-${vlist.RN}"
								id="${vlist.vurl}">
								
								<c:set var="strArray" value="${fn:split(vlist.vurl,'/')}" />
								<c:forEach items="${strArray }" var="videoId" varStatus="g">
									
									<c:if test="${g.count == 3}">
										<img  src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg">
								
									</c:if>
							 	</c:forEach> 
								
							</div>
							
							<div class="col-12 col-md-8 video-info-box">
								<label class="video-title" data-toggle="collapse" data-target="#collapse-${vlist.RN}"
									aria-expanded="false" aria-controls="collapse-${vlist.RN }">
									${vlist.vtitle}</label>
									
									<ul class="list-group info-group">
										<li class="list-group-item">작성자 : ${vlist.unum } </li>
										<li class="list-group-item">영상 링크 : ${vlist.vurl } </li>
									</ul>
									
									<div class="btn-box">
										<div class="btn-comment-box">
											<button class="btn btn-outline-dark" onclick="commentBox('${vlist.vnum}','${vlist.bnum }')" >댓글</button>
										</div>
										<div class="btn-like-box">
											<button class="btn btn-outline-success">좋아요 <i class="fas fa-thumbs-up"></i> 0</button>
											<button class="btn btn-outline-danger">싫어요 <i class="fas fa-thumbs-down"></i> 0</button> 
										</div>
									</div>
							</div>
						</div>
					</div>
				</div>

				<div id="collapse-${vlist.RN}" class="collapse" aria-labelledby="heading-${vlist.RN }" data-parent="#accordion">		
					<div class="card-body">

						<div class="videoBox video-box-player-${vlist.vnum}" id="videoBox-${vlist.vnum }">
							<div id="player-${vlist.vnum}"></div>
						</div>		
					</div>
				</div> 
				<hr>
				<div id="${vlist.bnum}" class="collapse comment-${vlist.vnum}" aria-labelledby="heading-${vlist.RN }" data-parent="#accordion">		
					<div class="card-body">
						<div class="container">
							<div class="reply-input-group row">
								<div class="col-md-10">
									<textarea  style="resize: none;" id="replyText-${vlist.bnum}" class="form-control"  rows="1" placeholder="댓글을 입력해주세요."></textarea>
								</div>
								<div class="col-md-2 reply-input-btn parentBtn">
									
									<button type="button"  name="boardNum-${vlist.bnum }" class="btn btn-dark insertReply ">댓글 등록</button>
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

$(document).ready(function(){
	
	
	$(".video-img-box, .video-title").on("click", function() {
	
	
	var clickTitle=$(this).attr("class");
	
	var bnum= $(this).parents(".card").children().next().next().next().attr("id");

	
	var vnum = $(this).parents(".card").attr("id");
	
	var vurl = $(this).parents(".card").attr("name");

	var player = $(this).parents(".card").children().next().children().children().children().attr("id");

	var openChk = $(this).parents(".card").children().next().children().children().hasClass("open");
	

	//열려 있는 아코디언이있다면 this의 "open" 을 삭제하고 iframe을 삭제한다.
	$(".videoBox").each(function(){
		
		if($(".videoBox").hasClass("open")){
			//alert("열려있는 아코디언있음");
			var rePlayer = $(this).children().attr("id");
			
			$(this).removeClass("open");
			$(this).children().replaceWith("<div id="+rePlayer+"></div>");
			$(".comment-"+vnum).removeClass("show");
		}
	})
	 
	if (openChk == false) {
				//alert("openChk==false");
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

				$(".video-box-player-" + vnum).addClass("open");
				
				//타이틀을 클릭해서 이벤트가 발생했다면 댓글창을 같이 보여준다.
				if(clickTitle == "video-title"){
					//alert("title");
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
	} 

})



$(".insertReply").on("click", function() {
 
							var replyName = $(this).attr("name");
							var rnArray = replyName.split("-");
							var bnum = rnArray[1];
							var replyText = $("#replyText-"+bnum).val();

							alert(bnum);

							$.ajax({

								url : "insertReply.do",
								type : "post",
								dataType : "text",
								data : {
									"replyText" : replyText,
									"bnum" : bnum
								},
								success : function(data) {

									alert(data);
									replyList(bnum);
								},
								error : function() {
									alert("error");
								}

							})
			})
			
					
})
					
					
function commentBox(vnum,bnum){
	
	var cmShowChk =$(".comment-"+vnum).hasClass("show");
	if(cmShowChk==false){
		$(".comment-"+vnum).addClass("show");
		
		replyList(bnum);
		
	}else{
		
		$(".comment-"+vnum).removeClass("show");
	}
	
}

function replyList(data){
	
	var bnum = data;
	
	$.ajax({
		type:"get",
		url : "replyList.do?bnum="+bnum,
		type : "json",
		success : function(result){
			
			//alert(JSON.stringify(result));
			var output ="";
			for (var i in result){
				
					
				output += "<div class='reply-box border rounded-lg' id='reply-"+result[i].rpnum+"' >";
				output += "<div class='reply-replyer-box'>"+result[i].replyer+"</div>";
				output += "<div class='reply-text-box'>"+result[i].replyText+"<button class='btn btn-outline-dark reReply' onclick='reCommentBox("+result[i].rpnum+","+result[i].rnum+","+result[i].bnum+")'>답글</button></div>";  
				output +="</div>";																																			
				output +="<div id='reReply-"+result[i].rpnum+"'></div>"
				
				
				if(result[i].rnum != 0){
					output +="<div class='reReply-box row'>";
					output += "<i class='fas fa-reply fa-rotate-180 fa-2x col-sm-1 reReplyIcon'></i>";
					output += "<div class='border rounded-lg col-sm reReply-box-child'>";
					output += "<div class='reply-replyer-box'>"+result[i].replyer+"</div>";
					output += "<div class='reply-text-box'>"+result[i].replyText+"<button class='btn btn-outline-dark reReply' id='reReply' onclick='reCommentBox()' >답글</button></div>"; 
					output += "</div>";
					output += "</div>";
				}; 
			}
			
			$("#replyList-"+bnum).html(output);
		},error :function(){
			
			alert("error");
			
		}
		 
		
	})
}

function reCommentBox(rpnum ,rnum,bnum){
	var output ="<div class='reReplyContainer reReply-"+rpnum+"'>"
		output+="<div class='reply-input-group row'>"
		
		output+="<div class='col-md-10'>"
		output+="<textarea  style='resize: none;' id='replyText-"+bnum+"' class='form-control'  rows='1' placeholder='답글을 입력해주세요.'></textarea>"
		output+="</div>"
		output+="<div class='col-md-2 reply-input-btn'>"
		
		output+="<button type='button' name='boardNum-"+bnum+"' class='btn btn-outline-secondary' onclick='insertReReply("+bnum+","+rpnum+")'>답글 등록</button>"
		output+="<button type='button' class='btn btn-outline-secondary' onclick ='cancel("+rpnum+")'>취소</button>"
		output+="</div></div></div><hr>"
	  
	
		$("#reReply-"+rpnum).html(output); 
	
}

function cancel(rpnum){
	
	$(".reReply-"+rpnum).replaceWith("<div id='reReply-"+rpnum+"></div>");
}


function insertReReply(bnum, rpnum){
	alert(bnum +','+rpnum);
}


</script>