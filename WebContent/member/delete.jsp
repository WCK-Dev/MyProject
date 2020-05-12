<%@page import="com.catp.mymember.MymemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 처리</title>
</head>
<body>
<jsp:useBean id="member" class="com.catp.mymember.MymemberDataBean"/>
<%
	String userid = (String)session.getAttribute("member_id");
	
	member.setUserid(userid);
	
	MymemberDBBean dbPro = MymemberDBBean.getInstance();
	dbPro.deleteMember(member);
	
	//회원 정보 삭제 후 남아있는 세션 삭제
	session.removeAttribute("member_id");
	//삭제후 페이지 이동
	response.sendRedirect("../index.jsp");
%>
</body>
</html>