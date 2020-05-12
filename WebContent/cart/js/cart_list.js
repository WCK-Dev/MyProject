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

function setValue(form){
	form.quantity.value=0;
	form.submit();
}

function changeQty(form, n){
	if(n == -1){
		form.quantity.value = Number(form.quantity.value)-1;
		if(form.quantity.value == "0") {
			
		} 
	} else {
		form.quantity.value = Number(form.quantity.value)+1;
	}
					
	form.submit();
}

function delete_check() {
	var answer = confirm ("회원 탈퇴처리 후에는 고객님의 정보를 복구할 수 없습니다.\n정말 회원 탈퇴를 수행할까요?");
	
	if(answer) { location.href="../member/delete.jsp"; }
	else { return; }
}