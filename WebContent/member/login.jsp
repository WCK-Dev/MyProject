<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link href="../css/login.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
		<jsp:include page="../include/header.jsp"></jsp:include>
	<div id="container">
	    <div id="content">
	    	<div id="login_block">
			    <h2>로그인</h2> 
			    <form action="loginProc.jsp" method="post" name="login">
			        <ul type="none">
			            <li>
			            	<p>아이디</p>
			            	<input type="text" class="other" name="userid" required>
			            </li>
			            <li>
			            	<p>&nbsp;&nbsp;비밀번호</p>
			            	<input type="password" class="ohter" name="password" required>
			           	</li>
			        </ul>
			        <button type="submit">로그인</button>
			    </form>
	    	</div>
	    </div>
    </div>        
	    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>