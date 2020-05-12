package com.catp.item;

public class ItemDataBean {
	private int orderId;
	private int itemNO;
	private int productId;
	private String pname;
	private int quantitiy;
	private int price;
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getItemNO() {
		return itemNO;
	}
	public void setItemNO(int itemNO) {
		this.itemNO = itemNO;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getQuantitiy() {
		return quantitiy;
	}
	public void setQuantitiy(int quantitiy) {
		this.quantitiy = quantitiy;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	@Override
	public String toString() {
		return "ItemDataBean [orderId=" + orderId + ", itemNO=" + itemNO + ", productId=" + productId + ", pname="
				+ pname + ", quantitiy=" + quantitiy + ", price=" + price + "]";
	}
}
