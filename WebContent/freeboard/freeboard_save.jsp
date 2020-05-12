<%@page import="com.catp.freeboard.FreeboardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기 처리</title>
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
		int cnt = 0;
		FreeboardDBBean dbPro = FreeboardDBBean.getInstance();
		cnt = dbPro.insertBoard(board);
		
		if(cnt != 0){
			out.print("정상적으로 게시글이 작성되었습니다.<br>");
		} else {
			out.print("게시글 작성에 실패했습니다.<br>");
		}
%>
<a href="freeboard_write.jsp">[글 쓰기 페이지로]</a>
<jsp:forward page="freeboard_list.jsp"></jsp:forward>
</div>
</body>
</html>