<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세보기</title>
<link href="../css/product_read.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
function login_check() {
	var form = document.login;
	if(!form.id.value) {
		alert("ID를 입력하세요!");
		return;
	}
	if(!form.pwd.value) {
		alert("password를 입력하세요!")
		return;
	}
	form.submit();
}

function changeImg() {
	var newImg = this.src;
	var largeImg = document.querySelector(".large-img");
	var smallImgs = document.querySelectorAll(".small-img");
	
	for (var i=0; i<smallImgs.length; i++){
		smallImgs[i].addEventListener("click", changeImg);
	}
	
	largeImg.setAttribute("src", newImg);
}
</script>
</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include>

<div id="container">
<%
	String id = request.getParameter("id");
	
	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM product WHERE id=" + id;
	
	NumberFormat nf = NumberFormat.getInstance();
	
	String pid = null;
	String pname = null;
	String wname = null;
    String sname = null;
    int price = 0;
    int downprice = 0;
    int stock = 0;
    String description = null;
    String img1 = null;
    String img2 = null;
    String img3 = null;
	String url = "../Images/product/";
	
	String category1 = ""; 
	String category2 = "";
	String category1_str = "";
	String category2_str = "";
	
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		rs.next();
		pid = rs.getString("id");
		pname = rs.getString("pname");
		wname = rs.getString("wname");
	   	sname = rs.getString("sname");
	    price = rs.getInt("price");
	    downprice = rs.getInt("downprice");
	    stock = rs.getInt("stock");
	    description = rs.getString("description");
	    img1 = rs.getString("img1");
	    img2 = rs.getString("img2");
	    img3 = rs.getString("img3");
	    category1 = rs.getString("category1");
	    category2 = rs.getString("category2");
	    
	    
	    if(category1 != null && !category1.equals("") && !category1.equals("null")){
			switch (Integer.parseInt(category1)) {
				case 11 : category1_str = "사료 / 간식"; 
					break;
				case 22 : category1_str = "화장실 / 위생"; 
					break;
				case 33 : category1_str = "장난감"; 
					break;
				case 44 : category1_str = "스크래쳐 / 캣타워"; 
					break;
			}
			
			if(Integer.parseInt(category1) == 11 && category2 != null && !category2.equals("") && !category2.equals("null")){
				switch (Integer.parseInt(category2)) {
					case 01 : category2_str = " > 건식사료"; 
						break;
					case 02 : category2_str = " > 캔";
						break;
					case 03 : category2_str = " > 파우치"; 
						break;
				}
			}
			
			if(Integer.parseInt(category1) == 22 && category2 != null && !category2.equals("") && !category2.equals("null")){
				switch (Integer.parseInt(category2)) {
					case 01 : category2_str = " > 하우스형 화장실"; 
						break;
					case 02 : category2_str = " > 평판형 화장실"; 
						break;
					case 03 : category2_str = " > 화장실 모래";
						break;
				}
			}
			
			if(Integer.parseInt(category1) == 33 && category2 != null && !category2.equals("") && !category2.equals("null")){
				switch (Integer.parseInt(category2)) {
					case 01 : category2_str = " > 낚시 / 막대";
						break;
					case 02 : category2_str = " > 공 / 인형";
						break;
					case 03 : category2_str = " > 터널 / 주머니";
						break;
				}
			}
			
			if(Integer.parseInt(category1) == 44 && category2 != null && !category2.equals("") && !category2.equals("null")){
				switch (Integer.parseInt(category2)) {
					case 01 : category2_str = " > 스크래쳐"; 
						break;
					case 02 : category2_str = " > 캣타워"; 
						break;
				}
			}
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
		if(stmt != null) try { stmt.close(); } catch(Exception e) { e.printStackTrace(); }
		if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
	}
	
%>
        
	<div id="product_read">
		<form method="post" action="../cart/cart.jsp">
			<input type="hidden" name="id" value="<%=id %>">
		<section>
			<span><%=category1_str %><%=category2_str %></span>
		</section>
	
	    <div id="product_img">
	        <img src="<%=url + img1 %>" class="large-img" width="450px" height="500px">
	        <span>작은 이미지를 클릭시 확대</span>
	        <div id="product_small">
	            <img src="<%=url + img1 %>" class="small-img" onclick="changeImg();">
	            <img src="<%=url + img2 %>" class="small-img" onclick="changeImg();">
	            <img src="<%=url + img3 %>" class="small-img" onclick="changeImg();">
	        </div>
	    </div>
	    <!-- 제품 정보 부분 -->
	    <div id="desc">
	        <h3><%=pname %></h3><hr id="head_line">
	        <ul>
	            <li><b>정가</b> : <del><%=nf.format(price) %></del> 원</li>
	            <li><b>판매가</b> : <%=nf.format(downprice) %> 원</li>
	            <li><b>할인받은 가격</b> : <%=nf.format(price-downprice) %> 원</li>
	            <li><b>배송비</b> : 3,000원<br>(30,000원 이상 구매시 배송비 무료)</li>
	        </ul>
	        <hr>
	        <ul>
	        	<li><b>판매사</b> : <%=wname %></li>
	            <li><b>제조사</b> : <%=sname %></li>
	<%if(stock == 0){	%>
				<li><b>재고량</b> : <font color="red"><b>재고없음</b></font></li>
	<%} else { %>
				<li><b>재고량</b> : <font color="green"><b>주문가능</b></font> (현재 재고량 : <%=stock %>)</li>
				<li><b>주문수량</b> : <input type="number" max="<%=stock %>" min="1" value="1" name="quantity"> </li>
	<%} %>
	            
	        </ul>   
	        <div id="buttons">
	                <button id="add_cart" type="submit">장바구니 담기</button> <button id="buy" type="button">바로 구매</button>
	<%			if(mem_id!=null && mem_id.equals("admin")){%>
	                <button id="update" type="button" onclick="location.href='product_update.jsp?id=<%=pid %>'">제품정보 수정</button>
	<%			} %>
	        </div>  
	    </div>
	    <hr id="line">
	    <!-- 제품 상세 설명 -->
	    <div id="information">
	        <h3 class="bright">상품 설명</h3>
	        <pre><%=description %></pre>
	   </div>
	   </form>
	   
	   <div id="review">
	   		<h3 class="bright">상품 리뷰 (최근 10건)</h3>
	   		
<%
				try { 
					
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
					stmt = conn.createStatement();
					sql = "SELECT * FROM review WHERE productid=" + id + " ORDER BY id DESC LIMIT 10";
					rs = stmt.executeQuery(sql);
					
					ArrayList idList = new ArrayList();
					ArrayList nameList = new ArrayList();
					ArrayList productidList = new ArrayList();
					ArrayList inputdateList = new ArrayList();
					ArrayList subjectList = new ArrayList();
					ArrayList contentList = new ArrayList();
					
					
					if(!rs.next()){
%>
						<b>해당 상품에 대한 리뷰가 없습니다.</b>
<%						
					} else {
						do{
							idList.add(rs.getInt("id"));
							nameList.add(rs.getString("name"));
							productidList.add(rs.getString("productid"));
							inputdateList.add(rs.getString("inputdate"));
							subjectList.add(rs.getString("subject"));
							contentList.add(rs.getString("content"));
						} while (rs.next());
						
						for(int i=0; i<idList.size(); i++){
%>
							<table>
								<tr>
									<td colspan="2" id="review_head"><b><%=idList.get(i)%>. <%=subjectList.get(i)%></b></td>
								</tr>
								<tr>
									<td width="50%" id="review_writer"><b>구매자명 : </b><%=nameList.get(i)%></td>
									<td width="*"><b>구매 제품 : </b>
<%
									String temp = (String)productidList.get(i);
									if(temp != null && !temp.equals("")) {
										out.print("<a href='../product/product_read.jsp?id="+temp+"'>"+ temp +"</a>");					
									}
%>
									</td>
								</tr>
								<tr>
									<td colspan="2" id="review_date"><%=inputdateList.get(i)%></td>
								</tr>
								<tr>
									<td colspan="2" id="review_content"><pre><%=contentList.get(i)%></pre></td>
								</tr>
							</table>
<%
						}
%>
						<button onclick="location.href='../review/review_show.jsp'">상품 리뷰 전체보기</button>
<%
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
					if(stmt != null) try { stmt.close(); } catch(Exception e) { e.printStackTrace(); }
					if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
				}
%>
	   </div>
    </div>
</div>   
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>