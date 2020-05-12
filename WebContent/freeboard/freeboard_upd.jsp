<%@page import="com.catp.freeboard.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 내용 수정 폼</title>
<link href="../css/freeboard_upd.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="../js/freeboard_upd.js"></script>
</head>
<body>
   <jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="com.catp.freeboard.FreeboardDataBean"/>
<jsp:setProperty property="*" name="board"/>
<%
	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
%>
	<div id="side_bar">
	<h3>리뷰 보드</h3>
		<ul>
			<li><a href="../review/review_show.jsp">리뷰 보기</a></li>
			<li><a href="../review/review_write.jsp">리뷰 작성</a></li>
		</ul>
		
	<h3>질의 게시판</h3>
		<ul>
			<li><a href="freeboard_list.jsp">게시판 보기</a></li>
			<li><a href="freeboard_write.jsp">게시판 글 작성</a></li>
		</ul>
	</div>

	<div id="freeboard">
<%
		String pageNum = request.getParameter("pageNum");

		FreeboardDBBean dbPro = FreeboardDBBean.getInstance();
		FreeboardDataBean getboard = dbPro.getBoard(board);
		
			
			if(getboard == null){
				out.print("<script>alert('해당 글은 존재하지않습니다.');<br>history.back();</script>");
			} else {
%>
		<h2>글 내용 수정하기</h2>
		<form name="msgwrite" action="freeboard_upddb.jsp?id=<%=getboard.getId() %>&pageNum=<%=pageNum %>" method="post">
			<input type="hidden" name="id" value="<%=getboard.getId() %>">
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
			
			<table>
				<tr>
					<th width="20%"><label for="name">이름</label></th>
					<td width="80%"><input type="text" name="name" id="name" value="<%=getboard.getName() %>"></td>
				</tr>
				<tr>
					<th><label for="email">E-MAIL</label></th>
					<td><input type="text" name="email" id="email" value="<%=getboard.getEmail() %>"></td>
				</tr>
				<tr>
					<th><label for="subejct">제목</label></th>
					<td><input type="text" name="subject" id="subject" size="50" maxlength="50" value="<%=getboard.getSubject() %>"></td>
				</tr>
				<tr>
					<th><label for="content">내용</label></th>
					<td><textarea name="content" id="content" cols="66" rows="19"><%=getboard.getContent() %></textarea></td>
				</tr>
				<tr>
					<th><label for="password">비밀번호</label></th>
					<td><input type="password" name="password" id="password" value="">
					<font color="red"><small>비밀번호를 입력해야 수정이 가능합니다.</small></font></td>
				</tr>
				
				<tr>
					<td class="move" colspan="2">
						<button type="button" onclick="check();">수정 완료</button>
						<button type="button" onclick="history.back();">취소</button>
					</td>
				</tr>
			</table>
		</form>
<%			}//else문의 종료 %>
	</div>
</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>