package com.kh.ready.order.domain;

import java.sql.Date;

import com.kh.ready.book.domain.Book;
import com.kh.ready.cart.domain.Cart;

public class Order {

	private int orderNo;	// 주문 테이블 PK값 
	private Integer bookNo;	// 책 번호 ( 책 테이블 PK값 )
	private String userId;	// 사용자 아이디
	private Integer productCount;	// 상품 수량
	private String orderRName;	// 수취인 이름
	private String orderRPhone;	// 수취인 연락처
	private String orderAddress1;	// 배송지 우편번호
	private String orderAddress2;	// 배송지 도로명 주소
	private String orderAddress3;	// 배송지 상세주소
	private String paymentMethod;	// 결제 방법
	private String orderState;	// 주문 상태
	private Date orderDate;	// 주문 날짜
	private String orderId;	// 주문 번호
	private int productPrice;	// 상품 한개 가격
	private int totalPrice;	// 주문의 총 가격
	private int useMileage;	// 사용한 마일리지
	private String impUid;	// 아임포트 고유번호 (API)
	
	private Book book;
	private Cart cart;
	
	public Order() {}

	public Order(int orderNo, Integer bookNo, String userId, Integer productCount, String orderRName,
			String orderRPhone, String orderAddress1, String orderAddress2, String orderAddress3, String paymentMethod,
			String orderState, Date orderDate, String orderId, int productPrice, int totalPrice, int useMileage, String impUid, Book book, Cart cart) {
		super();
		this.orderNo = orderNo;
		this.bookNo = bookNo;
		this.userId = userId;
		this.productCount = productCount;
		this.orderRName = orderRName;
		this.orderRPhone = orderRPhone;
		this.orderAddress1 = orderAddress1;
		this.orderAddress2 = orderAddress2;
		this.orderAddress3 = orderAddress3;
		this.paymentMethod = paymentMethod;
		this.orderState = orderState;
		this.orderDate = orderDate;
		this.orderId = orderId;
		this.productPrice = productPrice;
		this.totalPrice = totalPrice;
		this.useMileage = useMileage;
		this.impUid = impUid;
		this.book = book;
		this.cart = cart;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getBookNo() {
		return bookNo;
	}

	public void setBookNo(Integer bookNo) {
		this.bookNo = bookNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Integer getProductCount() {
		return productCount;
	}

	public void setProductCount(Integer productCount) {
		this.productCount = productCount;
	}

	public String getOrderRName() {
		return orderRName;
	}

	public void setOrderRName(String orderRName) {
		this.orderRName = orderRName;
	}

	public String getOrderRPhone() {
		return orderRPhone;
	}

	public void setOrderRPhone(String orderRPhone) {
		this.orderRPhone = orderRPhone;
	}

	public String getOrderAddress1() {
		return orderAddress1;
	}

	public void setOrderAddress1(String orderAddress1) {
		this.orderAddress1 = orderAddress1;
	}

	public String getOrderAddress2() {
		return orderAddress2;
	}

	public void setOrderAddress2(String orderAddress2) {
		this.orderAddress2 = orderAddress2;
	}

	public String getOrderAddress3() {
		return orderAddress3;
	}

	public void setOrderAddress3(String orderAddress3) {
		this.orderAddress3 = orderAddress3;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getUseMileage() {
		return useMileage;
	}

	public void setUseMileage(int useMileage) {
		this.useMileage = useMileage;
	}

	public String getImpUid() {
		return impUid;
	}

	public void setImpUid(String impUid) {
		this.impUid = impUid;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", bookNo=" + bookNo + ", userId=" + userId + ", productCount="
				+ productCount + ", orderRName=" + orderRName + ", orderRPhone=" + orderRPhone + ", orderAddress1="
				+ orderAddress1 + ", orderAddress2=" + orderAddress2 + ", orderAddress3=" + orderAddress3
				+ ", paymentMethod=" + paymentMethod + ", orderState=" + orderState + ", orderDate=" + orderDate
				+ ", orderId=" + orderId + ", productPrice=" + productPrice + ", totalPrice=" + totalPrice
				+ ", useMileage=" + useMileage + ", impUid=" + impUid + ", book=" + book + ", cart=" + cart + "]";
	}
	

}
