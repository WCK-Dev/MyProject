<%@page import="com.catp.product.ProductDataBean"%>
<%@page import="com.catp.product.ProductDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품정보 수정</title>
<style>
	#container {width: 600px; margin: 20px auto;}
	
	h2{ text-align: center; color:black;}
	table { width: 100%;}
	th { background: black; color: white; border-bottom: white;}
	tr { height: 30px; }
	table, th, td { border: 1px solid; border-collapse: collapse;}
	input[type="button"], input[type="reset"] { text-align: center; border: 1px solid black; background: black; color:white; font-weight: bold; width: 80px; height: 30px; cursor: pointer;}
	.btn_row td { text-align: center; border: hidden; border-top: 1px solid black; padding-top : 10px;}
	a { text-align: center;}
	#return { text-align: center; margin-top: 30px;}
</style>
<script>
	function check(){
		var form = document.productUpdate;
		
		if(form.wname.value.length == 0){
			alert("작성자명을 입력해주세요");
			form.wname.focus();
			return false;
		}
		if(form.pname.value.length == 0){
			alert("상품명을 입력해주세요");
			form.pname.focus();
			return false;
		}
		if(form.sname.value.length == 0){
			alert("제조사명을 입력해주세요");
			form.sname.focus();
			return false;
		}
		if(form.price.value.length == 0){
			alert("제품 정가를 입력해주세요");
			form.price.focus();
			return false;
		}
		if(form.downprice.value.length == 0){
			alert("판매가를 입력해주세요");
			form.downprice.focus();
			return false;
		}
		if(form.stock.value.length == 0){
			alert("입고수량을 입력해주세요");
			form.stock.focus();
			return false;
		}
		if(form.img1.value.length == 0){
			alert("이미지를 하나 이상 선택 해주세요");
			form.small.focus();
			return false;
		}
		
		form.submit();
	}
	
	function categoryChange() {
		var category1 = document.productUpdate.category1.value;
		var category2 = document.productUpdate.category2;
		
		if(category1 == 11){
			category2.innerHTML = "<option value='01'>건식사료</option><option value='02'>캔</option><option value='03'>파우치</option>";
		} else if (category1 == 22){
			category2.innerHTML = "<option value='01'>하우스형 화장실</option><option value='02'>평판형 화장실</option><option value='03'>화장실 모래</option>";
		} else if (category1 == 33){
			category2.innerHTML = "<option value='01'>낚시/막대형</option><option value='02'>공/인형</option><option value='03'>터널/주머니</option>";
		} else if (category1 == 44){
			category2.innerHTML = "<option value='01'>스크래쳐</option><option value='02'>캣타워</option><option value='03'>리필/로프</option>";
		}
	}
</script>
</head>
<body>
<div id="container">
	<%	request.setCharacterEncoding("UTF-8");%>
	<jsp:useBean id="product" class="com.catp.product.ProductDataBean"/>
	<jsp:setProperty property="*" name="product"/>
	<%
		String mem_name = (String)session.getAttribute("member_name");
		String mem_id = (String)session.getAttribute("member_id");
		session.setAttribute("member_id", mem_id);
		
		if(!mem_id.equals("admin")){
			out.print("<script>alert('상품 정보수정은 관리자 계정만 가능합니다 !'); history.back();</script>");
		}
		
		ProductDBBean dbPro = ProductDBBean.getInstance();
		product = dbPro.getProduct(product);
		NumberFormat nf = NumberFormat.getInstance();
	%>
	
	
	<form name="productUpdate" method="post" action="product_rsave.jsp" enctype="multipart/form-data">
	<h2>제품 수정하기</h2>
	<table>
		<tr>
			<th width="20%">판매자</th>
			<td width="*"><input type="text" name="wname" id="wname" value="<%=product.getWname() %>"></td>
		</tr>	
		<tr>
			<th>상품분류</th>
			<td>
				<select name="category1" id="category1" onchange="categoryChange()">
					<option value="11" <%if(product.getCategory1().equals("11")) {%>selected<%} %>>사료/간식</option>
					<option value="22" <%if(product.getCategory1().equals("22")) {%>selected<%} %>>화장실/위생</option>
					<option value="33" <%if(product.getCategory1().equals("33")) {%>selected<%} %>>장난감</option>
					<option value="44" <%if(product.getCategory1().equals("44")) {%>selected<%} %>>스크래쳐/캣타워</option>
				</select>
				<select name="category2" id="category2">
					<option value="01">---</option>
					<option value="02">---</option>
					<option value="03">---</option>
				</select>
			</td>
		</tr>	
		<tr>
			<th>상품명</th>
			<td><input type="text" name="pname" id="pname" size="30" value="<%=product.getPname() %>"></td>
		</tr>	
		<tr>
			<th>제조사</th>
			<td><input type="text" name="sname" id="sname" size="30" value="<%=product.getSname() %>"></td>
		</tr>	
		<tr>
			<th>정가</th>
			<td><input type="text" name="price" id="price" size="10" value="<%=product.getPrice() %>"></td>
		</tr>	
		<tr>
			<th>판매가</th>
			<td><input type="text" name="downprice" id="downprice" size="10" value="<%=product.getDownPrice() %>"></td>
		</tr>	
		<tr>
			<th>재고량</th>
			<td><input type="text" name="stock" id="stock" size="10" value="<%=product.getStock() %>"></td>
		</tr>	
		<tr>
			<th>이미지1</th>
			<td><input type="file" name="img1" id="img1" value="<%=product.getImg1() %>"><br>
		</tr>	
		<tr>
			<th>이미지2</th>
			<td><input type="file" name="img2" id="img2" value="<%=product.getImg2() %>"><br>
		</tr>	
		<tr>
			<th>이미지3</th>
			<td><input type="file" name="img3" id="img3" value="<%=product.getImg3() %>"><br>
		</tr>	
		<tr>
			<th>상품설명</th>
			<td>
				<textarea name="description" rows="10" cols="65"><%=product.getDescription() %></textarea>
			</td>
		</tr>	
		<tr class="btn_row">
			<td colspan="2">
				<input type="button" value="제품 수정" onclick="check();">&nbsp;
				<input type="button" value="취소" onclick="location.href='../index.jsp'">
			</td>
		</tr>
	</table>
	<input type="hidden" name="id" value="<%=product.getId() %>">
	</form>
</div>
</html>