<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<div class="genre-container col-12">
	
	<div class="genre-box">
		<c:forEach items="${glist }" var="glist">
			<button class="btn btn-outline-secondary">${ glist.gname}</button>
			
		</c:forEach>
	
	</div>
</div>

<div class="main-content col-12">

	<c:forEach items="${vlist}" var="vlist">

		<div class="accordion" id="accordion-${vlist.RN}">
			<div class="card">
				<div class="card-header" id="heading-${vlist.RN }">
					<h2 class="mb-0">
						<button  onclick="playerOpen('${vlist.vurl}');" class="btn btn-link collapsed" type="button"
							data-toggle="collapse" data-target="#collapse-${vlist.RN }"
							aria-expanded="false" aria-controls="collapse-${vlist.RN }" >
							${vlist.vtitle }	
						</button>
					</h2>
				</div>  

				<div id="collapse-${vlist.RN}" class="collapse" aria-labelledby="heading-${vlist.RN }" data-parent="#accordion-${vlist.RN }">
					<div class="card-body">	
						
						<div class="videoBox video-box-player-${vlist.bnum }" >
							<div id="player-${vlist.bnum }"></div>		
						</div>	
					</div> 
				</div>
			</div>
		</div> 
	</c:forEach>

	
</div>

<script type="text/javascript">
	var __player = null;
	
	var videoId =null;
	
	function playerOpen(vurl) {

		var strArray = vurl.split("/");

		videoId = strArray[3];
	}
	
	$(".card-header").on("click",function(){
		var checkShow = $(this).next().hasClass("show");
		var player =$(this).next().children().children().children().attr("id");
		 
		if(checkShow == false){
		 
			__player = new YT.Player(player, {
					
				height : '500px',
				width : '100%',
				videoId : videoId

			})
			
		}
	})
	

</script>