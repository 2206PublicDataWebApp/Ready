<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<title>답변 등록</title>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<link rel="stylesheet" href="/resources/css/que/faqList.css">
<link rel="stylesheet" href="/resources/css/comm/listView.css">
<link rel="stylesheet" href="/resources/css/comm/commForm.css">
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 서머노트를 위해 추가해야할 부분 -->
  <script src="/resources/js/summernote-lite.js"></script>
  <script src="/resources/js/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="/resources/css/summernote-lite.css">
</head>
<body>
	<jsp:include page="../main/header.jsp"></jsp:include>
    <div class="main-contents">
		<div class="main-sidebar">
		
		</div>
		<div class="main-section">
				<h2 class="list-title list-div">1:1 문의 답변 등록</h2>
				<form action="/que/answer.kh" method="post" enctype="multipart/form-data">
					<input type="hidden" name="page" value="${page }">
					<input type="hidden" name="queNo" value="${que.queNo }">
					<table class="table-style list-table" align="center">
						<tr class="detail-comm">
							<th>유형</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일</th>
						</tr>
						<tr class="detail-comm">
							<td>
								<c:if test="${que.qCategory eq 'user'}">회원정보</c:if>
								<c:if test="${que.qCategory eq 'order'}">교환/환불</c:if>
								<c:if test="${que.qCategory eq 'item'}">상품관련</c:if>
								<c:if test="${que.qCategory eq 'delivery'}">배송관련</c:if>
								<c:if test="${que.qCategory eq 'etc'}">기타문의</c:if>
							</td>
							<td>${que.queTitle }</td>
							<td>${que.queWriter }</td>
							<td>${que.qEnrollDate }</td>
						</tr>
						<tr class="border-bot">
							<td class="detail-content" colspan="4" align="left">${que.queContents }</td>
						</tr>
						
					</table>
					<table class="table-style list-table" align="center">
						<tr>
							<td colspan="4">
								<h2 class="center none-height">답변</h2>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="detail-content-bot">
								<textarea id="qAnswer" class="summernote" name="qAnswer"></textarea>
							</td>
						</tr>
						<c:if test="${principal.user.userRole eq 'ROLE_ADMIN' }">
							<tr>
								<td colspan="4" align="center">
									<button type="button" class="rvs-sig-btn" onclick="goList();">취소</button>
									<button class="sig-btn">등록</button>
								</td>
							</tr>
						</c:if>
					</table>
				</form>
		
		
		</div>
		<div class="main-sidebar"></div>
    </div>
	<footer>
		
	</footer>
	<script>
		$('.summernote').summernote({
		 	placeholder: '내용을 입력해주세요.',
	        height: 300,
	        lang: 'ko-KR'
	 	});
		function goList() {
			location.href="/admin/manageList.kh";
		}
	</script>
</body>
</html>