package com.catp.freeboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FreeboardDBBean {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//SQL문 정의
	private final String GET_MAX_ID = "SELECT max(id) FROM freeboard";
	private final String GET_TOTAL_BOARD_LIST = "SELECT * FROM freeboard WHERE id = masterid";
	private final String GET_BOARD_LIST = "SELECT * FROM freeboard WHERE id = masterid ORDER BY id desc limit ?, ?";
	private final String GET_REPLY_LIST = "SELECT * FROM freeboard WHERE masterid = ? AND id != ? ORDER BY inputdate";
	private final String INSERT_BOARD = "INSERT INTO freeboard(id, name, password, email, subject, content, inputdate, masterid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private final String GET_BOARD = "SELECT * FROM freeboard WHERE id = ?";
	private final String UPDATE_READ_COUNT = "UPDATE freeboard SET readcount = readcount+1 WHERE id=?";
	private final String UPDATE_BOARD = "UPDATE freeboard SET name=?, email=?, subject=?, content=? WHERE id=? AND password = ?";
	private final String REPLY_WRITE = "INSERT INTO freeboard(id, name, password, content, inputdate, masterid) VALUES (?, ?, ?, ?, ?, ?)";
	private final String DELETE_BOARD = "DELETE FROM freeboard WHERE id = ? AND password = ?";
	private final String DELETE_REPLY = "DELETE FROM freeboard WHERE masterid = ?";
	
		
	//싱글톤 패턴으로 리턴해줄 instance
	private FreeboardDBBean() { }
	private static FreeboardDBBean instance = new FreeboardDBBean();
	public static FreeboardDBBean getInstance() { return instance; }
	
	// CP를 통해 커넥션을 획득하는 메서드
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/myproject");
		
		return ds.getConnection();
	}
	
	//DB Connection close() 메서드
	private void close(Connection conn, Statement stmt, ResultSet rs) {
		if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();};
		if(stmt != null) try {stmt.close();} catch(Exception e) {e.printStackTrace();};
		if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();};
	}
	
	//전체 원글 획득 메서드 (원글수 확인)
	public int getBoardListCnt() {
		List<FreeboardDataBean> boardList = new ArrayList<>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(GET_TOTAL_BOARD_LIST);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FreeboardDataBean board = new FreeboardDataBean();
				board.setId(rs.getInt("id"));
				board.setName(rs.getString("name"));
				board.setPassword(rs.getString("password"));
				board.setEmail(rs.getString("email"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setInputDate(rs.getString("inputdate"));
				board.setMasterId(rs.getInt("masterid"));
				board.setReadCount(rs.getInt("readcount"));
				board.setReplyNum(rs.getInt("replynum"));
				board.setStep(rs.getInt("step"));
				
				boardList.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return boardList.size();
	}
	
	//페이징 된 게시글 목록 획득
	public List<FreeboardDataBean> getBoardList(int startRow, int pageSize) {
		List<FreeboardDataBean> boardList = new ArrayList<>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM freeboard WHERE id = masterid ORDER BY id desc limit ?, ?");
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FreeboardDataBean board = new FreeboardDataBean();
				board.setId(rs.getInt("id"));
				board.setName(rs.getString("name"));
				board.setPassword(rs.getString("password"));
				board.setEmail(rs.getString("email"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setInputDate(rs.getString("inputdate"));
				board.setMasterId(rs.getInt("masterid"));
				board.setReadCount(rs.getInt("readcount"));
				board.setReplyNum(rs.getInt("replynum"));
				board.setStep(rs.getInt("step"));
				
				boardList.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return boardList;
	}
	
	//답글목록 획득 메서드
	public List<FreeboardDataBean> getReplyList(FreeboardDataBean board) {
		List<FreeboardDataBean> replyList = new ArrayList<>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(GET_REPLY_LIST);
			pstmt.setInt(1, board.getId());
			pstmt.setInt(2, board.getId());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FreeboardDataBean reply = new FreeboardDataBean();
				reply.setId(rs.getInt("id"));
				reply.setName(rs.getString("name"));
				reply.setPassword(rs.getString("password"));
				reply.setEmail(rs.getString("email"));
				reply.setSubject(rs.getString("subject"));
				reply.setContent(rs.getString("content"));
				reply.setInputDate(rs.getString("inputdate"));
				reply.setMasterId(rs.getInt("masterid"));
				reply.setReadCount(rs.getInt("readcount"));
				reply.setReplyNum(rs.getInt("replynum"));
				reply.setStep(rs.getInt("step"));
				
				replyList.add(reply);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return replyList;
	}
	
	//새글 작성 메서드
	public int insertBoard(FreeboardDataBean board) {
		int check = 0;
		int maxid = 1; 
		
		java.util.Date nowdate = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
		String ymd = sdf.format(nowdate);
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(GET_MAX_ID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				maxid = rs.getInt(1);
			}
			
			pstmt = conn.prepareStatement(INSERT_BOARD);
			pstmt.setInt(1, maxid + 1);
			pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getPassword());
			pstmt.setString(4, board.getEmail());
			pstmt.setString(5, board.getSubject());
			pstmt.setString(6, board.getContent());
			pstmt.setString(7, ymd);
			pstmt.setInt(8, maxid + 1);
			
			check = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return check;
	}
	
	//글 내용 조회 메서드
	public FreeboardDataBean getBoard(FreeboardDataBean board) {
		FreeboardDataBean getBoard = new FreeboardDataBean();
		
		try {
			conn = getConnection();
			
			
			pstmt = conn.prepareStatement("SELECT * FROM freeboard WHERE id = ?");
			pstmt.setInt(1, board.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				getBoard.setId(rs.getInt("id"));
				getBoard.setName(rs.getString("name"));
				getBoard.setPassword(rs.getString("password"));
				getBoard.setEmail(rs.getString("email"));
				getBoard.setSubject(rs.getString("subject"));
				getBoard.setContent(rs.getString("content"));
				getBoard.setInputDate(rs.getString("inputdate"));
				getBoard.setMasterId(rs.getInt("masterid"));
				getBoard.setReadCount(rs.getInt("readcount")+1);
				getBoard.setReplyNum(rs.getInt("replynum"));
				getBoard.setStep(rs.getInt("step"));
			}
			
			pstmt = conn.prepareStatement("UPDATE freeboard SET readcount = readcount+1 WHERE id=?");
			pstmt.setInt(1, board.getId());
			pstmt.executeUpdate(); //글목록을 조회한후, 조회시마다 1씩 조회수 증가
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return  getBoard;
	}
	
	//댓글 작성 메서드
	public int replyWrite(FreeboardDataBean reply) {
		int check = 0;
		int maxid = 1; 
		
		java.util.Date nowdate = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
		String ymd = sdf.format(nowdate);
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(GET_MAX_ID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				maxid = rs.getInt(1);
			}
			
			pstmt = conn.prepareStatement(REPLY_WRITE);
			pstmt.setInt(1, maxid + 1);
			pstmt.setString(2, reply.getName());
			pstmt.setString(3, reply.getPassword());
			pstmt.setString(4, reply.getContent());
			pstmt.setString(5, ymd);
			pstmt.setInt(6, reply.getMasterId());
			
			check = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return check;
	}
	//글 수정 메서드
	public int updateBoard(FreeboardDataBean board) {
		int cnt = 0;
		
		try {conn = getConnection();
			String sql = "UPDATE freeboard SET name=?, email=?, subject=?, content=? WHERE id=? AND password = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getId());
			pstmt.setString(6, board.getPassword());
			
			cnt = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return cnt;
	}
	
	//글 삭제 메서드
	public int deleteBoard(FreeboardDataBean board) {
		int check = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("DELETE FROM freeboard WHERE id = ? AND password = ?");
			pstmt.setInt(1, board.getId());
			pstmt.setString(2, board.getPassword());
			check = pstmt.executeUpdate();
			
			if(check != 0) {
				pstmt = conn.prepareStatement("DELETE FROM freeboard WHERE masterid = ?");
				pstmt.setInt(1, board.getId());
				pstmt.executeUpdate();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return check;
	}
	
	
}
