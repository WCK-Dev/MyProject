function check() {
	var form = document.msgwrite;
	
	if(!form.name.value){
		alert("이름을 입력해 주세요 !!");
		form.name.focus();
		return false;
	}
	if(!form.email.value){
		alert("이메일을 입력해 주세요 !!");
		form.email.focus();
		return false;
	}
	if(!form.subject.value){
		alert("제목을 입력해 주세요 !!");
		form.subject.focus();
		return false;
	}
	if(!form.content.value){
		alert("글 내용을 입력해 주세요 !!");
		form.content.focus();
		return false;
	}
	if(!form.password.value){
		alert("비밀번호를 입력해 주세요 !!");
		form.password.focus();
		return false;
	}
	
	form.submit();
}