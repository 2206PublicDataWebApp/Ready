package com.kh.ready.user.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ready.book.domain.Book;
import com.kh.ready.book.service.BookService;
import com.kh.ready.community.domain.Comm;
import com.kh.ready.community.service.CommService;
import com.kh.ready.question.domain.Question;
import com.kh.ready.user.domain.Banner;
import com.kh.ready.user.domain.Notice;
import com.kh.ready.user.domain.User;
import com.kh.ready.user.service.AdminService;
import com.kh.ready.user.service.UserService;

@Controller
public class AdminController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private CommService commService;
	
	/**
	 *  admin 화면 요청
	 */
	// admin 메인 메뉴
	@GetMapping("/admin")
	public String adminMenu(Model model) {
		
		// 문의글 갯수
		int questionCount = adminService.questionTotalCount();
		
		// 처리 갯수
		int answeredCount = adminService.answeredTotalCount();
		
		// 신고글 갯수
		int reportCount = adminService.reportTotalCount();
		
		// 신고글 처리 갯수
		int completeCount = adminService.completeTotalCount();
		
		model.addAttribute("questionCount", questionCount);
		model.addAttribute("answeredCount", answeredCount);
		model.addAttribute("reportCount", reportCount);
		model.addAttribute("completeCount", completeCount);
		return "/admin/adminMenu";
	}
	
	/**
	 * 공지사항 관리
	 */
	
	// admin - 공지관리
	@GetMapping("/admin/admin-notice")
	public String noticeList(@RequestParam(value="page", required=false) Integer page, Model model) {
		//페이징
		int currentPage = (page != null) ? page : 1;
		int totalCount = adminService.getTotalCount("", "");
		int noticeLimit = 10;
		int naviLimit = 5;
		int maxPage;
		int startNavi;
		int endNavi;
		maxPage = (int)((double)totalCount/noticeLimit + 0.9);
		startNavi = ((int)((double)currentPage/naviLimit + 0.9)-1) * naviLimit +1;
		endNavi = startNavi + naviLimit - 1;
		
		if(maxPage < endNavi) {
			endNavi = maxPage;
		}
		
		List<Notice> noticeList = adminService.showAllNotice(currentPage, noticeLimit);
		
		if (!noticeList.isEmpty()) {
			model.addAttribute("urlVal","admin-notice");
			model.addAttribute("maxPage",maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("noticeList", noticeList);
		}
		
		return "/admin/notice/adminNotice";
	}
	
	// admin - 공지작성폼
	@GetMapping("/admin/admin-noticeForm")
	public String noticeForm() {
		return "/admin/notice/adminNoticeWriteForm";
	}
	
	// 공지사항 수정화면
	@GetMapping("/admin/modifyNoticeForm")
	public String modifyNotice(@RequestParam("noticeNumber") Integer noticeNumber, Model model) {
		Notice notice = adminService.selectNoticeByNumber(noticeNumber);
		model.addAttribute("notice", notice);
		return "/admin/notice/adminNoticeModifyForm"; 
	}
	
	// 공지사항 등록
	@PostMapping("/admin/postNotice")
	public String registerNotice(@ModelAttribute Notice notice, Principal principal, Model model) {
		String result = adminService.registerNotice(notice, principal);
		return "redirect:/admin/admin-notice";
	}

	// 공지사항 삭제
	@GetMapping("/admin/removeNotice")
	public String removeNotice(@RequestParam("noticeNumber") Integer noticeNumber, Model model) {
		adminService.removeNotice(noticeNumber);
		return "redirect:/admin/admin-notice";
	}

	// 공지사항 수정
	@PostMapping("/admin/modifyNotice")
	public String modifyNotice(@ModelAttribute Notice notice, Model model) {
		String result = adminService.modifyNotice(notice);
		return "redirect:/admin/admin-notice";
	}

	// admin - 공지 상세보기
	@GetMapping("/admin/noticeDetail")
	public String noticeDetail(@RequestParam("noticeNumber") Integer noticeNumber, Model model) {
		Notice notice = adminService.selectNoticeByNumber(noticeNumber);
		model.addAttribute("notice", notice);
		return "/admin/notice/adminNoticeDetail";
	}
	
	/**
	 * 배너관리
	 */
	// admin - 배너관리
	@GetMapping("/admin/admin-banner")
	public String bannerList(Model model) {
		
		// 배너 전체조회
		List<Banner> bannerList = adminService.showAllBanner();
		model.addAttribute("bannerList", bannerList);
		return "/admin/banner/adminBanner";
	}

	// 배너 등록
	@PostMapping("/admin/registerBanner")
	public String registerBanner(@RequestParam(value="bannerImage",required = false) MultipartFile bannerImage,
									HttpServletRequest request,
									@ModelAttribute Banner banner,
									Model model) {
		try {
			String bannerName = bannerImage.getOriginalFilename();
			//banner.setBannerName(bannerImage.getOriginalFilename());
			if(!bannerImage.getOriginalFilename().equals("")) {
				String root = request.getSession().getServletContext().getRealPath("resources");
				String savePath = root + "\\images\\banner";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String bannerRename = sdf.format(new Date(System.currentTimeMillis()))+"."+bannerName.substring(bannerName.lastIndexOf(".")+1);
				//banner.setBannerRename(sdf.format(new Date(System.currentTimeMillis()))+"."+banner.getBannerName().substring(banner.getBannerName().lastIndexOf(".")+1));
				File file = new File(savePath);
				if(!file.exists()) {
					file.mkdir();
				}
				bannerImage.transferTo(new File(savePath+"\\"+bannerRename));
				
				String bannerPath = savePath + "\\" + bannerRename;
				banner.setBannerName(bannerName);
				banner.setBannerRename(bannerRename);
				banner.setBannerPath(bannerPath);
			}
			System.out.println(banner.toString());
			int result = adminService.registerBanner(banner);
		}catch (IOException e) {
			e.printStackTrace();
		}
		List<Banner> bannerList = adminService.showAllBanner();
		model.addAttribute("bannerList", bannerList);
		return "/admin/banner/adminBanner";
	}

	// 배너 삭제
	@GetMapping("/admin/removeBanner")
	public String removeBanner(@RequestParam("bannerFrom") Integer bannerFrom,
								Model model) {
		adminService.removeBanner(bannerFrom);
		List<Banner> bannerList = adminService.showAllBanner();
		model.addAttribute("bannerList", bannerList);
		return "/admin/banner/adminBanner";
	}

	/**
	 * 상품관리
	 */
	
	// admin - 상품관리
	@GetMapping("/admin/admin-product")
	public String productList(Model model, @RequestParam(value="page", required=false) Integer page) {
		//페이징
		int currentPage = (page != null) ? page : 1;
		int totalCount = bookService.getTotalCount("", "");
		int bookLimit = 10;
		int naviLimit = 5;
		int maxPage;
		int startNavi;
		int endNavi;
		maxPage = (int)((double)totalCount/bookLimit + 0.9);
		startNavi = ((int)((double)currentPage/naviLimit + 0.9)-1) * naviLimit +1;
		endNavi = startNavi + naviLimit - 1;
		if(maxPage < endNavi) {
			endNavi = maxPage;
		}
		
		// 상품 전체 조회
		List<Book> bookList = bookService.printAllBook(currentPage, bookLimit);
		if(!bookList.isEmpty()) {
			model.addAttribute("urlVal", "admin-product");
			model.addAttribute("currentPage",currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("bookList", bookList);
		}
		return "/admin/product/adminProduct";
	}
	
	//도서 검색
	@GetMapping("/admin/searchProduct")
	public ModelAndView searchBookList(ModelAndView mv, 
								@RequestParam("searchCondition")String searchCondition,
								@RequestParam("searchValue")String searchValue,
								@RequestParam(value="page", required=false) Integer page) {
		try {
			//페이징
			int currentPage = (page != null) ? page : 1;
			int totalCount = bookService.getTotalCount(searchCondition, searchValue);
			int bookLimit = 10;
			int naviLimit = 5;
			int maxPage;
			int startNavi;
			int endNavi;
			maxPage = (int)((double)totalCount/bookLimit + 0.9);
			startNavi = ((int)((double)currentPage/naviLimit + 0.9)-1) * naviLimit +1;
			endNavi = startNavi + naviLimit - 1;
			if(maxPage < endNavi) {
				endNavi = maxPage;
			}
			//검색
			List<Book> bookList = bookService.printAllByValue(searchCondition, searchValue, currentPage, bookLimit);
			if(!bookList.isEmpty()) {
				mv.addObject("bookList", bookList);
			} else {
				mv.addObject("bookList", null);
			}
			mv.addObject("urlVal", "searchProduct");
			mv.addObject("searchCondition", searchCondition);
			mv.addObject("searchValue", searchValue);
			mv.addObject("currentPage", currentPage);
			mv.addObject("maxPage", maxPage);
			mv.addObject("startNavi", startNavi);
			mv.addObject("endNavi", endNavi);
			mv.setViewName("admin/product/adminProduct");
		} catch(Exception e) {
			mv.addObject("msg", e.toString()).setViewName("main/errorPage");
		}
		return mv;
	}
	
	
	// 상품 수정 폼
	@GetMapping("/admin/admin-productModifyForm")
	public String productModifyForm(@RequestParam("bookNo") Integer bookNo, Model model) {
		Book book = bookService.printOneByNo(bookNo);
		model.addAttribute("book", book);
		return "/admin/product/adminProductModifyForm";
	}
		
	// 상품수정
	@PostMapping("/admin/modifyProduct")
	public String modifyProduct(@ModelAttribute Book book, Model model) {
		String result = adminService.modifyProduct(book);
		if(result.equals("success")) {
			model.addAttribute("msg", "상품 수정 성공!");
		}else {
			model.addAttribute("msg", "상품 수정 실패!");
		}
		return "/admin/product/adminProduct";
	}

	// 상품삭제
	@ResponseBody
	@PostMapping("/admin/deleteProduct")
	public int removeProduct(@RequestParam(value="bookNoArray[]") int [] bookNoArray) {
		int totalResult = 0;
		for(int i = 0; i < bookNoArray.length; i++) {
			Integer bookNo = bookNoArray[i];
			int result = adminService.removeBook(bookNo);
			totalResult += result;
		}
		return totalResult;
	}
	
	
	/**
	 * 신고관리
	 */
	// admin - 신고관리
	@GetMapping("/admin/admin-report")
	public String reportList(@RequestParam(value="page", required=false) Integer page,
							Model model) {
		
		// admin- 신고관리 - 커뮤니티 - 신고게시글 리스트 불러오기
		/////////////////////////////////////////////////////////////////////////
		int reportCurrentPage = (page != null) ? page : 1;
		int reportTotalCount = adminService.reportTotalCount();
		int reportBoardLimit = 10;
		int reportNaviLimit = 5;
		int reportMaxPage;
		int reportStartNavi;
		int reportEndNavi;
		
		// 23/5 = 4.8 + 0.9 = 5(.7)
		reportMaxPage = (int) ((double) reportTotalCount / reportBoardLimit + 0.9);
		reportStartNavi = ((int) ((double) reportCurrentPage / reportNaviLimit + 0.9) - 1) * reportNaviLimit + 1;
		reportEndNavi = reportStartNavi + reportNaviLimit - 1;
		if (reportMaxPage < reportEndNavi) {
			reportEndNavi = reportMaxPage;
		}
		
		// 신고 처리 된 글 목록
		List<Comm> reportList = adminService.showAllReport(reportCurrentPage, reportBoardLimit);
		if (!reportList.isEmpty()) {
			model.addAttribute("reportUrlVal","admin-report");
			model.addAttribute("reportMaxPage",reportMaxPage);
			model.addAttribute("reportCurrentPage", reportCurrentPage);
			model.addAttribute("reportStartNavi", reportStartNavi);
			model.addAttribute("reportEndNavi", reportEndNavi);
			model.addAttribute("reportList", reportList);
		}
		
		///////////////////////////////////////////////////////////////////////// -> 일단은 전체 불러오기했음 나중에 쿼리 변경해서 연결
		int completeCurrentPage = (page != null) ? page : 1;
		int completeTotalCount = adminService.completeTotalCount();
		int completeBoardLimit = 10;
		int completeNaviLimit = 5;
		int completeMaxPage;
		int completeStartNavi;
		int completeEndNavi;
		
		// 23/5 = 4.8 + 0.9 = 5(.7)
		completeMaxPage = (int) ((double) completeTotalCount / completeBoardLimit + 0.9);
		completeStartNavi = ((int) ((double) completeCurrentPage / completeNaviLimit + 0.9) - 1) * completeNaviLimit + 1;
		completeEndNavi = completeStartNavi + completeNaviLimit - 1;
		if (completeMaxPage < completeEndNavi) {
		completeEndNavi = completeMaxPage;
		}
		
		// 신고 처리 된 글 목록
		List<Comm> completeList = adminService.showAllCompleteList(completeCurrentPage, completeBoardLimit);
		if (!completeList.isEmpty()) {
		model.addAttribute("completeUrlVal","admin-report");
		model.addAttribute("completeMaxPage",completeMaxPage);
		model.addAttribute("completeCurrentPage", completeCurrentPage);
		model.addAttribute("completeStartNavi", completeStartNavi);
		model.addAttribute("completeEndNavi", completeEndNavi);
		model.addAttribute("completeList", completeList);
		}	
		return "/admin/report/adminReport";
	}
	
	// 신고 내용 보기 
	@GetMapping("/admin/reportDetail")
	public String reportDetail(@RequestParam("boardNo") Integer boardNo, Model model) {
		Comm reportedComm = adminService.showReportDetail(boardNo);
		if(reportedComm != null) {
			model.addAttribute("comm", reportedComm);
			return "/admin/report/adminReportDetail";
		}else {
			return "/admin/report/adminReport";
		}
	}
	
	// 게시글 복구
	@ResponseBody
	@GetMapping("/admin/recoverComm")
	public String recoverComm(@RequestParam("boardNo") Integer boardNo) {
		String result = adminService.recoverComm(boardNo);
		return result;
	}
	
	// 게시글 삭제
	@ResponseBody
	@GetMapping("/admin/terminateComm")
	public String terminateComm(@RequestParam("boardNo") Integer boardNo) {
		String result = adminService.terminateComm(boardNo);
		return result;
	}
	
	// 처분 페이지
	@GetMapping("/admin/punishPage")
	public String punishPage(Model model, 
							@RequestParam("commWriter") String commWriter,
							@RequestParam("boardNo") Integer boardNo) {
		User BadUser = userService.findUserByNicknameForPunish(commWriter);
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("userId", BadUser.getUserId());
		return "/admin/report/adminJudgementPage";
	}
	
	// 유저 처분 메소드
	@PostMapping("/admin/punish")
	public String punishUser(@RequestParam("punishment") String punishment,
							@RequestParam("userId") String userId,
							@RequestParam("boardNo") Integer boardNo) {
		
		// 처벌의 내용(일단은 커뮤니티 글쓰기금지 // 회원로그인금or탈퇴)  -> 시큐리티 기능을 이용
		
		String result = adminService.punishUser(punishment, userId, boardNo);
			if(result.equals("fail") || result.equals("error")) {
				return "/exception/something";
			}
			
		return "redirect:/admin/admin-report";
	}
	
	 
	
	
	

	
	
}
