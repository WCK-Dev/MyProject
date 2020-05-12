function check() {
	var form = document.msgsearch;
	
	if(!form.sval.value) {
		alert("검색어를 입력해 주세요.");
		form.sval.focus();
		return false;
	}
	
	form.submit();
}

// 댓글에 대한 이미지 변환
function rimg_change(p1, p2) {
	if(p2 == 1) 
		document.images[p1].src = "./Images/open.gif";
	else 
		document.images[p1].src = "./Images/arrow.gif";
}
// 원글에 대한 이미지 변환
function img_change(p1, p2) {
	if(p2 == 1) 
		document.images[p1].src = "./Images/open.gif";
	else 
		document.images[p1].src = "./Images/close.gif";
}