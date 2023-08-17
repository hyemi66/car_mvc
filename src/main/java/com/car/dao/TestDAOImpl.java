package com.car.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.car.vo.TestVO;

@Repository
public class TestDAOImpl implements TestDAO {

	@Autowired
	private SqlSession sqlSession;

	//렌트 저장
	@Override
	public void insertTest(TestVO t) {
		this.sqlSession.insert("test_in",t);
	}

	//렌트 목록 가져오기
	@Override
	public List<TestVO> getTestList(String mid) {
		return this.sqlSession.selectList("t_list",mid);
	}

	@Override
	public String getName(TestVO t) {
		return this.sqlSession.selectOne("t_name",t);
	}
	
	
}
