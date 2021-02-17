<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="list-group my-4 left-menu">
	<a href="#" class="list-group-item" id="#">즐겨 찾기</a> 
	<a href="#" class="list-group-item " id="#">최근 본 영상</a>
</div>


<script type="text/javascript">

$(".conBtn").on("click",function(){

	
	$(".conBtn").each(function(){
		
	 	var btnClick = 	$(this).hasClass("conClick");
	 	if(btnClick==true){
	 		
	 		$(this).removeClass("conClick");
	 		$(this).css("border-color","");
	 	}
	})	
	
	$(this).css("border-color", "black");
	$(this).addClass("conClick");
	
	condition();
})
	
</script>