<%@page import="com.catp.mymember.MymemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복검사</title>
<link href="../css/useridCheck.css" rel="stylesheet">
<script src="../js/useridCheck.js"></script>
</head>
<body>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="com.catp.mymember.MymemberDataBean"/>
<jsp:setProperty property="*" name="member"/>
<%
	//아이디 중복을 체크하기위한 변수 
	int check_count = 0;

	MymemberDBBean dbPro = MymemberDBBean.getInstance();
	check_count = dbPro.userIdCheck(member);
	
%>
<div id="container">
	<div id="header">
	    <a href="../index.jsp"><img src="../Images/cat01.png" alt="" id="logo"></a>
		<h2>중복 아이디 체크<br><br></h2>
	</div>
	<form name="id_check" action="useridCheck.jsp" method="post">
		<input type="hidden" name="check_count" value="<%=check_count %>">
			<ul type="none">
				<li><label for="userid">아이디 :</label> 
					<input type="text" id="userid" name="userid" value="<%=member.getUserid() %>" maxlength="16" size="16" autofocus>
					<input type="button" value="중복확인" onclick="doCheck();">
				</li>
					<%
					if(check_count == 0) {
						out.print("<br><font color='red'><small><b>"+ member.getUserid() + "</b>는 등록되어 있는 아이디 입니다.<br>다시 입력해 주세요.</small></font>");
					} else {
						out.print("<br><font color='green'><small><b>"+ member.getUserid() + "</b>는 사용할 수 있는 아이디 입니다.</small></font>");
					}
					%>
				<li>
			</ul>
				<input type="button" id="ok" value="확인" onclick="checkEnd();">
	</form>
</div>
</body>
</html>