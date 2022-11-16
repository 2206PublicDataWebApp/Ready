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
<title>카테고리 도서목록</title>
	<style>
		.page-title {
			margin-left : 10%;
		}
		.view-section {
			margin-left : 20%;
		}
		#book-area {
			float : left;
			margin-right : 6px;
		}
		.book-title {
			width : 170px;
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
		<div class="main-sidebar"></div>
		<div class="main-section">
		<c:if test="${category eq 'Best'}">
			<div class="page-title">
				<h3>Read'y 베스트셀러</h3>
			</div>
		</c:if>
		<c:if test="${category eq 'New'}">
			<div class="page-title">
				<h3>Read'y 신작도서</h3>
			</div>
		</c:if>
		<c:if test="${category eq '소설'}">
			<div class="page-title">
				<h3>Read'y 소설</h3>
			</div>
		</c:if>
		<c:if test="${category eq '만화'}">
			<div class="page-title">
				<h3>Read'y 만화</h3>
			</div>
		</c:if>
		<c:if test="${category eq 'study'}">
			<div class="page-title">
				<h3>Read'y 공부도서</h3>
			</div>
		</c:if>
		<br><br><br>
		<div class="view-section">
			<c:if test="${!empty bList }">
				<c:forEach items="${bList }" var="book" varStatus="i">
					<div class="card mb-3" style="width: 700px;">
      					<a href="/book/detailView.kh?bookNo=${book.bookNo }">
	  						<div class="row g-0">
	    						<div class="col-md-4">
	      							<img src=${book.imgPath } class="img-fluid rounded-start" width="200" height="250">
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
			                    <a href="/book/category.kh?page=${currentPage - 1 }&category=${category }" class="btn-section">
			                    	<button class="btn">이전</button>
			                   </a>
			                </c:if>
			                <c:forEach var="p" begin = "${startNavi }" end="${endNavi }">
			                    <c:if test="${currentPage eq p }">
			                        <button class="btn" id="btn-b">${p}</button> 
			                    </c:if>
			                    <c:if test="${currentPage ne p }">
			                        <a href = "/book/category.kh?page=${p }&category=${category }" class="btn-section">
			                        	<button class="btn">${p}</button>
			                        </a>
			                    </c:if>
			                </c:forEach>
			            	<c:if test = "${currentPage < maxPage }">
			                	<a href = "/book/category.kh?page=${currentPage + 1}&category=${category }" class="btn-section">
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