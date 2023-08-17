package com.car.dao;

import java.util.List;

import com.car.vo.TestVO;

public interface TestDAO {

	void insertTest(TestVO t);

	List<TestVO> getTestList(String mid);

	String getName(TestVO t);

}
