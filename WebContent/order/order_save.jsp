<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문정보 저장</title>
</head>
<body>
<%request.setCharacterEncoding("UTF-8");

	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
	
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	String pay = request.getParameter("pay");
	String cardno ="";
	
	if(pay.equals("card")){
		cardno = request.getParameter("cardno");
	}
	
	String productid = request.getParameter("productid");
		
	int count = Integer.parseInt(request.getParameter("count")); // 장바구니에 담긴 품목의 수
	int total = Integer.parseInt(request.getParameter("total")); // 총 금액
	int cartno = Integer.parseInt(request.getParameter("cartno"));
	String userid = request.getParameter("userid");
	
	
	//주문 날짜 포맷
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
	String ymd = sdf.format(yymmdd);
	
	//변수 설정
	int id = 0; // 주문테이블(saleorder)의 번호 생성
	int itemno = 0; // item 테이블의 itemno
	int qty = 0; // item 테이블의 quantity
	String pname = ""; // item 테이블의 pname
	int price = 0; // item 테이블의 price == product테이블의 판매가(downprice);
	
	long pid = 0; //cart 테이블의 productid
	
	int cnt = 0; // saleorder 테이블의 insert가 수행되었는지 판단할 변수 (1이면 입력 성공)
	int cnt2 = 0; // item 테이블의 insert된 총 row의 수 (주문수량에 대한 상품 수)
	
	int stock = 0;
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	String sql = null;
	

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
		
		stmt = conn.createStatement();
		sql = "SELECT max(id) FROM saleorder";
		rs = stmt.executeQuery(sql);
		
		//saleorder의 id를 생성
		if(rs.next()) {
			id = rs.getInt(1) + 1;
		} else {
			id = 1;
		}
		stmt.close();
		rs.close();
		
			
		//주문정보를 saleorder 테이블에 삽입
		sql = "INSERT INTO saleorder(id, userid, name, orderdate, address, tel, pay, cardno, productcount, total) VALUES(?,?,?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		pstmt.setString(2, userid);
		pstmt.setString(3, name);
		pstmt.setString(4, ymd);
		pstmt.setString(5, address);
		pstmt.setString(6, tel);
		pstmt.setString(7, pay);
		pstmt.setString(8, cardno);
		pstmt.setInt(9, count);
		pstmt.setInt(10, total);
		
		cnt = pstmt.executeUpdate();
		
		if(cnt != 0){ //saleorder 테이블에 주문서를 insert성공했을 경우
		// item 테이블에 데이터를 삽입 
		// orderid = saleorder의 id로 입력 
		// itemno는 그냥 1씩 자동증가 
		// productid = cart테이블에서 받아옴 (product테이블의 id와 일치)
		// pname, quantity, price는 cart테이블에서 받아와서 삽입
		// cartno : request로 넘어오는 번호가 0이면 전체주문, 아니면 해당번호에 대한 개별주문
			
		
			if(mem_id == null) { // 비로그인 주문일 경우
				
				session = request.getSession();
				
				String[] a = session.getValueNames();
				
				for(int i=0; i<a.length; i++){
					
					if(session.getAttribute(a[i]) instanceof Integer) { // 세션에 저장된 value가 숫자타입이라면 제품정보를 저장한 세션
						qty = (int)session.getAttribute(a[i]);
					
						sql = "SELECT * FROM product WHERE id=" + a[i];
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql);
						rs.next();
						pid = rs.getInt("id");
						pname = rs.getString("pname");
						price = rs.getInt("downprice");
						stock = rs.getInt("stock");
						itemno++;
						
						stmt.close();
						
						if(stock < qty) {
							sql = "DELETE FROM saleorder WHERE id="+id;
							stmt = conn.createStatement();
							stmt.executeUpdate(sql);
							sql = "DELETE FROM item WHERE orderid="+id;
							stmt = conn.createStatement();
							stmt.executeUpdate(sql);
							
							out.print("<script>alert('상품의 재고량이 주문량 보다 적습니다 ! 현재 " + pname + "의 재고량은 "+ stock + "개 입니다.'); window.opener.location.reload(); window.close();</script>");
							
						} else {
							sql = "INSERT INTO item(orderid, itemno, productid, pname, quantity, price) VALUES(?, ?, ?, ?, ?, ?)";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, id);
							pstmt.setInt(2, itemno);
							pstmt.setLong(3, Long.parseLong(a[i]));
							pstmt.setString(4, pname);
							pstmt.setInt(5, qty);
							pstmt.setInt(6, price);
								
							cnt2 += pstmt.executeUpdate();
						}
					}
				}
				if( cnt2 == count ){
					session.invalidate();
					
					sql = "SELECT * FROM item WHERE orderid=" + id;
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					while(rs.next()){
						
						pid = rs.getInt("productid");
						qty = rs.getInt("quantity");
						
						sql = "UPDATE product SET stock=stock-" + qty + ", salesrate=salesrate+" + qty + " WHERE id=" + pid;
						stmt = conn.createStatement();
						stmt.executeUpdate(sql);
					}
				
					if(cartno == 0) {
						sql = "DELETE FROM cart WHERE userid='"+ mem_id + "'";
					} else {
						sql = "DELETE FROM cart WHERE cartno=" + cartno;
					}
					
					stmt = conn.createStatement();
					stmt.executeUpdate(sql);
					
					out.print("<script>alert('주문이 완료되었습니다.\\n주문번호는 [ " + id + " ] 입니다. 반드시 기억해주세요 !');</script>");
					out.print("<script>window.opener.location.reload(); window.close();</script>");
				} else {
					out.print("<script>alert('주문처리에 오류가 발생했습니다.');  window.opener.location.reload(); window.close();</script>");
				}
				
			} else { //로그인 상태일 경우
				
				if(cartno == 0) { // 전체주문
					sql = "SELECT productid, pname, quantity, price FROM cart WHERE userid='" + userid + "'";
				} else { // 개별주문
					sql = "SELECT productid, pname, quantity, price FROM cart WHERE cartno=" + cartno; 
				}
				stmt = conn.createStatement(); 
				rs = stmt.executeQuery(sql);
				
				
					
				//saleorder테이블에 등록된 주문번호의 상세 주문제품내역을 item테이블에 저장
				while(rs.next()){
					pid = rs.getLong("productid");
					pname = rs.getString("pname");
					qty = rs.getInt("quantity");
					price = rs.getInt("price");
					itemno++;
					
					//product테이블의 stock과 주문수량의 비교
					sql = "SELECT stock FROM product WHERE id=" + pid;
					stmt = conn.createStatement();
					rs2 = stmt.executeQuery(sql);
					rs2.next();
					stock = rs2.getInt("stock");
					
					if(stock < qty) {
						sql = "DELETE FROM saleorder WHERE id="+id;
						stmt.executeUpdate(sql);
						sql = "DELETE FROM item WHERE orderid="+id;
						stmt = conn.createStatement();
						stmt.executeUpdate(sql);
						
						out.print("<script>alert('상품의 재고량이 주문량 보다 적습니다 ! 현재 " + pname + "의 재고량은 "+ stock + "개 입니다.'); window.opener.location.reload(); window.close();</script>");
						return;
					} else {
						
						sql = "INSERT INTO item(orderid, itemno, productid, pname, quantity, price) VALUES(?, ?, ?, ?, ?, ?)";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, id);
						pstmt.setInt(2, itemno);
						pstmt.setLong(3, pid);
						pstmt.setString(4, pname);
						pstmt.setInt(5, qty);
						pstmt.setInt(6, price);
							
						cnt2 += pstmt.executeUpdate();
						
					}
						
				}
					
				//주문 완료후 cart테이블에서 데이터를 삭제
					
				if(cnt2 == count) { // item 테이블에 넣은 품목수와 이전페이지에서 넘어온 품목수가 같을 때
				
					sql = "SELECT * FROM item WHERE orderid=" + id;
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					while(rs.next()){
						
						pid = rs.getInt("productid");
						qty = rs.getInt("quantity");
						
						sql = "UPDATE product SET stock=stock-" + qty + ", salesrate=salesrate+" + qty + " WHERE id=" + pid;
						stmt = conn.createStatement();
						stmt.executeUpdate(sql);
					}
				
					if(cartno == 0) {
						sql = "DELETE FROM cart WHERE userid='"+ mem_id + "'";
					} else {
						sql = "DELETE FROM cart WHERE cartno=" + cartno;
					}
					
					stmt = conn.createStatement();
					stmt.executeUpdate(sql);
					
					out.print("<script>alert('주문이 정상적으로 처리되었습니다.');  window.opener.location.reload(); window.close();</script>");
				} else {
					out.print("<script>alert('주문처리에 오류가 발생했습니다.');  window.opener.location.reload(); window.close();</script>");
				}
			}
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); };
		if(stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); };
		if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); };
		if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); };
	}
	
	
	
	/* 세션으로 처리할경우에 , invalidate()쓰지말고, 제품 id를 하나하나 넣어서 삭제해줘야함 */
%>
</body>
</html>