<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>고양이대통령_회원가입</title>
<link href="../css/joinForm.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="../js/joinForm.js"></script>
</head>    

<body>
		<jsp:include page="../include/header.jsp"></jsp:include>
	<div id="container">
	    <div id="content">
	    	<div id="join_block">
			    <h2>회원 가입</h2> 
			    <form action="joinProc.jsp" method="post" name="join">
			        <ul type="none">
			            <li>
			            	<input type="text" id="userid" name="userid" placeholder=" 아이디" required> 
			            	<input type="button" onclick="MM_openBrWindow('useridCheck.jsp', 'userid_check', 'menubar=no, toolbar=no, location=no, width=450, height=450')" value="중복 확인">
			            </li>
			            <li><input type="password" class="ohter" name="password" placeholder=" 비밀번호" required></li>
			            <li><input type="password" class="ohter" name="password2" placeholder="비밀번호 다시 입력" required></li>
			            <li><input type="text" class="ohter"  name="username" placeholder=" 이름" required></li>
			            <li><input type="email" class="ohter" name="email" placeholder=" 이메일" required></li>
						<li><input type="text" class="ohter" name="phone" maxlength="13" placeholder=" 핸드폰 번호"></li>
						<li><input type="text" id="zipcode1" name="zipcode1" maxlength="3" size="3"> - 
							<input type="text" id="zipcode2" name="zipcode2" maxlength="3" size="3">
							<input type="button" value="우편번호 검색" onclick="MM_openBrWindow('zipcodeSearch.jsp', 'zipcodesearch', 'scrollbar=yes, location=no, width=550, height=600')">
						</li>
						<li><input type="text" class="ohter" name="address1" placeholder=" 주소지"></li>
						<li><input type="text" class="ohter" name="address2" placeholder=" 상세주소"></li>
			        </ul>
			        <input type="checkbox" id="marketing_ok" name="marketing_ok">
			        <label for="marketing_ok">이벤트 및 마케팅 정보 수신에 동의합니다. (선택)</label>
			
			        <p>본인은 만 14세 이상이며, <a href="#">고양이대통령 이용약관</a>,<br><a href="#">개인정보 수집 및 이용</a> 내용을 확인하였으며, 동의합니다. </p>
					<input type="hidden" name="userid_check">
			        <button type="button" onclick="doSubmit();">동의하고 가입하기</button>
			    </form>
	    	</div>
	    </div>
    </div>        
	    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>