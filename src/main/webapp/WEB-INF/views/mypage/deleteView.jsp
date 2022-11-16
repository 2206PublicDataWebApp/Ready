<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
	<style>
		.page-title {
			margin-left : 10%;
		}
		.btn-section > button {
			background-color:#AA7139;
			color : white;
		}
		.btn-section > button:hover {
			background-color:#804A15;
         	color : white;
         	border-color : #804A15;
		}
	</style>
	<jsp:include page="../main/header.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
</head>
<body>
	<div class="main-contents">
		<div class="col-md-3">
      		<jsp:include page="../main/mypageSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<br>
			<h3>회원탈퇴</h3>
			<br>
			<h5>회원님의 등록한 이메일을 입력해주세요.</h5>
			<br><br>
			<form action="/mypage/deleteUser.kh" method="post">
				<input type="hidden" name="userEmail" value="${principal.user.userEmail }">
				<input type="text" name="textEmail">
				<br><br>
				<div class="btn-section">
					<button type="submit" class="btn">회원 탈퇴</button>
				</div>
			</form>
		</div>
		<div class="col-md-3">
		</div>
	</div>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
</body>
</html>