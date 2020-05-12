package com.catp.mymember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MymemberDBBean {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//SQL문 정의
	private final String INSERT_MEMBER = "INSERT INTO mymember values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String SELECT_MEMBER = "SELECT * FROM mymember WHERE userid = ?";
	private final String SELECT_ALL_MEMBER = "SELECT  * FROM mymember WHERE userid != 'admin' ORDER BY regdate DESC";
	private final String UPDATE_MEMBER = "UPDATE mymember SET password=?, username=?, email=?, phone=?, zipcode=?, address1=?, address2=? WHERE userid=?";
	private final String DELETE_MEMBER = "DELETE FROM mymember WHERE userid= ?";
	private final String LOGIN_MEMBER = "SELECT * FROM mymember WHERE userid = ? AND password = ?";

		
	//싱글톤 패턴으로 리턴해줄 instance
	private static MymemberDBBean instance = new MymemberDBBean();
	
	//싱글톤 구현을 위해 생성자를 private로 
	private MymemberDBBean() { }
	//싱글톤으로 구현되었으므로, getInstance()메서드로 인스턴스를 리턴해주는 방식
	public static MymemberDBBean getInstance() {
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
	
	//회원 가입 메서드
	public void insertMember(MymemberDataBean member) {
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(INSERT_MEMBER);
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getUsername());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getZipcode());
			pstmt.setString(7, member.getAddress1());
			pstmt.setString(8, member.getAddress2());
			pstmt.setString(9, member.getRegdate());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
	}
	
	public int userIdCheck(MymemberDataBean member) {
		int check = 1; //1이면 중복되지 않는 아이디
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SELECT_MEMBER); //입력한 아이디로 가입된 유저 정보가 있는지 확인
			pstmt.setString(1, member.getUserid());
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //조회결과가 있으면 중복된 아이디임.
				check = 0; //0이면 중복아이디
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return check;
	}
	
	//회원 탈퇴 메서드
	public void deleteMember(MymemberDataBean member) {
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("DELETE FROM mymember WHERE userid= ?");
			pstmt.setString(1, member.getUserid());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
	}
	
	//회원 정보 수정 메서드
	public void updateMember(MymemberDataBean member) {
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(UPDATE_MEMBER);
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getUsername());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getZipcode());
			pstmt.setString(6, member.getAddress1());
			pstmt.setString(7, member.getAddress2());
			pstmt.setString(8, member.getUserid());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
	}
	
	//로그인용 회원정보 조회
	public MymemberDataBean login(MymemberDataBean member) {
		MymemberDataBean memberData = new MymemberDataBean();
		try {
			conn = getConnection();
			//입력한 아이디와 패스워드로 가입된 유저정보가 있는지 DB에 조회
			pstmt = conn.prepareStatement("SELECT * FROM mymember WHERE userid = ? AND password = ?");
			
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, member.getPassword());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberData.setUserid(rs.getString("userid"));
				memberData.setPassword(rs.getString("password"));
				memberData.setUsername(rs.getString("username"));
				memberData.setEmail(rs.getString("email"));
				memberData.setPhone(rs.getString("phone"));
				memberData.setZipcode(rs.getString("zipcode"));
				memberData.setAddress1(rs.getString("address1"));
				memberData.setAddress2(rs.getString("address2"));
				memberData.setRegdate(rs.getString("regdate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return memberData;
	}
	
	//회원 정보조회 메서드(한명)
	public MymemberDataBean selectMember(MymemberDataBean member) {
		MymemberDataBean memberData = new MymemberDataBean();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM mymember WHERE userid = ?");
			pstmt.setString(1, member.getUserid());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberData.setUserid(rs.getString("userid"));
				memberData.setPassword(rs.getString("password"));
				memberData.setUsername(rs.getString("username"));
				memberData.setEmail(rs.getString("email"));
				memberData.setPhone(rs.getString("phone"));
				memberData.setZipcode(rs.getString("zipcode"));
				memberData.setAddress1(rs.getString("address1"));
				memberData.setAddress2(rs.getString("address2"));
				memberData.setRegdate(rs.getString("regdate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return memberData;
	}
	
	//전체 회원 조회 (관리자메서드)
	public List<MymemberDataBean> selectAllMember() {
		List<MymemberDataBean> memberList = new ArrayList<MymemberDataBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT  * FROM mymember WHERE userid != 'admin' ORDER BY regdate DESC");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MymemberDataBean memberData = new MymemberDataBean();
				memberData.setUserid(rs.getString("userid"));
				memberData.setPassword(rs.getString("password"));
				memberData.setUsername(rs.getString("username"));
				memberData.setEmail(rs.getString("email"));
				memberData.setPhone(rs.getString("phone"));
				memberData.setZipcode(rs.getString("zipcode"));
				memberData.setAddress1(rs.getString("address1"));
				memberData.setAddress2(rs.getString("address2"));
				memberData.setRegdate(rs.getString("regdate"));
				
				memberList.add(memberData);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return memberList;
	}
	
}
