<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인</title>
<script src="../resources/js/jquery.js"></script>
<link href="../../css/rentCheck.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<div class="clear"></div>

 <div id = "bigbox">
 <p id = "bar">예약확인</p>
	<div id = "box">
	
		<%--목록이 있는 경우 실행 --%>
		<c:if test="${!empty rlist}"> 

		<div id="img">
	 			<img alt="레이" src="${path}/resources/images/ray.jpg">
	 	</div>
	 	
			
			  <c:forEach var="r" items="${rlist}">
			   아이디: <span>${r.m_id}</span><br>
			   차량번호:<span>${r.car_id}</span><br>
			   빌린일자:<span>${r.rental_date} 빌린시간:</span><span>${r.rental_time}</span><br>
			   반납일자:<span>${r.return_date} 반납시간:</span><span>${r.return_time}</span><br>
			   렌트가격:<span>${r.rental_cost}</span><br>
			  </c:forEach>
			  
		</c:if>	
		
		
		<%--목록이 비었을 경우 실행 --%>
		<c:if test="${empty rlist}">
			 목록이 비었습니다.
		</c:if>



	</div>
</div>
<script type="text/javascript">
   var msg = "${msg}";
   
   if (msg === 'success') {
       alert('예약이 완료 되었습니다!');   
   }
 </script>
 
 
<jsp:include page="../include/footer.jsp"/>
</body>
</html>