<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<link href="../css/zipcodeSearch.css" rel="stylesheet">
<script src="../js/zipcodeSearch.js"></script>
</head>
<body>
<%request.setCharacterEncoding("UTF-8");%>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	
	String searchAddr = request.getParameter("addr");
	String zipcode = null;
	String sido = null;
	String gugun = null;
	String dong = null;
	String bunji = null;
	String address = null;
	String address1 = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (Exception e){
		e.printStackTrace();
	}
	
	try {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<div id="container">
	<div id="header">
	    <a href="index.jsp"><img src="./Images/cat01.png" alt="" id="logo"></a>
		<h2>우편번호 검색<br><br></h2>
	</div>
	<form name="zipcode" action="zipcodeSearch.jsp" method="post">
		<table>
			<tr class="first_row">
				<td colspan="2">찾으려는 수조의 동/읍/면 이름을 입력하세요 <br> 검색한 후 주소를 클릭하세요.</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="text" name="addr" maxlength="15" size="15">
					<input type="submit" value="검색">
				</td>
			</tr>
			<%
			if(searchAddr != null) {
				out.print("<tr id='first_row'><td width='25%'>우편번호</td><td width='*'>주소</td></tr>");
				
				try {
					stmt = conn.createStatement();
					sql = "SELECT * FROM zipcode WHERE dong LIKE '%" + searchAddr + "%'";
					rs = stmt.executeQuery(sql);
					while(rs.next()) {
						zipcode = rs.getString("zipcode");
						sido = rs.getString("sido");
						gugun = rs.getString("gugun");
						dong = rs.getString("dong");
						bunji = rs.getString("bunji");
						address = sido + " " + gugun + " " + dong + " " +bunji;
						address1 = sido + " " + gugun + " " + dong;
						
			%>
			<tr>
				<td>
					<a href="javascript:choiceZipcode('<%=zipcode%>', '<%=address1%>')"><%=zipcode%></a>
				</td>
				<td>
					<a href="javascript:choiceZipcode('<%=zipcode%>', '<%=address1%>')"><%=address%></a>
				</td>
			</tr>
			<%
					}
				} catch(Exception e) {
					e.printStackTrace();
				} finally {
					
				}
			}
			%>
		</table>
	</form>
</div>
</body>
</html>