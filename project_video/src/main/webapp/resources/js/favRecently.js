
/*즐겨찾기 새로고침 */
function favRefresh(userid, width){
	//alert(userid+","+width);
	
	var favList ="${gui.favorites}";
	if(width <= 991){
		
		if(favList =="/"){
			
			$("#favoritesNone-sm").css("display" ,"block");
		
		}else{
			
			$("#favoritesNone-sm").css("display" ,"none");
			
			$.ajax({
				
				url : "favList.do",
				type : "get",
				dataType :"json",
				data:{
					
					"fav" : favList
				},
				success : function(data){
					var length = data.length
					
					
					var output ="";
					var h = 0;
					
					var i = 0;
					
					var j =0;
					var k =0;
					var l =0;
					
					output += "<div id='favorites-sm-slide' class='carousel slide' data-ride='carousel' data-interval='false'>"
					
					output +="<div class='carousel-inner favorites-inner'>"
					
					for(i ; i <Math.ceil(length/3); i++){
						output+="<div class='carousel-item'>";
							output+="<div class='favList'>";
							for(j ; j <length;j++){
								
								
								if(data[j] ==null){
									if(k< l+3){
										output +="<div class='item-emptyBoard col-4' id='favEmpty-"+j+"'>"
										output +="<img src='resources/img/no-video.png'>"
										output +="<span class='favList-name'>삭제된 게시물 입니다.</span>";
										output +="</div>"
										k++;
									}else{
									
										l+=3;
										break;
									}
								}else{
								
									var vurl = data[j].vurl;
									var vtitle =data[j].vtitle;
									var videoIdArray=vurl.split("/");
									var videoId = videoIdArray[3];
								
									if(k < l+3){
										output +="<div class='favList-item col-4' id='fav-"+j+"'>"
										output +="<img src='https://img.youtube.com/vi/"+videoId+"/mqdefault.jpg'>"
										output +="<span class='favList-name'>"+vtitle+"</span>";
										output +="</div>"
										k++;
									}else{
									
										l+=3;
										break;
									}
								
								}
								
							}
							output+="</div>";
						output+="</div>";
					}
					
					output +="</div>";
					
					output += "<ol class='carousel-indicators'>"
					for(h ; h <Math.ceil(length/3); h++){
							output+= "<li data-target='#favorites-sm-slide' data-slide-to='"+h+"' class='active'>";
							
						} 
					output +="</ol>";
					
					output+="<a class='carousel-control-prev' href='#favorites-sm-slide' role='button' data-slide='prev'>"
					output+="<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Previous</span>";
					output+="</a>";
					
					output+="<a class='carousel-control-next' href='#favorites-sm-slide' role='button' data-slide='next'>"
					output+="<span class='carousel-control-next-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Next</span>";
					output+="</a>";
					
					output +="</div>";
					
					
					
					
					$(".favorites-sm").html(output);
					$(".favorites-inner").children().first().addClass("active");
					
				},error : function(){
					alert("error");
				}
				
			})
			
			
		}	
	}
	
}

function recentlyRefresh(userid, width){
	//alert(userid +" , "+ width+" , "+document.cookie);
	var cookieList =document.cookie;
	
	
	if(width<=991){
		//alert("991이하");
		if(cookieList.indexOf(userid) == -1){
			//alert("block");
			$("#recentlyNone-sm").css("display" ,"block");
		}
		else{
			
			$("#recentlyNone-sm").css("display" ,"none");
			
			var cookie ="";
			
			if(cookieList.indexOf(";") != -1){
				var cookieArray = cookieList.split(";");
				
				for( var  i = 0 ; i < cookieArray.length ;i++){ 
					
					var chk = cookieArray[i].includes(userid);
					
					
					if(chk == true ){
						var updateArray = cookieArray[i].replace(userid+"=","");
						var updateArray2 = updateArray.replace(";","");
						cookie = updateArray2.split("%2C");
						
			 			
					}  
					
				}
			
			}else{
				
				var updateArray = document.cookie.replace(userid+"=","");
				cookie = updateArray.split("%2C");	
				
			}
			
			
			 //cookie 값이 한번에 안넘어가서 hidden input으로 받은다음 value를 넘겨줌
			 
			$("#cookie").val(cookie);
			
			var cookie = $("#cookie").val();
			
			
			$.ajax ({
				
				url : "recentlyList.do",
				type :"GET",
				data :{
					
					"cookie" : cookie 
				},
				dataType:"json",
				success : function(data){
					//	var x =data;
					var length = data.mlist.length;
					

					var output ="";
					var h = 0;
					
					var i = 0;
					
					var j =0;
					var k =0;
					var l =0;
					
					output += "<div id='recently-sm-slide' class='carousel slide' data-ride='carousel' data-interval='false'>"
					
					output +="<div class='carousel-inner recently-inner'>"
					
					for(i ; i <Math.ceil(length/3); i++){
						output+="<div class='carousel-item'>";
							output+="<div class='recentlyList'>";
							for(j ; j <length;j++){
								
								if(data.mlist[j] ==null){
									if(k< l+3){
										output +="<div class='item-emptyBoard col-4' id='recentlyEmpty-"+j+"'>"
										output +="<img src='resources/img/no-video.png'>"
										output +="<span class='recentlyList-item-name'>삭제된 게시물 입니다.</span>";
										output +="</div>"
										k++;
									}else{
									
										l+=3;
										break;
									}
								}else{
								
								
								var vurl = data.mlist[j].vurl;
								var vtitle =data.mlist[j].vtitle;
								var videoIdArray=vurl.split("/");
								var videoId = videoIdArray[3];
								
								if(k < l+3){
									output +="<div class='recentlyList-item col-4' id='recently-"+j+"'>"
									output +="<img src='https://img.youtube.com/vi/"+videoId+"/mqdefault.jpg'>"
									output +="<span class='recentlyList-name'>"+vtitle+"</span>";
									output +="</div>"
									k++;
								}else{
									
									l+=3;
									break;
								}
								}
							}
							output+="</div>";
						output+="</div>";
					}
					
					output +="</div>";
					
					output += "<ol class='carousel-indicators'>"
					for(h ; h <Math.ceil(length/3); h++){
							output+= "<li data-target='#recently-sm-slide' data-slide-to='"+h+"' class='active'>";
							
						} 
					output +="</ol>";
					
					output+="<a class='carousel-control-prev' href='#recently-sm-slide' role='button' data-slide='prev'>"
					output+="<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Previous</span>";
					output+="</a>";
					
					output+="<a class='carousel-control-next' href='#recently-sm-slide' role='button' data-slide='next'>"
					output+="<span class='carousel-control-next-icon' aria-hidden='true'></span>";
					output+="<span class='sr-only'>Next</span>";
					output+="</a>";
					
					output +="</div>";
					
					
					
					
					$(".recently-sm").html(output);
					$(".recently-inner").children().first().addClass("active");
					
					
					//alert($(".carousel-item").length);
				},error : function(){
					alert("error");
				}
			})
			
			
		}
	}
}

/* 오늘 본게시물 슬라이드 아이템 클릭  */
$(document).on("click", ".recentlyList-item", function() {
	var recentlyId = $(this).attr("id");
	var rArray = recentlyId.split("-");
	var reNum = rArray[1];

	//alert("renum :" + reNum);
	myRecentlyList(reNum);
})

function myRecentlyList(reNum) {
	var cookie = $("#cookie").val();
	//alert(reNum+","+cookie);
	window.location.href = "myRecentlyVideo.do?reNum=" + reNum + "&cookie="+ cookie;
}
/* 오늘 본게시물 슬라이드 아이템 클릭  끝 */

/* 즐겨찾기, 최근본 게시물 삭제된 게시물 처리  */
$(document).on("click", ".item-emptyBoard", function() {

		var emptyId = $(this).attr("id");
		var eArray = emptyId.split("-");
		var listName = eArray[0];
		var favNum=eArray[1];
		//alert(listName);
		if(listName=="recentlyEmpty"){
			alert("이미 삭제된 게시물 입니다.");
			return false;
		}
		if(listName=="favEmpty"){
			
			var con = confirm("즐겨찾기 목록에서 삭제하시겠습니까?");
			
			if (con == true) {
				$.ajax({

					url : "emptyDelete.do",
					type : "post",
					data : {
						"favNum" : favNum
					},
					success : function() {
						alert("해당 게시물이 즐겨찾기 목록에서 삭제되었습니다.");
						window.location.href = "mainView.do";
					},
					error : function() {
						alert("error");
					}
				})
			}else{
				
				return false;
			}
		}
		

		
	})
/* 즐겨찾기, 최근본 게시물 삭제된 게시물 처리  */
/* 즐겨찾기 슬라이드 아이템 클릭  */
$(document).on("click", ".favList-item", function() {
	var favId = $(this).attr("id");
	var fArray = favId.split("-");
	var favNum = fArray[1];

	myFavList(favNum);
})

function myFavList(favNum) {
	var gui = "${gui}";
	if (gui == "") {

		alert("로그인 후 이용해주세요.");
		return false;
	}
	//alert(favNum);
	window.location.href = "myFavVideo.do?favNum=" + favNum;
}

/* 즐겨찾기 슬라이드 아이템 클릭  끝*/