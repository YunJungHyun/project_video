<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project_video</title>

</head>
<body>
	<div class="headerwrap">
		
			<tiles:insertAttribute name="header" />
		
	</div>
	<div class="content" id="content"> 
		

			<tiles:insertAttribute name="body" />	
	
	</div>
	<div class="footer">
		
			<tiles:insertAttribute name="footer" />
		
	</div>



</body>
</html>