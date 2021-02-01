<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project_video</title>

<!-- bootstrap 4.3.1 css   -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- 내가 설정한 css  -->
<link type="text/css" rel="stylesheet" href="<c:url value='resources/css/css.css'/>"/>

 

<!-- bootstrap 4.3.1 js  -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</head>
<body>
	<div class="headerBox"> 
		<c:if test="${ user == null}">
			<tiles:insertAttribute name="noUserHeader" />
		</c:if>
		<c:if test="${ user != null}">
			<tiles:insertAttribute name="userHeader" />
		</c:if>
	</div>
	<div class="container-fluid">
		<div class="row flex-xl-nowrap">
			<div class="left-menuBox col-12 col-md-3 col-xl-2">
				<tiles:insertAttribute name="left-menu" />	
			</div>
			<div class="mainBox col-md-8 col-12 col-md-9 col-xl-8 py-md-3 pl-md-5 "> 
					<tiles:insertAttribute name="body" />	
			</div>
			<div class="right-menuBox col-12 col-xl-2">
				<tiles:insertAttribute name="right-menu" />	
			</div>
		</div>
	</div>
	<div class="footerBox">
			<tiles:insertAttribute name="footer" />
	</div>

</body>
</html>