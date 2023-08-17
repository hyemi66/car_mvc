package com.car.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.car.service.MemberService;
import com.car.service.RentService;
import com.car.vo.MemberVO;

@Controller
@RequestMapping("/rent/*")
public class RentCheckController {

	@Autowired
	private RentService rentService;
	@Autowired
	private MemberService memberService;
	
	//예약확인 페이지 폼
	@RequestMapping(value="/rentCheck", method=RequestMethod.GET)
	public void rentCheck() {
	}
	
	//예약확인 폼에서 작성된것을 전송하는 메서드
	@RequestMapping(value="/rentCheck", method=RequestMethod.POST)
	public ModelAndView rentCheck(MemberVO m, RedirectAttributes rttr) {
		this.rentService.getMemberList(m);
		System.out.println(m.getM_id());
		return new ModelAndView("redirect:/rent/rentCheck_Ok");
	}
		
}
