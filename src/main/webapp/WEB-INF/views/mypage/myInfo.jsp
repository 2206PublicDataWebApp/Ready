<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>내 정보</title>
	<jsp:include page="../main/header.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
	
	<style>
		span.guide {
			display: none;
			font-size: 12px;
			top: 12px;
			right: 10px;
		}

		span.ok {
			color: green;
		}

		span.error {
			color: red;
		}
		
		.info-section {
			margin-left : 10%;
			width : 50%;
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
		.input-group > button {
			background-color:#AA7139;
        	color : white;
		}
		.input-group > button:hover {
			background-color:#804A15;
         	color : white;
         	border-color : #804A15;
		}
	</style>
</head>
<body>
	<div class="main-contents">
		<div class="col-md-3">
      		<jsp:include page="../main/mypageSideBar.jsp"></jsp:include>
		</div>
		<div class="main-section">
			<h3>${principal.user.userName}의 회원정보</h3>
			<br><br>
			<div class= "info-section">
				<form method="post" action="/mypage/modifyInfo.kh">
					<div class="card container">
						<div class="form-group">
							<label for="userId">아이디</label> 
							<input type="text" class="form-control" id="userId" name="userId" value="${principal.user.userId }" readonly style="background-color:#E0E0E0">
						</div>
						<div class="form-group">
							<label for="userPassword">패스워드 </label> 
							<input type="password" class="form-control" placeholder="문자, 숫자 1개 이상 포함, 8자리 이상" id="userPassword" name="userPassword">
							<span class="guide ok pwd">사용가능한 패스워드입니다.</span> 
							<span class="guide error pwd" id="pwdCheck">규칙에 맞게 패스워드를 설정해주세요.</span>
						</div>
						<div class="form-group">
							<label for="userPassword">패스워드 확인 </label> 
							<input type="password" class="form-control" placeholder="비밀번호 재입력" id="userPasswordCheck">
							<span class="guide ok pwdCheck">패스워드가 일치합니다.</span> 
							<span class="guide error pwdCheck" id="pwdCheckCheck">패스워드가 일치하지 않습니다.</span>
						</div>
						<div class="form-group">
							<label for="userName">성명 </label> 
							<input type="text" class="form-control" id="userName" name="userName" value="${principal.user.userName }" readonly style="background-color:#E0E0E0">
						</div>
						<label for="userEmail">이메일 </label> 
						<div class="input-group col-md-5">
							<input type="email" class="form-control" id="userEmail" name="userEmail" value="${principal.user.userEmail }" readonly style="background-color:#E0E0E0">
						</div>
						<label for="userPostcode">우편번호 </label> 
						<div class="input-group col-md-5">
							<input type="text" class="form-control"  id="userPostcode" name="userPostcode" value="${principal.user.userPostcode }">
							<button type="button" class="btn" onclick="addrSearch()">주소검색</button>
						</div>
						<div class="form-group">
							<label for="userAddress">주소 </label> 
							<input type="text" class="form-control" id="userAddress" name="userAddress" value="${principal.user.userAddress }">
						</div>
						<div class="form-group">
							<label for="userDetailAddress">상세주소 </label> 
							<input type="text" class="form-control" id="userDetailAddress" name="userDetailAddress" value="${principal.user.userDetailAddress }">
						</div>
						<div class="form-group">
							<label for="userPhone">전화번호 </label> 
							<input type="text" class="form-control" id="userPhone" name="userPhone" value="${principal.user.userPhone }">
							<span class="guide error phone" id="phoneCheck">사용 할 수 없는 문자가 포함되었습니다.</span>
						</div>
						<div class="form-group">
							<label for="userNickname">닉네임 </label> 
							<input type="text" class="form-control" id="userNickname" name="userNickname" value="${principal.user.userNickname }">
							<span class="guide ok nicknameCheck">사용가능한 닉네임입니다.</span> 
							<span class="guide error nicknameCheck" id="nicknameCheck">이미 닉네임이 사용중입니다.</span>
							<span class="guide error regNickname" id="regNickname">사용할 수 없는 단어가 포함되어 있습니다.</span>
						</div>
						<br>
					</div>
						<br>
						<div class="btn-section">
							<button type="submit" class="btn col-md-12 mt-3" id="submit">회원정보 수정</button>
						</div>
				</form>
			</div>
		</div>
		<div class="col-md=3">
		</div>
	</div>
	<br>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	   	 <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">⚠주의</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>	
	
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	
	<script>
    
		function addrSearch(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	               document.querySelector('#userPostcode').value = data.zonecode;
	               document.querySelector('#userAddress').value = data.roadAddress;
	
	               document.querySelector("#userDetailAddress").focus();
	           }
	        }).open();
	    }
		
		$("#submit").on("click", function() {
			const userPassword = $("#userPassword").val();
			const userPasswordCheck = $("#userPasswordCheck").val();
			const userPostcode = $("#userPostcode").val();
			const userAddress = $("#userAddress").val();
			const userDetailAddress = $("#userDetailAddress").val();
			const userPhone = $("#userPhone").val();
			const userNickName = $("#userNickname").val();
			console.log(userPassword);
			if(userPassword == null){
				$(".modal-body").html("비밀번호를 입력해주세요.");
				$("#exampleModal").modal('show');
				return false;
			} else if(userPasswordCheck === ''){
				$(".modal-body").html("비밀번호를 확인해주세요.");
				$("#exampleModal").modal('show');
				return false;
			} else if(userPostcode === '' || userAddress === '' || userDetailAddress === ''){
				$(".modal-body").html("주소를 입력해주세요.");
				$("#exampleModal").modal('show');
				return false;
			} else if(userPhone === ''){
				$(".modal-body").html("전화번호를 입력해주세요.");
				$("#exampleModal").modal('show');
				return false;
			} else if(userNickname === ''){
				$(".modal-body").html("닉네임을 입력해주세요.");
				$("#exampleModal").modal('show');
				return false;
			} else if($("#pwdCheck").css("display") == "block") {
				$(".modal-body").html("사용불가능한 비밀번호입니다. 다시 확인해주세요.")
				$("#exampleModal").modal('show');
				return false;
			} else if($("#pwdCheckCheck").css("display") == "block"){
				$(".modal-body").html("비밀번호 확인이 일치하지 않습니다. 다시 확인해주세요.")
				$("#exampleModal").modal('show');
				return false;
			} else if($("#phoneCheck").css("display") == "block"){
				$(".modal-body").html("휴대폰 번호를 다시 확인해주세요.")
				$("#exampleModal").modal('show');
				return false;
			} else if($("#nicknameCheck").css("display") == "block"){
				$(".modal-body").html("이미 사용중인 닉네임입니다. 다시 확인해주세요.")
				$("#exampleModal").modal('show');
				return false;
			} 
		});
		
		$("#userPhone").keyup(function(e){
			let inputPhone = e.target.value;
			const regPhone = RegExp(/^[0-9]{10,11}$/);
			if(inputPhone !== ""){
				$(".error.phone").css("display","none");
				if(!regPhone.test(inputPhone)){
					$(".error.phone").css("display","block");
				}
			}else{
				$(".error.phone").css("display","none");
			}
		});
		
		// 패스워드 확인 -> 정규식 추가
		$("#userPassword").keyup(function(e){
			let inputPwd = e.target.value;
			const regPwd = RegExp(/(?=.*\d)(?=.*[a-zA-ZS]).{8,}/);
			if(inputPwd !== ""){
				$(".ok.pwd").css("display","none");
				$(".error.pwd").css("display","none");
				if(!regPwd.test(inputPwd)){
					$(".error.pwd").css("display","block");
				}else{
					$(".ok.pwd").css("display","block");
				}
			}else{
				$(".ok.pwd").css("display","none");
				$(".error.pwd").css("display","none");
			}
		});
		
		// 패스워드 확인 -> 정규식 추가
		$("#userPasswordCheck").keyup(function(e){
			let checkPwd = e.target.value;
			const pwd = $("#userPassword").val();
			if(checkPwd !== ""){
				$(".ok.pwdCheck").css("display","none");
				$(".error.pwdCheck").css("display","none");
				if(checkPwd !== pwd){
					$(".error.pwdCheck").css("display","block");
				}else if(checkPwd === pwd){
					$(".ok.pwdCheck").css("display","block");
				}
			}else{
				$(".ok.pwdCheck").css("display","none");
				$(".error.pwdCheck").css("display","none");
			}
		});
		
		// 닉네임 중복확인 -> 완료 , 정규식 추가
		$("#userNickname").keyup(function(e){
			let checkNickname = e.target.value;
			let badword = ['10새','10새기','10새리','10세리','10쉐이','10쉑','10스','10쌔',
				'10쌔기','10쎄','10알','10창','10탱','18것','18넘','18년','18노','18놈',
				'18뇬','18럼','18롬','18새','18새끼','18색','18세끼','18세리','18섹','18쉑','18스','18아',
				'c파','c팔','fuck',
				'ㄱㅐ','ㄲㅏ','ㄲㅑ','ㄲㅣ','ㅅㅂㄹㅁ','ㅅㅐ','ㅆㅂㄹㅁ','ㅆㅍ','ㅆㅣ','ㅆ앙','ㅍㅏ','凸',
				'갈보','갈보년','강아지','같은년','같은뇬','개같은','개구라','개년','개놈',
				'개뇬','개대중','개독','개돼중','개랄','개보지','개뻥','개뿔','개새','개새기','개새끼',
				'개새키','개색기','개색끼','개색키','개색히','개섀끼','개세','개세끼','개세이','개소리','개쑈',
				'개쇳기','개수작','개쉐','개쉐리','개쉐이','개쉑','개쉽','개스끼','개시키','개십새기',
				'개십새끼','개쐑','개씹','개아들','개자슥','개자지','개접','개좆','개좌식','개허접','걔새',
				'걔수작','걔시끼','걔시키','걔썌','걸레','게색기','게색끼','광뇬','구녕','구라','구멍',
				'그년','그새끼','냄비','놈현','뇬','눈깔','뉘미럴','니귀미','니기미','니미','니미랄','니미럴',
				'니미씹','니아배','니아베','니아비','니어매','니어메','니어미','닝기리','닝기미','대가리',
				'뎡신','도라이','돈놈','돌아이','돌은놈','되질래','뒈져','뒈져라','뒈진','뒈진다','뒈질',
				'뒤질래','등신','디져라','디진다','디질래','딩시','따식','때놈','또라이','똘아이','똘아이',
				'뙈놈','뙤놈','뙨넘','뙨놈','뚜쟁','띠바','띠발','띠불','띠팔','메친넘','메친놈','미췬',
				'미췬','미친','미친넘','미친년','미친놈','미친새끼','미친스까이','미틴','미틴넘','미틴년',
				'미틴놈','바랄년','병자','뱅마','뱅신','벼엉신','병쉰','병신','부랄','부럴','불알','불할','붕가',
				'붙어먹','뷰웅','븅','븅신','빌어먹','빙시','빙신','빠가','빠구리','빠굴','빠큐','뻐큐',
				'뻑큐','뽁큐','상넘이','상놈을','상놈의','상놈이','새갸','새꺄','새끼','새새끼','새키',
				'색끼','생쑈','세갸','세꺄','세끼','섹스','쇼하네','쉐','쉐기','쉐끼','쉐리','쉐에기',
				'쉐키','쉑','쉣','쉨','쉬발','쉬밸','쉬벌','쉬뻘','쉬펄','쉽알','스패킹','스팽','시궁창','시끼',
				'시댕','시뎅','시랄','시발','시벌','시부랄','시부럴','시부리','시불','시브랄','시팍',
				'시팔','시펄','신발끈','심발끈','심탱','십8','십라','십새','십새끼','십세','십쉐','십쉐이','십스키',
				'십쌔','십창','십탱','싶알','싸가지','싹아지','쌉년','쌍넘','쌍년','쌍놈','쌍뇬','쌔끼',
				'쌕','쌩쑈','쌴년','썅','썅년','썅놈','썡쇼','써벌','썩을년','썩을놈','쎄꺄','쎄엑',
				'쒸벌','쒸뻘','쒸팔','쒸펄','쓰바','쓰박','쓰발','쓰벌','쓰팔','씁새','씁얼','씌파','씨8',
				'씨끼','씨댕','씨뎅','씨바','씨바랄','씨박','씨발','씨방','씨방새','씨방세','씨밸','씨뱅',
				'씨벌','씨벨','씨봉','씨봉알','씨부랄','씨부럴','씨부렁','씨부리','씨불','씨붕','씨브랄',
				'씨빠','씨빨','씨뽀랄','씨앙','씨파','씨팍','씨팔','씨펄','씸년','씸뇬','씸새끼','씹같','씹년',
				'씹뇬','씹보지','씹새','씹새기','씹새끼','씹새리','씹세','씹쉐','씹스키','씹쌔','씹이','씹자지',
				'씹질','씹창','씹탱','씹퇭','씹팔','씹할','씹헐','아가리','아갈','아갈이','아갈통',
				'아구창','아구통','아굴','얌마','양넘','양년','양놈','엄창','엠병','여물통','염병','엿같','옘병',
				'옘빙','오입','왜년','왜놈','욤병','육갑','은년','을년','이년','이새끼','이새키','이스끼',
				'이스키','임마','자슥','잡것','잡넘','잡년','잡놈','저년','저새끼','접년','젖밥','조까',
				'조까치','조낸','조또','조랭','조빠','조쟁이','조지냐','조진다','조찐','조질래','존나','존나게','존니','존만',
				'존만한','좀물','좁년','좁밥','좃까','좃또','좃만','좃밥','좃이','좃찐','좆같','좆까','좆나',
				'좆또','좆만','좆밥','좆이','좆찐','좇같','좇이','좌식','주글','주글래','주데이','주뎅',
				'주뎅이','주둥아리','주둥이','주접','주접떨','죽고잡','죽을래','죽통','쥐랄','쥐롤',
				'쥬디','지랄','지럴','지롤','지미랄','짜식','짜아식','쪼다','쫍빱','찌랄','창녀','캐년',
				'캐놈','캐스끼','캐스키','캐시키','탱구','팔럼','퍽큐','호로','호로놈','호로새끼',
				'호로색','호로쉑','호로스까이','호로스키','후라들','후래자식','후레','후뢰'];
			const reg_badword = new RegExp(badword.join("|"), "i")
			if(checkNickname !== ""){
				$(".ok.nicknameCheck").css("display","none");
				$(".error.nicknameCheck").css("display","none");
				$(".error.regNickname").css("display","none");
				if(!reg_badword.test(checkNickname)){
					$.ajax({
						url : "/checkNickname2",
						data : {
							"userNickname" : checkNickname
						},
						type : "get",
						success : function(result){
							if(result == "itsOk"){
								$(".ok.nicknameCheck").css("display","block");
							}else{
								$(".error.nicknameCheck").css("display","block");
							}
						},
						error : function(){
							alert("서버 통신 에러!");
						}
					})
				}else{
					$(".error.regNickname").css("display","block");
				}
			}else{
				$(".ok.nicknameCheck").css("display","none");
				$(".error.nicknameCheck").css("display",'none');
				$(".error.regNickname").css("display","none");
			}
		})
	</script>
</body>
</html>