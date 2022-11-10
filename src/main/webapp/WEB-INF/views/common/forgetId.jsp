<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container" style="margin-top: 10%">
<div class="container col-lg-5">
	<h2>Read'y 아이디 찾기  </h2>
	<h4>가입할때 입력하셨던 정보를 확인할게요.</h4>
</div>
	<div class="card container col-lg-5 mt-5 p-5">
		<form method="post" action="/forget-id">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="form-group">
				<input type="text" class="form-control" placeholder="회원님 이름을 입력해주세요." id="userName" name="userName">
			</div>
			<div class="form-group">
				<input type="email" class="form-control" placeholder="가입시 등록하신 이메일을 입력해주세요." id="userEmail"name="userEmail">
			</div>
			<button type="button" class="btn btn-dark col-lg" id="findId">아이디 찾기</button>
			<button type="button" class="btn btn-outline-dark col-lg mt-3" id="redirectButton" onclick="getBack();">돌아가기</button>
		</form>
	</div>
	</div>
<script>
	$("#findId").on("click",function(){
		const inputName = $("#userName").val();
		const inputEmail = $("#userEmail").val();
		$.ajax({
			url : "/forget-id",
			data :{
				"userName" : inputName,
				"userEmail" : inputEmail
			},
			type : "POST",
			success : function(result){
				if(result === null || result === "null" || result === ""){
					alert("아이디가 존재하지 않습니다. 다시 확인해 주세요.");
				}else{
					alert("찾으시는 아이디는 " + result + "입니다.");
				}
			},
			error : function(){
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