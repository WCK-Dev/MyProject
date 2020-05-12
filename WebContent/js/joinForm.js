function MM_openBrWindow(theURL, winName, features){
	var form = document.join;
	if(winName == "userid_check") {
		if(!checkValue(form.userid, '아이디', 5, 16)){
			return;
		}
		theURL = theURL + "?userid=" + form.userid.value;
	}
	window.open(theURL, winName, features);
}

function checkValue(target, cmt, lmin, lmax) {
	var alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var degit = "1234567890";
	var astr = alpha + degit;
	var i;
	var tValue = target.value;
	
	if(tValue.length < lmin || tValue.length > lmax) {
//		if(lmin == lmax) alert(cmt + "는" + lmin + "Byte이어야 합니다.");
//		else alert(cmt + "는" + lmin + "~" + lmax + "Byte 이내로 입력하셔야 합니다.");
		
		alert(cmt + "는" + lmin + "~" + lmax + "Byte 이내로 입력하셔야 합니다.");
		target.focus();
		return false;
	}
	
	if(astr.length > 1) {
		for(i=0; i<tValue.length; i++) {
			if(astr.indexOf(tValue.substring(i, i+1)) < 0){
				alert(cmt + "에 허용할 수 없는 문자가 입력되었습니다.");
				target.focus();
				return false;
			}
		}
	}
	return true;
}

function doSubmit() {
	var form = document.join; //joinForm.jsp페이지에서 넘어오는 form의 name으로 조회하여 객체 접근
	
	if(!form.userid.value){
		alert("아이디를 입력해 주세요!");
		form.userid.focus();
		return;
	}
	
	if(!checkValue(form.userid, '아이디', 5, 16)){
		return;
	}
	
	if(!form.password.value){
		alert("비밀번호를 입력해주세요!");
		form.password.focus();
		return;
	}
	
	if(form.password.value != form.password2.value){
		alert("비밀번호 재입력시 같은 비밀번호를 입력해주세요 !")
		form.password.value = "";
		form.password2.value = "";
		form.password.focus();
		return;
	}
	
	if(form.userid.value == form.password.value){
		alert("아이디와 비밀번호는 같을 수 없습니다 !")
		form.password.value = "";
		form.password.focus();
		return;
	}
	
	if(!checkValue(form.password, '비밀번호', 4, 12)){
		return;
	}
	
	if(!form.username.value){
		alert("이름을 입력해주세요!");
		form.username.focus();
		return;
	}
	
	if(!form.email.value){
		alert("이메일을 입력해 주세요!")
		form.email.focus();
		return;
	}
	
	if(form.email.value.indexOf("@") < 0){
		alert("이메일 주소형식이 틀립니다 !");
		form.email.focus();
		return;
	}
	
	if(form.email.value.indexOf(".") < 0){
		alert("이메일 도메인 형식이 틀립니다 !");
		form.email.focus();
		return;
	}
	
	if(!form.zipcode1.value || !form.zipcode2.value){
		alert("우편번호를 입력해 주세요!");
		MM_openBrWindow('zipcode_search.jsp', 'zipcode_search', 'scrollbasrs=yes, width=500, height=250');
		form.zipcode1.focus();
		return;
	}
	
	if(!form.address1.value){
		alert("주소를 입력해 주세요!")
		MM_openBrWindow('zipcode_search.jsp', 'zipcode_search', 'scrollbasrs=yes, width=500, height=250');
		form.address1.focus();
		return;
	}
	
	if(!form.address2.value){
		alert("상세 주소를 입력해 주세요!")
		form.address2.focus();
		return;
	}
	
	if(!form.phone.value){
		alert("전화번호를 입력해 주세요!");
		form.phone2.focus();
		return;
	}
	
	form.submit();
}