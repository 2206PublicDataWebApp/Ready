<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 관리</title>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<link rel="stylesheet" href="/resources/css/que/faqList.css">
<link rel="stylesheet" href="/resources/css/comm/commForm.css">
<link rel="stylesheet" href="/resources/css/comm/listView.css">
</head>
<body>
	<jsp:include page="../main/header.jsp"></jsp:include>
    <div class="main-contents">
		<div class="main-sidebar">여기는 사이드바
		</div>
		<div class="main-section">
		<div class="faq-div">
				<h1 class="none-height">FAQ 관리</h1>
				<table border="1" class="list-table center">
					<tr class="faq-header">
						<th width="15%">유형</th>
						<th colspan="4" width="52%">제목</th>
						<th class="th-left" width="13%">작성자</th>
						<th width="10%">작성일</th>
						<th width="10%">답변여부</th>
					</tr>
					<c:if test="${!empty qList }">
						<c:forEach items="${qList }" var="question" varStatus="i">
							<tr class="tr-line">
								<td>
									<c:if test="${question.qCategory eq 'user'}">회원정보</c:if>
									<c:if test="${question.qCategory eq 'order'}">교환/환불</c:if>
									<c:if test="${question.qCategory eq 'item'}">상품관련</c:if>
									<c:if test="${question.qCategory eq 'delivery'}">배송관련</c:if>
									<c:if test="${question.qCategory eq 'etc'}">기타문의</c:if>
								</td>
								<td colspan="4" class="th-left"><a class="td-title" href="#" onclick="location.href='/que/myQue.kh?queNo=${question.queNo}&page=${currentPage}'">${question.queTitle }</a></td>
								<td class="th-left">${question.queWriter }</td>
								<td>${question.qEnrollDate }</td>
								<td>
									<c:if test="${question.qStatus eq 'N' }"><p class="qStatus-n">답변대기</p></c:if>
									<c:if test="${question.qStatus eq 'Y' }"><p class="qStatus-y">답변완료</p></c:if>
								</td>
							</tr>
						</c:forEach>
						<tr class="faq-div" height="20">
						<td colspan="8" class="paging-td">
							<c:if test="${currentPage != 1 }">
								<a class="a-button" href="/que/${urlVal }.kh?page=${currentPage - 1 }&searchCondition=${searchCondition}&searchValue=${searchValue}">[이전]</a>
							</c:if>
							<c:forEach var="p" begin="${startNavi }" end="${endNavi }">
								<c:if test="${currentPage eq p }">
									<b>${p }</b>
								</c:if>
								<c:if test="${currentPage ne p }">
									<a class="a-button" href="/que/${urlVal }.kh?page=${p }&searchCondition=${searchCondition}&searchValue=${searchValue}">${p }</a>
								</c:if>
							</c:forEach>
							<c:if test="${maxPage > currentPage }">
								<a class="a-button" href="/que/${urlVal }.kh?page=${currentPage + 1 }&searchCondition=${searchCondition}&searchValue=${searchValue}">[다음]</a>
							</c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${empty qList }">
						<tr>
							<td colspan="8" class="faq-div"><b>데이터가 존재하지 않습니다.</b></td>
						</tr>
					</c:if>
					<tr>
						<td colspan="8" class="faq-div">
							<form action="/question/search.kh" method="get">
								<select name="searchCondition">
									<option value="title" <c:if test="${searchCondition eq 'title' }">selected</c:if>>제목</option>
									<option value="contents" <c:if test="${searchCondition eq 'contents' }">selected</c:if>>내용</option>
								</select>
								<input type="text" name="searchValue" value="${searchValue }">
								<input class="rvs-sig-btn" type="submit" value="검색">
							</form>
						</td>
					</tr>
					<tr>
						<td colspan="8" align="right">
							<button class="sig-btn sig-btn-lg" onclick="location.href='/que/faq01.kh'">FAQ 목록</button>
							<!-- <button onclick="location.href='/que/viewWriteAdmin.kh'">글쓰기</button> -->
						</td>
					</tr>	
				</table>
			</div>
		</div>
		<div class="main-sidebar"></div>
    </div>
	<footer>
		
	</footer>
</body>
</html>