package DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBManager {
	/**
	 * 설명: 오라클 접속 메소드
	 * @return Connection객체 -> 오라클 접속 클래스 객체
	 */
	public static Connection getDBConnection() {
		Connection conn = null;
		try {
			// JDBC 드라이버 등록
			Class.forName("oracle.jdbc.OracleDriver");
			// 등록된 드라이버를 실제 Connection 클래스 변수에 연결
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@1.220.247.78:1522/orcl",
					"tmini_2410_team1",
					"1234"
			);
			System.out.println("Oracle DB 접속 성공");
		} catch(Exception e) {
			e.printStackTrace();
			System.err.println("Oracle DB 접속 에러");
		}
		
		return conn;
	}
	
	public static void dbClose(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		// DB입출력 자원 정리
		try {
			if(rs != null) {
				rs.close();
			}
			
			if(pstmt != null) {
				pstmt.close();
			}
			
			if (conn != null) {
				conn.close();
			}
		} catch(SQLException se) {
			System.err.println("Oracle DB IO 오류 -> " + se.getMessage());
		}
	}
}
