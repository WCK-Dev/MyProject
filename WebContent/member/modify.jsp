<%@page import="com.catp.mymember.MymemberDataBean"%>
<%@page import="com.catp.mymember.MymemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link href="../css/modify.css" rel="stylesheet">
<script src="../js/joinForm.js"></script>
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
	<jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="com.catp.mymember.MymemberDataBean"/>
<jsp:setProperty property="*" name="member"/>
<%

	if(session.getAttribute("member_id") == null) { //조회된 정보가 없을때 (회원 정보 조회에 실패했을 때)
		out.print("<script>alert('먼저 로그인을 해야합니다!'); location.href='login.jsp';</script>");
	} 

	String mode = request.getParameter("mode");
	
	member.setUserid((String)session.getAttribute("member_id"));
	String zipcode1 = request.getParameter("zipcode1");
	String zipcode2 = request.getParameter("zipcode2");
	String zipcode = zipcode1 + "-" + zipcode2;
	member.setZipcode(zipcode);
	
	MymemberDataBean user = new MymemberDataBean();
	MymemberDBBean dbPro = MymemberDBBean.getInstance();
	
	
	if(mode.equals("null")) {
		
		user = dbPro.selectMember(member);
		
		if(user.getUserid() != null){
			zipcode1 = user.getZipcode().split("-")[0];
			zipcode2 = user.getZipcode().split("-")[1];
		} else {
			out.print("<script>alert('먼저 로그인을 해야합니다!'); history.back();</script>");
		}
	} else if (mode.equals("update")) {
		dbPro.updateMember(member);
		out.print("<script>alert('회원 정보 수정이 완료되었습니다.');</script>");
		response.sendRedirect("../index.jsp");
	}
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
			<li><a href="#" onclick="location='modify.jsp">내 정보 변경하기</a></li>
			<li><a href="#" onclick="delete_check();">회원 탈퇴</a></li>
		</ul>
	</div>
	
	<div id="usermodify">
		<h1>| 회원정보 수정</h1>
		<form name="join" action="modify.jsp" method="post">
			<ul type="none">
				<li><p>아이디 </p><input type="text" name="userid" class="ohter" disabled value="<%=user.getUserid() %>" readonly></li>
				<li><p>비밀번호</p><input type="password" name="password" class="ohter" value="<%=user.getPassword() %>" ></li>
				<li><p>비밀번호 재입력</p><input type="password" class="ohter" name="password2" value="<%=user.getPassword() %>"></li>
				<li><p>이름</p><input type="text" name="username" class="ohter" value="<%=user.getUsername() %>"></li>
				<li><p>이메일</p><input type="email"name="email" class="ohter" value="<%=user.getEmail() %>"></li>
				<li><p>전화번호</p><input type="text" name="phone" class="ohter" maxlength="13" value="<%=user.getPhone() %>"></li>
				<li><p>우편번호</p><input type="text" name="zipcode1" class="zipcode" value="<%=zipcode1 %>"><input type="text" name="zipcode2" class="zipcode" value="<%=zipcode2 %>">
					<input type="button" value="우편번호 검색" id="zipcodesearch" onclick="MM_openBrWindow('zipcodeSearch.jsp', 'zipcodesearch', 'scrollbar=yes, width=550, height=600')"></li>
				<li><p>주소</p><input type="text" name="address1" class="ohter" value="<%=user.getAddress1() %>"></li>
				<li><p>나머지주소</p><input type="text" name="address2" class="ohter" value="<%=user.getAddress2() %>"></li>
			</ul>
			<input type="hidden" name="mode" value="update">
			<input type="button" value="수정완료" id="commit" onclick="doSubmit();">
			<input type="button" value="취소" id="cancle" onclick="history.back();"><br>
		</form>
	</div>
</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>