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
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
     <input type="hidden" name="bookNo" id="id-bookNo" value="${bookData.bookNo }">
     <c:set var="salePrice" value="${(bookData.priceSales * discountRate)-((bookData.priceSales *discountRate)%10)}"/>
     <input type="hidden" name="productPrice" id="id-productPrice" value="${salePrice}">
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
                    <tr>
                        <td>
                            <img class="product-img" src="${bookData.imgPath }">
                        </td>
                        <td>
                        	<!-- 마우스 커서 갖다댈시 다 보이게 타이틀에 책 이름 설정  -->
                        	<div title ="${bookData.bookTitle }">
                        	<!-- 책 이름 길이가 20이 넘는 제목은 ... 으로 요약 -->
                            <c:choose>
                            	<c:when test="${fn:length(bookData.bookTitle) gt 20 }">
                            	<c:out value="${fn:substring(bookData.bookTitle, 0, 19) }...">
                            	</c:out></c:when>
                            	<c:otherwise>
                            	<c:out value="${bookData.bookTitle }">
                            	</c:out></c:otherwise>
                            </c:choose>
                            </div>
                        </td>
                        <!-- 정가 -->
                        <td><fmt:formatNumber type="number" pattern="###,###,###" value="${bookData.priceSales}"/>원</td>
                        <!-- 할인가 -->
                        <td>
                        	<div style="margin-top:45%;">
                        	<fmt:formatNumber type="number" pattern="###,###,###" value="${salePrice}"/>원
                        	<p>(${discountPercent } <img src="https://img.ypbooks.co.kr/ypbooks/images/icon_down.gif" alt="down" id="discountArrow">)</p>
                        	</div>
                        </td>
                        <!-- 수량 -->
                        <td><input type="text" name='productCount' id="id-productCount" value="${productCount }"  style="border:0 solid black; width:30px;" readonly></td>
                        <!-- 할인가*수량 -->
                        <td><fmt:formatNumber type="number" pattern="###,###,###" value="${salePrice * productCount}"/>원</td>
                        <!-- 마일리지*수량 -->
                        <td><fmt:formatNumber type="number" pattern="###,###,###" value="${bookData.mileage * productCount }"/>P</td>
                    </tr>
                    <!-- 할인 안된 상품 총 가격 합계 구하기 -->
					<c:set var="priceSum" value="${priceSum + (bookData.priceSales * productCount) }"/>
                    <!-- 상품 총 수량 누적 합계 구하기 -->
                    <c:set var="productSum" value="${productSum + productCount }"/>
                    <!-- 할인된 상품 총 가격 합계 구하기 -->
                    <c:set var="salePriceSum" value="${salePriceSum + (salePrice * productCount)}"/>
                    <!-- 상품 총 가격이 만원 이상일 경우를 위한 c:set 설정 -->
                    <c:set var="onlysalePriceSum" value="${salePriceSum}"/>
                    <!-- 예상 적립 마일리지 누적 합계 구하기 -->
                    <c:set var="mileageSum" value="${mileageSum + (bookData.mileage * productCount) }"/>
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
                        	<input class="form-control form-control-sm Addr1" id="buyerZoneCode" type="text" value="${userInfo.userPostcode }" style="width:90px;">
                        </div>
                        <div class="div-floatLeft">
                        	<button class="btn btn-secondary searchAddr-btn" onclick="byuerAddrSearch();" style="font-size :12px;">우편번호 검색</button>
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
                        	<button class="btn btn-secondary" id="infocopy-btn" onclick="copyInfo();">구매자정보 복사</button>
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
                        	<button class="btn btn-secondary searchAddr-btn" onclick="reciverAddrSearch();" style="font-size :12px;">우편번호 검색</button>
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
        <h5 style="font-weight : bold;">결제 정보 확인</h5>
        <hr>
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
                        <th class="orderinfo-table-header"><p class="total-price">총 결제 금액</p></th>
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
            <button class="btn" id="order-btn"  onclick="requestPay(`${salePriceSum}` , `${bookData.bookTitle}` , `${productSum}`, `${mileageSum }`);">결제하기</button>								
        </div>
        
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//상품 총가격이 만원 이하 일시 화면단에 배송비 표시
	window.onload = function(){
		const bookPrice = ${priceSum};
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
    	
		const inputMileage = $("#useMileage");		// focus 메소드를 사용하기 위한 마일리지 input 태그 변수 생성
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
    		var calPrice = pacSalePriceSum - useMileage;		// 사용한 마일리지  계산
    		var caledPrice = calPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	// 숫자 콤마 표시 제거
		
    		$("#id-total-price").attr("value", caledPrice);		// 화면단 표시를 위해 총금액 계산된 숫자로 값 변경 
    	}
    }
    
	// 아임포트 API 쓰기위한 사전작업
	var IMP = window.IMP;
	IMP.init('imp45674133');
	
    function requestPay(priceSum, title, totalCount, mileageSum) {
    	
    	const orderId = (new Date().getFullYear())+""+(new Date().getMonth()+1) +(new Date().getDate())+new Date().getTime();	// 주문번호 현시간으로 생성
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
	    	const bookNo = $("#id-bookNo").val();
	    	const productCount = $("#id-productCount").val();
	    	const productPrice = Math.floor($("#id-productPrice").val());
	    	
	     	var useMileage = +$("#useMileage").val();
	    	var calPrice = totalPrice - useMileage;	// 마일리지 사용한만큼 계산
		
	        IMP.request_pay({ // param
	            pg: "html5_inicis",
	            pay_method: paymethod,
	            merchant_uid: orderId,
	            name: title + " 총 " + totalCount + "권",
	            amount: calPrice,
	            buyer_email: buyerEmail,
	            buyer_name: buyerName,
	            buyer_tel: buyerPhone,
	            custom_data: {
	            	bookNo : bookNo,
	            	productCount : productCount,
	            	productPrice : productPrice,
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
	            if (rsp.success) {
					$.ajax({	// 성공 시 DB에 인서트
						url :"/order/insertDirectOrder",
						type : "POST",
						data : {
							imp_uid: rsp.imp_uid,
							orderId : rsp.custom_data.orderId,
							bookNo : rsp.custom_data.bookNo,
							productCount : rsp.custom_data.productCount,
							productPrice : rsp.custom_data.productPrice,
							mileageSum : rsp.custom_data.mileageSum,
							totalPrice : rsp.paid_amount,
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
						error : function(){
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