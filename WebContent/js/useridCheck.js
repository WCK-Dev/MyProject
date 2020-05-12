function checkEnd() {
	var form = document.id_check;
	opener.join.userid.value = form.userid.value; // opener : 현재 창을 호출한 페이지 (즉, 이전 페이지)
	opener.join.userid_check.value = form.check_count.value;
	self.close();
}

function doCheck() {
	var form = document.id_check;
	if(!checkValue (form.userid, "아이디", 5, 16)){
		return;
	}
	form.submit();
}

function checkValue(target, cmt, lmin, lmax) {
	var alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var degit = "1234567890";
	var astr = alpha + degit;
	var i;
	var tValue = target.value;
	
	if(tValue.length < lmin || tValue.length > lmax) {
		if(lmin == lmax) alert(cmt + "는" + lmin + "Byte이어야 합니다.");
		else alert(cmt + "는" + lmin + "~" + lmax + "Byte 이내로 입력하셔야 합니다.");
		
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