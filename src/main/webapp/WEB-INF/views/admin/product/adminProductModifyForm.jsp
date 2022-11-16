<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<link rel="stylesheet" href="../resources/css/admin/button.css"/>
<meta charset="UTF-8">
<title>상품 수정</title>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="../../admin/adminHeader.jsp"></jsp:include>
	<div class="main-contents">
		<div>
						<jsp:include page="../../admin/adminSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<!-- 이 안에서 작업! 여기가 본문-->
			<div class="container col-lg-8">
			
			<h1>상품 수정</h1>
				<div>
					<img class="img-thumbnail" id="preview" src="${book.imgPath }"/>
				</div>
			<form method="post" action="/admin/modifyProduct">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" value="${book.bookNo }" name="bookNo">
				<div class="form-group">
					<label for="bookTitle">도서명</label> 
					<input type="text"
						class="form-control" placeholder="도서명을 입력하세요." id="bookTitle"
						name="bookTitle" value="${book.bookTitle }"> 
				</div>
				<div class="form-group">
					<label for="bookWriter">저자 </label> 
					<input type="text"
						class="form-control" placeholder="저자를 입력하세요."
						id="bookWriter" name="bookWriter" value="${book.bookWriter }">
				</div>
				<div class="form-group">
					<label for="pubDate">발매일 </label> <input type="text"
						class="form-control" placeholder="발매일을 입력하세요."
						id="pubDate" name="pubDate" value="${book.pubDate }">
				</div>
				<div class="form-group">
					<label for="category">카테고리 </label> 
					<input type="text"
						class="form-control" placeholder="카테고리를 입력하세요." id="category"
						name="category" value="${book.category }">
				</div>
				<div class="form-group">
					<label for="bookContents">도서 내용 </label> 
					<input type="text"
						class="form-control" placeholder="도서 내용을 입력하세요." id="bookContents"
						name="bookContents" value="${book.bookContents }">
				</div>
				<div class="form-group">
					<label for="ISBN">ISBN </label> 
					<input type="text"
						class="form-control" placeholder="ISBN을 입력하세요." id="ISBN"
						name="ISBN" value="${book.ISBN }">
				</div>
				<div class="form-group">
					<label for="priceSales">판매가 </label> <input type="text"
						class="form-control" placeholder="판매가를 입력하세요."
						id="priceSales" name="priceSales" value="${book.priceSales }">
				</div>
				<div class="form-group">
					<label for="mileage">마일리지 </label>
					 <input type="text"
						class="form-control" placeholder="마일리지를 입력하세요." id="mileage"
						name="mileage" value="${book.mileage }">
				</div>
				<div class="form-group">
					<label for="publisher">출판사 </label>
					 <input type="text"
						class="form-control" placeholder="출판사를 입력하세요."
						id="publisher" name="publisher" value="${book.publisher }">
				</div>
				<div class="btn-section2" style="text-align:center">
					<button class="btn btn-outline-dark" type="submit">도서 수정</button>
					<button class="btn btn-outline-dark" type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</form>
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