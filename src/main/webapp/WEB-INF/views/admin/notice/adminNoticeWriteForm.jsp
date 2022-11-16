<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<meta charset="UTF-8">
<title>공지사항 작성</title>
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
<!-- 서머노트를 위해 추가해야할 부분 -->
<script src="/resources/js/summernote-lite.js"></script>
<script src="/resources/js/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/css/summernote-lite.css">
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
			<h1>공지사항 작성</h1>
			<form method="post" action="/admin/postNotice">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input class="form-control mb-3" type="text" name="noticeTitle" placeholder="제목을 입력하세요." required width="100%">
				<textarea width="100%" class="summernote" name="noticeContents" required></textarea>
			<div class="mt-5" style="text-align:center">
				<button class="btn btn-outline-dark" type="submit">공지사항 등록</button>
				<button class="btn btn-outline-dark" type="button" onclick="history.back();">뒤로가기</button>
			</div>
			</form>
			</div>
			<footer> 
								<jsp:include page="../../../views/main/footer.jsp"></jsp:include>
			</footer>
		</div>
	<script>
		$('.summernote').summernote({
			placeholder: '공지사항 내용을 입력하세요.',
			height : 300,
			lang : "ko-KR",
		/* 		  focus : true, */
		});
	</script>
</body>
</html>