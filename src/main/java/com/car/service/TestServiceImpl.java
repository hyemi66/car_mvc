package com.car.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.car.dao.TestDAO;
import com.car.vo.TestVO;

@Service
public class TestServiceImpl implements TestService {

	@Autowired
	private TestDAO testDao;

	@Override
	public void insertTest(TestVO t) {
		this.testDao.insertTest(t);
	}

	@Override
	public List<TestVO> getTestList(String mid) {
		return this.testDao.getTestList(mid);
	}

	@Override
	public String getName(TestVO t) {
		return this.testDao.getName(t);
	}
	
}
