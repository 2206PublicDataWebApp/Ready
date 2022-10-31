package com.kh.ready.book.service;

import java.util.List;

import com.kh.ready.book.domain.Book;
import com.kh.ready.book.domain.Review;

public interface BookService {
	//도서 등록
	public int registerBook(Book book);
	
	public int removeBook(Integer bookNo);

	public int getTotalCount(String searchCondition, String searchValue);
	
	public List<Book> printAllBook(int currentPage, int bookLimit);
	
	public List<Book> printAllByValue(String searchCondition, String searchValue, int currentPage, int bookLimit);

	public Book printOneByNo(Integer bookNo);

	public int registerReview(Review review);

	public int modifyReview(Review review);

	public int removeReview(Integer reviewNo);

	public List<Review> printAllReview(Integer bookNo);

	public List<Book> printAllByCategory(String category);

	public List<Book> printBestSeller();

	public List<Book> printNewBook();

	public List<Book> printAllByCategoryNewLine(String category);

	public List<Book> printAllByCategoryBestLine(String category);
}
