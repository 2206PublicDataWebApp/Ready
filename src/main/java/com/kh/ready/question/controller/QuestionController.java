package com.kh.ready.question.controller;

import java.io.File;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ready.community.domain.Comm;
import com.kh.ready.question.domain.Question;
import com.kh.ready.question.service.QuestionService;

@Controller
public class QuestionController {
	@Autowired
	private QuestionService qService;
	
	// 고객센터 게시글 작성
	@RequestMapping(value="/que/viewWrite.kh", method=RequestMethod.GET)
	public String showBoardWrite() {
		return "que/queWriteForm";
	}
	
	// 고객센터 게시글 등록
	@RequestMapping(value="/que/register.kh", method=RequestMethod.POST)
	public ModelAndView registerFAQ(
			ModelAndView mv
			, @ModelAttribute Question que
			, @RequestParam(value="uploadFile", required=false) MultipartFile uploadFile
			, HttpServletRequest request) {
		try {
			int result = qService.registerFAQ(que);
			mv.setViewName("redirect:/que/myList.kh");
		} catch (Exception e) {
				e.printStackTrace();
				mv.addObject("msg", e.getMessage());
				mv.setViewName("main/errorPage");
		}
		return mv;
	} 
	
	
	/**
	 * FAQ 목록
	 * @param mv
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/que/list.kh", method=RequestMethod.GET)
	public ModelAndView viewList(
			ModelAndView mv
			, @RequestParam(value="page", required=false) Integer page) {
		/////////////////////////////////////////////////////////////////////////
		int currentPage = (page != null) ? page : 1;
		int totalCount = qService.getTotalCount("", "");
		int boardLimit = 100;
		int naviLimit = 5;
		int maxPage;
		int startNavi;
		int endNavi;
		// 23/5 = 4.8 + 0.9 = 5(.7)
		maxPage = (int) ((double) totalCount / boardLimit + 0.9);
		startNavi = ((int) ((double) currentPage / naviLimit + 0.9) - 1) * naviLimit + 1;
		endNavi = startNavi + naviLimit - 1;
		if (maxPage < endNavi) {
			endNavi = maxPage;
		}
		//////////////////////////////////////////////////////////////////////////
		// /board/list.kh?page=${currentPage }
		List<Question> qList = qService.printAllBoard(currentPage, boardLimit);
		if (!qList.isEmpty()) {
			mv.addObject("urlVal", "list");
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startNavi", startNavi);
			mv.addObject("endNavi", endNavi);
			mv.addObject("qList", qList);
		}
		mv.setViewName("/que/FAQList");
		return mv;
	}
	
	/**
	 * 내가 쓴 문의글 리스트
	 * @param mv
	 * @param principal
	 * @param que
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/que/myList.kh", method=RequestMethod.GET)
	public ModelAndView myQnaList(
			ModelAndView mv
			, Principal principal
			, @ModelAttribute Question que
			, @RequestParam(value="page", required=false) Integer page) {
		String queWriter = principal.getName();
		que.setQueWriter(queWriter);
		// Question객체에 setter 메소드를 이용해서 queWriter에 principal.getName으로
		// 현재 로그인중인 아이디의 정보를 저장
		// queWriter가 작성한 글만 불러올 수 있도록 하기 위함.
		/////////////////////////////////////////////////////
		int currentPage = (page != null) ? page : 1;
		int totalCount = qService.getMyCount("", "", queWriter);
		// queWriter가 작성한 글만 count되도록 객체를 넘겨줌
		int boardLimit = 10;
		int naviLimit = 5;
		int maxPage;
		int startNavi;
		int endNavi;
		maxPage = (int) ((double) totalCount / boardLimit + 0.9);
		startNavi = ((int)((double) currentPage / naviLimit + 0.9)-1) * naviLimit + 1;
		endNavi = startNavi + naviLimit - 1;
		if (maxPage < endNavi) {
			endNavi = maxPage;
		}
		List<Question> qList = qService.printMyBoard(currentPage, boardLimit, queWriter);
		if (!qList.isEmpty()) {
			mv.addObject("urlVal", "myList");
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startNavi", startNavi);
			mv.addObject("endNavi", endNavi);
			mv.addObject("qList", qList);
			mv.addObject("queWriter", queWriter);
			// addObject를 써서 queWriter정보를 넘겨주고 서비스단과 스토어단에서도 받아줌
		}
		mv.setViewName("/que/myList");
		return mv;
	}
	
	// 나의 1:1 문의 상세
	@RequestMapping(value="/que/myQue.kh")
	public ModelAndView myQnaDetail(
			ModelAndView mv
			, @RequestParam("queNo") Integer queNo
			, @RequestParam("page") Integer page
			, HttpSession session) {
		try {
		Question que = qService.printOneByNo(queNo);
		session.setAttribute("queNo", que.getQueNo());
		mv.addObject("que", que);
		mv.addObject("page", page);
		mv.addObject("queNo", queNo);
		mv.setViewName("que/myQueDetail");
		} catch (Exception e) {
			mv.addObject("msg", e.toString());
			mv.setViewName("main/errorPage");
		}
		return mv;
	}
	
	// FAQ 자주찾는질문 회원정보
	@RequestMapping(value="/que/faq01.kh", method=RequestMethod.GET)
	public ModelAndView viewUserFAQ(
			ModelAndView mv) {
		Question que = new Question();
		List<Question> qList = qService.printFAQBoard(que);
		if (!qList.isEmpty()) {
			
			mv.addObject("qList", qList);
		}
		mv.setViewName("/que/FAQListUser");
		return mv;
	}
	
	// FAQ 자주찾는 상품관련 
	@RequestMapping(value="/que/faq02.kh", method=RequestMethod.GET)
	public ModelAndView viewItemFAQ(
			ModelAndView mv) {
		Question que = new Question();
		List<Question> qList = qService.printFAQItem(que);
		if (!qList.isEmpty()) {
			mv.addObject("qList", qList);
		}
		mv.setViewName("/que/FAQListItem");
		return mv;
	}
	
	// FAQ 자주찾는 배송관련
	@RequestMapping(value="/que/faq03.kh", method=RequestMethod.GET)
	public ModelAndView viewDeliveryFAQ(
			ModelAndView mv) {
		Question que = new Question();
		List<Question> qList = qService.printFAQDelivery(que);
		if (!qList.isEmpty()) {
			mv.addObject("qList", qList);
		}
		mv.setViewName("/que/FAQListDelivery");
		return mv;
	}
	
	// FAQ 자주찾는 질문 교환/환불
	@RequestMapping(value="/que/faq04.kh", method=RequestMethod.GET)
	public ModelAndView viewChangeFAQ(
			ModelAndView mv) {
		Question que = new Question();
		List<Question> qList = qService.printFAQChange(que);
		if (!qList.isEmpty()) {
			mv.addObject("qList", qList);
		}
		mv.setViewName("/que/FAQListChange");
		return mv;
	}
	
	// FAQ 자주찾는 질문 기타문의
	@RequestMapping(value="/que/faq05.kh", method=RequestMethod.GET)
	public ModelAndView viewEtcFAQ(
			ModelAndView mv) {
		Question que = new Question();
		List<Question> qList = qService.printFAQEtc(que);
		if (!qList.isEmpty()) {
			mv.addObject("qList", qList);
		}
		mv.setViewName("/que/FAQListEtc");
		return mv;
	}
	
	/**
	 * 질문글 확인 관리자용
	 * @param mv
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/admin/manageList.kh", method=RequestMethod.GET)
	public ModelAndView viewManageList(
			ModelAndView mv
			, @RequestParam(value="page", required=false) Integer page) {
		/////////////////////////////////////////////////////////////////////////
		int currentPage = (page != null) ? page : 1;
		int totalCount = qService.getMangeTotalCount("", "");
		int boardLimit = 10;
		int naviLimit = 5;
		int maxPage;
		int startNavi;
		int endNavi;
		// 23/5 = 4.8 + 0.9 = 5(.7)
		maxPage = (int) ((double) totalCount / boardLimit + 0.9);
		startNavi = ((int) ((double) currentPage / naviLimit + 0.9) - 1) * naviLimit + 1;
		endNavi = startNavi + naviLimit - 1;
		if (maxPage < endNavi) {
			endNavi = maxPage;
		}
		//////////////////////////////////////////////////////////////////////////
		List<Question> qList = qService.printManageBoard(currentPage, boardLimit);
		if (!qList.isEmpty()) {
			mv.addObject("urlVal", "manageList");
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startNavi", startNavi);
			mv.addObject("endNavi", endNavi);
			mv.addObject("qList", qList);
		}
		mv.setViewName("/que/manageList");
		return mv;
	}
	
	// FAQ 공지등록화면
	@RequestMapping(value="/admin/viewWriteAdmin.kh", method=RequestMethod.GET)
	public String showFAQWrite() {
		return "que/FAQWriteForm";
	}
	
	// FAQ 공지등록
	@RequestMapping(value="/que/registerAdmin.kh", method=RequestMethod.POST)
	public ModelAndView registerFAQ(
			ModelAndView mv
			, @ModelAttribute Question que
			, HttpServletRequest request) {
		try {
			int result = qService.registerAdmin(que);
			mv.setViewName("redirect:/que/faq01.kh");
		} catch (Exception e) {
				e.printStackTrace();
				mv.addObject("msg", e.getMessage());
				mv.setViewName("main/errorPage");
		}
		return mv;
	} 
	
	// 답변등록 페이지
	@RequestMapping(value = "/que/answerView.kh", method = RequestMethod.GET)
	public ModelAndView queAnswerView(
			ModelAndView mv
			, @RequestParam("queNo") Integer queNo
			, @RequestParam("page") int page) {
		try {
			Question que = qService.printOneByNo(queNo);
			mv.addObject("que", que);
			mv.addObject("page", page);
			mv.setViewName("que/enrollAnswer");
		} catch (Exception e) {
			mv.addObject("msg", e.toString());
			mv.setViewName("main/errorPage");
		}
		return mv;
	}
	
	// Q&A 답변등록
	@RequestMapping(value = "/que/answer.kh", method = RequestMethod.POST)
	public ModelAndView commModify(
			@ModelAttribute Question que
			, ModelAndView mv
			, @RequestParam("page") Integer page
			, HttpServletRequest request) {
		try {
			int result = qService.modifyQna(que);
			mv.addObject("que", que);
			mv.setViewName("redirect:/que/manageList.kh?page=" + page);
			System.out.println(que);
		} catch (Exception e) {
			mv.addObject("msg", e.toString()).setViewName("main/errorPage");
		}
		return mv;
	}
	
	// q&a 제거
	@RequestMapping(value = "/que/remove.kh", method = RequestMethod.GET)
	public String queRemove(HttpSession session, Model model, @RequestParam("page") Integer page) {
		try {
			int queNo = (int) session.getAttribute("queNo");
			int result = qService.removeOneByNo(queNo);
			if (result > 0) {
				session.removeAttribute("queNo");
			}
			return "redirect:/que/manageList.kh?page=" + page;
		} catch (Exception e) {
			model.addAttribute("msg", e.toString());
			return "main/errorPage";
		}
	}
	// 문의글 검색 - 관리자용
	@RequestMapping(value = "/que/search.kh", method = RequestMethod.GET)
	public ModelAndView boardSearchList(
			ModelAndView mv
			, @RequestParam("searchCondition") String searchCondition
			, @RequestParam("searchValue") String searchValue
			, @RequestParam(value = "page", required = false) Integer page) {
		try {
			int currentPage = (page != null) ? page : 1;
			int totalCount = qService.getTotalUserCount(searchCondition, searchValue);
			int boardLimit = 10;
			int naviLimit = 5;
			int maxPage;
			int startNavi;
			int endNavi;
			maxPage = (int) ((double) totalCount / boardLimit + 0.9);
			startNavi = ((int) ((double) currentPage / naviLimit + 0.9) - 1) * naviLimit + 1;
			endNavi = startNavi + naviLimit - 1;
			if (maxPage < endNavi) {
				endNavi = maxPage;
			}
			List<Question> qList = qService.printAllByValue(searchCondition, searchValue, currentPage, boardLimit);
			if (!qList.isEmpty()) {
				mv.addObject("qList", qList);
			} else {
				mv.addObject("qList", null);
			}
			mv.addObject("urlVal", "search");
			mv.addObject("searchCondition", searchCondition);
			mv.addObject("searchValue", searchValue);
			mv.addObject("maxPage", maxPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("startNavi", startNavi);
			mv.addObject("endNavi", endNavi);
			mv.addObject("totalCount", totalCount);
			mv.setViewName("que/manageList");
		} catch (Exception e) {
			mv.addObject("msg", e.toString()).setViewName("common/errorPage");
		}
		return mv;
	}
	
}
