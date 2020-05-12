<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 제품 목록 보기</title>
<style>
	@font-face { 
    font-family: 'yg-jalnan';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.2/JalnanOTF00.woff') format('woff'); 
    font-weight: normal; 
    font-style: normal; }
	@font-face { 
	    font-family: 'NanumSquareRound'; 
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff') format('woff'); 
	    font-weight: normal; 
	    font-style: normal; }
	    
	#container { width: 1200px; margin:0 auto; position: relative; font-family: 'NanumSquareRound';}
	#container h2 { text-align: }
	h2 { text-align: center;}
	#searchTable { margin-bottom: 30px;}
	#searchTable, #searchTable td { border: hidden;}
	#category_row { text-align: center;}
	.category { width: 130px; height: 30px; border: 1px solid #ccc; background: #eee; display: inline-block; border-radius: 10px; line-height: 30px; }
	#searchTable a { text-decoration: none;}
	#searchTable input[type="text"]  { height: 20px;}
	table { width : 100%; text-align: center;}
	table, th, td { border: 1px solid black; border-collapse: collapse;}
	tr { height: 10px; }
	th { background : skyblue;}
	input[type="text"] { margin-top: 30px;}
	img { width: 100px; height: 110px;}
	#container button { text-align: center; border: 1px solid black; background: black; color:white; font-weight: bold; width: 80px; height: 50px; cursor: pointer;}
	#paging { text-align: center; margin-top: 30px;}
</style>
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<div id="container">
	<h2>상품 관리</h2>
	<form name="searchForm" action="product_manage.jsp" method="get">
		<table id="searchTable">
			<tr>
				<td id="category_row" colspan="2">
					<a href="../index.jsp"><div class="category">메인페이지</div></a> &nbsp;
					<a href="product_manage.jsp"><div class="category">전체</div></a> &nbsp;
					<a href="product_manage.jsp?category1=11"><div class="category">사료/간식</div></a> &nbsp;
					<a href="product_manage.jsp?category1=22"><div class="category">화장실/위생</div></a> &nbsp;
					<a href="product_manage.jsp?category1=33"><div class="category">장난감</div></a> &nbsp;
					<a href="product_manage.jsp?category1=44"><div class="category">스크래쳐/캣타워</div></a> &nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="2" width="50%" id="search_row" class="right">
					상품명 검색 <input type="text" name="pname"> <input type="submit" value="검색"> 
				</td>
			</tr>
		</table>
	</form>
	 
	<table>
		<tr>
			<th width="5%">상품 이미지</th>
			<th width="*%">상품명</th>
			<th width="10%">상품번호</th>
			<th width="15%">제조사</th>
			<th width="10%">판매 시작일</th>
			<th width="10%">판매가</th>
			<th width="5%">재고량</th>
			<th width="8%">상품분류</th>
			<th width="8%">상품 수정</th>
		</tr>
<%
	//페이징 처리 부분
	int pageSize = 10; //하나의 화면에 표시할 제품의 갯수
	String pageNum = request.getParameter("pageNum"); // 넘어오는 페이지 번호
	if(pageNum == null){
		pageNum = "1";
	} 
	
	int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
	int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 글의 번호
	//int endRow = startRow + pageSize - 1;
	int endRow = currentPage * pageSize;
	
	int totalRow = 0; //전체 글의 수


	//검색 처리
	String condition = ""; //조건식의 초기값은 null이면 안되므로, 공백문자로 
	String pname = request.getParameter("pname");
	String category1 = request.getParameter("category1");
	String category2 = request.getParameter("category2");
	
	//1. pname(상품명)으로 검색
	if(pname != null && !pname.equals("") && !pname.equals("null")) {
		condition = " WHERE pname LIKE '%" + pname + "%'";
	}
	
	//2. category(상품분류)로 검색
	if(category1 != null && !category1.equals("") && !category1.equals("null")) {
		condition = " WHERE category1='" + category1 + "'";
	}
	if(category2 != null && !category2.equals("") && !category2.equals("null")) {
		condition += "AND category2='" + category2 + "'";
	}
	
	ArrayList pnameList = new ArrayList(); // 상품명 리스트
	ArrayList idList = new ArrayList(); // 상품번호 리스트
	ArrayList snameList = new ArrayList(); // 제조사 리스트
	ArrayList inputdateList = new ArrayList(); // 입고일 리스트
	ArrayList downpriceList = new ArrayList(); // 판매가 리스트
	ArrayList stockList = new ArrayList(); // 재고량 리스트
	ArrayList category1List = new ArrayList(); // 상품분류 리스트
	ArrayList category2List = new ArrayList(); // 상품분류 리스트
	
	long id = 0;
	NumberFormat nf = NumberFormat.getInstance();
	String downprice_nf = null; // 포맷을 설정한 판매가 ex)45,000 
	String stock_nf = null;
	String category_str = null; // 상품분류 11 -> "가구"
	
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
		sql = "SELECT * FROM product" + condition +" ORDER BY id limit ?, ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, startRow-1);
		pstmt.setInt(2, pageSize);
		rs = pstmt.executeQuery();
		
		if(!rs.next()){ //조회결과가 없을 경우
			out.print("<tr><td colspan='8' class='center'><font color='red'><h3>등록된 상품이 없습니다.<h3></font></td></tr>");
		} else {
			do {
				idList.add(rs.getLong("id"));
				pnameList.add(rs.getString("pname"));
				snameList.add(rs.getString("sname"));
				String idate = rs.getString("inputdate");
				inputdateList.add(idate.substring(0, 10)); // yyyy-MM-dd 까지만 잘라서 입력
				downpriceList.add(rs.getInt("downprice"));
				stockList.add(rs.getInt("stock"));
				category1List.add(rs.getString("category1"));
				category2List.add(rs.getString("category2"));
			}while(rs.next());
			
			
			for(int i=0; i<idList.size(); i++){
				out.print("<tr>");
				out.print("<td class='center'><img src='/MyProject/Images/product/"+ idList.get(i) +"_01.jpg'></td>");
				
				//상품명을 클릭했을 때 상품 상세보기로 이동 - category, pname, 페이지번호를 가지고 이동
				out.print("<td><a href='product_read.jsp?id=" + idList.get(i) +"'>" + pnameList.get(i) + "</a></td>");
				out.print("<td class='center'>" + idList.get(i) + "</td>");
				out.print("<td>" + snameList.get(i) + "</td>");
				out.print("<td class='center'>" + inputdateList.get(i)+ "</td>");
				
				//판매가와 재고량의 포맷형식을 지정
				downprice_nf = nf.format(downpriceList.get(i));
				out.print("<td class='right'>" + downprice_nf + "</td>");
				stock_nf = nf.format(stockList.get(i));
				out.print("<td class='right'>" + stock_nf + "</td>");
				
				//상품분류에 따라 카테고리명으로 출력 (11 -> 가구)
				switch((String)category1List.get(i)) {
					case "11" : 
						category_str = "사료/간식"; 
						break;
					case "22" : 
						category_str = "화장실/위생"; 
						break;
					case "33" : 
						category_str = "장난감"; 
						break;
					case "44" : 
						category_str = "스크래쳐/캣타워"; 
						break;
				}
				out.print("<td>" + category_str + "</td><td>");
%>
				<button type="button" onclick="location.href='/MyProject/product/product_update.jsp?id=<%=idList.get(i)%>'">수정</button>
<%
				out.print("</td></tr>");
			}
		}
		out.print("</table>");
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
			out.print("[<a href='product_manage.jsp?pageNum=1&category1=" + category1 + "&pname=" + pname +"'>처음</a>]");
			out.print("[<a href='product_manage.jsp?pageNum=" + (currentPage - 1) + "&category1=" + category1 + "&pname=" + pname + "'>이전</a>]");
		} else {
			out.print("[처음]");
			out.print("[이전]");
		}
		
		//페이지 번호 출력
		for(int i=startPage; i<=endPage; i++){
			if(i == currentPage) {
				out.print("<font color='orange'>["+i+"]</font>");
			}else {
				out.print("[<a href='product_manage.jsp?pageNum=" + i + "&category1=" + category1 + "&pname=" + pname +"'>"+ i +"</a>]");
			}
		}
		
		//다음페이지 유무
		
		// 다음 버튼을 눌렀을때
		if(currentPage < totalPage){
			out.print("[<a href='product_manage.jsp?pageNum=" + (currentPage + 1) + "&category1=" + category1 + "&pname=" + pname + "'>다음</a>]");
			out.print("[<a href='product_manage.jsp?pageNum=" + totalPage + "&category1=" + category1 + "&pname=" + pname + "'>마지막</a>]");
		}else {
			out.print("[다음]");
			out.print("[마지막]");
		}
			
		out.print("<font color='blue'> (" + currentPage + " / " + totalPage + ")</font>");
	}
	out.print("</div>");
%>
</div>
</body>
</html>