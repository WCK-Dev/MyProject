<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 담기 처리</title>
<style>
	.move { text-align: center;}
</style>
</head>
<body>
<%request.setCharacterEncoding("UTF-8");

	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
	
	String id = request.getParameter("id");
	int qty = Integer.parseInt(request.getParameter("quantity"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	int cnt = 0;
	
	int cartno = 0;
	String sname = "";
	int price = 0;
	String cart_pname = "";
	String img1 = "";
	
try {
	//로그인을 하지 않은 상태일 경우에는, 세션을 통해 장바구니 처리
	if(session.getAttribute("member_id") == null){
		session = request.getSession();
		
		String[] a = session.getValueNames();
		
		for(int i=0; i<a.length; i++){
			if(a[i].equals(id)){
				int old = (int)session.getAttribute(id);
				qty += old;
			}
		}
		
		session.setAttribute(id, qty);
		out.print("id = " + id + "<br>");
		out.print("qty = " + qty);
		out.print("<script>alert('상품을 장바구니에 추가하였습니다.');</script>");
		out.print("<script>location.href='cart_list.jsp';</script>");
	} else {
		
		// 2. 장바구니 DB 처리
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
		
		//cartno 생성
		sql = "SELECT max(cartno) FROM cart";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			cartno = rs.getInt(1) + 1;
		} else {
			cartno = 1;
		}
		stmt.close(); rs.close();
		
		// sname, price -> DB product 테이블에서 가져온다.
		sql = "SELECT pname, sname, downprice, img1 from product WHERE id=" + id;
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		rs.next();
		cart_pname = rs.getString("pname");
		sname = rs.getString("sname");
		price = rs.getInt("downprice");
		img1 = rs.getString("img1");
		
		//상품명이 cart 테이블에 존재하는지 여부를 검사
		sql = "SELECT pname, quantity FROM cart WHERE productid=" + id + " AND userid='" + mem_id + "'";
		rs = stmt.executeQuery(sql);
			
		if(rs.next()) { // 장바구니에 추가하기를 선택한 상품명이 기존에 cart테이블에 존재한다면 수량만 수정한다.
			qty += rs.getInt("quantity");
			sql = "UPDATE cart SET quantity=" + qty + " WHERE productid=" + id;
			cnt = stmt.executeUpdate(sql);
			
		} else { // 상품명이 cart테이블에 존재하지 않는다면, cart테이블에 추가한다.
			
			sql = "INSERT INTO cart(cartno, userid, productid, pname, sname, quantity, price, img) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, cartno);
			pstmt.setString(2, mem_id);
			pstmt.setLong(3, Long.parseLong(id));
			pstmt.setString(4, cart_pname);
			pstmt.setString(5, sname);
			pstmt.setInt(6, qty);
			pstmt.setInt(7, price);
			pstmt.setString(8, img1);
			cnt = pstmt.executeUpdate();
		}
		
		if(cnt != 0) { // INSERT 성공
			out.print("<script>alert('상품을 장바구니에 추가하였습니다.');</script>");
			out.print("<script>location.href='cart_list.jsp';</script>");
		} else { // INSERT 실패
			out.print("<script>alert('장바구니 추가에 실패하였습니다.'); history.go(-1);</script>");
		}
	}
	
	
} catch (Exception e){
	e.printStackTrace();
} finally {
	if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
	if(stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
	if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
	if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
}
%>
</body>
</html>