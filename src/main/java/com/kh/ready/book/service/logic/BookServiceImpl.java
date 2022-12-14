package com.kh.ready.book.service.logic;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ready.book.domain.Book;
import com.kh.ready.book.domain.Review;
import com.kh.ready.book.service.BookService;
import com.kh.ready.book.store.BookStore;

@Service
public class BookServiceImpl implements BookService{
	@Autowired
	private SqlSessionTemplate session;
	@Autowired BookStore bStore;

	@Override
	public int registerBook(Book book) {
		int result = bStore.insertBook(session, book);
		return result;
	}

	@Override
	public int removeBook(Integer bookNo) {
		int result = bStore.deleteBook(session, bookNo);
		return result;
	}

	@Override
	public List<Book> printAllBook(int currentPage, int bookLimit) {
		List<Book> bList = bStore.selectAllBook(session, currentPage, bookLimit);
		return bList;
	}

	@Override
	public Book printOneByNo(Integer bookNo) {
		Book book = bStore.selectOneByNo(session, bookNo);
		return book;
	}

	@Override
	public int registerReview(Review review) {
		int result = bStore.insertReview(session, review);
		return result;
	}

	@Override
	public int modifyReview(Review review) {
		int result = bStore.updateReview(session, review);
		return result;
	}

	@Override
	public int removeReview(Review review) {
		int result = bStore.deleteReview(session, review);
		return result;
	}

	@Override
	public List<Review> printAllReview(Integer bookNo) {
		List<Review> rList = bStore.selectAllReview(session, bookNo);
		return rList;
	}

	@Override
	public int getTotalCount(String searchCondition, String searchValue) {
		int totalCount = bStore.selectTotalCount(session, searchCondition, searchValue);
		return totalCount;
	}
	
	@Override
	public int getTotalCatrgoryCount(String category) {
		int totalCategoryCount = bStore.selectTotalCategoryCount(session, category);
		return totalCategoryCount;
	}

	@Override
	public List<Book> printAllByValue(String searchCondition, String searchValue, int currentPage, int bookLimit) {
		List<Book> bList = bStore.selectAllByValue(session, searchCondition, searchValue, currentPage, bookLimit);
		return bList;
	}

	@Override
	public List<Book> printAllByCategory(String category, int currentPage, int bookLimit) {
		List<Book> bList = bStore.selectAllByCategory(session, category, currentPage, bookLimit);
		return bList;
	}

	@Override
	public List<Book> printBestSeller() {
		List<Book> bList1 = bStore.selectBestSeller(session);
		return bList1;
	}

	@Override
	public List<Book> printNewBook() {
		List<Book> bList2 = bStore.selectNewBook(session);
		return bList2;
	}

	@Override
	public List<Book> printAllByCategoryNewLine(String category) {
		List<Book> bList1 = bStore.selectAllByCategoryNewLine(session, category);
		return bList1;
	}

	@Override
	public List<Book> printAllByCategoryBestLine(String category) {
		List<Book> bList2 = bStore.selectAllByCategoryBestLine(session, category);
		return bList2;
	}

	@Override
	public List<Book> printRecommendBook(String userId) {
		List<Book> bList3 = bStore.selectRecommendBook(session, userId);
		return bList3;
	}

	@Override
	public List<Book> printNovel() {
		List<Book> bList4 = bStore.selectNovel(session);
		return bList4;
	}

	@Override
	public List<Book> printComic() {
		List<Book> bList5 = bStore.selectComic(session);
		return bList5;
	}

	@Override
	public List<Book> printStudy() {
		List<Book> bList6 = bStore.selectStudy(session);
		return bList6;
	}

	@Override
	public int getTotalMyReviewCount(String userId) {
		int getTotalMyReviewCount = bStore.selectTotalMyReviewCount(session, userId);
		return getTotalMyReviewCount;
	}

	@Override
	public List<Review> printMyReview(String userId, int currentPage, int reviewLimit) {
		List<Review> rList = bStore.selectMyReview(session, userId, currentPage, reviewLimit);
		return rList;
	}

	@Override
	public List<Book> printRecommemdBook1(String userId, String answerGender) {
		List<Book> rbook1 = bStore.selectRecommendBook1(session, userId, answerGender);
		return rbook1;
	}

	@Override
	public int getInsertCount(int bookNo, String userId) {
		int insertCount = bStore.selectInsertCount(session, bookNo, userId);
		return insertCount;
	}

	@Override
	public List<Book> printRecommendBook2(String userId, String answerLove) {
		List<Book> rbook2 = bStore.selectRecommendBook2(session, userId, answerLove);
		return rbook2;
	}

	@Override
	public List<Book> printRecommendBook3(String userId, String answerHobby) {
		List<Book> rbook3 = bStore.selectRecommendBook3(session, userId, answerHobby);
		return rbook3;
	}

	@Override
	public List<Book> printRecommendBook4(String userId, String answerReason) {
		List<Book> rbook4 = bStore.selectRecommendBook4(session, userId, answerReason);
		return rbook4;
	}

	@Override
	public List<Book> printRecommendBook5(String userId, String answerWriter) {
		List<Book> rbook5 = bStore.selectRecommendBook5(session, userId, answerWriter);
		return rbook5;
	}


}
