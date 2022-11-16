package com.kh.ready.order.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.kh.ready.book.domain.Book;
import com.kh.ready.cart.domain.Cart;
import com.kh.ready.order.domain.Order;
import com.kh.ready.user.domain.User;

public interface OrderService {

	List<Cart> getCartdataByUserId(String userId);

	User getUserInfoByUserId(String userId);

	Book getbookDataByBookNo(int bookNo);

	List<Order> getOrderDataByOrderId(String orderId);

	Order getOrderInfoByOrderId(String orderId);

	int insertOrder(Order order);

	int deleteCart(String userId);

	int updateMileageByUserId(String userId, int usedMileage);

	int updateStatusByOrderId(String orderId);

	int updatePurchaseInfoByUserId(String userId, int plusedMileage, int userPurchase);

	int updateOrderState(String orderId);

}
