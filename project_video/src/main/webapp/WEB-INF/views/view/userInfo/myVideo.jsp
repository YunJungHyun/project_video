<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="paging-box">


	<div class="col-lg-4 con-btn-group">
		<h4>내가 작성한 게시물</h4>
	</div>

	<div class="my-paging-btn  col-lg-auto ml-auto">
		<div id="my-paging-btn-group" class="btn-group" role="group"
			aria-label="Basic example">

			<button id="prev" type="button" class="btn btn-secondary"
				onclick="pageAnchor('prev','myVideo','','','${PagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage}')">
				<i class="fas fa-caret-left"></i>
			</button>
			<span class="btn btn-secondary"><b>${pagingVO.nowPage}</b></span>
			<button id="next" type="button" class="btn btn-secondary"
				onclick="pageAnchor('next','myVideo','','','${PagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage }')">
				<i class="fas fa-caret-right"></i>
			</button>
		</div>
	</div>
</div>



<div class="main-content" id="my-content">
	<div class="accordion" id="my-accordion">

		<c:forEach items="${vlist}" var="vlist">
			<div class="card body-card">
				<div class="card-header body-card-header" id="heading-${vlist.RN }">
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
									작성자 : ${vlist.userid } <span class="badge badge-info"> <a
										href="#">LINK</a>
									</span>

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

										<button class="btn btn-outline-dark info-inner-btn"
											data-toggle="modal" data-target="#myVideoUpdateModal"
											onclick="myVideoUpdate('${vlist.vnum }','${vlist.vurl}','${vlist.vtitle}','${vlist.gnum}','${vlist.vpw }')">
											수정 <i class="fas fa-wrench"></i>
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
					aria-labelledby="heading-${vlist.RN }" data-parent="#my-accordion">
					<div class="card-body">

						<div id="videoBox-${vlist.vnum}"
							class="videoBox video-box-player-${vlist.vnum}">
							<div id="player-${vlist.vnum}"></div>
						</div>
					</div>
				</div>
				<!-- reply  -->
				<div class="collapse comment-${vlist.vnum}"
					aria-labelledby="heading-${vlist.RN }" data-parent="#my-accordion">
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

<div class="modal fade" id="myVideoUpdateModal" tabindex="-1"
	role="dialog" aria-labelledby="myVideoUpdateModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="videoRegFormModalLabel">게시글 수정</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="videoUpdateForm" name="videoUpdateForm">
					<div class="form-group">
						<label>LINK</label> 
						<input type="text" class="form-control" name="vurl">
						<input type="hidden" name="vnum">
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label>제목</label> <input type="text" class="form-control"
								name="vtitle" placeholder="TITLE">
						</div>
						<div class="form-group col-md-6">
							<label>종류 선택</label> <select class="form-control"
								id="update-gnum" name="gnum">
								<option value="">선택</option>
								<c:forEach items="${glist}" var="glist">
									<option value="${glist.gnum}">${glist.gname}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label>동영상 비밀번호</label> <input type="password"
							class="form-control" name="vpw">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="videoUpdate" class="btn btn-primary">등록</button>
				<button type="button" id="" class="btn btn-danger videoDelete">삭제</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		 
		var gui = "${gui}";
		var unum = "${gui.unum}";
		if(gui ==""){
			
			alert("로그인 후 이용해주세요.");
			window.location.href="mainView.do";
		}
		
		$(".videoDelete").on("click",function(){
			
			var con =confirm("해당 글을 삭제하시겠습니까?");
		
			if(con == true){
				
				$.ajax({
					
					url : "videoDelete.do",
					data : {"vnum" : $(this).attr("id")},
					type : "POST",
					dataType : "TEXT",
					success: function(){
						alert("해당 글이 삭제되었습니다..");
						$('#myVideoUpdateModal').modal('hide');
						$(".my-paging-btn").load("myVideo.do?unum="+unum +"  #my-paging-btn-group");
						$("#my-content").load("myVideo.do?unum="+unum+" #my-accordion");
					},error : function(){
						
						alert("error");	
					}
					
				})
			}
		})
		
		$("#videoUpdate").on("click",function(){
			
			var queryString = $("form[name=videoUpdateForm]").serialize().replace(/%/g,'%25') ;
			
			
			$.ajax({
				
				url : "myVideoUpdate.do",
				type :"POST",
				dataType :"TEXT",
				data : queryString,
				success :function(data){
					
					alert("게시글이 수정되었습니다.");
					$('#myVideoUpdateModal').modal('hide');
					$(".my-paging-btn").load("myVideo.do?unum="+unum +"  #my-paging-btn-group");
					$("#my-content").load("myVideo.do?unum="+unum+" #my-accordion");
				},error : function(error){
					
					alert("error");
				}
			})
		})
	})
	
	function myVideoUpdate(vnum,vurl,vtitle,gnum,vpw){
		//alert(vnum);
		$("input[name=vnum]").val(vnum);
		$("input[name=vurl]").val(vurl);
		$("input[name=vtitle]").val(vtitle);
		$("input[name=vpw]").val(vpw); 
		$("select[name=gnum]").val(gnum).prop("selected",true);	
		$(".videoDelete").attr("id",vnum);
		
	}
	
</script>

