<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>CarInDrive</title>
  <link rel="stylesheet" type="text/css" href="../css/styles.css">
  <link rel="stylesheet" type="text/css" href="../css/rentCheck.css">
  
  <%-- STEP 1 --%>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


    
<script>
/*카드결제 API*/
function cardPay() {
  IMP.init('imp87360186'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
  IMP.request_pay({
    pg: "html5_inicis",
    pay_method: "card",
    merchant_uid : 'merchant_'+new Date().getTime(),
    name : '비싼차',
    amount : 10000,
    buyer_name : '구매자',
    buyer_tel : '010-1234-5678',
  }, function (rsp) { // callback
      if (rsp.success) {
    	  alert("결제가 완료되었습니다.");
    	  location.href='rentCash_Ok.jsp';
       	
      } else {
    	  alert("결제에 실패했습니다.");
      }
  });
}


/*카카오페이결제 API*/
function kakaoPay() {
	  IMP.init('imp87360186'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
	  IMP.request_pay({
	    pg: "kakaopay",
	    pay_method: "card",
	    merchant_uid : 'merchant_'+new Date().getTime(),
	    name : '비싼차',
	    amount : 1000000,
	    buyer_name : '구매자',
	    buyer_tel : '010-1234-5678',
	    buyer_postcode : '123-456'
	  }, function (rsp) { // callback
	      if (rsp.success) {
	       	alert("결제가 완료되었습니다.");
	       	location.href='rentCash_Ok.jsp?';
	      } else {
	        alert("결제에 실패했습니다.");
	      }
	  });
	}
	
</script>
	  
	          

</head>
<body>
  <jsp:include page="../include/header.jsp"/>
  

  
  <div class="clear"></div>

<div id = bigbox>

<button onclick="cardPay()">카드 결제하기</button>
<button onclick="kakaoPay()">카카오페이</button>

</div>



<jsp:include page="../include/footer.jsp"/>
