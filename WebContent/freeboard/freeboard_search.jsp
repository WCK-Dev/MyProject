<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록 보기</title>
<link href="../css/freeboard_list.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="../js/freeboard_list.js"></script>
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
			<li><a href="../review/review_show.jsp">리뷰 보기</a></li>
			<li><a href="../review/review_write.jsp">리뷰 작성</a></li>
		</ul>
		
	<h3>질의 게시판</h3>
		<ul>
			<li><a href="freeboard_list.jsp">게시판 보기</a></li>
			<li><a href="freeboard_write.jsp">게시판 글 작성</a></li>
		</ul>
	</div>


	<div id="freeboard">
		<h2>질의응답 게시판</h2>
		<form method="post" name="msgsearch" action="freeboard_search.jsp">
			<table border="0">
				<tr class="search_row">
					<td>
						<select name="stype">
<%
	String condition = null; //검색조건 문 (sql을 수행할 문장)
	String searchValue = null; //사용자의 검색어
	int searchType = 1;
	
	if(request.getParameter("stype") != null){
		searchType = Integer.parseInt(request.getParameter("stype"));
		searchValue = request.getParameter("sval");
		
		if(searchType == 1) {
			out.print("<option value='1' selected>이름</option>");
			condition = " WHERE name LIKE '%" + searchValue + "%'";
		} else {
			out.print("<option value='1'>이름</option>");
		}
		
		if(searchType == 2) {
			out.print("<option value='2' selected>제목</option>");
			condition = " WHERE subject LIKE '%" + searchValue + "%'";
		} else {
			out.print("<option value='2'>제목</option>");
		}
		
		if(searchType == 3) {
			out.print("<option value='3' selected>내용</option>");
			condition = " WHERE content LIKE '%" + searchValue + "%'";
		} else {
			out.print("<option value='3'>내용</option>");
		}
		
		if(searchType == 4) {
			out.print("<option value='4' selected>이름+제목</option>");
			condition = " WHERE name LIKE '%" + searchValue + "%' OR subject LIKE '%" + searchValue + "%'";
		} else {
			out.print("<option value='4'>이름+제목</option>");
		}
		
		if(searchType == 5) {
			out.print("<option value='5' selected>이름+내용</option>");
			condition = " WHERE name LIKE '%" + searchValue + "%' OR content LIKE '%" + searchValue + "%'";
		} else {
			out.print("<option value='5'>이름+내용</option>");
		}
		
		if(searchType == 6) {
			out.print("<option value='6' selected>제목+내용</option>");
			condition = " WHERE subject LIKE '%" + searchValue + "%' OR content LIKE '%" + searchValue + "%'";
		} else {
			out.print("<option value='6'>제목+내용</option>");
		}
		
		if(searchType == 7) {
			out.print("<option value='7' selected>이름+제목+내용</option>");
			condition = " WHERE name LIKE '%" + searchValue + "%' OR subject LIKE '%" + searchValue + "%' OR content LIKE '%" + searchValue + "%'";
		} else {
			out.print("<option value='7'>이름+제목+내용</option>");
		}
		
		if(searchValue.trim().equals("")) condition = "";
	}
%>
						</select>
						<input type="text" name="sval" size="17" value="<%=request.getParameter("sval") %>"> <!-- 검색어 입력 input -->
						<button type="button" onclick="check();">검색</button>
					</td>
				</tr>
			</table>
		</form>
	
<% 
		ArrayList idList = new ArrayList();
		ArrayList nameList = new ArrayList();
		ArrayList inputdateList = new ArrayList();
		ArrayList subjectList = new ArrayList();
		ArrayList readcountList = new ArrayList();
		ArrayList stepList = new ArrayList(); // 댓글 단계를 추가하는 ArrayList
		
		int pageSize = 10; //하나의 화면에 표시할 글의 갯수
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
			sql = "SELECT count(*) as count FROM freeboard" + condition;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			totalRow = rs.getInt("count");
			rs.close();
			
			sql = "SELECT * FROM freeboard " + condition + " ORDER BY masterid desc, replynum, step, id limit ?, ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			if(!rs.next()){
				out.println("게시판에 등록된 글이 없습니다.");
			} else {
				do{
					idList.add(rs.getInt("id"));
					nameList.add(rs.getString("name"));
					inputdateList.add(rs.getString("inputdate"));
					subjectList.add(rs.getString("subject"));
					readcountList.add(rs.getString("readcount"));
					stepList.add(rs.getInt("step"));
				} while (rs.next());
%>
	
		<table>
			<tr>
				<th width="10%">글번호</th>
				<th width="*">제목</th>	
				<th width="15%">글쓴이</th>	
				<th width="15%">등록날짜</th>	
				<th width="10%">조회수</th>	
			</tr> 
<%		
			for(int i=0; i<idList.size(); i++){
				if(i%2 == 0){
					out.print("<tr>");
				} else {
					out.print("<tr>");
				}
				
				out.print("<td>" + idList.get(i) + "</td>");
				
				//제목을 눌렀을 경우 id와 currentpage를 가지고 상세보기로 이동함
				out.print("<td class='subject_col'>"
				+"<a href='freeboard_read.jsp?id=" +idList.get(i) + "&pageNum=" + currentPage +"'>");
				int stepcount = (Integer)stepList.get(i);
				
				out.print(subjectList.get(i) + "</a></td>");
				out.print("<td>" + nameList.get(i) + "</td>");
				//등록 일시에서 날짜만 추출해서 보여준다.
				String idate = (String)inputdateList.get(i);
				idate = idate.substring(0, 10);
				out.print("<td>" + idate + "</td>");
				out.print("<td>" + readcountList.get(i) + "</td></tr>");
			}
%>
		</table>
<%
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
			<div class="paging_on" onclick="href='freeboard_search.jsp?pageNum=1&stype=<%=searchType%>&sval=<%=searchValue%>'">처음</div>
			<div class="paging_on" onclick="href='freeboard_search.jsp?pageNum<%=currentPage-1%>&stype=<%=searchType%>&sval=<%=searchValue%>'">이전</div>
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
				<div class="paging_on" onclick="location.href='freeboard_search.jsp?pageNum=<%=i %>&stype=<%=searchType%>&sval=<%=searchValue%>'"><%=i %></div>
<%
			}
		}
		
		//다음페이지 유무
		
		if(currentPage < totalPage){
%>
			<div class="paging_on" onclick="location.href='freeboard_search.jsp?pageNum=<%=currentPage + 1 %>&stype=<%=searchType%>&sval=<%=searchValue%>'">다음</div>
			<div class="paging_on" onclick="location.href='freeboard_search.jsp?pageNum=<%=totalPage %>&stype=<%=searchType%>&sval=<%=searchValue%>'">마지막</div>
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
		<div class="move"><a href="freeboard_write.jsp"><img src="../Images/write.gif" width="60" height="25"/></a></div>
	</div>
</div>
   	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>