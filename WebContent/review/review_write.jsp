<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰글 작성</title>
<link href="../css/review_write.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function check() {
		var form = document.reviewwrite;
		
		if(form.name.value.length == 0){
			alert("이름을 입력해 주세요!");
			form.name.focus();
			return false;
		}
	
		if(form.subject.value.length == 0){
			alert("제목을 입력해 주세요!");
			form.subject.focus();
			return false;
		}
		
		if(form.content.value.length == 0){
			alert("내용을 입력해 주세요!");
			form.content.focus();
			return false;
		}
		
		form.submit();
	}
</script>
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
			<li><a href="review_show.jsp">리뷰 보기</a></li>
			<li><a href="review_write.jsp">리뷰 작성</a></li>
		</ul>
		
	<h3>질의 게시판</h3>
		<ul>
			<li><a href="../freeboard/freeboard_list.jsp">게시판 보기</a></li>
			<li><a href="../freeboard/freeboard_write.jsp">게시판 글 작성</a></li>
		</ul>
	</div>
	
	<div id="review">
		<h2>리뷰글 작성</h2>
		<form name="reviewwrite" action="review_save.jsp" method="post">
			<table>
				<tr>
					<th width="15%"><label for="name">이름</label></th>
					<td width="*"><input type="text" name="name" maxlength="10" autofocus required></td>
				</tr>
				<tr>
					<th><label for="productid">제품번호</label></th>
					<td><input type="text" name="productid" maxlength="50"></td>
				</tr>
				<tr>
					<th><label for="subject">제목</label></th>
					<td><input type="text" name="subject" maxlength="60"></td>
				</tr>
				<tr class="content_row">
					<th><label for="name">내용</label></th>
					<td><textarea name="content" maxlength="2000" cols="80" rows="18" required></textarea></td>
				</tr>
			</table>
			<div id="btn_row">
				<button type="button" onclick="check();">작성하기</button>
				<button type="button" onclick="location.href='review_show.jsp'">취소</button>
			</div>
			
		</form>
	</div>	
</div>        
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>