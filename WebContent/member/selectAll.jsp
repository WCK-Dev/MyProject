<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="com.catp.mymember.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체회원 정보 조회</title>
<style>
	#container { float: right; width: 80%; height: 800px;  box-sizing: border-box;}
	#container h2{ text-align: center; color:black; font-size:2em; margin-top: 30px; margin-bottom: 30px; color: orange;}
	#container table { width: 86%; margin-left:80px; margin-bottom: 10px; border: 1px solid black;}
	#container th { background: black; color: white;}
	#container tr { height: 40px;}
	#container td { text-align: center; padding-left: 10px;}
	#container table a { font-weight: bold; color: red; text-decoration: none;}
	#container input[type="button"] { text-align: center; border: 1px solid black; background: black; color:white; font-weight: bold; width: 120px; height: 50px; cursor: pointer;}
	#btn { width: 100%; text-align: center;}
</style>
</head>
<body>
<div id="container">
<%
	MymemberDBBean dbPro = MymemberDBBean.getInstance();
	List<MymemberDataBean> memberList = dbPro.selectAllMember();
%>
<!-- 스크립틀릿 사이에 바디공간을 할당 -->
	<h2>회원 전체 정보 조회</h2>
	<table> 
		<tr>
			<th width="10%">아이디</th>
			<th width="10%">이름</th>
			<th width="*">주소</th>
			<th width="20%">이메일</th>
			<th width="15%">전화번호</th>
			<th width="15%">회원 관리</th>
		</tr>
<%		if(memberList.size() == 0) {// 등록된 회원이 없을경우 (회원 테이블이 텅비었을 때)%>
		<tr>
			<td colspan="5">등록된 회원이 없습니다.</td>
		</tr>
<%
		} else {
			for(int i=0; i < memberList.size(); i++){
				out.print("<tr><td>" + memberList.get(i).getUserid() + "</td>" );
				out.print("<td>" + memberList.get(i).getUsername() + "</td>" );
				out.print("<td>" + memberList.get(i).getAddress1() + " " + memberList.get(i).getAddress2() + "</td>" );
				out.print("<td>" + memberList.get(i).getEmail() + "</td>" );
				out.print("<td>" + memberList.get(i).getPhone() + "</td>" );
				out.print("<td><a href='delete.jsp?userid="+ memberList.get(i).getUserid() + "'>회원 강제탈퇴</a></td></tr>");
			}
		}
%>
	</table>
	<div id="btn">
		<input type="button" value="쇼핑몰 메인" onclick="location='../index.jsp'">&nbsp;
		<input type="button" value="관리자 메인" onclick="location='../admin.jsp'"> 
	</div>
</div>
</body>
</html>