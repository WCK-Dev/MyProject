function choiceZipcode(zipcodeNo, address1) {
	opener.join.zipcode1.value = zipcodeNo.substring(0, 3);
	opener.join.zipcode2.value = zipcodeNo.substring(4, 7);
	opener.join.address1.value = address1;
	opener.join.address2.focus()
	self.close();
}