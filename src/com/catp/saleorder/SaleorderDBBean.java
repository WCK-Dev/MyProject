package com.catp.saleorder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.catp.mymember.MymemberDataBean;

public class SaleorderDBBean {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//SQL문 정의
	private final String SELECT_ORDER_LIST ="SELECT * FROM saleorder WHERE userid= ? order by id desc";
		
	//싱글톤 패턴으로 리턴해줄 instance
	private SaleorderDBBean() { }
	private static SaleorderDBBean instance = new SaleorderDBBean();
	public static SaleorderDBBean getInstance() {
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
	
	//주문 목록 조회 메서드
	public List<SaleorderDataBean> selectOrderList(MymemberDataBean member) {
		List<SaleorderDataBean> orderList = new ArrayList<SaleorderDataBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SELECT_ORDER_LIST);
			pstmt.setString(1, member.getUserid());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SaleorderDataBean order = new SaleorderDataBean();
				order.setId(rs.getInt("id"));
				order.setUserid(rs.getString("userid"));
				order.setName(rs.getString("name"));
				order.setOrderdate(rs.getString("orderdate"));
				order.setAddress(rs.getString("address"));
				order.setTel(rs.getString("tel"));
				order.setPay(rs.getString("pay"));
				order.setCardno(rs.getString("cardno"));
				order.setProductcount(rs.getInt("productcount"));
				order.setTotal(rs.getInt("total"));
				
				orderList.add(order);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return orderList;
	}
	
}
