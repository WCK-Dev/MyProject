package com.catp.freeboard;

public class FreeboardDataBean {
	private int id;
	private String name;
	private String password;
	private String email;
	private String subject;
	private String content;
	private String inputDate;
	private int masterId;
	private int readCount;
	private int replyNum;
	private int step;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInputDate() {
		return inputDate;
	}
	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}
	public int getMasterId() {
		return masterId;
	}
	public void setMasterId(int masterId) {
		this.masterId = masterId;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	
	@Override
	public String toString() {
		return "FreeboardDataBean [id=" + id + ", name=" + name + ", password=" + password + ", email=" + email
				+ ", subject=" + subject + ", content=" + content + ", inputDate=" + inputDate + ", masterId="
				+ masterId + ", readCount=" + readCount + ", replyNum=" + replyNum + ", step=" + step + "]";
	}
}
