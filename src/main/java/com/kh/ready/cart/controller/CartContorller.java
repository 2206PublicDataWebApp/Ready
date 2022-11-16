package com.kh.ready.cart.controller;


import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ready.cart.domain.Cart;
import com.kh.ready.cart.service.CartService;
import com.kh.ready.user.domain.User;

@Controller
public class CartContorller {

	@Autowired
	private CartService cartService;
	
	
	/**
	 * 장바구니 담기 
	 * @param cart
	 * @param principal
	 * @return result , 0
	 */
	@ResponseBody // cartPage.jsp
	@PostMapping(value="/cart/insert")
	public int insertCart(Cart cart, Principal principal){
		
		try {
			String userId = principal.getName();
			cart.setUserId(userId);
			
			int result = cartService.insertCart(cart);

			return result;			
		} catch (Exception e) {
			return 0;	// 해당 사용자 장바구니에 이미 같은 상품이 있는 경우(유니크키) 예외처리를 통해 0을 리턴 
		}
	}

	/**
	 * 장바구니 삭제
	 * @param cart
	 * @param principal
	 * @param chArr
	 */
	@ResponseBody	// cartPage.jsp
	@PostMapping(value="/cart/delete")
	public void deleteCart(Cart cart, Principal principal, @RequestParam(value="checkArr[]") List<String> chArr) {
		
		try {
			String userId = principal.getName();
			cart.setUserId(userId);
			
			int cartNo = 0;
			
			for(String i : chArr) {   	// ajax를 통해 넘어온 chArr 리스트를 통해 그 길이 만큼 해당 카트PK값 삭제
				cartNo = Integer.parseInt(i);
				cart.setCartNo(cartNo);
				cartService.deleteCart(cart);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 장바구니 수량 수정
	 * @param cart
	 * @param principal
	 * @param cartNo
	 * @param productCount
	 */
	@ResponseBody	// cartPage.jsp
	@PostMapping(value="/cart/modifyCount")
	public void modifyCart(Cart cart, Principal principal,
			@RequestParam("cartNo") int cartNo, @RequestParam("productCount") int productCount) {
		
		try {
			String userId = principal.getName();
			
			cart.setCartNo(cartNo);
			cart.setUserId(userId);
			cart.setProductCount(productCount);
			
			cartService.modifyCart(cart);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	/**
	 * 장바구니 뷰
	 * @param mv
	 * @param principal
	 * @return mv
	 */
	@GetMapping(value="/cart/cartView")
	public ModelAndView showCartView(ModelAndView mv, Principal principal) {
		
		try {
			String userId = principal.getName();
			
			List<Cart> cartList = cartService.getCartdataByUserId(userId);
			
			User userInfo = cartService.getUserInfoByUserId(userId);
			String userTier = userInfo.getUserTier();
			double discountRate = 0;		 // 할인율을 곱하기 위한 변수 생성
			String discountPercent = "";	 // 할인율을 표시하기 위한 변수 생성
			
			// 회원 등급에 따른 할인율 적용
			if(userTier.equals("BRONZE")) {
				discountRate = 0.99;
				discountPercent = "1%";
			} else if(userTier.equals("SILVER")) {
				discountRate = 0.97;
				discountPercent = "3%";
			} else if(userTier.equals("GOLD")) {
				discountRate = 0.95;
				discountPercent = "5%";
			} else if(userTier.equals("VIP")) {
				discountRate = 0.90;
				discountPercent = "10%";
			}
			mv.addObject("discountPercent", discountPercent);
			mv.addObject("discountRate",discountRate);
			mv.addObject("userInfo", userInfo);
			mv.addObject("cartList", cartList);
			mv.setViewName("cart/cartPage");
			
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("/main/errorPage");
		}
		return mv;
	}
	
	/**
	 * 장바구니 카운트
	 * @param principal
	 * @return result
	 */
	@ResponseBody	// header.jsp
	@GetMapping(value="/cart/existedCart")
	public int existedCart(Principal principal) {
		
		String userId = principal.getName();
		int result = cartService.countingCartByUserId(userId);

		return result;
	}
}
