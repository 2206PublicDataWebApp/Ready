<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>회원정보</title>
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<!-- 타이틀 밑에 아래 css링크 추가해줄것 -->
<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
<link rel="stylesheet" href="/resources/css/que/faqList.css">
<link rel="stylesheet" href="/resources/css/que/faqTest.css">
<link rel="stylesheet" href="/resources/css/comm/commForm.css">
<link rel="stylesheet" href="/resources/css/comm/listView.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body>
	<jsp:include page="../main/header.jsp"></jsp:include>
    <div class="main-contents">
		<div class="main-sidebar"></div>
		<div class="main-section">
		<!-- 이 안에서 작업! 여기가 본문-->
			
			
			<h2 class="list-title list-div">FAQ</h2>
			<section id="wrapper">
			<div class="container">
				<div class="category-box">
						<div class="faq-category category-select" colspan="2" onclick="location.href='#'">회원정보</div>
						<div class="faq-category" colspan="2" onclick="location.href='/que/faq02.kh'">상품관련</div>
						<div class="faq-category" colspan="2" onclick="location.href='/que/faq03.kh'">배송관련</div>
						<div class="faq-category" colspan="2" onclick="location.href='/que/faq04.kh'">교환/환불</div>
						<div class="faq-category" colspan="2" onclick="location.href='/que/faq05.kh'">기타문의</div>
				</div>
			   <ul class="accordion">
				<c:if test="${!empty qList }">
					<c:forEach items="${qList }" var="question" varStatus="i">
			      <li class="item">
			         <h2 class="accordionTitle">${question.queTitle } <span class="accIcon"></span></h2>
			         <div class="text">${question.queContents }</div>
			      </li>
					</c:forEach>
				</c:if>
			   </ul>
			   <div class="btn-right">
					<c:if test="${principal.user.userRole eq 'ROLE_USER' }">
						<button class="rvs-sig-btn rvs-sig-btn-lg" onclick="location.href='/que/myList.kh'">내 문의글</button>
						<button class="sig-btn sig-btn-lg" onclick="location.href='/que/viewWrite.kh'">문의글작성</button>
					</c:if>
					<c:if test="${principal.user.userRole eq 'ROLE_ADMIN'}">
						<button class="rvs-sig-btn rvs-sig-btn-lg"  onclick="location.href='/que/myList.kh'">FAQ 관리</button>
						<button class="rvs-sig-btn rvs-sig-btn-lg" onclick="location.href='/admin/manageList.kh'">문의글관리</button>
						<button class="sig-btn sig-btn-lg" onclick="location.href='/admin/viewWriteAdmin.kh'">FAQ 등록</button>
					</c:if>
			   </div>
			</div>
			</section>
		</div>
		<div class="main-sidebar"></div>
    </div>
    <div class="main-footer div-top">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
	<footer>
		
	</footer>
	<script>
	var accordionBtn = document.querySelectorAll('.accordionTitle');
	var allTexts = document.querySelectorAll('.text');
	var accIcon = document.querySelectorAll('.accIcon');

	// event listener
	accordionBtn.forEach(function (el) {
	    el.addEventListener('click', toggleAccordion)
	});

	// function
	function toggleAccordion(el) {
	   var targetText = el.currentTarget.nextElementSibling.classList;
	   var targetAccIcon = el.currentTarget.children[0];
	   var target = el.currentTarget;
	   
	   if (targetText.contains('show')) {
	       targetText.remove('show');
	       targetAccIcon.classList.remove('anime');
	       target.classList.remove('accordionTitleActive');
	   } 
	   else {
	      accordionBtn.forEach(function (el) {
	         el.classList.remove('accordionTitleActive');
	         
	         allTexts.forEach(function (el) {
	            el.classList.remove('show');
	         })
	         
	         accIcon.forEach(function (el) {
	          el.classList.remove('anime');
	         }) 
	         
	      })
	      
	         targetText.add('show');
	         target.classList.add('accordionTitleActive');
	         targetAccIcon.classList.add('anime');
	   }  
	}
	
	$
	</script>
</body>
</html>