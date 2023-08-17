<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="../js/jquery.js"></script>
<link href="/controller/resources/css/main.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<form method="post">
<h2>회원 가입 페이지 입니다.</h2>
		아이디: <input type="text" name="m_id" id="m_id"> <br>
		비밀번호: <input type="password" name="m_pwd" id="m_pwd"> <br>
		이름: <input type="text" name="m_name" id="m_name"> <br>
		전화번호: <input type="text" name="m_phone" id="m_phone"> <br>
				<input type="submit" value="가입하기"> <br>
</form>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>