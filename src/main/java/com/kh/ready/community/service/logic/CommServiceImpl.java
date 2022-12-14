package com.kh.ready.community.service.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ready.community.domain.Comm;
import com.kh.ready.community.domain.CommReply;
import com.kh.ready.community.service.CommService;
import com.kh.ready.community.store.CommStore;
import com.kh.ready.user.domain.User;

@Service
public class CommServiceImpl implements CommService{
	@Autowired
	private SqlSession session;
	@Autowired
	private CommStore cStore;

	// 게시글 등록
	@Override
	public int registerBoard(Comm comm) {
		int result = cStore.insertBoard(session, comm);
		return result;
	}
	// 게시글 전체 개수
	@Override
	public int getTotalCount(String searchCondition, String searchValue) {
		int totalCount = cStore.selectTotalCount(session, searchCondition, searchValue);
		return totalCount;
	}
	// 게시글 전체 출력
	@Override
	public List<Comm> printAllBoard(int currentPage, int boardLimit) {
		List<Comm> cList = cStore.selectAllBoard(session, currentPage, boardLimit);
		return cList;
	}
	// 게시글 상세보기
	@Override
	public Comm printOneByNo(Integer boardNo) {
		Comm comm = cStore.selectOneByNo(session, boardNo);
		int result = 0;
		if(comm != null) {
			result = cStore.updateBoardCount(session, boardNo);
		}
		return comm;
	}
	// 댓글출력
	@Override
	public List<CommReply> printAllReply(Integer boardNo) {
		List<CommReply> cRList = cStore.selectAllReply(session, boardNo);
		return cRList;
	}
	@Override
	public int modifyBoard(Comm comm) {
		int result = cStore.updateComm(session, comm);
		return result;
	}
	@Override
	public int removeOneByNo(int boardNo) {
		int result = cStore.updateBoardRemove(session, boardNo);
		return result;
	}
	@Override
	public int registerReply(CommReply cReply) {
		int result = cStore.insertReply(session, cReply);
		return result;
	}
	@Override
	public int deleteReply(Integer cReplyNo) {
		int result = cStore.deleteReply(session, cReplyNo);
		return result;
	}
	@Override
	public int modifyReply(CommReply cReply) {
		int result = cStore.updateReply(session, cReply);
		return result;
	}
	@Override
	public List<Comm> printAllByValue(String searchCondition, String searchValue, int currentPage, int boardLimit) {
		List<Comm> cList = cStore.selectAllByValue(session, searchCondition, searchValue, currentPage, boardLimit);
		return cList;
	}
	@Override
	public User selectUser(String userId) {
		User user = cStore.selectUser(session, userId);
		return user;
	}

	@Override
	public int reportBoard(int boardNo) {
		int result = cStore.updateBoardReport(session, boardNo);
		return result;
	}
//	// 대댓글 등록
//	@Override
//	public int registerReComment(CommReply cReply) {
//		int result = cStore.insertReComment(session, cReply);
//		return result;
//	}

}
