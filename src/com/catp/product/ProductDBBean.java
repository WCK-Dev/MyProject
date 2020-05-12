package com.catp.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDBBean {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//SQL문 정의
	private final String GET_BEST = "SELECT * FROM product ORDER BY salesrate DESC LIMIT 10";
	private final String GET_NEW = "SELECT * FROM product ORDER BY inputdate DESC LIMIT 10";
	private final String GET_PRODUCT = "SELECT * FROM product WHERE id = ?";
	private final String INSERT_PRODUCT = "INSERT INTO product(id, category1, category2, wname, pname, sname, price, downprice, inputdate, stock, img1, img2, img3, description)" +
			"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String UPDATE_PRODUCT = "UPDATE product SET category1=?, category2=?, wname=?, pname=?, sname=?, price=?, downprice=?, inputdate=?, stock=?, img1=?, img2=?, img3=?, description=? WHERE id=?";
	
		
	//싱글톤 패턴으로 리턴해줄 instance
	private ProductDBBean() { }
	private static ProductDBBean instance = new ProductDBBean();
	public static ProductDBBean getInstance() {
		return instance;
	}
	
	// CP를 통해 커넥션을 획득하는 메서드
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/myproject");
		
		return ds.getConnection();
	}
	
	//close() 메소드 2개
	private void close(Connection conn, Statement stmt, ResultSet rs) {
		if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();};
		if(stmt != null) try {stmt.close();} catch(Exception e) {e.printStackTrace();};
		if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();};
	}
	
	
	//인덱스에서 사용할 BEST 획득 메서드
	public List<ProductDataBean> getBestProducts() {
		List<ProductDataBean> bestProducts = new ArrayList<ProductDataBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(GET_BEST);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDataBean product = new ProductDataBean();
				product.setId(rs.getInt("id"));
				product.setCategory1(rs.getString("category1"));
				product.setCategory2(rs.getString("category2"));
				product.setWname(rs.getString("wname"));
				product.setPname(rs.getString("pname"));
				product.setSname(rs.getString("sname"));
				product.setPrice(rs.getInt("price"));
				product.setDownPrice(rs.getInt("downprice"));
				product.setInputDate(rs.getString("inputdate"));
				product.setStock(rs.getInt("stock"));
				product.setSalesRate(rs.getInt("salesrate"));
				product.setDescription(rs.getString("description"));
				product.setImg1(rs.getString("img1"));
				product.setImg2(rs.getString("img2"));
				product.setImg3(rs.getString("img3"));
				
				bestProducts.add(product);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return bestProducts;
	}
	
	//인덱스에서 사용할 New획득 메서드
	public List<ProductDataBean> getNewProducts() {
		List<ProductDataBean> bestProducts = new ArrayList<ProductDataBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(GET_NEW);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDataBean product = new ProductDataBean();
				product.setId(rs.getInt("id"));
				product.setCategory1(rs.getString("category1"));
				product.setCategory2(rs.getString("category2"));
				product.setWname(rs.getString("wname"));
				product.setPname(rs.getString("pname"));
				product.setSname(rs.getString("sname"));
				product.setPrice(rs.getInt("price"));
				product.setDownPrice(rs.getInt("downprice"));
				product.setInputDate(rs.getString("inputdate"));
				product.setStock(rs.getInt("stock"));
				product.setSalesRate(rs.getInt("salesrate"));
				product.setDescription(rs.getString("description"));
				product.setImg1(rs.getString("img1"));
				product.setImg2(rs.getString("img2"));
				product.setImg3(rs.getString("img3"));
				
				bestProducts.add(product);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return bestProducts;
	}
	
	public ProductDataBean getProduct(ProductDataBean product) {
		ProductDataBean productData = new ProductDataBean();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(GET_PRODUCT);
			pstmt.setInt(1, product.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				productData.setId(rs.getInt("id"));
				productData.setCategory1(rs.getString("category1"));
				productData.setCategory2(rs.getString("category2"));
				productData.setWname(rs.getString("wname"));
				productData.setPname(rs.getString("pname"));
				productData.setSname(rs.getString("sname"));
				productData.setPrice(rs.getInt("price"));
				productData.setDownPrice(rs.getInt("downprice"));
				productData.setInputDate(rs.getString("inputdate"));
				productData.setStock(rs.getInt("stock"));
				productData.setSalesRate(rs.getInt("salesrate"));
				productData.setDescription(rs.getString("description"));
				productData.setImg1(rs.getString("img1"));
				productData.setImg2(rs.getString("img2"));
				productData.setImg3(rs.getString("img3"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return productData;
	}
	
	public int getNewProductId(ProductDataBean product) {
		int id = 0;
		
		try {
			conn = getConnection();
			String sql = "SELECT max(id) FROM product WHERE category1 = ? AND category2 = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getCategory1());
			pstmt.setString(2, product.getCategory2());
			rs = pstmt.executeQuery();
			rs.next();
			id = rs.getInt(1);
			
			if(id == 0) id = Integer.parseInt(product.getCategory1() + product.getCategory2() + "0001");
			else id = id + 1;
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return id;
	}
	
	public int insertProduct(ProductDataBean product) {
		int cnt = 0;
		
		try {
			conn = getConnection();
			String sql = "INSERT INTO product(id, category1, category2, wname, pname, sname, price, downprice, inputdate, stock, img1, img2, img3, description)" + 
						"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(INSERT_PRODUCT);
			pstmt.setInt(1, product.getId());
			pstmt.setString(2, product.getCategory1());
			pstmt.setString(3, product.getCategory2());
			pstmt.setString(4, product.getWname());
			pstmt.setString(5, product.getPname());
			pstmt.setString(6, product.getSname());
			pstmt.setInt(7, product.getPrice());
			pstmt.setInt(8, product.getDownPrice());
			pstmt.setString(9, product.getInputDate());
			pstmt.setInt(10, product.getStock());
			pstmt.setString(11, product.getImg1());
			pstmt.setString(12, product.getImg2());
			pstmt.setString(13, product.getImg3());
			pstmt.setString(14, product.getDescription());
			
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return cnt;
	}
	
	public int updateProduct(ProductDataBean product) {
		int cnt = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(UPDATE_PRODUCT);
			pstmt.setString(1, product.getCategory1());
			pstmt.setString(2, product.getCategory2());
			pstmt.setString(3, product.getWname());
			pstmt.setString(4, product.getPname());
			pstmt.setString(5, product.getSname());
			pstmt.setInt(6, product.getPrice());
			pstmt.setInt(7, product.getDownPrice());
			pstmt.setString(8, product.getInputDate());
			pstmt.setInt(9, product.getStock());
			pstmt.setString(10, product.getImg1());
			pstmt.setString(11, product.getImg2());
			pstmt.setString(12, product.getImg3());
			pstmt.setString(13, product.getDescription());
			pstmt.setInt(14, product.getId());
			
			cnt =pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return cnt;
	}
}
