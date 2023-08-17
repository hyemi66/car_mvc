package com.car.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.car.vo.CarVO;
import com.car.vo.MemberVO;
import com.car.vo.RentalVO;

@Repository
public class RentalDAOImpl implements RentalDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertRental(RentalVO r) {
		this.sqlSession.insert("rental_in",r);
	}

	@Override
	public List<RentalVO> getRentList(String m_id) {
		return this.sqlSession.selectList("get_rlist",m_id);
	}
	
	@Override
	public RentalVO getRentOne(String m_id) {
	    return this.sqlSession.selectOne("get_rentCar", m_id);
	}


	@Override
	public void getMemberList(MemberVO m) {
		this.sqlSession.selectList("m_list",m);
	}

	@Override
	public CarVO getCarInfo(int car_id) {
		return this.sqlSession.selectOne("c_list",car_id);
	}

}
