<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="paging-box">


	<div class="col-lg-4 con-btn-group">
		<h4>즐겨찾기한 게시물</h4>
	</div>

	<div class="myFav-paging-btn  col-lg-auto ml-auto">
		<div id="myFav-paging-btn-group" class="btn-group" role="group"
			aria-label="Basic example">

			<button id="prev" type="button" class="btn btn-secondary"
				onclick="pageAnchor('prev','favVideo','','','${PagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage}')">
				<i class="fas fa-caret-left"></i>
			</button>
			<span class="btn btn-secondary"><b>${pagingVO.nowPage}</b></span>
			<button id="next" type="button" class="btn btn-secondary"
				onclick="pageAnchor('next','favVideo','','','${PagingMap.nowPage}','${pagingVO.startPage}','${pagingVO.lastPage }')">
				<i class="fas fa-caret-right"></i>
			</button>
		</div>
	</div>
</div>

<div class="page-sm-title my-2">
	<span>즐겨찾기</span> <span class="badge page-sm-badge">(${fn:length(vlist)})
	</span>
</div>


<div class="main-content" id="myFav-content">
	<div class="accordion" id="myFav-accordion">

		<c:forEach items="${vlist}" var="vlist">
			<div class="card body-card">
				<div class="card-header main-card-header" id="heading-${vlist.RN}">
					<div class="row">
						<div class="col-lg-4 align-self-center video-img-box"
							data-toggle="collapse" data-target="#collapse-${vlist.RN}"
							aria-expanded="false" aria-controls="collapse-${vlist.RN}">

							<c:set var="strArray" value="${fn:split(vlist.vurl,'/')}" />
							<c:forEach items="${strArray }" var="videoId" varStatus="g">
								<c:if test="${g.count == 3}">
									<img id="img-${vlist.vnum}" src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg"
										onclick="videoClick('${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','imgClick')">
								</c:if>
							</c:forEach>
						</div>

						<!--video-info-box  -->
						<div class="col-lg-8 video-info-box">

							<div class="row">
								<div class="video-info-row">
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
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="btn-box-row">

									<div class="btn-comment-box">
										<button class="btn  info-inner-btn"
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
										<button class="btn info-inner-btn"
											onclick="judgment('up','${vlist.bnum}')">
											좋아요 <i class="fas fa-thumbs-up"></i> ${vlist.upcnt }
										</button>
										<button class="btn info-inner-btn"
											onclick="judgment('down','${vlist.bnum}')">
											싫어요 <i class="fas fa-thumbs-down"></i> ${vlist.downcnt }
										</button>

										<c:set value="/${vlist.bnum }/" var="fbnum" />

										<c:if test="${fn:contains(gui.favorites,fbnum)}">
											<button
												class="btn btn-outline-warning info-inner-btn fbtn-${vlist.bnum }"
												onclick="favorites('${gui.unum}','${vlist.bnum }','true')">
												<i class="fas fa-star"></i>
											</button>
										</c:if>
										<c:if test="${not fn:contains(gui.favorites,fbnum)}">
											<button
												class="btn btn-outline-warning info-inner-btn fbtn-${vlist.bnum }"
												onclick="favorites('${gui.unum}','${vlist.bnum }','false')">
												<i class="far fa-star"></i>
											</button>
										</c:if>
									</div>

								</div>
							</div>

						</div>
						<!--/video-info-box  -->
					</div>
					<!-- /.row -->
				</div>
				<!-- card-header -->

				<div id="collapse-${vlist.RN}"
					class="collapse colllapse-${vlist.vnum} video-collapse-body"
					aria-labelledby="heading-${vlist.RN }"
					data-parent="#myFav-accordion">
					<div class="card-body">

						<div id="videoBox-${vlist.vnum}"
							class="videoBox video-box-player-${vlist.vnum}">
							<div id="player-${vlist.vnum}"></div>
						</div>
					</div>
				</div>
				<!-- reply  -->
				<div class="collapse comment-${vlist.vnum} reply-collapse-body"
					aria-labelledby="heading-${vlist.RN }"
					data-parent="#myFav-accordion">
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


<script type="text/javascript">
	$(document).ready(function(){
		
			
		/* vnum으로 처리할것   */
		var favNum="${favNum}";
		
		$("#img-"+favNum).trigger("click");
		
		
		
	})
	
</script>

