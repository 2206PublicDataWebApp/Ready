<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공용jsp틀</title>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<link rel="stylesheet" href="/resources/css/admin/admin.css">
</head>
<body>
	<jsp:include page="../../admin/adminHeader.jsp"></jsp:include>
	<div class="main-contents">
		<div class="main-sidebar">
						<jsp:include page="../../admin/adminSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<!-- 이 안에서 작업! 여기가 본문-->
			<h1>공지사항 관리</h1>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록시간</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${noticeList }" var="noticeList" varStatus="i">
					<tr>
						<td>${noticeList.noticeNumber }</td>
						<td><a href="/admin/noticeDetail?noticeNumber=${noticeList.noticeNumber }">${noticeList.noticeTitle }</a></td>
						<td>${noticeList.noticeWriter }</td>
						<td><fmt:formatDate value="${noticeList.postDate }" pattern="yyyy-mm-dd hh:mm:ss"/></td>
					
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<table>
			        <tr align="center" height="20">
			            <td colspan="6">
			                <c:if test="${currentPage != 1}">
			                    <a href="/admin/${urlVal }?page=${currentPage - 1 }">[이전]</a>
			                </c:if>
			                <c:forEach var="p" begin = "${startNavi }" end="${endNavi }">
			                    <c:if test="${currentPage eq p }">
			                        <b>${p}</b> 
			                    </c:if>
			                    <c:if test="${currentPage ne p }">
			                        <a href = "/admin/${urlVal }?page=${p }&searchCondition=${searchCondition }&searchValue=${searchValue }">${p}</a>
			                    </c:if>
			                </c:forEach>
			            	<c:if test = "${currentPage < maxPage }">
			                	<a href = "/admin/${urlVal}?page=${currentPage + 1}">[다음]</a>
			            	</c:if>
			            </td>
		        	</tr>
			</table>
			<button class="btn btn-primary" onclick="writeNotice()">공지사항 등록</button>



		</div>
	<footer> </footer>
	<script>

	function writeNotice(){
		location.href="/admin/admin-noticeForm";
	}
	</script>
</body>
</html>