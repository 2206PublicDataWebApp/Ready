package com.kh.ready.question.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.ready.question.domain.Question;

@Service
public interface QuestionService {

	int registerFAQ(Question que);

	int getTotalCount(String searchCondition, String searchValue);

	List<Question> printAllBoard(int currentPage, int boardLimit);
	// 내 문의글 갯수
	int getMyCount(String searchCondition, String searchValue);
	// 내 문의글 리스트

	List<Question> printMyBoard(int currentPage, int boardLimit);

	Question printOneByNo(Integer queNo);

	List<Question> printFAQBoard(Question que);

	List<Question> printFAQItem(Question que);

	List<Question> printFAQDelivery(Question que);

	List<Question> printFAQChange(Question que);

	int getMangeTotalCount(String searchCondition, String searchValue);

	List<Question> printManageBoard(int currentPage, int boardLimit);


}
