package com.kh.ready.cart.service.logic;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ready.cart.domain.Cart;
import com.kh.ready.cart.service.CartService;
import com.kh.ready.cart.store.CartStore;
import com.kh.ready.user.domain.User;

@Service
public class CartServiceImpl implements CartService{

	@Autowired
	private CartStore cartStore;


	@Override
	public int insertCart(Cart cart){

		return cartStore.insertCart(cart);
	}

	@Override
	public int deleteCart(Cart cart) {
		
		return cartStore.deleteCart(cart);
	}

	@Override
	public int modifyCart(Cart cart) {
		
		return cartStore.modifyCart(cart);
	}

	@Override
	public List<Cart> getCartdataByUserId(String userId) {
		
		return cartStore.getCartdataByUserId(userId);
	}

	@Override
	public User getUserInfoByUserId(String userId) {

		return cartStore.getUserInfoByUserId(userId);
	}

	@Override
	public int countingCartByUserId(String userId) {

		return cartStore.countingCartByUserId(userId);
	}


	
}
