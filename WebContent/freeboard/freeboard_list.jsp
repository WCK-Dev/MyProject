<%@page import="com.catp.freeboard.FreeboardDataBean"%>
<%@page import="com.catp.freeboard.FreeboardDBBean"%>
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
<script src="./js/freeboard_list.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>
<div id="container">

	
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
<%
	int pageSize = 10; //하나의 화면에 표시할 글의 갯수
	String pageNum = request.getParameter("pageNum"); // 넘어오는 페이지 번호
	if(pageNum == null){
		pageNum = "1";
	} 
	
	int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
	int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 글의 번호
	int endRow = currentPage * pageSize;
	
	int totalRow = 0; //전체 글의 수
	int replyCnt = 0;
	
	FreeboardDBBean dbPro = FreeboardDBBean.getInstance();
	totalRow = dbPro.getBoardListCnt();
	
	List<FreeboardDataBean> boardList = dbPro.getBoardList(startRow-1, pageSize);
		
%>
	<h2>질의응답 게시판</h2>
<%	if(boardList.size() == 0){
			out.println("게시판에 등록된 글이 없습니다.");
		} else {%>
	<table>
		<tr>
			<th width="10%">글번호</th>
			<th width="*">제목</th>	
			<th width="15%">글쓴이</th>	
			<th width="15%">등록날짜</th>	
			<th width="10%">조회수</th>	
		</tr> 
<%		
			for(int i=0; i<boardList.size(); i++){
				FreeboardDataBean board = boardList.get(i);
				replyCnt = dbPro.getReplyList(board).size(); 
%>			
			<tr>
				<td><%=board.getId() %></td>
				<td class='subject_col'>
					<a href='freeboard_read.jsp?id=<%=board.getId() %>&pageNum=<%=currentPage %>'><%=board.getSubject() %></a>
<%					if(replyCnt != 0){ %>
						<small> [<%=replyCnt %>]</small>
<%					}%>
				<td><%=board.getName() %></td>
				<td><%=board.getInputDate().substring(0, board.getInputDate().indexOf(" ")) %></td>
				<td><%=board.getReadCount() %></td>
			</tr>
<%			} %>
	</table>
	<form method="post" name="msgsearch" action="freeboard_search.jsp">
		<table id="searchtable">
			<tr class="search_row">
				<td>
					<select name="stype">
						<option value='1'>이름</option>
						<option value='2'>제목</option>
						<option value='3'>내용</option>
						<option value='4'>이름+제목</option>
						<option value='5'>이름+내용</option>
						<option value='6'>제목+내용</option>
						<option value='7'>이름+제목+내용</option>
					</select>
					<input type="text" name="sval" size="17"> <!-- 검색어 입력 input -->
					<button type="button" onclick="check();">검색</button>
				</td>
			</tr>
		</table>
	</form>
	
<%		} //else 문의 종료 %>	
	<div id="paging">
<%	
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
		
		if(currentPage > 1) { %>
			<div class="paging_on" onclick="location.href='freeboard_list.jsp?pageNum=1'">처음</div>
			<div class="paging_on" onclick="location.href='freeboard_list.jsp?pageNum=<%=currentPage-1 %>'">이전</div>
<%		} else { %>
			<div class="paging_off">처음</div>
			<div class="paging_off">이전</div>
<%		}		
		//페이지 번호 출력
		for(int i=startPage; i<=endPage; i++){
			if(i == currentPage) { %>
			<div class="paging_now"><%=i %></div>
<%			}else { %>
				<div class="paging_on" onclick="location.href='freeboard_list.jsp?pageNum=<%=i %>'"><%=i %></div>
<%			}
		}
		//다음페이지 유무
		if(currentPage < totalPage){ %>
			<div class="paging_on" onclick="location.href='freeboard_list.jsp?pageNum=<%=currentPage + 1 %>'">다음</div>
			<div class="paging_on" onclick="location.href='freeboard_list.jsp?pageNum=<%=totalPage %>'">마지막</div>
<%		}else { %>
			<div class="paging_off">다음</div>
			<div class="paging_off">마지막</div>
<%		}
	}
		
%>
	</div>
	<div class="move">
		<button type="button" onclick="location.href='freeboard_write.jsp'">글 쓰기</button>
	</div>
	
	</div>	
	
</div>        
   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>