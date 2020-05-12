<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 리뷰 페이지</title>
<link href="../css/review_show.css" rel="stylesheet">
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
%>
	<div id="side_bar">
	<h3>리뷰 보드</h3>
		<ul>
			<li><a href="review_show.jsp">리뷰 보기</a></li>
			<li><a href="review_write.jsp">리뷰 작성</a></li>
		</ul>
		
	<h3>질의 게시판</h3>
		<ul>
			<li><a href="../freeboard/freeboard_list.jsp">게시판 보기</a></li>
			<li><a href="../freeboard/freeboard_write.jsp">게시판 글 작성</a></li>
		</ul>
	</div>
	
	<div id="review">
		<h2>리뷰 페이지</h2>	
<%
	String id = request.getParameter("id");

	ArrayList idList = new ArrayList();
	ArrayList nameList = new ArrayList();
	ArrayList productidList = new ArrayList();
	ArrayList inputdateList = new ArrayList();
	ArrayList subjectList = new ArrayList();
	ArrayList contentList = new ArrayList();
	
	//Page = 한 화면 , Row = 하나의 글
	
	int pageSize = 5; //하나의 화면에 표시할 글의 갯수
	String pageNum = request.getParameter("pageNum"); // 넘어오는 페이지 번호
	if(pageNum == null){
		pageNum = "1";
	} 
	
	int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
	int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 글의 번호
	//int endRow = startRow + pageSize - 1;
	int endRow = currentPage * pageSize;
	
	int totalRow = 0; //전체 글의 수
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String sql = null;
	
	try { 
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myproject?useSSL=false", "multi", "1234");
		sql = "SELECT count(*) as count FROM review";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		rs.next();
		totalRow = rs.getInt("count");
		rs.close();
		
		sql = "SELECT * FROM review ORDER BY id desc limit ?, ?"; //limit는 0부터 시작함
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, startRow-1);
		pstmt.setInt(2, pageSize);
		rs = pstmt.executeQuery();
		
		if(!rs.next()){
			out.println("등록된 글이 없습니다.");
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
			} //for문의 종료
		} //else 문의 종료
	} catch(Exception e){
		e.printStackTrace();
	} finally {
		if(rs!=null) rs.close();
		if(stmt != null) stmt.close();
		if(pstmt!=null) pstmt.close();
		if(conn!=null) conn.close();
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
		
		if(currentPage > 1) {
%>
			<div class="paging_on" onclick="location.href='review_show.jsp?pageNum=1'">처음</div>
			<div class="paging_on" onclick="location.href='review_show.jsp?pageNum=<%=currentPage-1%>'">이전</div>
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
				<div class="paging_on" onclick="location.href='review_show.jsp?pageNum=<%=i %>'"><%=i %></div>
<%
			}
		}
		
		//다음페이지 유무
		if(currentPage < totalPage){
%>
			<div class="paging_on" onclick="location.href='review_show.jsp?pageNum=<%=currentPage + 1 %>'">다음</div>
			<div class="paging_on" onclick="location.href='review_show.jsp?pageNum=<%=totalPage %>'">마지막</div>
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
		<div class="move">
			<button type="button" onclick="location.href='review_write.jsp'">작성하기</button>
		</div>
	</div>	
	

</div>        
   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>