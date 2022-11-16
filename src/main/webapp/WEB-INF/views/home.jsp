<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var="principal" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>READ'Y</title>
	<style>
	.cat-title {
		margin-left : 3%;
		font-size : 20px;
		width : 87%;
		
	}
	.line {
		border-top : 1px solid #dcdcdc;
		width : 90%;
	}
		#book-area {
			float : left;
			margin-left : 3%;
			height : 370px;
		}
		.book-title {
			width : 170px;
			text-decoration : none;
		}
		.card {
			width : 15%;
		}
		.more{
			float : right;
			font-size : 15px;
			margin-top : 3px;
		}
		.cat-title > a {
			color : gray;
		}
		.card > a {
			color : black;
		}
		.main-side {
			width : 15%;
		}
	</style>
	<jsp:include page="../views/main/header.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
	<script src="/resources/js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<div class="main-contents">
		<div class="main-side"></div>
		<div class="main-section">
			<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="width:100%; height:400px">
  				<div class="carousel-indicators">
   					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  				</div>
  				<div class="carousel-inner" style="width:100%; height:100%">
    				<div class="carousel-item active" style="width:100%; height:100%">
         				<c:choose>
         					<c:when test="${bannerList[0].bannerFrom eq 1 }">
            					<img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[0].bannerRename}" style="width:100%; height:100%"/>
         					</c:when>
					        <c:when test="${bannerList[1].bannerFrom eq 1 }">
					           <img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[1].bannerRename}" style="width:100%; height:100%"/>
					        </c:when>
					        <c:when test="${bannerList[2].bannerFrom eq 1 }">
					           <img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[2].bannerRename}" style="width:100%; height:100%"/>
					        </c:when>
         					<c:otherwise>
            					<img class="img-fluid"  id="preview3" style="width:100%; height:100%"> 
         					</c:otherwise>
     					</c:choose>
    				</div>
    				<div class="carousel-item" style="width:100%; height:100%">
         				<c:choose>
         					<c:when test="${bannerList[0].bannerFrom eq 2 }">
            					<img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[0].bannerRename}" style="width:100%; height:100%"/>
        					</c:when>
         					<c:when test="${bannerList[1].bannerFrom eq 2 }">
            					<img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[1].bannerRename}" style="width:100%; height:100%"/>
         					</c:when>
         					<c:when test="${bannerList[2].bannerFrom eq 2 }">
            					<img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[2].bannerRename}" style="width:100%; height:100%"/>
         					</c:when>
         					<c:otherwise>
            					<img class="img-fluid"  id="preview3" style="width:100%; height:100%"> 
         					</c:otherwise>
      					</c:choose>
    				</div>
    				<div class="carousel-item" style="width:100%; height:100%">
      					<c:choose>
         					<c:when test="${bannerList[0].bannerFrom eq 3 }">
            					<img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[0].bannerRename}" style="width:100%; height:100%"/>
         					</c:when>
         					<c:when test="${bannerList[1].bannerFrom eq 3 }">
            					<img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[1].bannerRename}" style="width:100%; height:100%"/>
         					</c:when>
         					<c:when test="${bannerList[2].bannerFrom eq 3 }">
            					<img class="img-fluid"  id="preview3" src="/resources/images/banner/${bannerList[2].bannerRename}" style="width:100%; height:100%"/>
         					</c:when>
         					<c:otherwise>
            					<img class="img-fluid"  id="preview3" style="width:100%; height:100%"> 
         					</c:otherwise>
      					</c:choose>
   					</div>
  				</div>
  				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    				<span class="visually-hidden">Previous</span>
  				</button>
  				<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
			</div>
			<br><br><br>
			<div class="cat-title">
				READ'Y 베스트셀러
				<a href = "/book/category.kh?category=Best" class="more text-decoration-none">더보기</a>
			</div>
				<br>
				<c:forEach items="${bList1 }" var="book" end="4">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
				<div class="line"></div><br>
				<c:if test="${!empty rbook1 }">
				<div class="cat-title">
					READ'Y 추천도서
				</div>
				<br>
				<c:forEach items="${rbook1 }" var="book" end="0">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<c:forEach items="${rbook2 }" var="book" end="0">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<c:forEach items="${rbook3 }" var="book" end="0">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<c:forEach items="${rbook4 }" var="book" end="0">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<c:forEach items="${rbook5 }" var="book" end="0">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
				<div class="line"></div><br>
				</c:if>
				<div class="cat-title">
					READ'Y 신작
					<a href = "/book/category.kh?category=New" class="more text-decoration-none">더보기</a>
				</div>
				<br>
				<c:forEach items="${bList2 }" var="book" end="4">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
				<div class="line"></div><br>
				<div class="cat-title">
					READ'Y 소설
					<a href = "/book/category.kh?category=소설" class="more text-decoration-none">더보기</a>
				</div>
				<br>
				<c:forEach items="${bList4 }" var="book" end="4">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
				<div class="line"></div><br>
				<div class="cat-title">
					READ'Y 만화
					<a href = "/book/category.kh?category=만화" class="more text-decoration-none">더보기</a>
				</div>
				<br>
				<c:forEach items="${bList5 }" var="book" end="4">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
				<div class="line"></div><br>
				<div class="cat-title">
					READ'Y Study
					<a href = "/book/category.kh?category=study" class="more text-decoration-none">더보기</a>
				</div>
				<br>
				<c:forEach items="${bList6 }" var="book" end="4">
					<div class="card" id="book-area">
						<a href="/book/detailView.kh?bookNo=${book.bookNo }" class="book-detail text-decoration-none">
							<img src=${book.imgPath } width="180" height="250" class="card-img-top"><br>
							<div class="card-body">
								<c:choose>
                            		<c:when test="${fn:length(book.bookTitle) gt 20 }">
                            			<c:out value="${fn:substring(book.bookTitle, 0, 19) }...">
                            			</c:out>
                            		</c:when>
                            		<c:otherwise>
                            			<c:out value="${book.bookTitle }">
                            			</c:out>
                            		</c:otherwise>
<%--                             <p id="bookTitle" style="margin-bottom: 10%;">${cartList.book.bookTitle }</p> --%>
                            	</c:choose>	
							</div><br>
						</a>
					</div>
				</c:forEach>
		</div>
	</div>
	<div class="main-footer">
		<jsp:include page="../views/main/footer.jsp"></jsp:include>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	   	 <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">${notice.noticeTitle }</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	${notice.noticeContents }
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>	
	
	<script>
		function viewCategory(event) {
			category = event.target.innerText;
			location.href="/book/category.kh?category=" + category;
		}
		
		$(document).ready(function(){
			const principalCheck = '${principal.user.userId }';
			if(principalCheck == ''){
				$("#exampleModal").modal('show');
			}else{
				console.log();
			}
		});

	</script>

</body>
</html>
