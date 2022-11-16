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
<title>나의 문의글</title>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<link rel="stylesheet" href="/resources/css/que/faqList.css">
<link rel="stylesheet" href="/resources/css/comm/listView.css">
<link rel="stylesheet" href="/resources/css/comm/commForm.css">
<script src="/resources/js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<jsp:include page="../main/header.jsp"></jsp:include>
    <div class="main-contents">
		<div class="main-sidebar">
		
		</div>
		<div class="main-section">
			<div class="faq-div">
				<h2 class="list-title">1:1문의글</h2>
				<table align="center" class="table-style">
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
					<tr class="detail-contents">
						<td class="detail-content" colspan="4" align="left">${que.queContents }</td>
					</tr>
					<c:if test="${!empty que.qAnswer }">
						<tr class="border-top">
							<td colspan="4" class="border-top">
								<h2 class="list-title">답변</h2>
							</td>
						</tr>
						<tr class="detail-contents">
							<td colspan="4" align="left" class="detail-content-bot">${que.qAnswer }</td>
						</tr>
					</c:if>
					<c:if test="${principal.user.userRole eq 'ROLE_ADMIN' }">
						<tr>
							<td colspan="4" align="center">
								<button class="rvs-sig-btn rvs-sig-btn-lg" onclick="deleteQue(${page});">삭제</button>
								<c:if test="${que.qStatus ne 'F' }">
									<c:if test="${que.qStatus eq 'N' }">
										<button class="sig-btn sig-btn-lg" onclick="location.href='/que/answerView.kh?queNo=${que.queNo }&page=${page}'">답변등록</button>
									</c:if>
									<c:if test="${que.qStatus eq 'Y' }">
										<button class="sig-btn sig-btn-lg" onclick="location.href='/que/answerView.kh?queNo=${que.queNo }&page=${page}'">답변수정</button>
									</c:if>
								</c:if>
							</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="4" align="right" class="detail-content-bot">
							<c:if test="${principal.user.userRole ne 'ROLE_ADMIN' }">
								<a class="a-button" href="/que/myList.kh">리스트</a>
							</c:if>
							<c:if test="${principal.user.userRole eq 'ROLE_ADMIN' }">
								<c:if test="${que.qStatus eq 'F'}">
									<a class="a-button" href="/que/myList.kh?page=${page}">리스트</a>
								</c:if>
								<c:if test="${que.qStatus ne 'F'}">
									<a class="a-button" href="/admin/manageList.kh?page=${page }">리스트</a>
								</c:if>
							</c:if>
						</td>
					</tr>
				</table>
			</div>
		
		
		</div>
		<div class="main-sidebar"></div>
    </div>
    <div class="main-footer div-top">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
	<footer>
		
	</footer>
	<script>
		function deleteQue(value){
			event.preventDefault(); // 하이퍼링크 이동 방지
			if(confirm("게시물을 삭제하시겠습니까?")) {
				location.href="/que/remove.kh?page="+value;
			}
		}
	</script>
</body>
</html>