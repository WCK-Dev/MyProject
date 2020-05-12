<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰글 작성 처리</title>
<style>
	#container {width : 400px; margin: 50px auto; border: 1px solid black; padding: 20px; text-align: center;}
	a { text-decoration: none; font-weight: bold;}
</style>
</head>
<body>
<div id="review">
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String name = request.getParameter("name");
	String productid = request.getParameter("productid");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
	
	String inputdate = df.format(new java.util.Date());
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = null;
	int cnt = 0;
	
	try { 
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
		
		sql = "INSERT INTO review(name, productid, inputdate, subject, content) VALUES (?, ?, ?, ?, ?);";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, productid);
		pstmt.setString(3, inputdate);
		pstmt.setString(4, subject);
		pstmt.setString(5, content);
		
		cnt = pstmt.executeUpdate();
		
		if(cnt != 0){
			out.print( "<br>" + name + "님의 리뷰가 정상적으로 등록 되었습니다.");
		} else {
			out.print("<br>리뷰 등록에 문제가 발생했습니다.");
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
%>
<br><br>
	<jsp:forward page="review_show.jsp"></jsp:forward>
</div>
</body>
</html>