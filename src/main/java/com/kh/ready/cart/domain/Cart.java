package com.kh.ready.cart.domain;

import com.kh.ready.book.domain.Book;


public class Cart {
	
	private int cartNo;	// 장바구니 PK
	private int bookNo;	// 책 번호 (책 테이블의 PK)
	private String userId; // 사용자 아이디
	private int productCount;	// 장바구니 상품 수량
	
	private Book book;
	
	public Cart(){}

	public Cart(int cartNo, int bookNo, String userId, int productCount, Book book) {
		super();
		this.cartNo = cartNo;
		this.bookNo = bookNo;
		this.userId = userId;
		this.productCount = productCount;
		this.book = book;
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getProductCount() {
		return productCount;
	}

	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", bookNo=" + bookNo + ", userId=" + userId + ", productCount=" + productCount
				+ ", book=" + book + "]";
	};
	
	
	
	
}
