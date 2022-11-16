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
<title>도서 세부 조회</title>
	<script src="/resources/js/jquery-3.6.1.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<style >
		[id^=product] {
			border-bottom : 1px solid #dcdcdc;
		}
		.review-container {
			background-color : #FFFAEA;
		}
		.product {
			border-top : 1px solid white;
			
		}
		#container1 {
			width : 70%;
			float : left;
		}
		#container2 {
			margin-left : 10%;
			padding-top : 5%;
			width : 30%;
		}
		#product2 {
			display : flex;
		}
		.review-area{
			width : 100%;
			display : flex;
			background-color : #FFFAEA;
		}
		.review-text {
			width : 100%;
		}
		.review-btn {
			width : 20%;
		}
		select {
			color : orange;
		}
		.rtext-area {
			width: 80%;
		}
		.rbtn-area {
			width : 20%;
			float : left;
		}
		#insertReview-btn {
			margin-left : 25%;
			width : 122px;
			background-color:#AA7139;
			color : white;
		}
		#insertReview-btn:hover {
			background-color:#804A15;
			color : white;
		}
		#pur-btn {
			background-color:#AA7139;
			color : white;
			width : 177px;
		}
		#pur-btn:hover {
			background-color:#804A15;
			color : white;
		}
		#insertCart-btn {
			background-color:white;
         	color : #804A15;
         	border-color : #804A15;
         	width : 177px;
		}
		#insertCart-btn:hover {
			background-color:#E4DDD3;
         	color : #804A15;
         	border-color : #E4DDD3;	
		}
		#btn-mr {
			background-color:#AA7139;
			color : white;
		}
		#btn-mr:hover {
			background-color:#804A15;
			color : white;
		}
		#rev-del {
			background-color:white;
         	color : #804A15;
         	border-color : #804A15;
		}
		#rev-del:hover {
			background-color:#E4DDD3;
         	color : #804A15;
         	border-color : #E4DDD3;
		}
		#rev-mod {
			background-color:#AA7139;
			color : white;
			margin-left : 20px;
		}
		#rev-mod:hover {
			background-color:#804A15;
			color : white;
		}
	</style>
	<jsp:include page="../main/header.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/main/mainHeader.css">
</head>
<body>
	<input type="hidden" id="bookNo" name="bookNo" value="${book.bookNo }">
	<input type="hidden" id="productPrice"  name="productPrice" value="${book.priceSales }">
    <div class="main-contents">
		<div class="col-md-3"></div>
		<div class="main-section">
			<div  id="product2">
		      	<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250" id="container1">
		        	<div class="col-auto d-none d-lg-block">
						<img src=${book.imgPath } width="200" height="250">
		        	</div>
		        	<div class="col p-4 d-flex flex-column position-relative">
			        	<h3 class="mb-0" id="product1">${book.bookTitle }</h3>
			        	<div class="mb-1 text-muted">저자 : ${book.bookWriter } | 출판사 : ${book.publisher } | 발행일 : ${book.pubDate }</div><br>
			        	<p class="mb-auto">판매가 : <fmt:formatNumber type="number" value="${book.priceSales }" pattern="#,###"/>원</p>
			        	<p class="mb-auto">적립금 : <fmt:formatNumber type="number" value="${book.mileage }" pattern="#,###"/>원</p>
		        	</div>
		    	</div>
				<div id="container2">
					<div>주문수량</div>
					<input type="text" id="productCount" value="1">
					<br><br>
					<button type="button" class="btn" onclick="order(${book.bookNo});" id="pur-btn">구매하기</button>
					<br>
					<br>
					<button type="button" class="btn" id="insertCart-btn">장바구니</button>
				</div>
				<br>
		    </div>
		    <br>
		    
			<div id="product3">
				<h3>이 책의 분류</h3>
				<p>${book.category }</p>
			</div>
			<div id="product4">
			<br>
				<h3>책 소개</h3>
				<p>${book.bookContents }</p>
			</div>
			<form action="/book/addReview.kh" method="post">
					<input type="hidden" id="bookNo" name="bookNo" value="${book.bookNo }">
					<input type="hidden" id="userNickname" name="userNickname" value="${principal.user.userNickname }">
					<input type="hidden" id="userId" name="userId" value="${principal.user.userId }">
					<input type="hidden" id="insertCount" name="insertCount" value="${insertCount }">
				<br>
				<h3>독자서평 (${book.scoreAvg })</h3>
				<div class="review-container">
					<c:if test="${!empty principal }">
					<br>
						<label>평점  : </label>
						<select name="score" id="score">
							<option value="1">★☆☆☆☆</option>
							<option value="2">★★☆☆☆</option>
							<option value="3">★★★☆☆</option>
							<option value="4">★★★★☆</option>
							<option value="5">★★★★★</option>
						</select>
						<br><br>
						<h5>한줄평</h5>
						<div class="review-area">
							<div class="rtext-area">
								<input type="text" name="reviewContents" class="review-text" id="reviewContents">
							</div>
							<div class="rbtn-area">
								<button type="submit" class="btn" class="review-btn" id="insertReview-btn">등록하기</button>
							</div>
						</div>
						<br>
					</c:if>
				</div>
			</form>
			<c:forEach items="${rList }" var="review">
				<div class="review-area">
					<div class="product review-text">
						<span><b>${review.userNickname }</b></span>
						<span>평점 ${review.score } / 5</span>
						<div>${review.reviewContents }</div>
						<div>${review.updateDate }</div>
						<br>
					</div>
					<div class="product review-btn" align="center">
						<c:if test="${principal.username eq review.userId }">
							<br>
							<button onclick="modifyView(this,'${review.score }', '${review.reviewContents}', '${review.reviewNo }', '${review.bookNo }');" class="btn" id="btn-mr">수정</button>
							<button onclick="removeReview(${review.reviewNo},${review.bookNo });" class="btn" id="rev-del">삭제</button>
						</c:if>
						<br>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="col-md-3"></div>
    </div>
	<div class="main-footer">
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</div>

	<script>
	
		function modifyView(obj, score, reviewContents, reviewNo, bookNo) {
			event.preventDefault();
			var sel = "";
			var $div = $("<div class='review-area'>");
			sel += "<select name='score' value='"+score+"'>"
			sel += "<option value='"+1+"'>★☆☆☆☆</option>"
			sel += "<option value='"+2+"'>★★☆☆☆</option>"
			sel += "<option value='"+3+"'>★★★☆☆</option>"
			sel += "<option value='"+4+"'>★★★★☆</option>"
			sel += "<option value='"+5+"'>★★★★★</option>"
			sel += "</select>"
			$div.html(sel);
			$div.append("<input type='text' size='50' value='"+reviewContents+"'>");
			$div.append("<button onclick='modifyReview(this,"+reviewNo+", "+bookNo+");' class='btn' id='rev-mod'>수정</button>");
			console.log($(obj).parent().parent().after($div));
			const target = document.getElementById('btn-mr');
	         target.disabled = true;
		}
		
		function modifyReview(obj, reviewNo, bookNo) {
			event.preventDefault();
			var inputTag = $(obj).parent().children();
			console.log(inputTag);
			var score = inputTag.eq(0).val();
			var reviewContents = inputTag.eq(1).val();
			console.log(score);  
			console.log(reviewContents); 
			var $form = $("<form>");
				$form.attr("action", "/book/modifyReview.kh");
				$form.attr("method", "post");
				$form.append("<input type='hidden' value='"+score+"' name='score'>");
				$form.append("<input type='hidden' value='"+reviewContents+"' name='reviewContents'>");
				$form.append("<input type='hidden' value='"+reviewNo+"' name='reviewNo'>");
				$form.append("<input type='hidden' value='"+bookNo+"' name='bookNo'>");
				$form.appendTo("body");
				$form.submit();
		}
	
		function removeReview(reviewNo, rBookNo) {
			event.preventDefault();
			if(confirm("정말 삭제하시겠습니까?")) {
				var $delForm = $("<form>");
					$delForm.attr("action", "/book/removeReview.kh");
					$delForm.attr("method", "post");
					$delForm.append("<input type='hidden' name='reviewNo' value='"+reviewNo+"'>");
					$delForm.append("<input type='hidden' name='bookNo' value='"+rBookNo+"'>");
					$delForm.appendTo("body");
					$delForm.submit();
			}
		}
		
		$("#insertReview-btn").click(function() {
			var count = $("#insertCount").val();
			var score = $("#score").val();
			var reviewContents = $("#reviewContents").val();
			console.log(reviewContents);
			if(!reviewContents) {
				alert("내용을 입력해 주세요.");
				return false;
			}
			if(count == 0) {
				alert("후기가 등록되었습니다.");
				return true;
			} else {
				alert("1개의 후기만 등록 할 수 있습니다.");
				return false;
			}
		})
		
		$("#insertCart-btn").click(function(){

             var login = "${principal }";

             if(login == "") {
                alert("로그인이 필요합니다");
                return false;
             }

             var bookNo = $("#bookNo").val();
             var productCount = $("#productCount").val();
             var num_check = /^[0-9]*$/;
             if(num_check.test(productCount)) {
                 if(productCount > 99) {
                     alert("99개 이상 주문할 수 없습니다.");
                     return false;
                 } else if(productCount == 0){
                     alert("1개 이상의 숫자를 입력해주세요.");
                     return false;
                 }
             } else {
                 alert("숫자만 입력할 수 있습니다.");
             }

             $.ajax({
                url : "/cart/insert",
                type : "POST",
                data : {
                   bookNo : bookNo,
                   productCount : productCount
                },
                success : function(result) {
                   if(result > 0){
                      var cartConfirm = confirm("장바구니에 추가되었습니다.\n 장바구니로 이동하시겠습니까?");
                      if(cartConfirm) {
                         location.href="/cart/cartView";
                      } else {
                         window.location.reload(true);
                      }
                   } else if(result == 0) {
                      alert("장바구니에 이미 있는 상품입니다.");
                   }
                }
             });
          })
		
		
		
		function order(bookNo) {
             var productCount = $("#productCount").val();
             var num_check = /^[0-9]*$/;

             if(num_check.test(productCount)) {
                 if(productCount > 99) {
                     alert("99개 이상 주문할 수 없습니다.");
                     return false;
                 } else if(productCount == 0){
                     alert("1개 이상의 숫자를 입력해주세요.");
                     return false;
                 }
             } else {
                 alert("숫자만 입력할 수 있습니다.");
                     return false;
             }
             location.href="/order/directOrderView?bookNo="+bookNo+"&productCount="+productCount;
          }bb

	</script>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>