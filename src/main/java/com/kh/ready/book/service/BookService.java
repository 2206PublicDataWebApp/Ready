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

	public int removeReview(Review review);

	public List<Review> printAllReview(Integer bookNo);

	public List<Book> printAllByCategory(String category, int currentPage, int bookLimit);

	public List<Book> printBestSeller();

	public List<Book> printNewBook();

	public List<Book> printAllByCategoryNewLine(String category);

	public List<Book> printAllByCategoryBestLine(String category);

	public List<Book> printRecommendBook(String userId);

	public List<Book> printNovel();

	public List<Book> printComic();

	public List<Book> printStudy();

	public int getTotalCatrgoryCount(String category);

	public int getTotalMyReviewCount(String userId);

	public List<Review> printMyReview(String userId, int currentPage, int reviewLimit);

	public List<Book> printRecommemdBook1(String userId, String answerGender);

	public int getInsertCount(int bookNo, String userId);

	public List<Book> printRecommendBook2(String userId, String answerLove);

	public List<Book> printRecommendBook3(String userId, String answerHobby);

	public List<Book> printRecommendBook4(String userId, String answerReason);

	public List<Book> printRecommendBook5(String userId, String answerWriter);
}
