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
<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
<meta charset="UTF-8">
<title>설문조사 수정</title>
	<style>
		.gender-img {
			height : 150px;
			width : 150px;
			border-rauius : 100%;
		}
		.half-area {
			width : 50%;
			float : left;
		}
		.tripple-area {
			width : 33%;
			float : left;
		}
		.btn-section > button {
			background-color:#AA7139;
         	color : white;
		}
		.btn-section > button:hover {
			background-color:#804A15;
         	color : white;
         	border-color : #804A15;
		}
	</style>

	<jsp:include page="../main/header.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
</head>
<body>
	<div class="main-contents">
		<div class="col-md-3">
			<jsp:include page="../main/mypageSideBar.jsp"></jsp:include>
		</div>
		
		<div class="main-section">
			<h1>Read'y 설문조사</h1>
			<br><br><br><br><br><br><br>
			<form action="/mypage/modifySurvey.kh" method="POST">
			<div>
				<h3>회원님의 성별을 알려주세요</h3><br><br>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/boy_img.png"><br>
						<input type="radio" name="answerGender" value="남" <c:if test="${survey.answerGender == '남' }">checked</c:if>>남자
					</label>
				</div>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/girl_img.png"><br>
						<input type="radio" name="answerGender" value="여" <c:if test="${survey.answerGender == '여' }">checked</c:if>>여자
					</label>
				</div>
				<br><br><br><br><br><br><br><br><br><br><br>
			</div>
			<div>
				<h3>연애중이시거나 결혼을 하셨나요?</h3><br><br>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/solo_img.png">
						<br><input type="radio" name="answerLove" value="solo" <c:if test="${survey.answerLove == 'solo' }">checked</c:if>>솔로
					</label>
				</div>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/couple_img.png">
						<br><input type="radio" name="answerLove" value="couple" <c:if test="${survey.answerLove == 'couple' }">checked</c:if>>연애중
					</label>
				</div><br><br><br><br><br><br><br><br><br>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/married_img.png">
						<br><input type="radio" name="answerLove" value="married" <c:if test="${survey.answerLove == 'married' }">checked</c:if>>결혼
					</label>
				</div>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/family_img.png">
						<br><input type="radio" name="answerLove" value="family" <c:if test="${survey.answerLove == 'family' }">checked</c:if>>자녀있음
					</label>
				</div>
				<br><br><br><br><br><br><br><br><br><br><br>
			</div>
			<div>
				<h3>취미가 무엇인가요?</h3><br><br>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_art.png">
						<br><input type="radio" name="answerHobby" value="미술" <c:if test="${survey.answerHobby == '미술' }">checked</c:if>>미술
					</label>
				</div>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_beauty.png">
						<br><input type="radio" name="answerHobby" value="뷰티" <c:if test="${survey.answerHobby == '뷰티' }">checked</c:if>>뷰티
					</label>
				</div>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_camping.png">
						<br><input type="radio" name="answerHobby" value="캠핑" <c:if test="${survey.answerHobby == '캠핑' }">checked</c:if>>캠핑
					</label>
				</div><br><br><br><br><br><br><br><br><br>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_cook.png">
						<br><input type="radio" name="answerHobby" value="요리" <c:if test="${survey.answerHobby == '요리' }">checked</c:if>>요리
					</label>
				</div>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_driving.png">
						<br><input type="radio" name="answerHobby" value="운전" <c:if test="${survey.answerHobby == '운전' }">checked</c:if>>운전
					</label>
				</div>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_game.png">
						<br><input type="radio" name="answerHobby" value="게임" <c:if test="${survey.answerHobby == '게임' }">checked</c:if>>게임
					</label>
				</div><br><br><br><br><br><br><br><br><br>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_movie.png">
						<br><input type="radio" name="answerHobby" value="영화" <c:if test="${survey.answerHobby == '영화' }">checked</c:if>>영화
					</label>
				</div>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_music.png">
						<br><input type="radio" name="answerHobby" value="음악" <c:if test="${survey.answerHobby == '음악' }">checked</c:if>>음악
					</label>
				</div>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_picture.png">
						<br><input type="radio" name="answerHobby" value="사진" <c:if test="${survey.answerHobby == '사진' }">checked</c:if>>사진
					</label> 
				</div><br><br><br><br><br><br><br><br><br>
				<div class="tripple-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/hobby_shopping.png">
						<br><input type="radio" name="answerHobby" value="쇼핑" <c:if test="${survey.answerHobby == '쇼핑' }">checked</c:if>>쇼핑
					</label>
				</div><br><br><br><br><br><br><br><br><br>
			</div>
			<br><br><br>
			<div>
				<h3>어떤 이유로 책을 구매하시나요?</h3>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/reason_update.png">
						<br><input type="radio" name="answerReason" value="자기계발" <c:if test="${survey.answerReason == '자기계발' }">checked</c:if>>자기개발
					</label>
				</div>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/reason_data.png">
						<br><input type="radio" name="answerReason" value="정보수집" <c:if test="${survey.answerReason == '정보수집' }">checked</c:if>>정보수집
					</label>
				</div><br><br><br><br><br><br><br><br><br>
				<div class="half-area" align="center">
					<label>
						<img class="gender-img" src="../resources/images/survey/reason_life.png">
						<br><input type="radio" name="answerReason" value="여가생활" <c:if test="${survey.answerReason == '여가생활' }">checked</c:if>>여가생활
					</label>
				</div>
			</div>
				<br><br><br><br><br><br><br><br>
			<div>
				<h3>좋아하는 저자가 있나요?</h3>
				<input type="text" name="answerWriter" placeholder="저자 이름을 입력해주세요.">
			</div>
			<br><br><br>
			<div class="btn-section">
				<input type="hidden" name="userId" value="${principal.user.userId }">
				<button type="submit" class="btn">수정</button>
			</div>
			</form>
		</div>
		
		<div class="col-md-3"></div>
	</div>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
</body>
</html>