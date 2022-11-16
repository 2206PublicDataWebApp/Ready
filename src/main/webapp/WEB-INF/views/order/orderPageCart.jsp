<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="icon" type="image/png"  href="/resources/images/favicon.ico"/>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리디 주문하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/main/mainHeader.css">
    <link href="../resources/css/cart_order/order.css" rel="stylesheet">
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script src="../resources/js/jquery-3.6.1.min.js"></script>
</head>
<style>
</style>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
     <div id="order-title">
         <h1 id="order-text">ORDER</h1>
         <img src="../resources/images/cart_order/c-step02.png" >
     </div>
    <br><br>
        <div class="order-data-list">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th colspan="7"><h5 style="font-weight : bold;">주문할 상품</h5></th>
                    </tr>
                </thead>
                        <tbody class="cartbody">
                            <tr>
                                <td colspan="2">상품정보</td>
                                <td>정가</td>
                                <td>할인가</td>
                                <td>수량</td>
                                <td>합계</td>
                                <td>예상 마일리지</td>
                            </tr>
                        </tbody>
                <tbody class="cartbody">
                	<!-- 상품 총 가격 c:set 설정 -->
                	<c:set var="priceSum" value="0"/>
                	<!-- 상품 총 갯수 c:set 설정 -->
                	<c:set var="productSum" value="0"/>
                	<c:forEach items="${cartList }" var="cartList" varStatus="i">
                	<!-- 할인이 적용된 상품 총가격 누적합계 구하기 -->
                    <c:set var="salePrice" value="${(cartList.book.priceSales * discountRate)-((cartList.book.priceSales * discountRate)%10)}"/>
                    <!-- script에 작업에 필요한 값  책PK값과 해당 할인된 상품 가격 -->
                	<input type="hidden" name="bookNo" value="${cartList.book.bookNo }">
                	<input type="hidden" name="productPrice" value="${salePrice }">
                    <tr>
                        <td>
                            <img class="product-img" src="${cartList.book.imgPath }">
                        </td>
                        <td>
                        	<!-- 마우스 커서 갖다댈시 다 보이게 타이틀에 책 이름 설정  -->
                        	<div title ="${cartList.book.bookTitle }">
                        	 <!-- 책 이름 길이가 20이 넘는 제목은 ... 으로 요약 -->
                            <c:choose>
                            	<c:when test="${fn:length(cartList.book.bookTitle) gt 20 }">
                            	<c:out value="${fn:substring(cartList.book.bookTitle, 0, 19) }...">
                            	</c:out></c:when>
                            	<c:otherwise>
                            	<c:out value="${cartList.book.bookTitle }">
                            	</c:out></c:otherwise>
                            </c:choose>
                            </div>
                        </td>
                        <!-- 정가 -->
                        <td><fmt:formatNumber type="number" pattern="###,###,###" value="${cartList.book.priceSales}"/>원</td>
                        <!-- 할인가 -->
                        <td>
                        	<div style="margin-top:44%;">
                        	<fmt:formatNumber type="number" pattern="###,###,###" value="${salePrice}"/>원
                        	<p>(${discountPercent } <img src="https://img.ypbooks.co.kr/ypbooks/images/icon_down.gif" id="discountArrow" alt="down">)</p>
                        	</div>
                        </td>
                        <!-- 수량 -->
                        <td><input type="text" name='productCount' value="${cartList.productCount }"  style="border:0 solid black; width:30px;" readonly></td>
                        <!-- 할인가*수량 -->
                        <td><fmt:formatNumber type="number" pattern="###,###,###" value="${salePrice * cartList.productCount}"/>원</td>
                        <!-- 마일리지*수량 -->
                        <td><fmt:formatNumber type="number" pattern="###,###,###" value="${cartList.book.mileage * cartList.productCount }"/>P</td>
                    </tr>
                    <!-- 할인 안된 상품 총 가격 합계 구하기 -->
                    <c:set var="priceSum" value="${priceSum + (cartList.book.priceSales * cartList.productCount) }"/>
                    <!-- 상품 총 수량 누적 합계 구하기 -->
                    <c:set var="productSum" value="${productSum + cartList.productCount }"/>
                    <!-- 할인된 상품 총 가격 합계 구하기 -->
                    <c:set var="salePriceSum" value="${salePriceSum + (salePrice * cartList.productCount)}"/>
                    <!-- 예상 적립 마일리지 누적 합계 구하기 -->
                    <c:set var="mileageSum" value="${mileageSum + (cartList.book.mileage * cartList.productCount) }"/>
                    </c:forEach>
                    <!-- 상품 총 가격이 만원 이상일 경우를 위한 cset 설정 -->
                    <c:set var="onlysalePriceSum" value="${salePriceSum}"/>
                    <!-- 상품 총 가격이 만원 이하일 경우 배송비 2500원 누적으로 더 더해줌 -->
                    <c:if test="${priceSum < 10000}">
                    	<c:set var="salePriceSum" value="${salePriceSum + 2500}"/>
                    </c:if>
                </tbody>
            </table>
        </div>
        <div class="buyer-data-list">
            <table class="buyer-info buyer-info-title">
                <tr>
                    <th colspan="6">
                        <h5 style="font-weight : bold;">구매자 정보</h5>
                    </th>
                </tr>
            </table>
            <hr>
            <table class="buyer-info-table">
                <tr class="buyer-info-tr">
                    <td class="buyer-info-td">
                        <p>이름</p>
                    </td>
                    <td>
                        <input class="form-control form-control-sm name-phone" id="buyerName" type="text" value="${userInfo.userName }" style="width:130px">
                    </td>
                </tr>
                <tr>
                    <td class="buyer-info-td">
                        <p>연락처</p>
                    </td>
                    <td>
                        <input class="form-control form-control-sm name-phone" id="buyerPhone" type="text" value="${userInfo.userPhone }" style="width:130px">
                    </td>
                </tr>
                <tr>
                    <td class="buyer-info-td">
                        <p>E-mail</p>
                    </td>
                    <td>
                        <input class="form-control form-control-sm Email" type="text" id="buyerEmail" style="width:200px" value="${userInfo.userEmail }">
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p style="vertical-align :middle; margin-top : 0px; margin-bottom : 0px;">주소</p>
                    </td>
                    <td class="addr-info-td" style="width : 400px;">
                    	<div class="div-floatLeft">
                        	<input class="form-control form-control-sm Addr1" id="buyerZoneCode" type="text" value="${userInfo.userPostcode }" placeholder="우편번호" style="width:90px;">
                        </div>
                        <div class="div-floatLeft btn-section2">
                        	<button class="btn searchAddr-btn" onclick="byuerAddrSearch();" style="font-size :12px;">우편번호 검색</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p></p>
                    </td>
                    <td colspan="2">
                        <input class="form-control form-control-sm detail-Addr" id="buyerRoadAddr" type="text" value="${userInfo.userAddress }" placeholder="도로명 주소" style="width: 400px;">
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p></p>
                    </td>
                    <td colspan="2" class="addr-td">
                        <input class="form-control form-control-sm detail-Addr" id="buyerDetailAddr" type="text" value="${userInfo.userDetailAddress }" placeholder="상세 주소" style="width: 400px;">
                    </td>
                </tr>
            </table>
        </div>

        <div class="buyer-data-list">
           <table class="buyer-info buyer-info-title">
              <tr>
                 <th colspan="6">
                     <h5 style="font-weight : bold;">배송지 정보</h5>
                 </th>
              </tr>
           </table>
           <hr>
           <table class="buyer-info-table">
                <tr class="buyer-info-tr">
                    <td class="buyer-info-td">
                        <p>이름</p>
                    </td>
                    <td>
                    	<div class="div-floatLeft">
                        	<input class="form-control form-control-sm name-phone" id="reciverName" type="text" placeholder="이름" value="" style="width:130px">
                    	</div>
                    	<div class="div-floatLeft">
                        	<button class="btn" id="infocopy-btn" onclick="copyInfo();">구매자정보 복사</button>
                    	</div>
                    </td>
                </tr>
                <tr>
                    <td class="buyer-info-td">
                        <p>연락처</p>
                    </td>
                    <td>
                        <input class="form-control form-control-sm name-phone" id="reciverPhone" type="text" placeholder="전화번호" value="" style="width:130px">
                    </td>
                </tr>
                <tr>
                    <td class="buyer-info-td">
                        <p>E-mail</p>
                    </td>
                    <td>
                        <input class="form-control form-control-sm Email" id="reciverEmail" type="text" placeholder="이메일" style="width:200px" value="">
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p style="vertical-align :middle; margin-top : 0px; margin-bottom : 0px;">주소</p>
                    </td>
                    <td class="addr-info-td" style="width : 400px;">
                    	<div class="div-floatLeft">
                        	<input class="form-control form-control-sm Addr1" id="reciverZoneCode" type="text" value="" placeholder="우편번호" style="width:90px;">
                        </div>
                        <div class="div-floatLeft">
                        	<button class="btn searchAddr-btn" onclick="reciverAddrSearch();" style="font-size :12px;">우편번호 검색</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p></p>
                    </td>
                    <td colspan="2">
                        <input class="form-control form-control-sm detail-Addr" id="reciverRoadAddr" type="text" value="" placeholder="도로명 주소" style="width: 400px;">
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p></p>
                    </td>
                    <td colspan="2" class="addr-td">
                        <input class="form-control form-control-sm detail-Addr" id="reciverDetailAddr" type="text" value="" placeholder="상세 주소" style="width: 400px;">
                    </td>
                </tr>
            </table>
        </div>
        <div class="order-data-list">
            <table id="order-Info"> 
                <thead>
                    <tr>
                        <th id="orderinfo-table-left">주문 수량</th>
                        <th class="orderinfo-table-header">주문 금액 합계</th>
                        <th class="orderinfo-table-header">
                            <div id="div-delivery" style="text-align : center;">
                        		<p class="arrow_box" style="margin-bottom:0px;">
                        			배송비 <img src="../resources/images/cart_order/guide_icon.png" style="width:20px; height:20px; margin-bottom:4px;" >
                        		<span class="deliveryGuide-span">
                        			상품 총 가격이 만원 이상일 시 배송비가 무료입니다!
                        		</span>
                        		</p>
                        	</div>
                        </th>
                        <th class="orderinfo-table-header"><p class="total-price">총 금액 합계</p></th>
                        <th id="orderinfo-table-right">예상 마일리지</th>
                    </tr>
                </thead>
                <tbody>
                    <td id="productSum">총 <c:out value="${productSum }"/> 권</td>
                    <td class="orderinfo-table-body"><fmt:formatNumber type="number" pattern="###,###,###" value="${priceSum }"/> 원</td>
                    <td class="orderinfo-table-body"><input readonly type="text" id="id-delivery-fee" style="border:0px; width:50px;" value="<fmt:formatNumber type="number" pattern="###,###,###" value="0"/>">원</td>
					<td class="orderinfo-table-body"><input readonly type="text" class="total-price" id="id-total-price" style="border:0px; width:100px;" value="<fmt:formatNumber type="number" pattern="###,###,###" value="${salePriceSum}"/>">원</td>
					<td><fmt:formatNumber type="number" pattern="###,###,###" value="${mileageSum}"/> P</td>
                </tbody>
            </table>
            <div class="div-mileage">
            	<p>보유 마일리지 : <input type="text" value="${userInfo.userReserves }" id="currentMileage" style="border:0px; width:100px;" readonly> P  </p>
            	마일리지 : <input type="text" value="0" id="useMileage" style="width:100px;"><button class="btn mileage-btn" onclick="useMileage(${salePriceSum }, ${onlysalePriceSum });">사용</button>
        	</div>
        </div>
        
        
        <div class="buyer-data-list">
        	<table class="buyer-info buyer-info-title">
              <tr>
                 <th colspan="6">
                     <h5 style="font-weight : bold;">결제 방법</h5>
                 </th>
              </tr>
           </table>
           <hr><br><br>
	        <div class="form-check">
			  <input class="form-check-input" type="radio" name="paymentmethod" value="card" id="flexRadioDefault1" checked>
			  	<label class="form-check-label" for="flexRadioDefault1">
			    	신용카드
			  	</label>
			</div><br>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="paymentmethod" value="kakaopay" id="flexRadioDefault2">
			  	<label class="form-check-label" for="flexRadioDefault2">
			    	카카오 페이
			  	</label>
			</div><br>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="paymentmethod" value="trans" id="flexRadioDefault2">
			  	<label class="form-check-label" for="flexRadioDefault2">
			    	실시간 계좌 이체
			  	</label>
			</div><br>
		</div>
        <div id="div-order-btn">
            	<button class="btn" id="goback-btn" onclick="history.back();">이전 페이지</button>
            	<button class="btn" id="order-btn" onclick="requestPay(`${salePriceSum}` , `${cartList[0].book.bookTitle}` , `${productSum}`, `${mileageSum}`);">결제하기</button>							
        </div>
        
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 상품 총가격이 만원 이하 일시 화면단에 배송비 표시
	window.onload = function(){
		var bookPrice = ${priceSum};
		if(bookPrice < 10000) {
			var deliveryFeeId = $("#id-delivery-fee").val;
			$("#id-delivery-fee").attr("value", "2,500");
		}
	}
	
	// 다음 우편번호 찾기 API 사용
    function byuerAddrSearch(){
        new daum.Postcode({
            oncomplete: function(data) {
               document.querySelector('#buyerZoneCode').value = data.zonecode;
               document.querySelector('#buyerRoadAddr').value = data.roadAddress;
               document.querySelector("#buyerDetailAddr").focus();
           }
        }).open();
    }
    
    function reciverAddrSearch(){
        new daum.Postcode({
            oncomplete: function(data) {
               document.querySelector('#reciverZoneCode').value = data.zonecode;
               document.querySelector('#reciverRoadAddr').value = data.roadAddress;
               document.querySelector("#reciverDetailAddr").focus();
           }
        }).open();
    }
    
    // 구매자와 배송지 동일할 경우 배송지 칸에 구매자 정보 자동 입력
    function copyInfo(){
    	const buyerName = $("#buyerName").val();
    	$("#reciverName").attr('value',buyerName);
    	
    	const buyerPhone = $("#buyerPhone").val();
    	$("#reciverPhone").attr('value', buyerPhone);
    	
    	const buyerEmail = $("#buyerEmail").val();
    	$("#reciverEmail").attr('value', buyerEmail);
    	
    	const buyerZoneCode = $("#buyerZoneCode").val();
    	$("#reciverZoneCode").attr('value',buyerZoneCode);
    	
    	const buyerRoadAddr = $("#buyerRoadAddr").val();
    	$("#reciverRoadAddr").attr('value',buyerRoadAddr);
    	
    	const buyerDetailAddr = $("#buyerDetailAddr").val();
    	$("#reciverDetailAddr").attr('value',buyerDetailAddr);
    }
    
    // 마일리지 사용 펑션
	function useMileage(salePriceSum, onlysalePriceSum){
    	
		const inputMileage = $("#useMileage");	// focus 메소드를 사용하기 위한 마일리지 input 태그 변수 생성
		const currentMileage = +$("#currentMileage").val();	// 현재 보유한 마일리지 값 변수 생성
		const useMileage = +$("#useMileage").val();	// 사용할 마일리지 변수 생성
		const pacSalePriceSum = salePriceSum;	// 만원 넘었을 경우  배송비 포함된 변수 생성
		const onlySalePriceSum = onlysalePriceSum;	// 만원이 안넘었을 경우 배송비 미포함 변수 생성
		const num_check= /^[0-9]+$/;
		
    	// 마일리지 사용 위한 유효성 검사
    	if(currentMileage < useMileage) {
    		alert("현재 보유한 마일리지가 부족합니다!");
    		inputMileage.focus();
    		return false;
    	} else if(useMileage > onlySalePriceSum) {
    		alert("사용 마일리지는 최소 결제 금액을 넘을 수 없습니다!");
    		inputMileage.focus();
    		return false;
    	} else if(!num_check.test(useMileage)){
    		alert ("숫자만 입력할 수 있습니다.");
			inputMileage.focus();
			return false;
    	} else {
    		const calPrice = pacSalePriceSum - useMileage;	// 사용한 마일리지  계산
    		const caledPrice = calPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	// 숫자 콤마 표시 제거
		
    		$("#id-total-price").attr("value", caledPrice);	// 화면단 표시를 위해 총금액 계산된 숫자로 값 변경 
    	}
    }
    
	// 아임포트 API 쓰기위한 사전작업
	var IMP = window.IMP;
	IMP.init('imp45674133');
    
    // 결제 버튼 (주문)
    function requestPay(priceSum, firstTitle, totalCount, mileageSum) {
    	
    	const orderId = (new Date().getFullYear())+""+(new Date().getMonth()+1) +(new Date().getDate())+new Date().getTime(); // 주문번호 생성
    	const totalPrice = Math.floor(priceSum);	// 총 가격에서 소수점 버린 변수 생성
    	const buyerName = $("#buyerPhone").val();	
    	const buyerPhone = $("#buyerPhone").val();	// DB에 들어갈 데이터들 변수 생성
    	const buyerEmail = $("#buyerEmail").val();
    	const paymethod = $('input:radio[name=paymentmethod]:checked').val();
    	
   		const reciverName = $("#reciverName").val();
   		const reciverPhone = $("#reciverPhone").val();
   		const reciverEmail = $("#reciverEmail").val();
   		const reciverZoneCode = $("#reciverZoneCode").val();
   		const reciverRoadAddr = $("#reciverRoadAddr").val();
   		const reciverDetailAddr = $("#reciverDetailAddr").val();
   		
   		if(reciverName == "" && reciverPhone == "" && reciverEmail == "" && reciverZoneCode == "" && reciverRoadAddr == "" && reciverDetailAddr == ""){
   			alert("배송 정보를 확인해주세요");
   			return false;
   		} else {
	    	// 카트에 한가지 품목만 담는게 아닌 여러 품목이 들어갈 수 있기 때문에 리스트 변수 생성
	    	var bookNoArr = [];
	 	    var productCountArr = [];
	 	    var productPriceArr = [];
	 	    
	 	    var useMileage = +$("#useMileage").val();
	   		var calPrice = totalPrice - useMileage;	// 마일리지 사용한만큼 계산
	 	    
	   		// 생성된 리스트에 길이만큼 값 푸쉬
	    	$("input[name='bookNo']").each(function(i){
	    		bookNoArr.push($(this).val());
	 		});
	    	$("input[name='productCount']").each(function(i){
	    		productCountArr.push($(this).val());
	 		});
	    	$("input[name='productPrice']").each(function(i){
	    		productPriceArr.push(Math.floor($(this).val()));
	    	});
	
	        IMP.request_pay({ // 아임포트에 보내줄 데이터들
	            pg: "html5_inicis",
	            pay_method: paymethod,
	            merchant_uid: orderId,
	            name: firstTitle + " 등  총  "+ totalCount + "권",
	            amount: calPrice,
	            buyer_email: buyerEmail,
	            buyer_name: buyerName,
	            buyer_tel: buyerPhone,
	            custom_data: {
	            	bookNoArr : bookNoArr,
	            	productCountArr : productCountArr,
	            	productPriceArr : productPriceArr,
	            	mileageSum : mileageSum,
	            	useMileage : useMileage,
	            	totalPrice : totalPrice,
	            	orderId : orderId,
	            	reciverName : $("#reciverName").val(),
	            	reciverPhone : $("#reciverPhone").val(),
	            	reciverEmail : $("#reciverEmail").val(),
	            	reciverZoneCode : $("#reciverZoneCode").val(),
	            	reciverRoadAddr : $("#reciverRoadAddr").val(),
	            	reciverDetailAddr : $("#reciverDetailAddr").val()
	            }
	        }, function (rsp) { // callback
	            if (rsp.success) {	// 성공 시 DB에 인서트
					$.ajax({
						url :"/order/insertCartOrder",
						type : "POST",
						data : {
							imp_uid: rsp.imp_uid,
							orderId : rsp.custom_data.orderId,
							bookNoArr : rsp.custom_data.bookNoArr,
							productCountArr : rsp.custom_data.productCountArr,
							productPriceArr : rsp.custom_data.productPriceArr,
							mileageSum : rsp.custom_data.mileageSum,
							paymethod : rsp.pay_method,
							reciverName : rsp.custom_data.reciverName,
							reciverPhone : rsp.custom_data.reciverPhone,
							reciverEmail : rsp.custom_data.reciverEmail,
			            	reciverZoneCode : rsp.custom_data.reciverZoneCode,
			            	reciverRoadAddr : rsp.custom_data.reciverRoadAddr,
			            	reciverDetailAddr : rsp.custom_data.reciverDetailAddr,
			            	useMileage : rsp.custom_data.useMileage,
			            	totalPrice : rsp.custom_data.totalPrice
						},
						success : function(orderId){	// 주문완료시 해당 주문번호의 주문완료 페이지로 이동
							location.href="/order/orderDetailView?orderId="+orderId;
						},
						error : function(orderId){
							alert("fail");
						}
					})
	            } else {
					alert("결제가 실패하였습니다. 에러내용 : " + rsp.error_msg);
	            }
	        });
   			
   		}
    	
    }

</script>
</body>
</html>