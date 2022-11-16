<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var="principal" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<meta charset="UTF-8">
<title>도서 목록</title>
	<style>
		.page-title {
			margin-left : 10%;
		}
		.view-section {
			margin-left : 20%;
		}
		.card > a {
			color : black;
			text-decoration : none;
		}
		.page-section > a {
			text-decoration : none;
		}
		.btn-section > button {
			background-color:#AA7139;
			color : white;
		}
		.btn-section > button:hover {
			background-color:#804A15;
			color : white;
		}
		#btn-b {
			background-color:#804A15;
			color : white;
		}
	</style>
	
	<jsp:include page="../main/header.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
</head>
<body>
	<div class="main-contents">
		<div class="main-sidebar">여기는 사이드바</div>
		<div class="main-section">
			<div class="page-title">
				<h3>'${searchValue }'의 검색 결과</h3>
			</div>
			<br><br><br>
			<div class="view-section">
			<c:if test="${empty bList }">
				<h3>검색조건에 맞는 도서가 없습니다.</h3>
			</c:if>
			<c:if test="${!empty bList }">
				<c:forEach items="${bList }" var="book" varStatus="i">
					<div class="card mb-3" style="width: 700px;">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }">
							<div class="row g-0"> 
								<div class="col-md-4">
									<img src=${book.imgPath } width="200" height="250">
								</div>
								<div class="col-md-8">
									<div class="card-body">
										<h5 class="card-title">${book.bookTitle }</h5>
		        						<p class="card-text"><small class="text-muted">${book.publisher }</small></p>
		       							<p class="card-text">판매가 : <fmt:formatNumber type="number" value="${book.priceSales }" pattern="#,###"/> 원</p>
		       							<p class="card-text">평점 : ${book.scoreAvg }</p>
		       							<p class="card-text"><small class="text-muted">적립금 : <fmt:formatNumber type="number" value="${book.mileage }" pattern="#,###"/>원</small></p>
									</div>
								</div>
							</div>
       					</a>
					</div>
					<br>
					<br>
					<br>
				</c:forEach>		
			</c:if>
			</div>
			        <div align="center">
			            <div class="page-section">
			                <c:if test="${currentPage != 1}">
			                    <a href="/book/${urlVal }.kh?page=${currentPage - 1 }" class="btn-section">
			                    	<button class="btn">이전</button>
			                    </a>
			                </c:if>
			                <c:forEach var="p" begin = "${startNavi }" end="${endNavi }">
			                    <c:if test="${currentPage eq p }">
			                        <button class="btn" id="btn-b">${p}</button> 
			                    </c:if>
			                    <c:if test="${currentPage ne p }">
			                        <a href = "/book/${urlVal }.kh?page=${p }&searchCondition=${searchCondition }&searchValue=${searchValue }" class="btn-section">
			                        	<button class="btn">${p}</button>
			                        </a>
			                    </c:if>
			                </c:forEach>
			            	<c:if test = "${currentPage < maxPage }">
			                	<a href = "/book/${urlVal}.kh?page=${currentPage + 1}&searchCondition=${searchCondition }&searchValue=${searchValue }" class="btn-section">
			                		<button class="btn">다음</button>
			                	</a>
			            	</c:if>
			            </div>
		        	</div>
		</div>
		<div class="main-sidebar"></div>
	</div>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
</body>
</html>