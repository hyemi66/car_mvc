package com.car.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.car.dao.RentalDAO;
import com.car.vo.CarVO;
import com.car.vo.MemberVO;
import com.car.vo.RentalVO;

@Service
public class RentServiceImpl implements RentService {

	@Autowired
	private RentalDAO rentalDao;
	
	@Override
	public void insertRental(RentalVO r) {
		this.rentalDao.insertRental(r);
	}

	@Override
	public List<RentalVO> getRentList(String m_id) {
		return rentalDao.getRentList(m_id);
	}
	
	@Override
	public RentalVO getRentOne(String m_id) {
		return this.rentalDao.getRentOne(m_id);
	}

	@Override
	public void getMemberList(MemberVO m) {
		this.rentalDao.getMemberList(m);
	}

	@Override
	public CarVO getCarInfo(int car_id) {
		return this.rentalDao.getCarInfo(car_id);
	}




}
