package com.car.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.car.service.TestService;
import com.car.vo.TestVO;

@Controller
@RequestMapping("test/*")
public class TestController {

	@Autowired
	private TestService testService;

	//차 렌트 입력 폼
	@RequestMapping(value="/testCar", method=RequestMethod.GET)
	public void testCar() {
	}

	//차 렌트 저장
	@RequestMapping(value="/testCar", method=RequestMethod.POST)
	public ModelAndView testCar(TestVO t, RedirectAttributes rttr ) {
		this.testService.insertTest(t);
		rttr.addFlashAttribute("msg", "success");				//메서드는 이동하는 주소 testCar_Ok.jsp에서 동작시킴 (이동 후 동작)
		rttr.addFlashAttribute("mid", t.getMid()); 				//mid 값을 FlashAttribute에 추가
		return new ModelAndView("redirect:/test/testCar_Ok"); // 리다이렉트할 URL로 수정 (매핑주소(메서드)를 찾아감)
	}
	
	
	//차 예약처리
	@RequestMapping(value="/testCar_Ok")
	public String testCar_Ok(Model model, @ModelAttribute("mid") String mid) {
	    List<TestVO> tlist = this.testService.getTestList(mid);
	    model.addAttribute("tlist", tlist);
	    return "test/testCar_Ok";
	}


	
	/*
	//차 예약처리
	@RequestMapping(value="/testCar_Ok")
	public ModelAndView testCar_Ok(@RequestParam("mid") int mid) {
		TestVO tl = this.testService.getTestList(mid);
		listM.addAttribute("tlist",tlist);		//모델에 값을 저장
		return "test/testCar_Ok";
	}
	*/
	
}
























