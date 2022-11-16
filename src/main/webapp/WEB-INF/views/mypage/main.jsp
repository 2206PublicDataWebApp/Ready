<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>마이페이지</title>
	<style>
		.table {
		width : 30%;
		margin : 0;
		}
		h3 {
			margin-left : 32%;
		}
		h5 {
		margin-left : 60%;
		}
		.text {
			margin-left : 28%;
		}
		.tb-section {
			width : 50%;
			margin-left : 25%;
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
		<div class="main-sidebar">
      		<jsp:include page="../main/mypageSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
		<br><br>
			<h3>${principal.user.userName}(${principal.user.userNickname })님의 마이페이지</h3><br><br>
			<div>
				<div class="text">회원님의 등급</div>
				<h5> ${principal.user.userTier }</h5>
				<br><br>
				<div class="text">총 결제 금액</div>
				<h5><fmt:formatNumber type="number" value="${principal.user.userPurchase }" pattern="#,###"/>원</h5>
				<br><br>
				<div class="text">내 적립금</div>
				<h5><fmt:formatNumber type="number" value="${principal.user.userReserves }" pattern="#,###"/>원</h5>
			</div>
				<br><br><br><br>
			<div class="tb-section">
				<table class="table table-hover">
					<thead>
						<tr bgcolor="#AA7139" >
							<th>등급</th>
							<th>조건</th>
							<th>혜택</th>
						</tr>
					</thead>
					 <tbody>
						<tr>
							<td>브론즈</td>
							<td>가입시 자동등급</td>
							<td>구매시 1% 할인</td>
						</tr>
						<tr>
							<td>실버</td>
							<td>총 200,000원 구매시 승급</td>
							<td>구매시 3% 할인</td>
						</tr>
						<tr>
							<td>골드</td>
							<td>총 500,000원 구매시 승급</td>
							<td>구매시 5% 할인</td>
						</tr>
						<tr>
							<td>VIP</td>
							<td>총 1,000,000원 구매시 승급</td>
							<td>구매시 10% 할인</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="main-sidebar">
		</div>
	</div>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
</body>
</html>