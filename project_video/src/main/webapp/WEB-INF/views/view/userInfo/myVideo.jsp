<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="paging-box mb-2">


	<div class="con-btn-group">
		<span class="page-title">내가 작성한 게시물 ( ${fn:length(vlist)} )</span>
	</div>

	<div class="my-paging-btn  ml-auto">
		<div id="my-paging-btn-group" class="btn-group" role="group"
			aria-label="Basic example">

			<button id="prev" type="button" class="btn btn-secondary"
				onclick="pageAnchor('prev','myVideo.do','${pagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage}')">
				<i class="fas fa-caret-left"></i>
			</button>
			<span class="btn btn-secondary"><b>${pagingVO.nowPage}</b></span>
			<button id="next" type="button" class="btn btn-secondary"
				onclick="pageAnchor('next','myVideo.do','${pagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage}')">
				<i class="fas fa-caret-right"></i>
			</button>
		</div>
	</div>
</div>

<!-- sm-title  -->
<div class="page-sm-title my-2">
	<span>내가 쓴 게시물</span> <span class="badge page-sm-badge">(${fn:length(vlist)})
	</span>
</div>

<div class="main-content" id="my-content">
	<div class="accordion" id="my-accordion">
		<c:if test="${fn:length(vlist) ==0}">
			<div class="boardNone">
				<i class="far fa-frown"></i> <span class="boardNone-text">
					게시물이 없습니다. </span>
			</div>
		</c:if>
		<c:forEach items="${vlist}" var="vlist">
			<div class="card body-card">
				<div class="card-header main-card-header" id="heading-${vlist.RN }">
					<div class="row">
						
						<div class="col-lg-5  align-self-center video-img-box"
							data-toggle="collapse" data-target="#collapse-${vlist.RN}"
							aria-expanded="false" aria-controls="collapse-${vlist.RN}">

							<c:set var="strArray" value="${fn:split(vlist.vurl,'/')}" />
							<c:forEach items="${strArray }" var="videoId" varStatus="g">
								<c:if test="${g.count == 3}">
									<img class="videoImg" src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg"
										onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','imgClick')">
								</c:if>
							</c:forEach>
						</div>

						<!--video-info-box  -->
						<div class="col-lg-7  video-info-box">
									
									
							<div class="video-info-row lg">
								<div class="video-title" data-toggle="collapse"
									data-target="#collapse-${vlist.RN}" aria-expanded="false"
									aria-controls="collapse-${vlist.RN }"
									onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','titleClick')">
									<span class="v-title">${vlist.vtitle}</span>
								</div>

								<div class="viewCnt badge">
									<i class="far fa-eye"></i> ${vlist.viewcnt }
								</div>
							</div>
							<div class="writer-info-row lg">
								<span class="u-title">작성자 : ${vlist.userid }</span>
								<div class="link badge">LINK</div>
							</div>
							<div class="btn-box-row lg">

								<div class="btn-comment-box">
									<button class="btn info-btn" id="replyBtn-${vlist.bnum }"
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
									<button class="btn info-btn"
										onclick="judgment('up','${vlist.bnum}')">
										좋아요 <i class="far fa-thumbs-up"></i> ${vlist.upcnt }
									</button>
									<button class="btn info-btn"
										onclick="judgment('down','${vlist.bnum}')">
										싫어요 <i class="far fa-thumbs-down"></i> ${vlist.downcnt }
									</button>

									<c:set value="/${vlist.bnum }/" var="fbnum" />

									<c:if test="${fn:contains(gui.favorites,fbnum)}">
										<button class="btn info-btn fbtn-${vlist.bnum }"
											onclick="favorites('${gui.unum}','${vlist.bnum }','true')">
											<i class="fas fa-star"></i>
										</button>
									</c:if>
									<c:if test="${not fn:contains(gui.favorites,fbnum)}">
										<button class="btn info-btn fbtn-${vlist.bnum }"
											onclick="favorites('${gui.unum}','${vlist.bnum }','false')">
											<i class="far fa-star"></i>
										</button>
									</c:if>
								</div>

							</div>
								
								<div class="video-info-row sm">
									<div class="video-title" data-toggle="collapse"
										data-target="#collapse-${vlist.RN}" aria-expanded="false"
										aria-controls="collapse-${vlist.RN }"
										onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','titleClick')">
										<span class="v-title">${vlist.vtitle}</span>
									</div>

									<div class="video-info badge">
										<div class="view-cnt">
											<i class="far fa-eye"></i> ${vlist.viewcnt}
										</div>

										<div class="reply-cnt"
											id="reply-cnt-${vlist.bnum}-${vlist.vnum}">

											<i class="far fa-comment-dots"></i>
											<c:set var="i" value="0" />
											<c:set var="sz" value="${fn:length(rlist) }" />

											<c:forEach items="${rlist}" var="rlist">
												<c:if test="${vlist.bnum == rlist.bnum }">
													${rlist.bnumCnt}
												</c:if>
												<c:if test="${vlist.bnum != rlist.bnum }">
													<c:set var="i" value="${i+1 }" />
													<c:if test="${sz == i }">
														0
													</c:if>
												</c:if>
											</c:forEach>
										</div>

										<div class="tool-box dropup">
											<i class="fas fa-ellipsis-v" data-toggle="dropdown"
												aria-haspopup="true" aria-expanded="false"
												data-display="static"></i>

											<div class="dropdown-menu dropdown-menu-right">
												<div class="v-dropup">

													<button class="btn"
														onclick="judgment('up','${vlist.bnum}')">
														<i class="far fa-thumbs-up"></i> ${vlist.upcnt}
													</button>

													<button class="btn"
														onclick="judgment('down','${vlist.bnum}')">
														<i class="far fa-thumbs-down"></i> ${vlist.downcnt }
													</button>

													<c:set value="/${vlist.bnum }/" var="fbnum" />
													<c:if test="${ fn:contains(gui.favorites,fbnum)}">
														<button class="btn"
															onclick="favorites('${gui.unum}','${vlist.bnum }','true')">
															<img class="star" src="resources/css/icon/star.png"></span>
														</button>
													</c:if>
													<c:if test="${not fn:contains(gui.favorites,fbnum)}">
														<button class="btn"
															onclick="favorites('${gui.unum}','${vlist.bnum }','false')">
															<img class="star" src="resources/css/icon/star-empty.png"></span>
														</button>
													</c:if>
													<button class="btn" data-toggle="modal"
														data-target="#myVideoUpdateModal"
														onclick="myVideoEdit('${vlist.vnum }','${vlist.vurl}','${vlist.vtitle}','${vlist.gnum}','${vlist.vpw }')">
														<img class="edit" src="resources/css/icon/edit.png" />
													</button>
												</div>
											</div>
										</div>
									</div>
								</div>

								
							</div>
						</div>

						<!--/video-info-box  -->
				

				</div>
				<!-- card-header -->

				<!--  card-body -->
				<div id="collapse-${vlist.RN}"
					class="collapse colllapse-${vlist.vnum} video-collapse-body"
					aria-labelledby="heading-${vlist.RN }" data-parent="#my-accordion">
					<div class="card-body">

						<div id="videoBox-${vlist.vnum}"
							class="videoBox video-box-player-${vlist.vnum}">
							<div id="player-${vlist.vnum}"></div>
						</div>
					</div>
				</div>

				<!-- reply  -->
				<div class="collapse comment-${vlist.vnum} reply-collapse-body"
					aria-labelledby="heading-${vlist.RN }" data-parent="#my-accordion">
					<div class="card-body">
						<div class="container">
							<div class="row reply-input-group">
								<div class="reply-input col-lg-10 col-10">
									<textarea style="resize: none;" id="replyText-${vlist.bnum}"
										class="form-control" rows="1" placeholder="댓글을 입력해주세요."></textarea>
								</div>
								<div class="reply-input-btn parentBtn col-lg-2 col-2">

									<button type="button" name="boardNum-${vlist.bnum }"
										class="btn reply-btn" onclick="insertReply('${vlist.bnum}')">댓글
										입력</button>
								</div>
							</div>
						</div>
						<hr class="reply-hr">
						<div class="reply-list-group container">
							<div id="replyList-${vlist.bnum }" class="replyList-row"></div>
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
						<label>LINK</label> <input type="text" class="form-control"
							name="vurl"> <input type="hidden" name="vnum">
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
	
	function myVideoEdit(vnum,vurl,vtitle,gnum,vpw){
		//alert(vnum);
		$("input[name=vnum]").val(vnum);
		$("input[name=vurl]").val(vurl);
		$("input[name=vtitle]").val(vtitle);
		$("input[name=vpw]").val(vpw); 
		$("select[name=gnum]").val(gnum).prop("selected",true);	
		$(".videoDelete").attr("id",vnum);
		
	}
	
</script>
