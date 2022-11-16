<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>내 게시글</title>
	<style>
		.page-title {
		}
		.tb-section {
			width : 75%;
		}
		td > a {
			color : black;
			text-decoration : none;
		}
		a > button {
			background-color:#AA7139;
			color : white;
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
			<div class="page-title">
				<h3>${principal.user.userName }님의 게시글</h3>
			</div>
			<br><br><br>
			<div class="tb-section">
				<table class="table table-hover align-middle">
					<thead>
						<tr align="center" bgcolor="#AA7139">
							<th>번호</th>
							<th colspan="2">제목</th>
							<th>날짜</th>
							<th>조회수</th>
							<th>추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${!empty cList }">
							<c:forEach items="${cList }" var="comm" varStatus="i">
								<tr align="center">
									<td><%-- ${comm.boardNo } --%>${fn:length(cList) - i.index}<!--${i.count } 얘는 게시글 ASC로 출력--></td>
									<td colspan="2"><a href="#" onclick="location.href='/comm/detail.kh?boardNo=${comm.boardNo }&page=${currentPage }'" >${comm.commTitle  }</a></td>
									<!--  -->
									<td>${comm.cCreateDate }</td>
									<td>${comm.cCount }</td>
									<td>${comm.cLike }</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty cList }">
							<tr>
								<td colspan="6" align="center"><b>데이터가 존재하지 않습니다.</b></td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<br>
				<c:if test="${!empty cList }">
						<div align="center">
							<div>
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
							</div>
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
</body>
</html>