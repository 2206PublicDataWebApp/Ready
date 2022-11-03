package com.kh.ready.mypage.service.logic;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ready.mypage.domain.Survey;
import com.kh.ready.mypage.service.MypageService;
import com.kh.ready.mypage.store.MypageStore;

@Service
public class MypageServiceImpl implements MypageService{
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private MypageStore mStore;
	
	@Override
	public int registSurvey(Survey survey) {
		int result = mStore.insertSurvey(survey, session);
		return result;
	}

	@Override
	public Survey printMySurvey(String userId) {
		Survey survey = mStore.selectMySurvey(userId, session);
		return survey;
	}

	@Override
	public int modifySurvey(Survey survey) {
		int result = mStore.updateSurvey(survey, session);
		return result;
	}

}