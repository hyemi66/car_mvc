package com.car.service;

import java.util.List;

import com.car.vo.CarVO;
import com.car.vo.MemberVO;
import com.car.vo.RentalVO;

public interface RentService {

	//차량 예약 요청
	void insertRental(RentalVO r);

	//차량 렌트 내역 확인
	List<RentalVO> getRentList(String m_id);

	//방금 예약한목록 가져오기
	RentalVO getRentOne(String m_id);
	
	//회원 정보 확인(가져오기)
	void getMemberList(MemberVO m);

	//차 정보 확인
	CarVO getCarInfo(int car_id);

}
