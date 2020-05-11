package com.common;

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class FakeBlobTest extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static DataSource ds = null; //連線池
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/DA106G5_DB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

//			try {
//				Class.forName(DRIVER_CLASS);
//			} catch (ClassNotFoundException e) {
//				e.printStackTrace();
//				return;
//			}

			// 存圖片到地標資料庫
			String sql_updateLoc = "UPDATE LOCATION SET LOC_PIC = ? WHERE LOC_NO = ?";
			try (Connection connection = ds.getConnection();
					PreparedStatement ps = connection.prepareStatement(sql_updateLoc);) {
				int rowCount = 0;
//				FileInputStream in;
				BufferedInputStream bf;
				// 塞12張假圖
				for (int i = 1; i <= 12; i++) {
					// 共五位數字，不足補0
//					in = new FileInputStream("C:\\Users\\soowi\\git\\DA106G5\\WebContent\\front_end\\loc" + String.format("%05d", i) + ".jpg");
					
					InputStream input = getServletContext().getResourceAsStream("/fake_picture/loc" + String.format("%05d", i) + ".jpg");
					bf = new BufferedInputStream(input);
					
					// 方法1.使用byte陣列setBytes
//				    byte[] image = new byte[bf.available()];//讀入的圖檔,暫存在記憶體
//				    bf.read(image);
//				    ps.setBytes(1, image);

					// 方法2.讀入圖檔後setBinaryStream到DB
					ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB

					ps.setString(2, "loc" + String.format("%05d", i));
					rowCount += ps.executeUpdate();
					bf.close();
					input.close();
				}
				System.out.println(rowCount + " row(s) inserted!!");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			// 存圖片到商品資料庫
			String sql_updatePd = "UPDATE PRODUCT SET PD_PIC = ? WHERE PD_NO = ?";
			try (Connection connection = ds.getConnection();
					PreparedStatement ps = connection.prepareStatement(sql_updatePd);) {
				int rowCount = 0;
//				FileInputStream in;
				BufferedInputStream bf;
				// 塞3張假圖
				for (int i = 1; i <= 60; i++) {
					// 共五位數字，不足補0
//					in = new FileInputStream("WebContent/fake_picture/pd" + String.format("%05d", i) + ".jpg");
					InputStream in = getServletContext().getResourceAsStream("/fake_picture/pd" + String.format("%05d", i) + ".jpg");
					bf = new BufferedInputStream(in);
					// 方法1.使用byte陣列setBytes
//				    byte[] image = new byte[bf.available()];//讀入的圖檔,暫存在記憶體
//				    bf.read(image);
//				    ps.setBytes(1, image);
					
					// 方法2.讀入圖檔後setBinaryStream到DB
					ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
					
					ps.setString(2, "PDN" + String.format("%05d", i));
					rowCount += ps.executeUpdate();
					bf.close();
					in.close();
				}
				System.out.println(rowCount + " row(s) inserted!!");
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 存圖片到資料庫
			String sql_updateWth = "UPDATE Weather SET weather_pic = ? WHERE wth_status = ?";
			try (Connection connection = ds.getConnection();
					PreparedStatement ps = connection.prepareStatement(sql_updateWth);) {
				int rowCount = 0;
				InputStream in;
				BufferedInputStream bf;
				// 不跑回圈塞圖
				// 第一張
				in =getServletContext().getResourceAsStream("/fake_picture/weather00001.png");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "晴");
				rowCount += ps.executeUpdate();
				// 第二張
				in = getServletContext().getResourceAsStream("/fake_picture/weather00002.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "雨");
				rowCount += ps.executeUpdate();
				in = getServletContext().getResourceAsStream("/fake_picture/weather00002.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "晴時多雲偶陣雨");
				rowCount += ps.executeUpdate();
				in = getServletContext().getResourceAsStream("/fake_picture/weather00002.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "颱風");
				rowCount += ps.executeUpdate();
				in = getServletContext().getResourceAsStream("/fake_picture/weather00002.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "陰時多雲短暫陣雨");
				rowCount += ps.executeUpdate();
				// 第三張
				in = getServletContext().getResourceAsStream("/fake_picture/weather00003.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "陰");
				rowCount += ps.executeUpdate();
				in = getServletContext().getResourceAsStream("/fake_picture/weather00003.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "多雲時陰");
				rowCount += ps.executeUpdate();
				in = getServletContext().getResourceAsStream("/fake_picture/weather00003.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "多雲時晴");
				rowCount += ps.executeUpdate();
				in = getServletContext().getResourceAsStream("/fake_picture/weather00003.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "多雲");
				rowCount += ps.executeUpdate();
				in = getServletContext().getResourceAsStream("/fake_picture/weather00003.jpg");
				bf = new BufferedInputStream(in);
				ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
				ps.setString(2, "晴時多雲");
				rowCount += ps.executeUpdate();
				
				System.out.println(rowCount + " row(s) inserted!!");
				bf.close();
				in.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// 8個會員
			String[] mb_id = {"soowii123","xuan123","michael123","vain123","yiwen123","weijhih123","androidlababy520","anjavababy520"};
			
			Connection con = null;
			PreparedStatement pstmt = null;
			InputStream fin = null;
			int count = 0;

			try {

				Class.forName("oracle.jdbc.driver.OracleDriver");
				con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "DA106G5", "DA106G5");
				pstmt = con.prepareStatement("UPDATE MEMBER SET MB_PIC=? WHERE MB_ID = ?");
				// 7張照片
				for(int i = 0; i < 7; i++) {
					
					fin = getServletContext().getResourceAsStream("/fake_picture/mb" + (i+1) + ".jpg"); 
					pstmt.setBinaryStream(1, fin, fin.available());
					pstmt.setString(2, mb_id[i]);
					count += pstmt.executeUpdate();
					
				}
				System.out.println(count + " images inserted!!");

				// Handle any driver errors
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
				// Handle any SQL errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			} catch (IOException e) {
				e.printStackTrace();
				// Clean up JDBC resources
			} finally {
				if(fin != null) {
					try {
						fin.close();
					} catch (IOException e) {
						e.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace(System.err);
					}
				}
			}
			
			// 存圖片到資料庫
			String sql_updatePath = "UPDATE PATH SET PATH_PIC = ? WHERE PATH_NO = ?";
			try (Connection connection = ds.getConnection();
					PreparedStatement ps = connection.prepareStatement(sql_updatePath);) {
				int rowCount = 0;
				InputStream in;
				BufferedInputStream bf;
				// 塞六張假圖
				for (int i = 1; i <= 9; i++) {
					// 共五位數字，不足補0
					in = getServletContext().getResourceAsStream("/fake_picture/p" + String.format("%05d", i) + ".png");
					bf = new BufferedInputStream(in);
					// 方法1.使用byte陣列setBytes
//						    byte[] image = new byte[bf.available()];//讀入的圖檔,暫存在記憶體
//						    bf.read(image);
//						    ps.setBytes(1, image);

					// 方法2.讀入圖檔後setBinaryStream到DB
					ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB

					ps.setString(2, "p" + String.format("%05d", i));
					rowCount += ps.executeUpdate();
					bf.close();
					in.close();
				}
				System.out.println(rowCount + " row(s) inserted!!");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			// 存圖片到資料庫
			String sql_updateLive = "UPDATE LIVE SET LIVE_PIC = ? WHERE LIVE_NO = ?";
			try (Connection connection = ds.getConnection();
					PreparedStatement ps = connection.prepareStatement(sql_updateLive);) {
				int rowCount = 0;
				InputStream in;
				BufferedInputStream bf;
				// 塞六張假圖
				for (int i = 1; i <= 6; i++) {
					// 共五位數字，不足補0
					in = getServletContext().getResourceAsStream("/fake_picture/LIV" + String.format("%05d", i) + ".jpg");
					bf = new BufferedInputStream(in);
					// 方法1.使用byte陣列setBytes
//						    byte[] image = new byte[bf.available()];//讀入的圖檔,暫存在記憶體
//						    bf.read(image);
//						    ps.setBytes(1, image);
					
					// 方法2.讀入圖檔後setBinaryStream到DB
					ps.setBinaryStream(1, bf, bf.available());// 如果不用顯示在使用者裝置直接寫入DB
					
					ps.setString(2, "LIV" + String.format("%05d", i));
					rowCount += ps.executeUpdate();
					bf.close();
					in.close();
				}
				System.out.println(rowCount + " row(s) inserted!!");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
			
		}
}
