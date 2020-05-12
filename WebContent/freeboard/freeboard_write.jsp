<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 게시판 글쓰기</title>
<link href="../css/freeboard_write.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="../js/freeboard_write.js"></script>
</head>
<body>
    <jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">
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
	
	<div id="freeboard">
	<h2>회원 게시판 글쓰기</h2>
	<form name="msgwrite" method="post" action="freeboard_save.jsp">
		<table>
			<tr>
				<th width="15%"><label for="name">이름</label></th>
				<td width="35%"><input type="text" name="name" id="name" autofocus required></td>
				<th width="15%"><label for="email">E-MAIL</label></th>
				<td width="35%"><input type="text" name="email" id="email" required></td>
			</tr>		
			<tr>
				<th><label for="subject">제목</label></th>
				<td><input type="text" name="subject" id="subject" size="40" required></td>
				<th><label for="password">비밀번호</label></th>
				<td><input type="password" name="password" id="password" required><br>
				</td>
			</tr>		
			<tr>
				<th><label for="content">내용</label></th>
				<td colspan="3"><textarea name="content" id="content" rows="25" cols="110" maxlength="2000" required ></textarea></td>
			</tr>
		</table>
		<div id="btn_row">
			<button class="bot_btn" type="button" onclick="check();">작성 완료</button>
			<button class="bot_btn" type="button" onclick="history.back();">취소</button>
		</div>
		<br>
	</form>
	</div>	
</div> 
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>