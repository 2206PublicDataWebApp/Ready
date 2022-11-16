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
    <title>리디 주문 완료</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link href="../resources/css/cart_order/order.css" rel="stylesheet">
    <script src="../resources/js/jquery-3.6.1.min.js"></script>
</head>
<style>
.main-contents {
	display:flex;
	height : 90%;
}
.main-sidebar {
	width:15%;
	border:solid 1px black;
}
.main-section {
	width:70%;
	margin : 0;
	/*display:flex;
	 flex-direction:column;
	justify-contents:center;
	align-items:center; */
}
.main-footer {
	float : bottom;
	height : 10%;
}
.main-p {
	font-size:12px;
	margin:0px 0px;
	text-weight:bolder;
}
.fa-solid {
	margin-bottom:20px;
	padding-top:20px;
}
.center {
	text-align:center;	
}
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

.b-example-divider {
	height: 3rem;
	background-color: rgba(0, 0, 0, 0.1);
	border: solid rgba(0, 0, 0, 0.15);
	border-width: 1px 0;
	box-shadow: inset 0 0.5em 1.5em rgba(0, 0, 0, 0.1), inset 0 0.125em
		0.5em rgba(0, 0, 0, 0.15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -0.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.center {
	margin: auto;
}

.search {
	width: 700px;
}
</style>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
        <div id="order-title">
            <h1 id="order-text">ORDER COMPLETE</h1>
            <img src="../resources/images/cart_order/c-step03.png" >
        </div>
    <br><br>
        <div class="buyer-data-list">
            <table class="buyer-info buyer-info-title">
                <tr>
                    <th colspan="6">
                        <h5 style="font-weight : bold;">주문 정보</h5>
                    </th>
                </tr>
            </table>
            <hr>
            <table class="buyer-info-table">
                <tr class="buyer-info-tr">
                     <td class="buyer-info-td">
                        <p class="order-info-p">주문번호</p>
                    </td>
                    <td>
                        <p class="order-info-p">${orderInfo.orderId }</p>
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p class="order-info-p">수취인</p>
                    </td>
                    <td>
                        <p class="order-info-p">${orderInfo.orderRName }</p>
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p class="order-info-p">연락처</p>
                    </td>
                    <td>
                        <p class="order-info-p">${orderInfo.orderRPhone }</p>
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                    	<p class="order-info-p">배송지 정보</p>
                    </td>
                    <td>
                        <p class="order-info-addr-p">${orderInfo.orderAddress1 }  ${orderInfo.orderAddress2 }  ${orderInfo.orderAddress3 }</p>
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p class="order-info-p">결제 방법</p>
                    </td>
                    <td>
                        <p class="order-info-p"><input type="text" id="payMethod" value="${orderInfo.paymentMethod }" readonly style="border : 0px; text-align:left;"></p>
                        
                    </td>
                </tr>
                <tr>
                    <td class="addr-info-td">
                        <p class="order-info-p">주문 상태</p>
                    </td>
                    <td>
                        <p class="order-info-p"><input type="text" id="orderState" value="${orderInfo.orderState }" readonly style="border : 0px; text-align:left;"></p>
                    </td>
                </tr>
            </table>
        </div>

        <div class="accordion accordion-flush order-data-list" id="accordionFlushExample">
            <div class="accordion-item">
              <h2 class="accordion-header" id="flush-headingOne">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                  <h5 style="font-weight : bold;">상품 정보</h5>
                </button>
                <hr>
              </h2>
              <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                <div class="accordion-body">
                      <table class="table table-hover">
                            <thead>
                                <tr class="acd-tr">
                                    <td colspan="2">상품 정보</td>
                                    <td>정가</td>
                                    <td>할인가</td>
                                    <td>수량</td>
                                    <td>합계</td>
                                    <td>적립 마일리지</td>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${orderList }" var="orderList" varStatus="i">
                              <tr class="acd-tr">
                              	  <!-- 이미지 -->
                                  <td>
                                      <img class="product-img" src="${orderList.book.imgPath }">
                                  </td>
                                  <!-- 제목 -->
                                  <td>
                                  	<div title="${orderList.book.bookTitle }">
                                      <c:choose>
                            		  	<c:when test="${fn:length(orderList.book.bookTitle) gt 20 }">
                            				<c:out value="${fn:substring(orderList.book.bookTitle, 0, 19) }..."/>
                            			</c:when>
                            			<c:otherwise>
                            				<c:out value="${orderList.book.bookTitle }"/>
										</c:otherwise>
<%--                             		<p id="bookTitle" style="margin-bottom: 10%;">${orderList.book.bookTitle }</p> --%>
                            		  </c:choose>
                            		 </div>
                                  </td>
                                  <!-- 정가 -->
                                  <td><fmt:formatNumber type="number" pattern="###,###,###" value="${orderList.book.priceSales}"/>원</td>
                                  <!-- 할인가 -->
                                  <td>
			                        <div style="margin-top:47%;">
			                        <fmt:formatNumber type="number" pattern="###,###,###" value="${orderList.productPrice}"/>원
			                        <p>(${discountRate } <img src="https://img.ypbooks.co.kr/ypbooks/images/icon_down.gif" alt="down" id="discountArrow">)</p>
			                        </div>
			                       </td>
                                  <!-- 수량 -->
                                  <td>${orderList.productCount }</td>
                                  <!-- 할인가*수량 -->
                                  <td><fmt:formatNumber type="number" pattern="###,###,###" value="${orderList.productPrice * orderList.productCount}"/>원</td>
                                  <!-- 마일리지*수량 -->
                        		  <td><fmt:formatNumber type="number" pattern="###,###,###" value="${orderList.book.mileage * orderList.productCount }"/>P</td>
                              </tr>
                            <c:set var="priceSum" value="${priceSum + (orderList.book.priceSales * orderList.productCount) }"/>
                    		<c:set var="productSum" value="${productSum + orderList.productCount }"/>
                    		<c:set var="salePriceSum" value="${salePriceSum + (orderList.productPrice * orderList.productCount) }"/>
                            <c:set var="mileageSum" value="${mileageSum + (orderList.book.mileage * orderList.productCount) }"/>
                          </c:forEach>
                          </tbody>
                      </table>
                  </div>
                </div>
              </div>
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
                        <th class="orderinfo-table-header">사용 마일리지</th>
                        <th class="orderinfo-table-header"><p class="total-price">총 금액 합계</p></th>
                        <th id="orderinfo-table-right">적립 마일리지</th>
                    </tr>
                </thead>
                <tbody>
                    <td>총 <c:out value="${productSum }"/> 권</td>
                    <td class="orderinfo-table-body">
                    	<fmt:formatNumber type="number" pattern="###,###,###" value="${priceSum }"/> 원
                    </td>
                    <td class="orderinfo-table-body">
                    	<input readonly type="text" id="id-delivery-fee" style="border:0px; width:50px;" value="<fmt:formatNumber type="number" pattern="###,###,###" value="0"/>">원
                    </td>
                    <td class="orderinfo-table-body">
                    	<fmt:formatNumber type="number" pattern="###,###,###" value="${orderInfo.useMileage}"/> P
                    </td>
                    <td class="orderinfo-table-body">
                    	<p class="total-price">
                    		<fmt:formatNumber type="number" pattern="###,###,###" value="${orderInfo.totalPrice - orderInfo.useMileage}"/> 원
                    	</p>
                    </td>
                    <td>
                    	<fmt:formatNumber type="number" pattern="###,###,###" value="${mileageSum}"/> P
                    </td>
                </tbody>
            </table>
        </div>
        <c:if test="${orderInfo.orderState eq 'N'}">
	        <div class="div-confirmPurchase">
	            <button class="btn" onclick="cancelPay(`${orderInfo.orderId }`, ${orderInfo.totalPrice},`${orderInfo.impUid}`);">환불하기</button>
	            <button class="btn" onclick="confirmPurchase(${salePriceSum});">구매 확정</button>
	       	</div>
       	</c:if>
       	<c:if test="${orderInfo.orderState eq 'Y'}">
	        <div class="div-confirmPurchase">
	            <button class="btn" onclick="alert('이미 구매 확정된 주문입니다!');">환불하기</button>
	            <button class="btn" onclick="alert('이미 구매 확정된 주문입니다!');">구매 확정</button>
	        </div>
       	</c:if>
       	<c:if test="${orderInfo.orderState eq 'R'}">
	        <div class="div-confirmPurchase">
	            <button class="btn" onclick="alert('이미 전액 환불된 주문입니다!');">환불하기</button>
	            <button class="btn" onclick="alert('이미 전액 환불된 주문입니다!');">구매 확정</button>
	        </div>
       	</c:if>
        <div id="div-order-btn">
            <button class="btn" id="goback-btn" onclick="location.href='/';">메인으로</button>
            <button class="btn" id="order-btn-complete" onclick="location.href='/book/category.kh?category=Best';">쇼핑 하러가기</button>
        </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
window.onload = function(){
	const price = ${priceSum};
	let paymethod = $("#payMethod").val();
	let orderState = $("#orderState").val();
	let discountRate = $("#discountRate").val();
	
	if(paymethod == "card"){
		$("#payMethod").val("신용카드");
	} else if(paymethod == "kakaopay" || paymethod == "point"){
		$("#payMethod").val("카카오 페이");
	} else if(paymethod == "trans"){
		$("#payMethod").val("실시간 계좌 이체");
	}
	
	if(orderState == "N"){
		$("#orderState").val("결제 완료");
	} else if(orderState == "R") {
		$("#orderState").val("환불 완료");
	} else if(orderState == "Y"){
		$("#orderState").val("구매 확정");
	}
	
	if(price < 10000) {
		$("#id-delivery-fee").attr("value", "2,500");
	}
}

	
	
	function confirmPurchase(salePriceSum){
		
			const confirmPurchase = confirm("구매 확정하시겠습니까?");
			
			if(confirmPurchase == true){
				
				const plusMileage = ${mileageSum};
				const orderId = '${orderInfo.orderId }';
				
		 		$.ajax({
					url : "/order/confirmPurchase",
					type : "POST",
					data : {
						plusMileage : plusMileage,
						orderId : orderId,
						salePriceSum : salePriceSum
					},
					success : function(result){
						if(result > 2) {
							alert("구매 확정 되었습니다.");
							window.location.reload(true);
						}
					},
					error : function(result){
						alert("구매 확정 불가");
						console.log(result);
					}
				}) 
			} else {
				alert("취소하였습니다.");
				return false;
			}
	}
	
	
	function cancelPay(orderId, payedPrice, impUid){
		
		const confirmCancelPay = confirm("정말 환불을 진행하시겠습니까? \n마일리지를 되돌려 받을 수 없습니다.");

		if(confirmCancelPay){
			$.ajax({
				url : "/refund/doRefund",
				type : "post",
				data : {
			        orderId : orderId,	
			        cancel_request_amount : payedPrice,
			        impUid : impUid
			      },
				success : function(orderId){
					console.log("ajax : " + orderId);
					$.ajax({
						url : "/refund/refundState",
						type : "POST",
						data : {
							orderId : orderId
						},
						success : function(orderId){
							alert("주문번호 : "+orderId+ "\n환불이 완료되었습니다.");
							window.location.reload(true);
						},
						error : function(error){
							console.log(error);
						}
					})
				},
				error : function(error){
					console.log("error : " + error);
				}
			});
		} else {
			alert("취소하였습니다.");
			return false;
		}

	}
</script>
</body>
</html>