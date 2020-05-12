<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 작성 페이지</title>
<script>
	function check() {
		var form = document.orderForm;
		
		if(!form.name.value){
			alert("이름을 입력해주세요!");
			form.name.focus();
			return false;
		}
		
		if(form.pay.value == "card" && !form.cardno.value){
			alert("카드 번호를 입력해주세요!");
			form.cardno.focus();
			return false;
		}
		
		if(!form.address.value){
			alert("배송지를 입력해주세요!");
			form.address.focus();
			return false;
		}
		
		if(!form.tel.value){
			alert("전화번호를 입력해주세요!");
			form.tel.focus();
			return false;
		}
		
		form.submit();
	}
	
/* 	function disable() {
		var form = document.orderForm;
		var cardno = document.querySelector("#cardno");
		
		if(form.pay.value == "card") {
			cardno.removeAttribute("disabled");
		} else {
			cardno.value = "";
			cardno.setAttribute("disabled", "disabled");
		}
	} */
	
	function none() {
		var form = document.orderForm;
		var cardRow = document.querySelector("#card_Row");
		
		if(form.pay.value == "card") {
			cardRow.style.display = "table-row";
		} else {
			cardno.value = "";
			cardRow.style.display = "none";
		}
	}
</script>
<link href="../css/order.css" rel="stylesheet">
</head>
<body>
<div id="container">
<%request.setCharacterEncoding("UTF-8");

	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
	
	int cartno = 0;
	if(request.getParameter("cartno") != null){
		cartno = Integer.parseInt(request.getParameter("cartno"));
	}	
	//카트 번호가 넘어와서 대입되면 개별주문 , cartno가 0이라면 전체주문임
	
	int total = Integer.parseInt(request.getParameter("total"));
	int count = Integer.parseInt(request.getParameter("count"));
	
	if(count == 0){
		out.print("<script>alert('장바구니에 추가된 상품이 없습니다.'); window.close();</script>");
	}
	
	NumberFormat nf = NumberFormat.getInstance();
	String total_nf = nf.format(total);
	if(mem_id == null){
		
	}
%>
	<div align="center"><img src="./Images/cat01.png" alt="" id="logo"></div>
	<h3>상품 주문하기</h3>
	<form name="orderForm" method="post" action="order_save.jsp">
		<table>
			<tr>
				<th width="25%">주문자명</th>
				<td width="*"><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>결제 수단</th>
				<td>
					<input type="radio" name="pay" value="card" onchange="none();" checked>카드결제&nbsp;
					<input type="radio" name="pay" value="cash" onchange="none();">온라인 입금
				</td>
			</tr>
			<tr id="card_Row">
				<th>카드 번호</th>
				<td><input type="text" name="cardno" id="cardno"></td>
			</tr>
			<tr>
				<th>배송 주소</th>
				<td><input type="text" name="address" size="40"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel"></td>
			</tr>
			<tr>
				<th>주문 총액</th>
				<td><%=total_nf %></td>
			</tr>
			<tr class="end_row">
				<td colspan="2">
					<input type="hidden" name="total" value="<%=total %>">
					<input type="hidden" name="count" value="<%=count %>">
					<input type="hidden" name="cartno" value="<%=cartno %>">
					<input type="hidden" name="userid" value="<%=mem_id %>">
					<input type="button" value="주문 완료" onclick="check();">
					<input type="reset" value="다시 작성">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>