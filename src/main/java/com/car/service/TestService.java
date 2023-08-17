package com.car.service;

import java.util.List;

import com.car.vo.TestVO;

public interface TestService {

	void insertTest(TestVO t);

	List<TestVO> getTestList(String mid);

	String getName(TestVO t);

}
