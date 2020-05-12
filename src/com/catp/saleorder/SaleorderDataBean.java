package com.catp.saleorder;

public class SaleorderDataBean {
	private int id;
	private String userid;
	private String name;
	private String orderdate;
	private String address;
	private String tel;
	private String pay;
	private String cardno;
	private int productcount;
	private int total;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public String getCardno() {
		return cardno;
	}
	public void setCardno(String cardno) {
		this.cardno = cardno;
	}
	public int getProductcount() {
		return productcount;
	}
	public void setProductcount(int productcount) {
		this.productcount = productcount;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	@Override
	public String toString() {
		return "SaleorderDataBean [id=" + id + ", userid=" + userid + ", name=" + name + ", orderdate=" + orderdate
				+ ", address=" + address + ", tel=" + tel + ", pay=" + pay + ", cardno=" + cardno + ", productcount="
				+ productcount + ", total=" + total + "]";
	}
}
