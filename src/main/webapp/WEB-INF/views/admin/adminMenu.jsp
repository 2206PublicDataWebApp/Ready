<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<meta charset="UTF-8">
<title>Read'y 관리자 메뉴</title>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
</head>
<body>
	<jsp:include page="../admin/adminHeader.jsp"></jsp:include>
	<div class="main-contents">
		<div>
			<jsp:include page="../admin/adminSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<!-- 이 안에서 작업! 여기가 본문-->
			<div class="container col-lg-8">
			<h2>관리자님 안녕하세요.</h2>
			<h5>관리자 메뉴입니다.</h5>
			<h5>원하는 메뉴를 왼쪽에서 선택해주세요.</h5>
			
			<table class="table mt-5">
				<thead>
					<tr class="table border-3" bgcolor="#AA7139" style="color:white">
						<th colspan="4">오늘의 주요 업무</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>문의 등록</td><td>현재 ${questionCount } 건 남음</td><th>처리</th><td>현재 ${answeredCount } 건 완료</td>
					</tr>
					<tr>
						<th>신고 등록</td><td>현재 ${reportCount } 건 남음</td><th>처리</th><td>현재 ${completeCount } 건 완료</td>
					</tr>
				</tbody>
			</table>
			
			</div>
			</div>
		</div>
	
	<footer>
		<jsp:include page="../../views/main/footer.jsp"></jsp:include>
	</footer>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>

</body>
</html>