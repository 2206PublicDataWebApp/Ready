<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<meta charset="UTF-8">
<title>신고 관리</title>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">

</head>
<body>
	<jsp:include page="../../admin/adminHeader.jsp"></jsp:include>
	<div class="main-contents">
		<div>
						<jsp:include page="../../admin/adminSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<div class="container col-lg-8">
			<!-- 이 안에서 작업! 여기가 본문-->
			<h1>신고 관리</h1>
			<h4>신고된 글</h4>
			<table class="table table-hover">
				<thead>
					<tr bgcolor="#AA7139" style="color:white">
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록시간</th>
						<th>처리결과</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${reportList }" var="reportList" varStatus="i">
					<tr>
						<td>${reportList.boardNo}</td>
						<td><a href="/admin/reportDetail?boardNo=${reportList.boardNo}">${reportList.commTitle }</a></td>
						<td>${reportList.commWriter }</td>
						<td>${reportList.cUpdateDate }</td>
						<td></td>
					</tr>
					</c:forEach>
					<tr align="center" height="20">
						<td colspan="7">
							<c:if test="${reportCurrentPage != 1 }">
								<a href="/admin/${reportUrlVal }?page=${reportCurrentPage - 1 }">
									<button class="btn btn-outline-dark">이전</button>
								</a>
							</c:if>
							<c:if test="${reportCurrentPage == 1 }">
									<button class="btn btn-outline-dark disabled">이전</button>
							</c:if>
							<c:forEach var="p" begin="${reportStartNavi }" end="${reportEndNavi }">
								<c:if test="${reportCurrentPage eq p }">
									<button class="btn btn-dark">${p}</button>
								</c:if>
								<c:if test="${reportCurrentPage ne p }">
									<a href="/admin/${reportUrlVal }?page=${p }">
									<button class="btn btn-outline-dark">${p}</button>
									</a>
								</c:if>
							</c:forEach>
							<c:if test="${reportMaxPage > reportCurrentPage }">
								<a href="/admin/${reportUrlVal }?page=${reportCurrentPage + 1 }">
								<button class="btn btn-outline-dark">
			                		다음
			                	</button>
								</a>
							</c:if>
							<c:if test="${reportMaxPage == reportCurrentPage }">
								<button class="btn btn-outline-dark disabled">
			                		다음
			                	</button>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="container col-lg-8">
			<!-- 이 안에서 작업! 여기가 본문-->
			<h4>처리된 글</h4>
			<table class="table table-hover">
				<thead>
					<tr bgcolor="#AA7139" style="color:white">
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록시간</th>
						<th>처리결과</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${completeList }" var="completeList" varStatus="i">
					<tr>
						<td>${completeList.boardNo}</td>
						<td><a href="/admin/reportDetail?boardNo=${completeList.boardNo}">${completeList.commTitle }</a></td>
						<td>${completeList.commWriter }</td>
						<td>${completeList.cUpdateDate }</td>
						<td>${completeList.reportResult }</td>
					</tr>
					</c:forEach>
					<tr align="center" height="20">
						<td colspan="7">
							<c:if test="${completeCurrentPage != 1 }">
								<a href="/admin/${completeUrlVal }?page=${completeCurrentPage - 1 }">
									<button class="btn btn-outline-dark">이전</button>
								</a>
							</c:if>
							<c:if test="${completeCurrentPage == 1 }">
									<button class="btn btn-outline-dark disabled">이전</button>
							</c:if>
							<c:forEach var="p" begin="${completeStartNavi }" end="${completeEndNavi }">
								<c:if test="${completeCurrentPage eq p }">
									<button class="btn btn-dark">${p}</button>
								</c:if>
								<c:if test="${completeCurrentPage ne p }">
									<a href="/admin/${completeUrlVal }?page=${p }">
									<button class="btn btn-outline-dark">${p}</button>
									</a>
								</c:if>
							</c:forEach>
							<c:if test="${completeMaxPage > completeCurrentPage }">
								<a href="/admin/${completeUrlVal }?page=${completeCurrentPage + 1 }">
								<button class="btn btn-outline-dark">
			                		다음
			                	</button>
								</a>
							</c:if>
							<c:if test="${completeMaxPage == completeCurrentPage }">
								<button class="btn btn-outline-dark disabled">
			                		다음
			                	</button>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<footer>
							<jsp:include page="../../../views/main/footer.jsp"></jsp:include>
		</footer>
		</div>
	</div>
	<script>
	</script>
</body>
</html>