function check() {
		var form = document.msgdel;
		
		if(!form.password.value){
			alert("비밀번호를 입력해 주세요");
			form.password.focus();
			return false;
		}
		
		form.submit();
	}