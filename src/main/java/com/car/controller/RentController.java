package com.car.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.car.service.MemberService;
import com.car.service.RentService;
import com.car.vo.CarVO;
import com.car.vo.MemberVO;
import com.car.vo.RentalVO;

@Controller //스프링 MVC 게시판 컨트롤러 클래스
@RequestMapping("/rent/*")
public class RentController {
	
	@Autowired
	private RentService rentService;
	
	@Autowired
	private MemberService memberService;
	
	
	//차량 예약 페이지 (클라이언트가 입력)
	@RequestMapping(value="/rentCar",method=RequestMethod.GET)
	public void rentCar() {}
	
	//차 렌트 저장	(입력된 값들이 RentalVO로 넘어온 상태)
	@RequestMapping(value="/rentCar", method=RequestMethod.POST)
	public ModelAndView rentCar(RentalVO r, RedirectAttributes rttr){
		
		try {
			
		
		/*렌트빌리는 날짜, 반납하는 날짜 기능*/
		String rental_date_time = r.getRental_date_time();		//VO에 들어있는 날짜,시간 값들을 가져옴
		String return_date_time = r.getReturn_date_time();
		
		rental_date_time = rental_date_time.replace("T", " ");	//중간에 껴있는 T문자를 공백처리함
		return_date_time = return_date_time.replace("T", " ");
		
		r.setRental_date_time(rental_date_time);	//공백처리한 날짜,시간 값을 다시 저장
		r.setReturn_date_time(return_date_time);
		
		/*렌트 신청일 구하기*/
		// 현재 날짜 가져오기
	    Date d = new Date();
	    SimpleDateFormat s = new SimpleDateFormat("yyyy년 MM월 dd일 aa hh시 mm분");
	    String reservation_date = s.format(d);
	    
	    // 현재 날짜 설정 (렌트 신청일)
	    r.setReservation_date(reservation_date);	//클라이언트에게 입력받는것이 아닌 코드가 동작하는 순간 시간 저장
		this.rentService.insertRental(r);			//모든 값들이 준비되었으면 데이터베이스에 저장
		
		rttr.addFlashAttribute("msg", "success");					//메서드는 이동하는 주소 testCar_Ok.jsp에서 동작시킴 (이동 후 동작)
		rttr.addFlashAttribute("m_id", r.getM_id()); 				//mid 값을 FlashAttribute에 추가
		return new ModelAndView("redirect:/rent/rent_Wait"); 		// 리다이렉트할 URL로 수정 (매핑주소(메서드)를 찾아감)
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/error");	//에러페이지로 이동
	}
	
	//차 예약 완료전 결제창
	@RequestMapping(value = "/rent_Wait", method = RequestMethod.GET)
	public String rent_Wait(Model model, @ModelAttribute("m_id") String m_id) {
		try {
		//Model은 데이터를 뷰로 전달하기 위해 사용됨
		//@ModelAttribute("m_id") String m_id는 이전 페이지에서 "m_id"라는 속성으로 전달된 데이터를 받는 용도
		
		/*해당 아이디의 렌트 정보를 가져옴*/
	    RentalVO rental = this.rentService.getRentOne(m_id);

	    // 차량 정보 조회 (가격)
	    CarVO car = this.rentService.getCarInfo(rental.getCar_id());
	    
	    //고객 정보 가져오기 (렌트 내역에 필요)
	    MemberVO mem = this.memberService.getMemberInfo(m_id);

	    // 렌트 기간 계산
	    //DateTimeFormatter를 이용하여 날짜와 시간 문자열을 파싱하여 LocalDateTime 객체로 변환
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
	    LocalDateTime rentalDateTime = LocalDateTime.parse(rental.getRental_date_time(), formatter);
	    LocalDateTime returnDateTime = LocalDateTime.parse(rental.getReturn_date_time(), formatter);
	    
	  /*Duration.between(rentalDateTime, returnDateTime)를 통해 렌트 기간의 시간 간격을 계산*/
	    Duration duration = Duration.between(rentalDateTime, returnDateTime);
	    long minutes = duration.toMinutes();	//몇분동안 렌트했는지 파악

	    // 1분당 렌트 가격
	    double totalPrice = Math.ceil(minutes) * (car.getCar_price() / 60.0);
	    
	    /*DecimalFormat 는 숫자의 출력형태를 변환한다.*/
	    DecimalFormat decimalFormat = new DecimalFormat("#,###");
        String formattedTotalPrice = decimalFormat.format(totalPrice);
	    

	    model.addAttribute("rental", rental);	//렌탈정보
	    model.addAttribute("car",car);			//차정보
	    model.addAttribute("mem",mem);			//회원정보
	    model.addAttribute("formattedTotalPrice", formattedTotalPrice);	//렌트비용

	    return "/rent/rent_Wait";
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/error";	//에러페이지로 이동
	}
	
	@RequestMapping(value = "/rent_Cash_backup", method = RequestMethod.GET)
	public void rent_Cash_backup(){
	}
}
