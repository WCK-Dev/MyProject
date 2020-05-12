package com.catp.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.catp.freeboard.FreeboardDBBean;

public class CartDBBean {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//SQL문 정의
		
		
	//싱글톤 패턴으로 리턴해줄 instance
	private CartDBBean() { }
	private static CartDBBean instance = new CartDBBean();
	public static CartDBBean getInstance() { return instance; }
	
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
}
