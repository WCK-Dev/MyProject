<%@page import="com.catp.freeboard.FreeboardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글내용 삭제 처리</title>
</head>
<body>
<jsp:useBean id="board" class="com.catp.freeboard.FreeboardDataBean"/>
<jsp:setProperty property="*" name="board"/>
<% request.setCharacterEncoding("UTF-8");%>
<%
	String pageNum = request.getParameter("pageNum");
	FreeboardDBBean dbPro = FreeboardDBBean.getInstance();	
	int check = dbPro.deleteBoard(board);
		
	if(check > 0){
		out.print("<script>alert('정상적으로 삭제되었습니다.'); location.href='freeboard_list.jsp?pageNum=1'</script>");
	} else {
		out.print("<script>alert('삭제에 오류가 발생했습니다.'); history.back();</script>");
	}
%>

</body>
</html>