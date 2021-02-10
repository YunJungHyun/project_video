<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="left-menu">
	<ul class="list-group left-list-group">
		<li class="list-group-item conBtn" id="allCon">전체보기</li>
		<li class="list-group-item conBtn" id="viewCon">조 회 순</li>
		<li class="list-group-item conBtn" id="upCon">좋 아 요</li>
		<li class="list-group-item conBtn" id="latestCon">최 신 순</li>
	</ul>
</div>

<script type="text/javascript">

$(".conBtn").on("click",function(){
	
	
	$(".conBtn").each(function(){
		
	 	var btnClick = 	$(this).hasClass("btnClick");
	 	if(btnClick==true){
	 		
	 		$(this).removeClass("btnClick");
	 		$(this).css("border-color","");
	 	}
	})	
	
	$(this).css("border-color", "black");
	$(this).addClass("btnClick");
	
	var con= $(this).attr("id");
	
	window.location.href="mainView.do?con="+con;
})
	
</script>