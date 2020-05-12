<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 정보</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	/* function check_member() {
		non_member = confirm('고양이대통령 회원이시라면 먼저 로그인후 조회해주세요 !<br>비회원 주문조회를 하시려면 확인을 눌러주세요.');
		if(non_member == true){
			window.open("");
		} else {
			location.href="../index.jsp"
		}
	} */
</script>
<style>
	#container { width: 1400px; margin: 0 auto; margin-bottom: 30px; font-family: 'NanumSquareRound';}
	.mypage_top { clear: both; border: 2px solid black; width: 100%;}
	.mypage_top table { border: 2px solid black; width: 100%; line-height: 250px}
	.mypage_top tr { height: 180px;}
	.mypage_top th { width: 250px; background: black; color: white; font-size: 50px; line-height: 80px;}
	.mypage_top td { font-size: 40px; line-height: 80px; text-align: center;}
	
	#member_tab {float: left; margin-top: 10px; width: 20%; box-sizing: border-box;}
	#member_tab h3 { text-indent: 20px; color: black; font-size: 1.5em; padding-top: 20px; padding-bottom: 20px;}
	#member_tab ul { list-style: none;}
	#member_tab ul li { margin-bottom: 15px; font-size: 1.2em; padding-top: 15px; margin-left: 40px;}
	#member_tab a { text-decoration: none; color: black; font-size: 1.1em;}
	#member_tab a:hover { color: #c23ca7; font-weight: bold;}
		
	 #order_read { width: 75%; float: right;}
     #order_read h1 { margin-top: 40px; color: #c23ca7; font-size: 1.4em; font-weight: bold; margin-bottom: 40px;}
     #order_read .row_1, .row_2 { border : 1px solid lightgray; width: 90%; margin-top: 5px; padding: 20px; float:left; font-size: 1.2em;}
     #order_read .col_1 { width: 30%;}
     #order_read .col_2 { width: 30%;}
     #order_read .col_3 { width: 68%;}
     #order_read .col_1, .col_2 { float: left;}
     #order_read .row_2 table { padding-left: 15px; margin-top: 50px;}
     #order_read .row_2 span { color:firebrick;}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>

<div id="container">
<%
	request.setCharacterEncoding("UTF-8");
	
	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
%>
	<div class="mypage_top">
   		<table><tr>
           <th width="200px">마이<br>페이지</th><td><%=mem_name %>님의 구매내역입니다.</td>
        </tr></table> 
  	</div>
        
	<div id="member_tab">
	<h3>나의 구매정보</h3>
		<ul>
			<li><a href="../cart/cart_list.jsp">장바구니</a></li>
			<li><a href="order_list.jsp">나의 구매내역</a></li>
			<li><a href="#">반품하기</a></li>
		</ul>
		
	<h3>회원정보 관리</h3>
		<ul>
			<li><a href="../member/select.jsp">내 정보 조회</a></li>
			<li><a href="#" onclick="location='../member/modify.jsp?mode=modify'">내 정보 변경하기</a></li>
			<li><a href="#" onclick="delete_check();">회원 탈퇴</a></li>
		</ul>
	</div>
	
	<div id="order_read">
<%		
		if(mem_id == null){
			/* out.print("<script>check_member();</script>"); // 비회원으로 해당 페이지 이동시 로그인 안내메시지 */
		}
	
		Connection conn = null;
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String sql = null;
		
		int orderid = Integer.parseInt(request.getParameter("orderid")); // 주문번호
		
		String ordername = "";
		String orderdate = "";
		String address = "";
		String tel = "";
		String pay = "";
		
		
		String pname = "";
		NumberFormat nf = NumberFormat.getInstance();
		int total = 0;
		int count = 0; // 품목수
		int qty = 0; // 품목별 주문수량
		int price = 0; // 판매가
		String total_nf = "";
		
		long pid = 0;
		String img = "";
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
			
			sql = "SELECT * FROM saleorder WHERE id = " + orderid;
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(sql);
			rs1.next();
			
			ordername = rs1.getString("name");
			orderdate = rs1.getString("orderdate").substring(0,10);
			address = rs1.getString("address");
			tel = rs1.getString("tel");
			pay = rs1.getString("pay");
			
			sql = "SELECT * FROM item WHERE orderid = " + orderid;
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(sql);
%>
			<h1>주문 상세정보</h1>

            <div class="row_1">
                <div class="col_1">
                    <p><b>주문 날짜</b></p>
                    <%=orderdate %><br><br>
                    <p><b>주문 번호</b></p>
                    <%=orderid %>
                </div>
                <div class="col_2">
                    <p><b>주문자명</b></p>
                    <%=ordername %><br><br>
                    
                    <p><b>주문자연락처</b></p>
                    <%=tel %>
                </div>
                <div class="col_3">
                    <p><b>배송주소</b></p>
                    <%=address %>
                </div>
            </div>
            
            <div class="row_2">
            	<p><b>구매 상품정보</b></p>
<%
			while(rs2.next()){
				pid = rs2.getLong("productid");
				pname = rs2.getString("pname");
				qty = rs2.getInt("quantity");
				price = rs2.getInt("price");
				
				sql = "SELECT * FROM product WHERE id=" + pid;
				stmt3 = conn.createStatement();
				rs1 = stmt3.executeQuery(sql);
				rs1.next();
				img = rs1.getString("img1");
%>				
				<table>
                    <tr>
                        <td rowspan="3" width="30%"><img src="../Images/product/<%=img %>" width="200px"></td> <td colspan="2"><b><%=pname %></b></td>
                    </tr>
                    <tr>
                        <td><b>개당가격</b><br><span>₩<%=nf.format(price) %></span></td> <td><b>지불가격</b><br><span>₩<%=nf.format(price*qty) %></span></td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>주문수량</b> : <%=qty %> 개</td>
                    </tr>
                </table>
<%				
			}
%>
			</div>  
<%
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs1 != null) try { rs1.close(); } catch (Exception e) { e.printStackTrace(); } 
			if(rs2 != null) try { rs2.close(); } catch (Exception e) { e.printStackTrace(); } 
			if(stmt1 != null) try { stmt1.close(); } catch (Exception e) { e.printStackTrace(); } 
			if(stmt2 != null) try { stmt2.close(); } catch (Exception e) { e.printStackTrace(); } 
			if(stmt3 != null) try { stmt3.close(); } catch (Exception e) { e.printStackTrace(); } 
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); } 
		}
	%>
	</div>
</div>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>