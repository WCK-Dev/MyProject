<%@page import="com.catp.freeboard.FreeboardDataBean"%>
<%@page import="com.catp.freeboard.FreeboardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세(내용) 보기</title>
<link href="../css/freeboard_read.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./js/freeboard_read.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>

<div id="container">
<jsp:useBean id="board" class="com.catp.freeboard.FreeboardDataBean"/>
<jsp:setProperty property="*" name="board"/>
<%request.setCharacterEncoding("UTF-8"); %>
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

	<div id="read">
<%
		String pageNum = request.getParameter("pageNum");
		FreeboardDBBean dbPro = FreeboardDBBean.getInstance();
		FreeboardDataBean getBoard = dbPro.getBoard(board);
		
%>
	<h2>글 내용 보기</h2>
	<form name="reply" method="post" action="freeboard_rsave.jsp">
	<table>
		<tr>
			<th width="15%">글 번호</th>
			<td width="35%"  class="left"><%=getBoard.getId() %></td>
			<th width="15%">조회수</th>
			<td width="35%" class="center"><%=getBoard.getReadCount() %></td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td class="left"><%=getBoard.getName() %></td>
			<th>작성일</th>
			<td class="center"><%=getBoard.getInputDate() %>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3" class="left"><%=getBoard.getSubject() %></td>
		</tr>
		<tr>
			<td colspan="4" class="left"><pre class="content_pre" style="white-space: pre-wrap;"><%=getBoard.getContent() %></pre></td>
		</tr>
		<tr>
			<td colspan="4" class="center" class="sub_content">댓글</td>
		</tr>
<%
		List<FreeboardDataBean> replyList = dbPro.getReplyList(getBoard);
		for(int i=0; i<replyList.size(); i++){
			FreeboardDataBean reply = replyList.get(i);
%>
				<tr>
					<td class="left"><%=reply.getName() %></td> <td colspan="3" class="left"><%=reply.getContent() %></td>
				</tr>
<%		
		}
%>
		<tr id="reply_row">
			<td class="left">
				<input type="hidden" name="masterId" value="<%=getBoard.getId() %>">
				<input type="hidden" name="pageNum" value="<%=pageNum %>">
				<input type="text" name="name" placeholder="아이디" size="14" maxlength="10" required>
				<input type="password" name="password" placeholder="비밀번호" size="14" maxlength="10" required></td>
			<td colspan="3">
				<textarea name="content" id="content" rows="4" cols="70" maxlength="2000" required></textarea>
				<input id="reply_btn" type="button" onclick="submitCheck();" value="댓글 쓰기">
			</td>
			
		</tr>
		<tr class="right">
			<td colspan="4">
				<button class="bot_btn" type="button" onclick="location.href='freeboard_list.jsp?pageNum=<%=pageNum %>'">글 목록</button>
				<button class="bot_btn" type="button" onclick="location.href='freeboard_upd.jsp?id=<%=getBoard.getId() %>&pageNum=<%=pageNum %>'">글 수정</button>
				<button class="bot_btn" type="button" onclick="location.href='freeboard_del.jsp?id=<%=getBoard.getId() %>&pageNum=1'">삭제</button>
			</td>
		</tr>
	</table>
	</form>
<%
			
%>
	</div>
</div> 
   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>