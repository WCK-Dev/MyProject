function submitCheck(){
		var form = document.reply;
		
		if(!form.name.value){
			alert("댓글 작성자 이름을 입력해야 합니다!");
			form.name.focus();
			return false;
		}
		if(!form.password.value){
			alert("댓글 비밀번호를 입력해야 합니다.");
			form.password.focus();
			return false;
		}
		if(!form.content.value){
			alert("댓글 내용이 없습니다!");
			form.content.focus();
			return false;
		}
		
		form.submit();
	}