package com.kh.ready.user.service.impl;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ready.book.domain.Book;
import com.kh.ready.community.domain.Comm;
import com.kh.ready.user.domain.Banner;
import com.kh.ready.user.domain.Notice;
import com.kh.ready.user.domain.User;
import com.kh.ready.user.repository.AdminRepository;
import com.kh.ready.user.repository.UserRepository;
import com.kh.ready.user.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminRepository adminRepository;
	
	@Autowired
	private UserRepository userRepository;

	// 배너 등록
	@Override
	public int registerBanner(Banner banner) {
		int result = adminRepository.insertBanner(banner);
		return result;
	}

	// 배너 삭제
	@Override
	public int removeBanner(Integer bannerFrom) {
		int result = adminRepository.deleteBanner(bannerFrom);
		return result;
	}

	
	// 배너 선택
	@Override
	public List<Banner> showAllBanner() {
		List<Banner> bannerList = adminRepository.selectAllBanner();
		return bannerList;
	}

	// 공지등록
	@Override
	public String registerNotice(Notice notice, Principal principal) {
		notice.setNoticeWriter(principal.getName());
		int result = adminRepository.insertNotice(notice);
		
		if(result > 0) {
			return "insert success";
		}else {
			return "insert fail";
		}
	}
	
	// 공지삭제
	@Override
	public int removeNotice(Integer noticeNumber) {
		int result = adminRepository.deleteNotice(noticeNumber);
		return result;
	}
	
	// 공지 갯수
	@Override
	public int getTotalCount(String searchCondition, String searchValue) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("searchCondition", searchCondition);
		paramMap.put("searchValue", searchValue);
		int totalCount = adminRepository.selectTotalCount(paramMap);
		return totalCount;
	}
	
	// 공지 전체보기
	@Override
	public List<Notice> showAllNotice(int currentPage, int noticeLimit) {
		List<Notice> noticeList = adminRepository.selectAllNotice(currentPage, noticeLimit);
		return noticeList;
	}
	
	// 공지 뿌리기
	@Override
	public Notice selectRecentNotice() {
		Notice notice = adminRepository.selectRecentNotice();
		return notice;
	}
	
	// 공지 상세보기
	@Override
	public Notice selectNoticeByNumber(Integer noticeNumber) {
		Notice notice = adminRepository.selectNoticeByNumber(noticeNumber);
		return notice;
	}

	 // 공지 수정
	@Override
	public String modifyNotice(Notice notice) {
		int result = adminRepository.updateNotice(notice);
		if(result > 0) {
			return "update success";
		}else {
			return "update fail";
		}
	}
	
	// 신고된 게시글 전체 보기
	@Override
	public List<Comm> showAllReport(int reportCurrentPage, int reportBoardLimit) {
		List<Comm> reportList = adminRepository.selectAllReport(reportCurrentPage, reportBoardLimit);
		return reportList;
	}
	
	// 처리 완료 게시글 전체 보기
	@Override
	public List<Comm> showAllCompleteList(int completeCurrentPage, int completeBoardLimit) {
		List<Comm> completeList = adminRepository.selectAllComplete(completeCurrentPage, completeBoardLimit);
		return completeList;
	}
	
	// 신고 게시글 상세 보기
	@Override
	public Comm showReportDetail(Integer boardNo) {
		Comm reportedComm = adminRepository.selectOneReport(boardNo);
		if(reportedComm != null) {
			return reportedComm;
		}else {
			return null;
		}
	}
	
	// 신고글 복구
	@Override
	public String recoverComm(Integer boardNo) {
		int result = adminRepository.updateReportedComm(boardNo);
		if(result == 1) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	// 신고글 삭제처리
	@Override
	public String terminateComm(Integer boardNo) {
		int result = adminRepository.deleteReportedComm(boardNo);
		if(result == 1) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	// 유저 처벌
	@Override
	public String punishUser(String punishment, String userId, Integer boardNo) {
		if(punishment.equals("suspend")) {
			//ROLE_USER -> ROLE_BAD 해서 글쓰기라든지를 막음
			int commResult = adminRepository.updateSuspendResultInComm(boardNo);
			int result = adminRepository.updateBadUser(userId);
			if(result > 0 && commResult > 0) {
				return "success";
			}else {
				return "fail";
			}
		}else if(punishment.equals("getout")) {
			// enabled -> n 해서 로그인을 막음
			int commResult = adminRepository.updateKickoutResultInComm(boardNo);
			int result = adminRepository.kickOutUser(userId);
			if(result > 0 && commResult > 0) {
				return "success";
			}else {
				return "fail";
			}
		}else {
			return "error";
		}
	}
	
	// 상품 수정
	@Override
	public String modifyProduct(Book book) {
		int result = adminRepository.updateProduct(book);
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	// 상품 삭제
	@Override
	public int removeBook(Integer bookNo) {
		int result = adminRepository.deleteBook(bookNo);
		return result;
	}

	// 신고글 갯수
	@Override
	public int reportTotalCount() {
		int reportCount = adminRepository.selectReportCount();
		return reportCount;
	}
	
	// 신고글 처리 갯수
	@Override
	public int completeTotalCount() {
		int completeCount = adminRepository.selectCompleteCount();
		return completeCount;
	}
	
	// 문의글 갯수
	@Override
	public int questionTotalCount() {
		int questionCount = adminRepository.selectQuestionCount();
		return questionCount;
	}
	
	// 답변글 갯수
	@Override
	public int answeredTotalCount() {
		int answeredCount = adminRepository.selectAnsweredCount();
		return answeredCount;
	}
















}
