package cn.edu.cuit.tsmgr.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class MysqlTool {
	private static ComboPooledDataSource dataSource = null;
	
	private static ThreadLocal<Connection> tl = new ThreadLocal<Connection>();
	
	static {
		try {
			dataSource = new ComboPooledDataSource();
			dataSource.setUser("root");
			dataSource.setPassword("root");
			dataSource.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/tsmgr?useUnicode=true&characterEncoding=utf-8");
			dataSource.setDriverClass("com.mysql.jdbc.Driver");
			dataSource.setInitialPoolSize(1);
			dataSource.setAcquireIncrement(1);
			dataSource.setMinPoolSize(1);
			dataSource.setMaxPoolSize(10);
			dataSource.setMaxStatements(50);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public static DataSource getDataSource(){
		return dataSource;
	}
	
	public static Connection getConnection(){
		Connection conn = tl.get();
		try {
			if(conn == null){
				conn = dataSource.getConnection();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tl.set(conn);
		return conn;
	}
	
	/**
	 * 开始事务
	 * @throws SQLException
	 */
	public static void startTransaction(){
		Connection conn = getConnection();
		try {
			conn.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 回滚事务
	 * @throws SQLException
	 */
	public static void rollback(){
		Connection conn = getConnection();
		try {
			conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 提交事务
	 * @throws SQLException
	 */
	public static void commit(){
		Connection conn = getConnection();
		try {
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 关闭Connection,并移除线程中的连接
	 * @throws SQLException
	 */
	public static void closeConnection(){
		close(getConnection());
		tl.remove();
	}
	
	public static void close(Connection conn){
		try {
			if(conn != null){
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Statement stm){
		try {
			if(stm != null){
				stm.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(ResultSet rs){
		try {
			if(rs != null){
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
