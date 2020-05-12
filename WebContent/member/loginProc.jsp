<%@page import="com.catp.mymember.MymemberDBBean"%>
<%@page import="com.catp.mymember.MymemberDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리페이지</title>
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="com.catp.mymember.MymemberDataBean"/>
<jsp:setProperty property="*" name="member"/>
<%
		MymemberDataBean user = new MymemberDataBean();
		MymemberDBBean dbPro = MymemberDBBean.getInstance();

		user = dbPro.login(member);
		
		if(user.getUserid() != null) { //로그인 성공
			session.setAttribute("member_id", user.getUserid());
			session.setAttribute("member_name", user.getUsername());
			out.print("<script> location.href='../index.jsp'; </script>");
		} else { //로그인 실패
			out.print("<script> alert('아이디와 비밀번호를 다시 입력해주세요 !'); history.back(); </script>");
		}
%>
</body>
</html>