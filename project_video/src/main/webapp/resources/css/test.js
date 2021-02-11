$(".video-img-box, .video-title").on("click", function() {
	
	
	//var clickTitle=$(this).hasClass("video-title");

	//var bnum= $(this).parents(".card").children().next().next().next().attr("id");

	
	//var vnum = $(this).parents(".card").attr("id");
	
	//var vurl = $(this).parents(".card").attr("name");

	//var player = $(this).parents(".card").children().next().children().children().children().attr("id");

	//var openChk = $(this).parents(".card").children().next().children().children().hasClass("open");
	

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
				//alert(openChk);
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
				if(clickTitle==true){
					 
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

})



$(".insertReply").on("click", function() {
 	var gui = "${gui}";
 	
 	if( gui == ""){
 		
 		alert("로그인 후 이용해주세요.");
 		return false;
 	}
							
							var replyName = $(this).attr("name");
							var rnArray = replyName.split("-");
							var bnum = rnArray[1];
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
			})
			
					
