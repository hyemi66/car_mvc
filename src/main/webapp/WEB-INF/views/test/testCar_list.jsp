<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인</title>
<script src="../resources/js/jquery.js"></script>
<link href="${path}/resources/css/main.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
테스트 차 리스트
<c:if test="${!empty tlist}"> <%--목록이 있는 경우 실행 --%>
  <c:forEach var="t" items="${tlist}">
   <p>${t.mnum}</p>
   <p>${t.mid}</p>
   <p>${t.car_name}</p>
  </c:forEach>
 </c:if>
 <c:if test="${empty tlist}">
   목록이 비었습니다.
 </c:if>





<script type="text/javascript">
   var msg = "${msg}";
   
   if (msg === 'success') {
       alert('예약이 완료 되었습니다!');   
   }
 </script>
 
<jsp:include page="../include/footer.jsp"/>
</body>
</html>