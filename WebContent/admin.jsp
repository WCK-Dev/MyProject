<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 모드 페이지</title>
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

	#container { width: 1400px; margin:0 auto; position: relative; font-family: 'NanumSquareRound';}
	#container h1 { margin-left: 70px;}
	#container table { width: 20%; text-align: center; border: 2px solid black; border-collapse: collapse;}
	#container td, #container th  { border: 1px solid black;}
	#container tr { height: 50px;}
	#container th {	background: lightgray;}
	#container button { text-align: center; border: 2px solid black; background: black; color:white; font-weight: bold; width: 80%; height: 40px; cursor: pointer; font-size: 1.1em; font-family: 'NanumSquareRound';}
</style>
</head>
<body>
	<div id="container">
		<h1>관리자 메뉴</h1> 
		<table>
			<tr><th>
			<h3>회원 관리영역</h3>
			</th></tr>
			<tr><td>
			<button type="button" onclick="location.href='/MyProject/member/selectAll.jsp'">회원정보 관리</button>
			</td></tr>
			<tr><th>
			<h3>상품 관리영역</h3>
			</th></tr>
			<tr><td>
			<button type="button" onclick="location.href='/MyProject/product/product_manage.jsp'">상품 관리 페이지</button>
			</td></tr>
			<tr><td>
			<button type="button" onclick="location.href='/MyProject/product/product_write.jsp'">새 상품 등록</button>
			</td></tr>
		</table>
	</div>
</body>
</html>