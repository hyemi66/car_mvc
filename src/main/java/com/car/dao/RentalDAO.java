package com.car.dao;

import java.util.List;

import com.car.vo.CarVO;
import com.car.vo.MemberVO;
import com.car.vo.RentalVO;

public interface RentalDAO {

	void insertRental(RentalVO r);

	List<RentalVO> getRentList(String m_id);
	
	RentalVO getRentOne(String m_id);

	void getMemberList(MemberVO m);

	CarVO getCarInfo(int car_id);

	

}
