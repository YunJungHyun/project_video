<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="paging-box">
	<input type="hidden" id="reNum" value="${reNum }"/>
	<div class="con-btn-group">
		<span class="page-title">오늘 본 게시물 ( ${fn:length(vlist)} )</span>
	</div>
</div>

<div class="page-sm-title my-2">
	<span>최근 본 게시물</span>
	<span class="badge page-sm-badge">(${fn:length(vlist)}) </span>
</div>

<div class="main-content" id="myRecently-content">
	<div class="accordion" id="myRecently-accordion">
		<c:if test="${fn:length(vlist) ==0}">
			<div class="boardNone">
				<i class="far fa-frown"></i> <span class="boardNone-text">
					게시물이 없습니다. </span>
			</div>
		</c:if>
		<c:forEach items="${vlist}" var="vlist">
			<div class="card body-card">
				<div class="card-header main-card-header" id="heading-${vlist.RN}">
					<div class="row">
						<div class="col-lg-5 align-self-center video-img-box"
							data-toggle="collapse" data-target="#collapse-${vlist.RN}"
							aria-expanded="false" aria-controls="collapse-${vlist.RN}">

									<img class="videoImg" id="img-${vlist.vnum }" src="${vlist.vthumimg}"
										onclick="videoClick('${vlist.videoid }','${vlist.vnum}','${vlist.vurl}','${vlist.bnum }','imgClick')">
								
						</div>

						
						<!--video-info-box  -->
						<div class="col-lg-7 video-info-box">

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
								<div class="video-info-row row-sm-${vlist.vnum} sm">
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

								
						
							
						</div>
						<!--/video-info-box  -->
					</div>
					
				</div>
				<!-- card-header -->

				<div id="collapse-${vlist.RN}"
					class="collapse colllapse-${vlist.vnum} video-collapse-body"
					aria-labelledby="heading-${vlist.RN }" data-parent="#myRecently-accordion">
					<div class="card-body">

						<div id="videoBox-${vlist.vnum}"
							class="videoBox video-box-player-${vlist.vnum}">
							<div id="player-${vlist.vnum}"></div>
						</div>
					</div>
				</div>
				<!-- reply  -->
				<div class="collapse comment-${vlist.vnum} reply-collapse-body"
					aria-labelledby="heading-${vlist.RN }" data-parent="#myRecently-accordion">
					<div class="card-body">
						<div class="container">
							<div class="row reply-input-group">
								<div class="reply-input col-lg-10 col-10">
									<textarea style="resize: none;" id="replyText-${vlist.bnum}"
										class="form-control reply-area" rows="1" placeholder="댓글을 입력해주세요."></textarea>
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
		
		var reNum="${reNum}";
		
		$("#img-"+reNum).trigger("click");
		
		
	})
	
	
</script>

