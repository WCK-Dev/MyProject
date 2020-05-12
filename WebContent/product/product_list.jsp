<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트 조회</title>
<link href="../css/product_list.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
	
	String category1 = request.getParameter("category1"); 
	String category2 = request.getParameter("category2");
	String category1_str = "전체상품리스트";
	String category2_str = "";
	
	//검색 처리
	
	String condition = ""; //조건식의 초기값은 null이면 안되므로, 공백문자로 
	String searchvalue = request.getParameter("searchvalue");
	
	if(category1 != null && !category1.equals("") && !category1.equals("null")){
		
		condition = " WHERE category1=" + category1;
		
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
			condition += " AND category2=" + category2;
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
			condition += " AND category2=" + category2;
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
			condition += " AND category2=" + category2;
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
			condition += " AND category2=" + category2;
			switch (Integer.parseInt(category2)) {
				case 01 : category2_str = " > 스크래쳐"; 
					break;
				case 02 : category2_str = " > 캣타워"; 
					break;
			}
		}
	}
	
	if(searchvalue != null && !searchvalue.equals("") && !searchvalue.equals("null")) {
		condition = " WHERE pname LIKE '%" + searchvalue + "%' OR sname LIKE '%" + searchvalue + "%'";
	}
	
%>
        
	<div id="side_bar">
		<h3><a href="product_list.jsp">전체상품보기</a></h3>
	    <h3><a href="product_list.jsp?category1=11">사료/간식</a></h3>
	        <ul>
	            <li><a href="product_list.jsp?category1=11&category2=01">건식사료</a></li>
	            <li><a href="product_list.jsp?category1=11&category2=02">캔</a></li>
	            <li><a href="product_list.jsp?category1=11&category2=03">파우치</a></li>
	        </ul>
	        
	    <h3><a href="product_list.jsp?category1=22">화장실/위생</a></h3>
	        <ul>
	            <li><a  href="product_list.jsp?category1=22&category2=01">하우스형 화장실</a></li>
	            <li><a  href="product_list.jsp?category1=22&category2=02">평판형 화장실</a></li>
	            <li><a  href="product_list.jsp?category1=22&category2=03">화장실 모래</a></li>
	        </ul>
	
	    <h3><a href="product_list.jsp?category1=33">장난감</a></h3>
	        <ul>
	            <li><a  href="product_list.jsp?category1=33&category2=01">낚시/막대형</a></li>
	            <li><a  href="product_list.jsp?category1=33&category2=02">공/인형</a></li>
	            <li><a  href="product_list.jsp?category1=33&category2=03">터널/주머니</a></li>
	        </ul>
	
	    <h3><a href="product_list.jsp?category1=44">스크래쳐/캣타워</a></h3>
	        <ul>
	            <li><a  href="product_list.jsp?category1=44&category2=01">스크래쳐</a></li>
	            <li><a  href="product_list.jsp?category1=44&category2=02">캣타워</a></li>
	        </ul>
	</div>
	
	<div id="product">
<%
	//페이징 처리 부분
		int pageSize = 12; //하나의 화면에 표시할 제품의 갯수
		String pageNum = request.getParameter("pageNum"); // 넘어오는 페이지 번호
		if(pageNum == null){
			pageNum = "1";
		} 
		
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
		int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 글의 번호
		//int endRow = startRow + pageSize - 1;
		int endRow = currentPage * pageSize;
		
		int totalRow = 0; //전체 글의 수

		ArrayList idList = new ArrayList(); // 상품번호 리스트
		ArrayList pnameList = new ArrayList(); // 상품명 리스트
		ArrayList snameList = new ArrayList(); // 제조사 리스트
		ArrayList downpriceList = new ArrayList(); // 판매가 리스트
		ArrayList category1List = new ArrayList(); // 상품분류 리스트
		ArrayList category2List = new ArrayList(); // 상품분류 리스트
		ArrayList imgList = new ArrayList();
		
		long id = 0;
		NumberFormat nf = NumberFormat.getInstance();
		
		String url = "../Images/product/";
		
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
			
			sql = "SELECT count(*) as count FROM product" + condition;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			totalRow = rs.getInt("count"); // 등록된 전체 상품 목록수
			rs.close();
			
			//페이징 처리 - 몇번부터 몇개를 가져올 것인지
			sql = "SELECT * FROM product" + condition + " ORDER BY id limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			if(!rs.next()){ //조회결과가 없을 경우
				out.print("<h3>등록된 상품이 없습니다.<h3>");
			} else {
			%>
				<h2><%=category1_str %><%=category2_str %></h2><hr>
			<%
				do {
					idList.add(rs.getLong("id"));
					pnameList.add(rs.getString("pname"));
					snameList.add(rs.getString("sname"));
					downpriceList.add(rs.getInt("downprice"));
					imgList.add(rs.getString("img1"));
				}while(rs.next());
				
				
				for(int i=0; i<idList.size(); i++){
%>
					<figure class="products">	<!-- snip1384 -->
				        <img src="<%=url + imgList.get(i)%>"/>
				        <figcaption>
				        <h5><b>제조사 :</b><br> <%=snameList.get(i) %></h5>
				        <p><b>가격 :</b> ￦<%=nf.format(downpriceList.get(i))%></p><i class="ion-ios-arrow-right"></i>
				        </figcaption>
				        <a href="product_read.jsp?id=<%=idList.get(i) %>"></a>
				        <b><span><%=pnameList.get(i) %></span></b>
				    </figure>
			        
				    <%-- <div class="products">
				    	<a href="product_read.jsp?id=<%=idList.get(i) %>"><img class="product_img" src="<%=url + imgList.get(i)%>"> 
				    	<span><%=pnameList.get(i) %></span><br>
				    	<span>￦<%=nf.format(downpriceList.get(i))%></span>
				    </a>
				    </div> --%>
<%						
					if((i+1) % 4 == 0 && (i+1) != 12) out.print("<br><br><hr><br>");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(stmt != null) try { stmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		out.print("<div id='paging'>");
		
		if(totalRow > 0) {
			int totalPage = totalRow / pageSize + (totalRow % pageSize == 0 ? 0 : 1); //전체 페이지 수
			//int pageCount = (totalRow - 1) / pageSize + 1;
			
			int startPage = 1;//시작 페이지
			int pagebtn = 10; //아래에 표시될 페이지 이동버튼의 수  == ex) 3이면  [1][2][3] / [4][5][6] 페이지 버튼이 표시되는 식
			
			if(currentPage % pagebtn != 0){
				startPage = (int)(currentPage/pagebtn) * pagebtn + 1; 
			} else {
				startPage = ((int)(currentPage/pagebtn)-1) * pagebtn + 1; 
			}
			
			int endPage = startPage + pagebtn - 1;
			
			if(endPage > totalPage) endPage = totalPage;
			
			//이전페이지 유무
			
			// 이전 버튼을 눌렀을때
			if(currentPage > 1) {
%>
				<div class="paging_on" onclick="location.href='product_list.jsp?pageNum=1&category1=<%=category1%>&category2=<%=category2%>&searchvalue=<%=searchvalue%>'">처음</div>
				<div class="paging_on" onclick="location.href='product_list.jsp?pageNum=<%=currentPage - 1%>&category1=<%=category1%>&category2=<%=category2%>&searchvalue=<%=searchvalue%>'">이전</div>
<%
			} else {
%>
				<div class="paging_off">처음</div>
				<div class="paging_off">이전</div>
<%
			}
			
			//페이지 번호 출력
			for(int i=startPage; i<=endPage; i++){
				if(i == currentPage) {
%>
					<div class="paging_now"><%=i %></div>
<%
				}else {
%>
					<div class="paging_on" onclick="location.href='product_list.jsp?pageNum=<%=i%>&category1=<%=category1%>&category2=<%=category2%>&searchvalue=<%=searchvalue%>'"><%=i %></div>
<%
				}
			}
			
			//다음페이지 유무
			
			// 다음 버튼을 눌렀을때
			if(currentPage < totalPage){
%>
				<div class="paging_on" onclick="location.href='product_list.jsp?pageNum=<%=currentPage + 1%>&category1=<%=category1%>&category2=<%=category2%>&searchvalue=<%=searchvalue%>'">다음</div>
				<div class="paging_on" onclick="location.href='product_list.jsp?pageNum=<%=totalPage%>&category1=<%=category1%>&category2=<%=category2%>&searchvalue=<%=searchvalue%>'">마지막</div>
<%
			}else {
%>
				<div class="paging_off">다음</div>
				<div class="paging_off">마지막</div>
<%
			}
		}
		out.print("</div>");
%>
	</div>
	

</div>        
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>