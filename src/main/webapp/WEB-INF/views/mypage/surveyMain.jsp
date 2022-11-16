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
<title>설문조사 페이지</title>
	<style>
		.tb-section {
			width : 50%;
			margin-left : 8%;
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
		th {
			color : white;
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
			<h3>설문조사 현황</h3>
			<br><br><br><br>
			<div class="tb-section">
				<c:if test = "${!empty survey}">
					<table class="table table-bordered">
						<thead>
							<tr bgcolor="#AA7139">
								<th>성별</th>
								<th>연애여부</th>
								<th>취미</th>
								<th>목적</th>
								<th>선호 작가</th>
								<th>등록일</th>
							</tr>
						</thead>
							<tbody>
								<tr>
									<td>${survey.answerGender }</td>
									<td>${survey.answerLove }</td>
									<td>${survey.answerHobby }</td>
									<td>${survey.answerReason }</td>
									<td>${survey.answerWriter }</td>
									<td>${survey.updateDate }</td>
								</tr>
							</tbody>
					</table>
						<br><br><br>
						<div class="btn-section">
							<button type="button" class="btn" onclick="modifySurvey()">수정하기</button>
						</div>
					</c:if>
					<c:if test= "${empty survey }">
						<h5>등록된 설문지가 없습니다.</h5>
						<div align="center" class="btn-section">
							<button type="button" class="btn" onclick="registSurvey()">등록하기</button>
						</div>
					</c:if>
			</div>
		</div>
		<div class="col-md=3">
		</div>
	</div>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
	
	<script>
		function registSurvey() {
			location.href="/mypage/survey.kh";
		}
		function modifySurvey() {
			location.href="/mypage/modifyForm.kh";
		}
	</script>
</body>
</html>