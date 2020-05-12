<%@page import="com.catp.freeboard.FreeboardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글내용 수정 처리</title>
</head>
<body>
<div id="container">
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="com.catp.freeboard.FreeboardDataBean"/>
<jsp:setProperty property="*" name="board"/>
<%
	FreeboardDBBean dbPro = FreeboardDBBean.getInstance();
	int cnt = dbPro.updateBoard(board);
	
	
	if(cnt != 0) {
		out.print("<script>alert('정상적으로 수정되었습니다.'); location.href='freeboard_list.jsp?pagenum=1'</script>");		
	} else {
		out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
	}
%>

</div>
</body>
</html>