<%@page import="com.catp.freeboard.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 답글쓰기 처리</title>
<style>
	#container { width: 300px; margin:20px auto; border: 1px solid black; padding: 20px; text-align: center;}
	a:link, a:visited { text-decoration: none;}
</style>
</head>
<body>
<div id="container">
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="com.catp.freeboard.FreeboardDataBean"/>
<jsp:setProperty property="*" name="board"/>
<%
	System.out.print(board.getMasterId());

	String pageNum = request.getParameter("pageNum");
	
	FreeboardDBBean dbPro = FreeboardDBBean.getInstance();
	int check = dbPro.replyWrite(board);
		
	if(check != 1) {
		out.print("<script>alert('댓글 입력에 실패했습니다.'); history.go(-1)</script>");		
	} else {
		response.sendRedirect("freeboard_read.jsp?id="+ board.getMasterId() +"&pageNum=" + pageNum);
	}
%>
</div>
</body>
</html>