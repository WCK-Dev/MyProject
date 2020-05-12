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

