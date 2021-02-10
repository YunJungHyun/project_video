<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="left-menu">
	<ul class="list-group left-list-group">
		<li class="list-group-item conBtn" id="allCon">전체보기</li>
		<li class="list-group-item conBtn" id="viewcnt">조 회 순</li>
		<li class="list-group-item conBtn" id="upcnt">좋 아 요</li>
		<li class="list-group-item conBtn" id="latestCon">최 신 순</li>
	</ul>
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