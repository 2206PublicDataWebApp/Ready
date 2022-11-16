package com.kh.ready.order.store.logic;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ready.book.domain.Book;
import com.kh.ready.cart.domain.Cart;
import com.kh.ready.order.domain.Order;
import com.kh.ready.order.store.OrderStore;
import com.kh.ready.user.domain.User;

@Repository
public class OrderStoreLogic implements OrderStore{

	@Autowired
	private SqlSession session;

	@Override
	public List<Cart> getCartdataByUserId(String userId) {

		return session.selectList("OrderMapper.selectCartListByUserId", userId);
	}

	@Override
	public User getUserInfoByUserId(String userId) {

		return session.selectOne("UserMapper.selectOneUser",userId);
	}

	@Override
	public Book getbookDataByBookNo(int bookNo) {
		
		return session.selectOne("BookMapper.selectOneBook", bookNo);
	}

	@Override
	public List<Order> getOrderDataByOrderId(String orderId) {
	
		return session.selectList("OrderMapper.selectOrderListByOrderId", orderId);
	}

	@Override
	public Order getOrderInfoByOrderId(String orderId) {
	
		return session.selectOne("OrderMapper.selectOneOrderByOrderId", orderId);
	}

	@Override
	public int insertOrder(Order order) {
		
		return session.insert("OrderMapper.insertOrder",order);
	}
	

	@Override
	public int deleteCart(String userId) {
		
		return session.delete("OrderMapper.deleteCart", userId);
	}

	@Override
	public int updateMileageByUserId(String userId, int usedMileage) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("userId", userId);
		paramMap.put("usedMileage", usedMileage);
		
		return session.update("OrderMapper.updateUserMileage", paramMap);
	}

	@Override
	public int updateStatusByOrderId(String orderId) {

		return session.update("OrderMapper.updateStatusByOrderId", orderId);
	}

	@Override
	public int updatePurchaseInfoByUserId(String userId, int plusedMileage, String userTier, int userPurchase) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("plusedMileage", plusedMileage);
		paramMap.put("userTier", userTier);
		paramMap.put("userPurchase", userPurchase);
		
		return session.update("OrderMapper.updatePlusMileageByUserId", paramMap);
	}

	@Override
	public int updateOrderState(String orderId) {

		return session.update("OrderMapper.updateOrderState", orderId);
	}
	
}
