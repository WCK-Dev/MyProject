<%@page import="com.catp.saleorder.SaleorderDataBean"%>
<%@page import="com.catp.saleorder.SaleorderDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록 페이지</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function check_member() {
		non_member = confirm('고양이대통령 회원이시라면 먼저 로그인후 조회해주세요 !<br>비회원 주문조회를 하시려면 확인을 눌러주세요.');
		if(non_member == true){
			window.open("");
		} else {
			location.href="../index.jsp"
		}
	}
</script>
<link href="../css/order_list.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>

<div id="container">
<% 	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="com.catp.mymember.MymemberDataBean"/>

<%
	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
	
	member.setUserid(mem_id);
	
	NumberFormat nf = NumberFormat.getInstance();
	
	SaleorderDBBean dbPro = SaleorderDBBean.getInstance();
	List<SaleorderDataBean> orderList = dbPro.selectOrderList(member);
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
	
	<div id="order_list">
		<table>
			<tr>
               <td>주문번호</td><td>주문날짜</td><td>결제방법</td><td>결제금액</td>
            </tr>	
<%		if(orderList.size() == 0) {
			out.print("<tr><td colspan='4'><h1>주문 내역이 없습니다.</h1><td></tr>");
		} else {
			for(int i=0; i < orderList.size(); i++) { %>
			 <tr>
                 <td><a href="order_read.jsp?orderid=<%=orderList.get(i).getId() %>"><%=orderList.get(i).getId() %></a></td><td><%=orderList.get(i).getOrderdate() %></td><td><%=orderList.get(i).getPay() %></td><td><%=nf.format(orderList.get(i).getTotal())%></td>
             </tr>
<%			}
		} %>
		</table>
	</div>
</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>