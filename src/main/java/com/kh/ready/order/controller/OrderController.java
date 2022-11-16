package com.kh.ready.order.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.Principal;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ready.book.domain.Book;
import com.kh.ready.cart.domain.Cart;
import com.kh.ready.order.domain.Order;
import com.kh.ready.order.service.OrderService;
import com.kh.ready.user.domain.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {

	@Autowired
	private OrderService orderService;


	/**
	 * 책 상세페이지 통한 주문페이지 뷰 
	 * @param mv
	 * @param principal
	 * @param user
	 * @param bookNo
	 * @param productCount
	 * @return ModelAndView
	 */
	@GetMapping(value="/order/directOrderView")
	public ModelAndView showOrderView(ModelAndView mv, Principal principal, User user,
								@RequestParam("bookNo") int bookNo,
								@RequestParam("productCount") int productCount) {
		
		try {
			
			String userId = principal.getName();
	
			Book bookData = orderService.getbookDataByBookNo(bookNo);
			User userInfo = orderService.getUserInfoByUserId(userId);
			
			mv.addObject("discountPercent", discountPercent(userId));	// 할인율 표시용 데이터
			mv.addObject("discountRate", discountRate(userId));	// 할인율 표시용 데이터
			mv.addObject("productCount" , productCount);
			mv.addObject("bookData", bookData);
			mv.addObject("userInfo", userInfo);
			mv.setViewName("/order/orderPageDirect");
			
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("/main/errorPage");
		}
	
		return mv;
	}

	/**
	 * 장바구니 통한 주문페이지 뷰
	 * @param mv
	 * @param principal
	 * @param cart
	 * @param user
	 * @return ModelAndView
	 */
	@GetMapping(value="/order/cartOrderView")
	public ModelAndView showOrderViewByCart(ModelAndView mv, Principal principal, Cart cart, User user) {
		
		try {
			String userId = principal.getName();
			
			List<Cart> cartList = orderService.getCartdataByUserId(userId);
			User userInfo = orderService.getUserInfoByUserId(userId);
			
			mv.addObject("discountPercent", discountPercent(userId)); // 할인율 표시용 데이터
			mv.addObject("discountRate", discountRate(userId));
			mv.addObject("cartList", cartList);
			mv.addObject("userInfo", userInfo);
			mv.setViewName("/order/orderPageCart");
			
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("/main/errorPage");
		}
		return mv;
	}
	
	/**
	 * 주문완료 상세 페이지 뷰
	 * @param mv
	 * @param orderId
	 * @param principal
	 * @return ModelAndView
	 */
	@GetMapping(value="/order/orderDetailView")
	public ModelAndView orderDetailView(ModelAndView mv, String orderId, Principal principal) {
		
		String userId = principal.getName();
		User userInfo = orderService.getUserInfoByUserId(userId);
		String discountRate = "";
		Order orderInfo = orderService.getOrderInfoByOrderId(orderId);
		List<Order> orderList = orderService.getOrderDataByOrderId(orderId);
		double salePrice = orderList.get(0).getProductPrice();	// 할인된 금액
		double price = orderList.get(0).getBook().getPriceSales();	// 책 정가
		double percent =  salePrice / price;	// 할인율 ex)0.95
		
		if(percent == 0.99) {	// 퍼센트(string) 으로 바꿈
			discountRate = "1%";
		} else if(percent == 0.97) {
			discountRate = "3%";
		} else if(percent == 0.95) {
			discountRate = "5%";
		} else if(percent == 0.90) {
			discountRate = "10%";
		}
		mv.addObject("discountRate",discountRate);
		mv.addObject("discountPercent", discountPercent(userId));
		mv.addObject("userInfo",userInfo);
		mv.addObject("orderInfo",orderInfo);
		mv.addObject("orderList", orderList);
		mv.setViewName("/order/orderCompletePage");
		
		return mv;
	}

	/**
	 * 장바구니 통한 주문 DB 인서트 함수
	 * @param principal
	 * @param bookNoArr
	 * @param productCountArr
	 * @param productPriceArr
	 * @param mileageSum
	 * @param useMileage
	 * @param totalPrice
	 * @param reciverName
	 * @param reciverPhone
	 * @param reciverZoneCode
	 * @param reciverRoadAddr
	 * @param reciverDetailAddr
	 * @param imp_uid
	 * @param orderId
	 * @param paymethod
	 * @return String
	 */
	@ResponseBody
	@PostMapping(value="/order/insertCartOrder")
	public String insertOrder(Principal principal, @RequestParam("bookNoArr[]") List<Integer> bookNoArr,
												@RequestParam("productCountArr[]") List<Integer> productCountArr,
												@RequestParam("productPriceArr[]") List<Integer> productPriceArr,
												@RequestParam("mileageSum") int mileageSum,
												@RequestParam("useMileage") int useMileage,
												@RequestParam("totalPrice") int totalPrice,
												@RequestParam("reciverName") String reciverName,
												@RequestParam("reciverPhone") String reciverPhone,
												@RequestParam("reciverZoneCode") String reciverZoneCode,
												@RequestParam("reciverRoadAddr") String reciverRoadAddr,
												@RequestParam("reciverDetailAddr") String reciverDetailAddr,
												@RequestParam("imp_uid") String imp_uid,	// API통해 생성된 아임포트 고유번호
												@RequestParam("orderId") String orderId,
												@RequestParam("paymethod") String paymethod){
				
				Order order = new Order();
				
				String userId = principal.getName();
				
				User user = orderService.getUserInfoByUserId(userId);
				int result = 0;
				// 마일리지 사용한 만큼 차감하기 위해 계산
				int usedMileage = user.getUserReserves() - useMileage;
				
				// 장바구니 통해 온 주문이기 때문에 상품이 여러개일 경우를 위한 반복문
				for(int i=0; i<bookNoArr.size(); i++) {		
					order.setBookNo(bookNoArr.get(i));
					order.setProductCount(productCountArr.get(i));
					order.setProductPrice(productPriceArr.get(i));
					order.setOrderRName(reciverName);
					order.setOrderRPhone(reciverPhone);
					order.setOrderAddress1(reciverZoneCode);
					order.setOrderAddress2(reciverRoadAddr);
					order.setOrderAddress3(reciverDetailAddr);
					order.setPaymentMethod(paymethod);
					order.setOrderId(orderId);
					order.setUserId(userId);
					order.setTotalPrice(totalPrice);
					order.setUseMileage(useMileage);
					order.setImpUid(imp_uid);
					
					// ORDER 테이블에 데이터 인서트
					result = orderService.insertOrder(order);
					
				}
					// 차감된 마일리지로 유저 마일리지 업데이트 
					orderService.updateMileageByUserId(userId, usedMileage);
				
				if(result > 0) {
					orderService.deleteCart(userId);	// 주문이 성공 했을 경우 장바구니 삭제
				}
				String getOrderId = order.getOrderId();
				
			return getOrderId;		// 주문완료 페이지로 가기 위한 주문번호 데이터 리턴
	}
	
	/**
	 * 책 상세페이지를 통한  주문 DB 인서트 함수
	 * @param principal
	 * @param bookNo
	 * @param productCount
	 * @param productPrice
	 * @param totalPrice
	 * @param mileageSum
	 * @param reciverName
	 * @param reciverPhone
	 * @param reciverZoneCode
	 * @param reciverRoadAddr
	 * @param reciverDetailAddr
	 * @param paymethod
	 * @param imp_uid
	 * @param orderId
	 * @param useMileage
	 * @return String
	 */
	@ResponseBody
	@PostMapping(value="/order/insertDirectOrder")
	public String insertDirectOrder(Principal principal, @RequestParam("bookNo") int bookNo,
												@RequestParam("productCount") int productCount,
												@RequestParam("productPrice") int productPrice,
												@RequestParam("totalPrice") int totalPrice,
												@RequestParam("mileageSum") int mileageSum,
												@RequestParam("reciverName") String reciverName,
												@RequestParam("reciverPhone") String reciverPhone,
												@RequestParam("reciverZoneCode") String reciverZoneCode,
												@RequestParam("reciverRoadAddr") String reciverRoadAddr,
												@RequestParam("reciverDetailAddr") String reciverDetailAddr,
												@RequestParam("paymethod") String paymethod,
												@RequestParam("imp_uid") String imp_uid,	// API통해 생성된 아임포트 고유번호
												@RequestParam("orderId") String orderId,
												@RequestParam("useMileage") int useMileage){
			
			Order order = new Order();
			String userId = principal.getName();
			
			order.setBookNo(bookNo);
			order.setProductCount(productCount);
			order.setProductPrice(productPrice);
			order.setOrderRName(reciverName);
			order.setOrderRPhone(reciverPhone);
			order.setOrderAddress1(reciverZoneCode);
			order.setOrderAddress2(reciverRoadAddr);
			order.setOrderAddress3(reciverDetailAddr);
			order.setPaymentMethod(paymethod);
			order.setOrderId(orderId);
			order.setUserId(userId);
			order.setTotalPrice(totalPrice);
			order.setUseMileage(useMileage);
			order.setImpUid(imp_uid);
			// ORDER 테이블에 데이터 인서트
			orderService.insertOrder(order);

			User userInfo = orderService.getUserInfoByUserId(userId);

			int usedMileage = userInfo.getUserReserves() - useMileage;	// 사용자 마일리지 차감 계산
			
			orderService.updateMileageByUserId(userId, usedMileage);	// 차감된 마일리지로 유저 마일리지 업데이트 
			
			String getOrderId = order.getOrderId();

			return getOrderId;	// 주문완료 페이지로 가기 위한 주문번호 데이터 리턴
	}
	
	
	/**
	 * 구매 확정 ( 주문상태 , 유저정보 업데이트 )
	 * @param principal
	 * @param plusMileage
	 * @param orderId
	 * @param salePriceSum
	 * @return int
	 */
	@ResponseBody
	@PostMapping(value="/order/confirmPurchase")
	public int confirmPurchase(Principal principal, @RequestParam("plusMileage") int plusMileage,
													@RequestParam("orderId") String orderId,
													@RequestParam("salePriceSum") int salePriceSum) {
		
		String userId = principal.getName();
		
		User userInfo = orderService.getUserInfoByUserId(userId);
		int plusedMileage = userInfo.getUserReserves() + plusMileage;	// 현재 마일리지 + 예상 적립 마일리지 해서 나온 값 변수 생성
		int userPurchase = userInfo.getUserPurchase() + salePriceSum;	// 총 구매금액을 통해 회원등급이 달라지기 때문에 기존 구매금액 + 해당 주문의 총 금액 계산
		
		int updateorderStatus = orderService.updateStatusByOrderId(orderId);	// 해당 주문을 구매확정 ('Y') 로 변경
		int updataUserInfo = orderService.updatePurchaseInfoByUserId(userId, plusedMileage, userPurchase);	// 바뀐 마일리지, 총 구매금액 변경
		
		int result = updateorderStatus + updataUserInfo;	// 업데이트 된 행 결과
		
		return result;	// 성공 여부 판단을 위한 결과값 리턴
	}
	
	
	/**
	 * 환불하기 진행 시 주문상태 변경
	 * @param orderId
	 * @return String
	 */
	@ResponseBody
	@PostMapping(value="/refund/refundState")
	public String refundStateChange(@RequestParam String orderId) {
		
		try {
			int result = orderService.updateOrderState(orderId);

			if(result > 0) {
				return orderId;			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "error";
	}
	
	/**
	 * 할인율 구하는 함수
	 * @param userId
	 * @return double
	 */
	public double discountRate(String userId) {
		
		User userInfo = orderService.getUserInfoByUserId(userId);
		String userTier = userInfo.getUserTier();
		
		double discountRate = 0;
		
		if(userTier.equals("BRONZE")) {
			discountRate = 0.99;
		} else if(userTier.equals("SILVER")) {
			discountRate = 0.97;
		} else if(userTier.equals("GOLD")) {
			discountRate = 0.95;
		} else if(userTier.equals("VIP")) {
			discountRate = 0.90;
		}
		
		return discountRate;
	}

	/**
	 * 할인율(퍼센트) 구하는 함수
	 * @param userId
	 * @return
	 */
	public String discountPercent(String userId) {
		
		User userInfo = orderService.getUserInfoByUserId(userId);
		String userTier = userInfo.getUserTier();
		
		String discountPercent = "";
		
		if(userTier.equals("BRONZE")) {
			discountPercent = "1%";
		} else if(userTier.equals("SILVER")) {
			discountPercent = "3%";
		} else if(userTier.equals("GOLD")) {
			discountPercent = "5%";
		} else if(userTier.equals("VIP")) {
			discountPercent = "10%";
		}
		
		return discountPercent;
	}

	/**
	 * 아임포트를 통한 토큰 발급
	 * @return String
	 */
	public String getToken() {
		 OutputStreamWriter osw;
		 BufferedWriter bw;
		 InputStreamReader isr;
		 BufferedReader br;
		 StringBuffer sb = new StringBuffer();
		 JSONParser jsonParser = new JSONParser();
		 JSONObject jsonObjectParam = new JSONObject();
		 JSONObject jsonObjectResult;
		
		String accUrl = "https://api.iamport.kr/users/getToken";
		
		try {
			//url객체를 생성 후 주소 입력
			URL url = new URL(accUrl);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setRequestProperty("Content-Type", "application/json");
			
			//환불요청 시 필요한 값인 imp_key, imp_secret을  json객체에 put
			jsonObjectParam.put("imp_key", "2668574740488838");
			jsonObjectParam.put("imp_secret","Q44VoZAfwC9pWRV8qaC83RwB2wZgC1rrjd7OVECCDMvwMeilYD3n4KIw1hR5nmsE9PeESLEMh0Be2M1j");
			
			//출력스트림 요청
			osw = new OutputStreamWriter(con.getOutputStream());
			bw = new BufferedWriter(osw);
			bw.write(jsonObjectParam.toString());
			bw.flush();
			
			//입력스트림 응답
			isr = new InputStreamReader(con.getInputStream());
			br = new BufferedReader(isr);
			if(con.getResponseCode() == 200) {
				String line = "";
				sb = new StringBuffer();
				while((line = br.readLine()) != null) {
					sb.append(line);
				}
				//응답받은 문자열을 json객체로 만들고 필요한 값을 뽑기
				jsonObjectResult = (JSONObject)jsonParser.parse(sb.toString());
				JSONObject responseJson = (JSONObject)jsonObjectResult.get("response");
				String access_token = responseJson.get("access_token").toString();
				return access_token;		// 토큰키 리턴
				
			}else {
				return "";
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * 환불하기
	 * @param orderId
	 * @param impUid
	 * @return String
	 */
	@ResponseBody
	@PostMapping(value="/refund/doRefund")
	public String refund(@RequestParam(value="orderId") String orderId, @RequestParam(value="impUid") String impUid) {
		
		
		OutputStreamWriter osw;
		BufferedWriter bw;
		InputStreamReader isr;
		BufferedReader br;
		StringBuffer sb = new StringBuffer();
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObjectParam = new JSONObject();
		JSONObject jsonObjectResult;
		String accUrl="https://api.iamport.kr/payments/cancel";
		
		String access_token = getToken();
		
		try {
			URL url = new URL(accUrl);	//url객체를 생성 후 주소 입력
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("Authorization","Bearer "+ access_token);
			//환불요청 시 필요한 값인 imp_key, imp_secret을  json객체에 put
			jsonObjectParam.put("merchant_uid", orderId);
			jsonObjectParam.put("imp_uid", impUid);
			//문자출력스트림 요청
			osw = new OutputStreamWriter(con.getOutputStream());
			bw = new BufferedWriter(osw);
			bw.write(jsonObjectParam.toString());
			bw.flush();
			//문자입력스트림 응답
			isr = new InputStreamReader(con.getInputStream());
			br = new BufferedReader(isr);
			if(con.getResponseCode() == 200) {
				String line = "";
				sb = new StringBuffer();
				while((line = br.readLine()) != null) {
					sb.append(line);
				}
				//응답받은 문자열을 json객체로 만들고 필요한 값을 뽑기
				jsonObjectResult = (JSONObject)jsonParser.parse(sb.toString());
				System.out.println(jsonObjectResult.toString());
				if(Integer.parseInt(jsonObjectResult.get("code").toString())!=0) {
					//환불 실패
					return "fail";
				}
			}
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return orderId;
	}
	
}