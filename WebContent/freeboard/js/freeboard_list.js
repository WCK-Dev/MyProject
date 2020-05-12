function check() {
		var form = document.msgsearch;
		
		if(!form.sval.value) {
			alert("검색어를 입력해 주세요.");
			form.sval.focus();
			return false;
		}
		
		form.submit();
	}