package com.kh.ready.cart.service;

import java.util.List;

import com.kh.ready.cart.domain.Cart;
import com.kh.ready.user.domain.User;

public interface CartService {

	int insertCart(Cart cart);

	int deleteCart(Cart cart);
	
	int modifyCart(Cart cart);

	List<Cart> getCartdataByUserId(String userId);

	User getUserInfoByUserId(String userId);

	int countingCartByUserId(String userId);

}
