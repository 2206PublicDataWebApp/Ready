<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<meta charset="UTF-8">
<title>배너 관리</title>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<link rel="stylesheet" href="../resources/css/admin/button.css"/>
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
			<h1>배너 관리</h1>
			<div>
				<h5>1번 배너</h5>
					<div style="border: 1px solid black; height: 300px">
					<c:choose>
						<c:when test="${bannerList[0].bannerFrom eq 1 }">
							<img class="img-fluid" id="preview1" src="/resources/images/banner/${bannerList[0].bannerRename}" style="width:100%; height:100%"/>
						</c:when>
						<c:when test="${bannerList[1].bannerFrom eq 1 }">
							<img class="img-fluid" id="preview1" src="/resources/images/banner/${bannerList[1].bannerRename}" style="width:100%; height:100%"/>
						</c:when>
						<c:when test="${bannerList[2].bannerFrom eq 1 }">
							<img class="img-fluid" id="preview1" src="/resources/images/banner/${bannerList[2].bannerRename}" style="width:100%; height:100%"/>
						</c:when>
						<c:otherwise>
							<img class="img-fluid" id="preview1" style="width:100%; height:100%">
						</c:otherwise>
					</c:choose>
					
					</div>
				<form method="post" action="/admin/registerBanner" encType="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input class="form-control" type="file" name="bannerImage"  onchange="readFile(this,1);">
					<input type="hidden" name="bannerFrom" value="1">
					<div class="mt-3 btn-section2" style="text-align:center">
						<button class="btn btn-outline-dark type="submit">배너 등록</button>
						<button class="btn btn-outline-dark" type="button" onclick="removeBanner(1);">배너 삭제</button>
					</div>
				</form>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
			</div>

			<div>
				<h5>2번 배너</h5>
					<div style="border: 1px solid black; height: 300px">
					<c:choose>
						<c:when test="${bannerList[0].bannerFrom eq 2 }">
							<img class="img-fluid"  id="preview2" src="/resources/images/banner/${bannerList[0].bannerRename}" style="width:100%; height:100%"/>
						</c:when>
						<c:when test="${bannerList[1].bannerFrom eq 2 }">
							<img class="img-fluid"  id="preview2" src="/resources/images/banner/${bannerList[1].bannerRename}" style="width:100%; height:100%"/>
						</c:when>
						<c:when test="${bannerList[2].bannerFrom eq 2 }">
							<img class="img-fluid"  id="preview2" src="/resources/images/banner/${bannerList[2].bannerRename}" style="width:100%; height:100%"/>
						</c:when>
						<c:otherwise>
							<img class="img-fluid"  id="preview2" style="width:100%; height:100%">
						</c:otherwise>
					</c:choose>
					</div>
				<form method="post" action="/admin/registerBanner" encType="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input class="form-control"  type="file" name="bannerImage"  onchange="readFile(this,2);">
					<input type="hidden" name="bannerFrom" value="2">
					<div class="mt-3 btn-section2" style="text-align:center">
						<button class="btn btn-outline-dark type="submit">배너 등록</button>
						<button class="btn btn-outline-dark" type="button" onclick="removeBanner(2);">배너 삭제</button>
					</div>
				</form>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
			</div>

			<div>
				<h5>3번 배너</h5>
					<div style="border: 1px solid black; height: 300px">
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
				<form method="post" action="/admin/registerBanner" encType="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input class="form-control"  type="file" name="bannerImage"  onchange="readFile(this,3);">
					<input type="hidden" name="bannerFrom" value="3">
					<div class="mt-3 btn-section2" style="text-align:center">
						<button class="btn btn-outline-dark type="submit">배너 등록</button>
						<button class="btn btn-outline-dark" type="button" onclick="removeBanner(3);">배너 삭제</button>
					</div>
				</form>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
			</div>
			</div>
		
		
			<footer>
				<jsp:include page="../../../views/main/footer.jsp"></jsp:include>
			 </footer>
		</div>
	<script>
	function readFile(input,from){
  		if(input.files && input.files[0]){
  			var reader = new FileReader();
  			reader.onload = function(e){
  				document.getElementById('preview'+from).src = e.target.result;
  			};
  			reader.readAsDataURL(input.files[0]);
  		}else{
  			document.getElementById('preview'+from).src = "";
  		}
  	}
	
	function removeBanner(bannerFrom){
		location.href = "/admin/removeBanner?bannerFrom="+bannerFrom;
	}
	
	
	</script>
</body>
</html>