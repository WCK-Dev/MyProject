<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록보기</title>
<link href="../css/cart_list.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="/cart/js/cart_list.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">
<%	
	request.setCharacterEncoding("UTF-8");

	String mem_name = (String)session.getAttribute("member_name");
	if(mem_name == null) mem_name = "비회원";
	
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
%>
        
    
    <div class="mypage_top">
   		<table><tr>
           <th width="200px">마이<br>페이지</th><td><%=mem_name %>님의 장바구니입니다.</td>
        </tr></table> 
  	</div>
        
	<div id="member_tab">
	<h3>나의 구매정보</h3>
		<ul>
			<li><a href="cart_list.jsp">장바구니</a></li>
			<li><a href="../order/order_list.jsp">나의 구매내역</a></li>
			<li><a href="#">반품하기</a></li>
		</ul>
		
	<h3>회원정보 관리</h3>
		<ul>
			<li><a href="../member/select.jsp">내 정보 조회</a></li>
			<li><a href="#" onclick="location='../member/modify.jsp?mode=modify'">내 정보 변경하기</a></li>
			<li><a href="#" onclick="delete_check();">회원 탈퇴</a></li>
		</ul>
	</div>
	
	<div id="cartlist">

<%request.setCharacterEncoding("UTF-8");

	String id = "";
	String[] a= session.getValueNames();
	
	NumberFormat nf = NumberFormat.getIntegerInstance();
	
	int qty = 0; // 각 품목마다 장바구니에 담아둔 수량
	int count = 0; // 장바구니에 등록된 품목의 수
	String price_nf = ""; // 넘버 포맷형식의 가격
	String sum = ""; // 수량*가격
	int price = 0; // 각 품목 마다의 가격
	int total = 0; // 모든 품목의 sum을 합한 값 (장바구니 전체 가격)
	String cart_pname = "";
	
	String url ="../Images/product/";
	String img = "";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	
	// DB 처리를 위한 변수
	long cartno = 0;
	String sname = "";
		
%>
	<table>
		<tr>
			<th width="10%">이미지</th>
			<th width="*">상품명</th>
			<th width="15%">제조사</th>
			<th width="15%">주문 수량</th>
			<th width="15%">판매가</th>
			<th width="15%">합계</th>
			<th width="10%">주문/삭제</th>
		</tr>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
		
		stmt = conn.createStatement();
		
		
		//세션 장바구니처리 ( 비로그인 상태 )
		
		if(session.getAttribute("member_id") == null){
			session = request.getSession();
			
			for(int i=0; i<a.length; i++){
				id = (a[i].trim());
				if(session.getAttribute(a[i]) instanceof Integer) {
					qty = (int)session.getAttribute(a[i]);
					sql = "SELECT * FROM product WHERE id='" + id +"'";
					rs = stmt.executeQuery(sql);
					
					if(rs.next()){//장바구니에 담긴 상품이 있을때
						++count;
						price = rs.getInt("downprice");
						img = rs.getString("img1");
						price_nf = nf.format(price);
						sum = nf.format(price*qty);
						total += (price*qty);
	%>
			<form method="post" action="cart_update.jsp">
			<tr>
				<input type="hidden" name="id" value="<%=id %>">
				<td class="center"><img id="product_img" src="<%=url %><%=img %>"></td>
				<td class="left"><span id="pname"><%=rs.getString("pname") %></span></td>
				<td class="left"><span id="sname"><%=rs.getString("sname") %></span></td>
				<td class="center">
					<input type="image" onclick="changeQty(this.form, -1)" class="change_qty" src="../Images/minus.png">
					<input type="text" name="quantity" value="<%=qty %>" id="qty" size="1">
					<input type="image" onclick="changeQty(this.form, 1)" class="change_qty" src="../Images/plus.png">
				</td>
				<td class="right"><%=price_nf %> 원</td>
				<td class="right"><%=sum %> 원</td>
				<td class="center">
					<input class="order_btn" type="button" value="개별주문" onclick="window.open('../order/order.jsp?total=<%=price*qty %>&count=1&cartno=<%=cartno %>&productid=<%=id %>', 'orderWindow', 'width=600, height=550');" >
					<input class="order_btn" type="button" value="상품삭제" onclick="setValue(this.form);" >
				</td>
			</tr>
			</form>
	<%					
					}
				}
			} if(count == 0){
				out.print("<tr><td colspan='7'><h1>장바구니에 담긴 상품이 없습니다.</h1></td></tr>");
			}
		} else { //로그인상태일경우
			sql = "SELECT * FROM cart WHERE userid='" + mem_id + "'";
			rs = stmt.executeQuery(sql);
			
			if(!rs.next()) { // 장바구니에 담긴 상품이 없을 때
				out.print("<tr><td colspan='7'><h1>장바구니에 담긴 상품이 없습니다.</h1></td></tr>");
			} else { // 장바구니에 담긴 상품이 있을 때
				do{
					++count;
					cartno = rs.getLong("cartno");
				    cart_pname = rs.getString("pname");
				    id = rs.getString("productid");
					sname = rs.getString("sname");
					qty = rs.getInt("quantity");
					price = rs.getInt("price");
					img = rs.getString("img");
					price_nf = nf.format(price);
					sum = nf.format(price*qty);
					total += (price*qty);
	%>
			<form method="post" action="cart_update.jsp">
			<tr>
				<input type="hidden" name="id" value="<%=id %>">
				<input type="hidden" name="cartno" value="<%=cartno %>">
				<td class="center"><img id="product_img" src="<%=url %><%=img %>"></td>
				<td class="left"><span id="pname"><%=cart_pname %></span></td>
				<td class="left"><span id="sname"><%=sname %></span></td>
				<td class="center">
					<input type="image" onclick="changeQty(this.form, -1)" class="change_qty" src="../Images/minus.png">
					<input type="text" name="quantity" value="<%=qty %>" id="qty" size="1">
					<input type="image" onclick="changeQty(this.form, 1)" class="change_qty" src="../Images/plus.png">
				</td>
				<td class="right"><%=price_nf %> 원</td>
				<td class="right"><%=sum %> 원</td>
				<td class="center">
					<input class="order_btn" type="button" value="개별주문" onclick="window.open('../order/order.jsp?total=<%=price*qty %>&count=1&cartno=<%=cartno %>&productid=<%=id %>&qty=<%=qty %>', 'orderWindow', 'width=600, height=550');">
					<input class="order_btn" type="button" value="상품삭제" onclick="location.href='cart_delete.jsp?cartno=<%=cartno %>'">
				</td>
			</tr>
			</form>
	<%				
				} while(rs.next());
			}
		}
	%>
				<tr class="end_row">
				<td colspan="7">
					<h4>
					주문상품 : <%=count %> 품목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					주문 총 합계 금액 : <%=nf.format(total) %> 원
					</h4>
				</td>
			</tr>
		</table>
		<jsp:useBean class="com.catp.item.ItemDataBean" id="item"/>
		<div id="move">
			<button type="button" onclick="location.href='../review/review_write.jsp?productid=<%=item.getProductId()%>'">리뷰 작성하기</button>
			<button type="button" onclick="window.open('../order/order.jsp?total=<%=total %>&count=<%=count %>', 'orderWindow', 'width=600, height=550');">일괄 주문하기</button>
		</div>
	
	<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
		if(stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
		if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
	}
%>
	</div>
</div>        
   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>