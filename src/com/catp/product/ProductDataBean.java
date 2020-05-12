package com.catp.product;

public class ProductDataBean {
	private int id;
	private String category1;
	private String category2;
	private String wname;
	private String pname;
	private String sname;
	private int price;
	private int downPrice;
	private String inputDate;
	private int stock;
	private int salesRate;
	private String description;
	private String img1;
	private String img2;
	private String img3;
	

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	public String getWname() {
		return wname;
	}
	public void setWname(String wname) {
		this.wname = wname;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDownPrice() {
		return downPrice;
	}
	public void setDownPrice(int downPrice) {
		this.downPrice = downPrice;
	}
	public String getInputDate() {
		return inputDate;
	}
	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public int getSalesRate() {
		return salesRate;
	}
	public void setSalesRate(int salesRate) {
		this.salesRate = salesRate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public String getImg3() {
		return img3;
	}
	public void setImg3(String img3) {
		this.img3 = img3;
	}
	
	@Override
	public String toString() {
		return "ProductDataBean [id=" + id + ", category1=" + category1 + ", category2=" + category2 + ", wname="
				+ wname + ", pname=" + pname + ", sname=" + sname + ", price=" + price + ", downPrice=" + downPrice
				+ ", inputDate=" + inputDate + ", stock=" + stock + ", salesRate=" + salesRate + ", description="
				+ description + ", img1=" + img1 + ", img2=" + img2 + ", img3=" + img3 + "]";
	}
	
}
