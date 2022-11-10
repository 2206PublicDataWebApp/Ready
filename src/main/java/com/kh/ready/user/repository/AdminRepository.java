package com.kh.ready.user.repository;

import java.util.HashMap;
import java.util.List;

import com.kh.ready.community.domain.Comm;
import com.kh.ready.user.domain.Banner;
import com.kh.ready.user.domain.Notice;
import com.kh.ready.user.domain.User;

public interface AdminRepository {

	public int insertBanner(Banner banner);
	
	public int deleteBanner(Integer bannerFrom);
	
	public List<Banner> selectAllBanner();
	
	public int insertNotice(Notice notice);

	public List<Notice> selectAllNotice(int currentPage, int noticeLimit);

	public int deleteNotice(Integer noticeNumber);

	public Notice selectNoticeByNumber(Integer noticeNumber);

	public int updateNotice(Notice notice);

	public List<Comm> selectAllReport(int currentPage, int boardLimit);

	public int updateBadUser(String userNickname);

	public int kickOutUser(String userNickname);

	public int selectTotalCount(HashMap<String, String> paramMap);

	public Notice selectRecentNotice();

	public int updateReportedComm(Integer boardNo);
	
	public int deleteReportedComm(Integer boardNo);

	public Comm selectOneReport(Integer boardNo);



}
