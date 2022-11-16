<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/admin/button.css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<style>
* { 
	font-family: 'Spoqa Han Sans Neo', 'sans-serif';
}
</style>
</head>
<body>
<div class="container" style="margin-top: 10%">
<div class="container col-lg-5">
	<h2>Read'y 비밀번호 찾기 </h2>
	<h4>가입할때 입력하셨던 정보를 확인할게요</h4>
</div>
	<div class="card container col-lg-5 mt-5 p-5">
		<form method="post" action="/forget-password">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<img src="../resources/images/READY-LOGO1.png" height="80px" style="margin: auto; display: block;">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="회원님의 아이디를 입력해주세요." id="userId" name="userId">
			</div>
			<div class="form-group">
				<input type="email" class="form-control" placeholder="가입시 등록하신 이메일을 입력해주세요." id="userEmail"name="userEmail">
			</div>
			<div class="btn-section1">
				<button type="button" class="btn col-lg" id="requestButton">비밀번호 찾기</button>
			</div>
			<div class="btn-section2">
				<button type="button" class="btn col-lg mt-3" id="redirectButton" onclick="getBack();">돌아가기</button>
			</div>
		</form>
	</div>
	</div>
	<script>
	$("#requestButton").on("click",function(){
		const inputId = $("#userId").val();
		const inputEmail = $("#userEmail").val();
		$("#requestButton").prop('disabled', true);
		$.ajax({
			url : "/forget-password",
			data :{
				"userId" : inputId,
				"userEmail" : inputEmail
			},
			type : "POST",
			success : function(result){
				JSON.stringify(result);
				if(result == "fail"){
					$("#requestButton").prop('disabled', true);
					alert("비밀번호가 존재하지 않습니다. 다시 확인해 주세요.");
				}else if(result == "success"){
					$("#requestButton").prop('disabled', true);
					alert("등록된 이메일로 변경된 비밀번호가 전송되었습니다.");
					location.href = "/login";
				}
			},
			error : function(result){
				JSON.stringify(result);
				$("#requestButton").prop('disabled', true);
				alert("서버 통신 오류!");
			}
		});
		
	});
	
	function getBack(){
		location.href="/login";
	}
	</script>
</body>
</html>