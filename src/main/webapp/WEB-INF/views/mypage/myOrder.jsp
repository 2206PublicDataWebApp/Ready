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
<title>내 주문내역</title>
	<jsp:include page="../main/header.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
	<style>
		td > a {
			color : black;
			text-decoration : none;
		}
		a > button {
			background-color:#AA7139;
		}
		a > button:hover {
			background-color:#804A15;
			color : white;
		}
		#btn-b {
			background-color:#804A15;
			color : white;
		}
		th {
			color : white;
		}
	</style>
</head>
<body>
	<div class="main-contents">
		<div class="col-md-3">
			<jsp:include page="../main/mypageSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<br>
			<div class="page-title">
				<h3>${principal.user.userName}님의 주문 내역</h3>
			</div>
			<br><br><br>
			<div class="tb-section">
				<table class="table table-hover align-middle" >
					<thead>
						<tr align="center" bgcolor="#AA7139">
							<th>상품정보</th>
							<th>구매일자</th>
							<th>주문번호</th>
							<th>결제금액</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty oList}">
							<td colspan="5" align="center">주문한 내역이 없습니다.</td>
						</c:if>
						<c:if test="${!empty oList}">
							<c:forEach items="${oList }" var="order" varStatus="i">
								<tr align="center">
										<td>
											<a href="/order/orderDetailView?orderId=${order.orderId }">
												<img src="${order.book.imgPath }" width="150" height="200">
											</a>
										</td>
										<td>
											<a href="/order/orderDetailView?orderId=${order.orderId }">
												${order.orderDate }
											</a>
										</td>
										<td>
											<a href="/order/orderDetailView?orderId=${order.orderId }">
												${order.orderId }
											</a>
										</td>
										<td>
											<a href="/order/orderDetailView?orderId=${order.orderId }">
												<fmt:formatNumber type="number" value="${order.totalPrice }" pattern="#,###"/>원
											</a>
										</td>
										<td>
											<a href="/order/orderDetailView?orderId=${order.orderId }">
												<c:if test="${order.orderState eq 'R'}">	
												환불 완료
												</c:if>
												<c:if test="${order.orderState eq 'Y'}">	
												구매 확정
												</c:if>
												<c:if test="${order.orderState eq 'N'}">	
												결제 완료
												</c:if>
											</a>
										</td>
									
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<br>
			<div align="center">
				<div>
					<c:if test="${!empty oList }">
						<c:if test="${currentPage != 1 }">
							<a href="/mypage/${urlVal }.kh?page=${currentPage - 1 }">
								<button class="btn">이전</button>
							</a>
						</c:if>
						<c:forEach var="p" begin="${startNavi }" end="${endNavi }">
							<c:if test="${currentPage eq p }">
								<button class="btn" id="btn-b">${p }</button>
							</c:if>
							<c:if test="${currentPage ne p }">
								<a href="/mypage/${urlVal }.kh?page=${p }">
									<button class="btn">${p }</button>
								</a>
							</c:if>
						</c:forEach>
						<c:if test="${maxPage > currentPage }">
							<a href="/mypage/${urlVal }.kh?page=${currentPage + 1 }">
								<button class="btn">다음</button>
							</a>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		<div class="col-md-3">
		</div>
	</div>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
</body>
</html>