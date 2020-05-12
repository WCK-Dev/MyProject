<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/MyProject/css/header.css" rel="stylesheet">
<link href="/MyProject/css/reset.css" rel="stylesheet">

<script>
	function login_check() {
		var form = document.login;
		if(!form.id.value) {
			alert("ID를 입력하세요!");
			return;
		}
		if(!form.pwd.value) {
			alert("password를 입력하세요!")
			return;
		}
		form.submit();
	}
</script>
<script src="/MyProject/js/cat.js"></script>

</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String mem_name = (String)session.getAttribute("member_name");
	String mem_id = (String)session.getAttribute("member_id");
	session.setAttribute("member_id", mem_id);
%>
<div class="top">
        <div class="top-left">
            <ul>
                <li><a href="/MyProject/index.jsp"></a></li>
            </ul>
        </div>
        <div class="top-right">
            <ul>
<%
				if(mem_id != null){
%>
				<li><a href="/MyProject/member/logout.jsp">로그아웃</a></li>
<%
				} else {
%>
                <li><a href="/MyProject/member/login.jsp">로그인</a></li>
<%    
				}
				if(mem_id != null){
					if(mem_id.equals("admin")){%>
						<li><a href="/MyProject/admin.jsp">관리자모드</a></li>
<%					} else {%>
		                <li><a href="/MyProject/cart/cart_list.jsp">장바구니</a></li>
<%					}

				} else {%>
                <li><a href="/MyProject/member/joinForm.jsp">회원가입</a></li>
<%
				}
%>
				<li><a href="/MyProject/member/select.jsp">마이페이지</a></li>
                <li><a href="/MyProject/freeboard/freeboard_list.jsp">질의게시판</a></li>
            </ul>
        </div>
    </div>

    <!-- 탑 끝  ------------------------------------------------->


    <ul class="nav">
        <li class="nav-top">
            <ul class="nav-left">
                <li><a href="/MyProject/index.jsp">고양이대통령</a></li>
            </ul>
            <ul class="nav-middle">
                <li><a href="/MyProject/product/product_list.jsp">전체상품보기</a></li>
                <li><a href="/MyProject/product/product_list.jsp?category1=11">사료/간식</a></li>
                <li><a href="/MyProject/product/product_list.jsp?category1=22">화장실/위생</a></li>
                <li><a href="/MyProject/product/product_list.jsp?category1=33">장난감</a></li>
                <li><a href="/MyProject/product/product_list.jsp?category1=44">스크래쳐/캣타워</a></li>
            </ul>
            <form action="/MyProject/product/product_list.jsp" method="post">
                <ul class="nav-right">
                    <li>
                        <input type="text" placeholder="상품명 또는 제조사로 검색" size="30" name="searchvalue">
                    </li>
                    <li>
                        <button type="submit"><img src="/MyProject/Images/search.png" alt="검색"></button>
                    </li>
                </ul>
            </form>
        </li>
        <li class="nav-bottom">
            <ul class="bottom-left">
                <li></li>
            </ul>
            <ul class="nav-middle">
                <li>
                    
                </li>
                <li>
                    <p><a href="/MyProject/product/product_list.jsp?category1=11&category2=01">건식사료</a></p>
                    <p><a href="/MyProject/product/product_list.jsp?category1=11&category2=02">캔</a></p>
                    <p><a href="/MyProject/product/product_list.jsp?category1=11&category2=03">파우치</a></p>
                </li>
               
                <li>
                    <p><a href="/MyProject/product/product_list.jsp?category1=22&category2=01">하우스형화장실</a></p>
                    <p><a href="/MyProject/product/product_list.jsp?category1=22&category2=02">평판형화장실</a></p>
                    <p><a href="/MyProject/product/product_list.jsp?category1=22&category2=03">화장실모래</a></p>
                </li>
                <li>
                    <p><a href="/MyProject/product/product_list.jsp?category1=33&category2=01">낚시/막대</a></p>
                    <p><a href="/MyProject/product/product_list.jsp?category1=33&category2=02">공/인형</a></p>
                    <p><a href="/MyProject/product/product_list.jsp?category1=33&category2=03">터널</a></p>
                </li>
                <li>
                    <p><a href="/MyProject/product/product_list.jsp?category1=44&category2=01">스크래쳐</a></p>
                    <p><a href="/MyProject/product/product_list.jsp?category1=44&category2=02">캣타워</a></p>
                </li>
            </ul>
            <ul class="bottom-right">
                <li></li>
            </ul>
        </li>
    </ul>
    <hr>
</body>
</html>