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
			<button class="btn btn-outline-secondary">${glist.gname}</button>
			
		</c:forEach>
	
	</div>
</div>

<div class="main-content col-12">

	<div class="accordion" id="accordion">
		<c:forEach items="${vlist}" var="vlist">
			<div class="card">
				<div class="card-header" id="heading-${vlist.RN }" name="${vlist.vnum}">
					<h2 class="mb-0" id="${vlist.vurl }">
						<button class="btn btn-link collapsed" type="button"
							data-toggle="collapse" data-target="#collapse-${vlist.RN }"
							aria-expanded="false" aria-controls="collapse-${vlist.RN }">
							${vlist.vtitle }</button>
					</h2>
				</div>

				<div id="collapse-${vlist.RN}" class="collapse"
					aria-labelledby="heading-${vlist.RN }" data-parent="#accordion">
					<div class="card-body">

						<div class="videoBox video-box-player-${vlist.vnum}" id="videoBox-${vlist.vnum }">
							<div id="player-${vlist.vnum}"></div>
						</div>
						
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<script type="text/javascript">
	$(".card-header").on("click", function() {
			var vnum = $(this).attr("name");
				var vurl = $(this).children().attr("id");

				var player = $(this).next().children().children().children().attr("id");

				var openChk = $(this).next().children().children().hasClass("open");
				
				$(".videoBox").each(function(){
					
					if($(".videoBox").hasClass("open")){
						//alert("열려있는 아코디언있음");
						var rePlayer = $(this).children().attr("id");
						
						$(this).removeClass("open");
						$(this).children().replaceWith("<div id="+rePlayer+"></div>");
						
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
</script>