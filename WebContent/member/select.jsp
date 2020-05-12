<%@page import="com.catp.mymember.MymemberDataBean"%>
<%@page import="com.catp.mymember.MymemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 개인 정보 조회</title>
<link href="../css/select.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function delete_check() {
		var answer = confirm ("회원 탈퇴처리 후에는 고객님의 정보를 복구할 수 없습니다.\n정말 회원 탈퇴를 수행할까요?");
		
		if(answer) { location.href="delete.jsp"; }
		else { return; }
	}
</script>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">
<jsp:useBean id="member" class="com.catp.mymember.MymemberDataBean"/>
<%
	if(session.getAttribute("member_id") == null) { //조회된 정보가 없을때 (회원 정보 조회에 실패했을 때)
		out.print("<script>alert('먼저 로그인을 해야합니다!'); location.href='login.jsp';</script>");
	} 

	member.setUserid((String)session.getAttribute("member_id"));
	
	MymemberDBBean dbPro = MymemberDBBean.getInstance();
	MymemberDataBean user = new MymemberDataBean();

	user = dbPro.selectMember(member);
%>
   	<div class="mypage_top">
   		<table><tr>
           <th width="200px">마이<br>페이지</th><td><%=user.getUsername() %>님 반갑습니다 !</td>
        </tr></table> 
  	</div>
        
	<div id="member_tab">
	<h3>나의 구매정보</h3>
		<ul>
			<li><a href="../cart/cart_list.jsp">장바구니</a></li>
			<li><a href="../order/order_list.jsp">나의 구매내역</a></li>
			<li><a href="#">반품하기</a></li>
		</ul>
		
	<h3>회원정보 관리</h3>
		<ul>
			<li><a href="select.jsp">내 정보 조회</a></li>
			<li><a href="#" onclick="location='modify.jsp?mode=modify'">내 정보 변경하기</a></li>
			<li><a href="#" onclick="delete_check();">회원 탈퇴</a></li>
		</ul>
	</div>
	
    <div class="select">
        <h1>| 회원정보 조회</h1>
        <form name="join" method="post">
		<input type="hidden" name="userid" value="<%=user.getUserid() %>">
		<input type="hidden" name="mode" value="modify">
        <table>
            <tr>
                <td class="first_col" width="35%">아이디</td>
                <td class="second_col"><%=user.getUserid() %></td>
            </tr>
            <tr>
                <td class="first_col" >비밀번호</td>
                <td class="second_col"><%=user.getPassword() %></td>
            </tr>
            <tr>
                <td class="first_col" >이름</td>
                <td class="second_col"><%=user.getUsername() %></td>
            </tr>
            <tr>
                <td class="first_col" >E-mail</td>
                <td class="second_col"><%=user.getEmail() %></td>
            </tr>
            <tr>
                <td class="first_col" >연락처</td>
                <td class="second_col"><%=user.getPhone() %></td>
            </tr>
            <tr>
                <td class="first_col" >주소</td>
                <td class="second_col"><%=user.getZipcode() %>&nbsp;&nbsp;<%=user.getAddress1() %><br>
				<%=user.getAddress2() %>
                </td>
            </tr>
            <tr>
			<td class="first_col">가입일</td>
			<td class="second_col"><%=user.getRegdate() %></td>
		</tr>
        </table>
            <button type="button" id="commit" onclick="location.assign('../index.jsp');">확 인</button>
			<input type="button" value="정보 수정" id="modify" onclick="location='modify.jsp?mode=modify'"><br><br>
			<input type="button" value="회  원  탈  퇴" id="delete" onclick="delete_check();">
        </form>
    </div>
</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>