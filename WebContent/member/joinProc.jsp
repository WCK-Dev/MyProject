<%@page import="com.catp.mymember.MymemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리페이지</title>
<link href="../css/joinProc.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="com.catp.mymember.MymemberDataBean"/>
<jsp:setProperty property="*" name="member"/>
<%
	String zipcode1 = request.getParameter("zipcode1");
	String zipcode2 = request.getParameter("zipcode2");
	String zipcode = zipcode1 + "-" + zipcode2;
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
	String regDate = myFormat.format(yymmdd);
	
	member.setZipcode(zipcode);
	member.setRegdate(regDate);
	
	MymemberDBBean dbPro = MymemberDBBean.getInstance();
	dbPro.insertMember(member);
	
%>
    <jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
%>
        

	<div id="mypage">
        <div class="mypage_top">
           <table><tr>
                <th width="200px">마이<br>페이지</th><td><%=member.getUsername() %>님 회원가입을 환영합니다 !</td>
           </tr></table> 
        </div>
        <div class="select">
            <h1>| 회원가입 정보</h1>
            <form name="join" method="post">
				<input type="hidden" name="userid" value="<%=member.getUserid() %>">
				<input type="hidden" name="mode" value="modify">
            <table>
                <tr>
                    <td class="first_col" width="35%">아이디</td>
                    <td class="second_col"><%=member.getUserid() %></td>
                </tr>
                <tr>
                    <td class="first_col" >비밀번호</td>
                    <td class="second_col"><%=member.getPassword() %></td>
                </tr>
                <tr>
                    <td class="first_col" >이름</td>
                    <td class="second_col"><%=member.getUsername() %></td>
                </tr>
                <tr>
                    <td class="first_col" >E-mail</td>
                    <td class="second_col"><%=member.getEmail() %></td>
                </tr>
                <tr>
                    <td class="first_col" >연락처</td>
                    <td class="second_col"><%=member.getPhone() %></td>
                </tr>
                <tr>
                    <td class="first_col" >주소 (배송지 정보)</td>
                    <td class="second_col"><%=zipcode %>&nbsp;&nbsp;<%=member.getAddress1() %><br>
						<%=member.getAddress2() %>
                    </td>
                </tr>
                <tr id="last_row">
                    <td colspan="2"><button type="button" id="commit" onclick="location.assign('../index.jsp');">가 입 완 료</button></td>
                </tr>
            </table>
            </form>
       </div>
	</div>
</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>