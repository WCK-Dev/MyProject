<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 품목 삭제</title>
</head>
<body>
<%request.setCharacterEncoding("UTF-8");


	session = request.getSession();
	String id = request.getParameter("id");
	int qty = 0; 
	if (request.getParameter("quantity") != null){
		Integer.parseInt(request.getParameter("quantity"));
	}
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	int cnt = 0;
	int cartno = 0;
	
	if(request.getParameter("cartno") != null){
		cartno = Integer.parseInt(request.getParameter("cartno"));
	}
	
	
	try {
		if(session.getAttribute("member_id") == null){ // 비로그인시 (세션 장바구니 처리)
			session.removeAttribute(id);
			out.print("<script>alert('장바구니에서 상품이 삭제되었습니다.');</script>");
			out.print("<script>location.href='cart_list.jsp';</script>");
		} else { //로그인상태 일 시
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
			
			stmt = conn.createStatement();
			sql = "DELETE FROM cart WHERE cartno=" + cartno;
			cnt = stmt.executeUpdate(sql);
			
			if(cnt != 0) { // 삭제 성공
				out.print("<script>alert('장바구니에서 품목을 삭제하였습니다.'); location.href='cart_list.jsp'</script>");
			} else { // 삭제 실패
				out.print("<script>alert('장바구니 품목 삭제에 오류가 발생했습니다.')</script>");
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
		if(stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
		if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
	}
%>
</body>
</html>