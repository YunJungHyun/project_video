<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand" id="navbar-brand" href="#page-top">
			YOONPLAYER </a>
		
		<ul class="nav justify-content-end">
			<li class="nav-item">
				<a class="nav-link nav-btn" data-target="#boardRegFormModal" data-toggle="modal" href="#">게시물 등록</a>
			</li>
			&nbsp;
			<li class="nav-item ">
				<div class="dropdown">
					<a class="nav-link nav-btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" href="#">내정보</a>
					<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
						<button class="dropdown-item" type="button">나의 회원 정보</button>
						<button class="dropdown-item" type="button">내가 작성한 게시글</button>
						
					</div>
				</div>
			
			</li>
		</ul>
		
	</div> 
</nav> 
 

<!-- Modal -->
<div class="modal fade" id="boardRegFormModal" tabindex="-1" role="dialog" aria-labelledby="boardRegFormModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="boardRegFormModalLabel">게시글 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     	<form id="boardRegForm" action="boardReg.do" method="POST">
			
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
 