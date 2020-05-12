<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제</title>
<link href="./css/freeboard_del.css" rel="stylesheet">
<script src="./js/freeboard_del.js"></script>
</head>
<body>
<div id="container">
	<h2>글 삭제하기</h2>
	<form name ="msgdel"action="freeboard_deldb.jsp" method="post">
		<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
		<input type="hidden" name="pageNum" value="<%=request.getParameter("pageNum") %>">
		<table>
			<tr>
				<th width="40%"><label for="password">비밀번호</label></th>
				<td width="*"><input type="password" name="password" id="password" ></td>
			</tr>
			<tr class="end_row">
				<td colspan="2">
					<button type="button" onclick="check();">삭제</button>
					<button type="button" onclick="history.back();">취소</button>
				</td>
			</tr>
		</table>	
	</form>
</div>
</body>
</html>