<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 대기</title>
<link href="${pageContext.request.contextPath}/resources/css/rentCheck.css" rel="stylesheet"/>

<script src="../resources/js/jquery.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script>
/* 카드결제 API */
function cardPay(rental_m_id, mem_m_phone, mem_m_name, car_car_name, car_car_color, car_car_year, formattedTotalPrice) {
    IMP.init('imp87360186'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
    
    var showName = car_car_year+'년식 ' + car_car_color + ' ' + car_car_name;
    IMP.request_pay({
      pg: "html5_inicis",
      pay_method: "card",
      merchant_uid : 'merchant_'+new Date().getTime(),
      name : showName,
      amount : formattedTotalPrice * 1000,  //원 단위로 변경하여 전달 (기본값이 1달러)
      buyer_name : mem_m_name,
      buyer_tel : mem_m_phone,
    }, function (rsp) { // callback
        if (rsp.success) {
          alert("결제가 완료되었습니다.");
          location.href='rentCash.jsp';
        } else {
          alert("결제에 실패했습니다.");
        }
    });
}
</script>

<script>
/* 카카오페이결제 API */
function kakaoPay(rental_m_id, mem_m_phone, mem_m_name, car_car_name, car_car_color, car_car_year, formattedTotalPrice) {
    IMP.init('imp87360186'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
    
    var showName = car_car_year+'년식 ' + car_car_color + ' ' + car_car_name;
    
    IMP.request_pay({
      pg: "kakaopay",
      pay_method: "card",
      merchant_uid : 'merchant_'+new Date().getTime(),
      name : showName,
      amount : formattedTotalPrice * 1000,  //원 단위로 변경하여 전달 (기본값이 1달러)
      buyer_name : rental_m_id,
      buyer_tel : mem_m_phone,
    }, function (rsp) { // callback
        if (rsp.success) {
          alert("결제가 완료되었습니다. 메인페이지로 돌아갑니다.");
          location.href='/controller/';
        } else {
          alert("결제가 취소되었습니다.");
        }
    });
}
</script>

</head>

<body>
<jsp:include page="../include/header.jsp"/>
<div class="clear"></div>

<div id="bigbox">
    <p id="bar">예약대기</p>
    <div id="box">
        <c:if test="${!empty rental and !empty rental.m_id}">
            <div id="img">
                <img alt="레이" src="${pageContext.request.contextPath}/resources/images/ray.jpg">
            </div>
            
            <div id="member">
            <h2>&nbsp;예약자 정보</h2>
                아이디: <span>${rental.m_id}</span><br>
                연락처: <span>${mem.m_phone}</span><br>
                이름: <span>${mem.m_name}</span><hr>
                
            <h2>&nbsp;차량 정보</h2>
                차종: <span>${car.car_name}</span><br>
                차량색상: <span>${car.car_color}</span><br>
                연식: <span>${car.car_year}년식</span><br>
            </div>
            
            <div id="car">
            <h2>&nbsp;렌트 정보</h2>
                예약일자: <span>${rental.reservation_date}</span><br>
                실제 대여일자: <span>${rental.rental_date_time}부터</span><br>
                반납일자: <span>${rental.return_date_time}까지</span><br>
                렌트 비용: <span>${formattedTotalPrice}원</span><br>
                <button onclick="cardPay('${rental.m_id}', '${mem.m_phone}', '${mem.m_name}', '${car.car_name}', '${car.car_color}', '${car.car_year}', ${formattedTotalPrice})">카드 결제</button>
                <button onclick="kakaoPay('${rental.m_id}', '${mem.m_phone}', '${mem.m_name}', '${car.car_name}',  '${car.car_color}', '${car.car_year}', ${formattedTotalPrice})">카카오페이 결제</button>
                <p><span id="carDetails"></span></p>
            </div>
        </c:if>
        
        <c:if test="${empty rental}">
            세션이 만료 되었습니다. 다시 예약 해주세요
        </c:if>
    </div>
</div>

<script type="text/javascript">
   var msg = "${msg}";
   
   if (msg === 'success') {
       alert('예약내역을 확인합니다!');   
   }
</script>

<jsp:include page="../include/footer.jsp"/>
</body>
</html>
