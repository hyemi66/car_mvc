<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script src="../js/jquery.js"></script>
<link href="/controller/resources/css/main.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<form method="post">
<h2>로그인 페이지 입니다.</h2>
		아이디: <input type="text" name="m_id" id="m_id">	<br>
		비밀번호: <input type="password" name="m_pwd" id="m_pwd"> <br>
		<input type="submit" value="로그인">
		<input type="button" value="회원가입" onclick="location.href='/controller/member/memberSign'">

</form>

<script type="text/javascript">
	var loginmsg = "${loginmsg}";
	
	if (loginmsg === 'success') {
	    alert('로그인에 성공 했습니다!');   
	}

   var errorMessage  = "${errorMessage}";
   
   if (errorMessage  === 'error') {
       alert('잘못 입력 하셨습니다. 다시 로그인 해주세요 !');   
   }
 </script>

<jsp:include page="../include/footer.jsp"/>
</body>
</html>