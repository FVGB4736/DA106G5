package com.orders.model;

import java.util.*;

import com.od_detail.model.Od_detailDAO;
import com.od_detail.model.Od_detailVO;

import java.sql.*;

public class OrdersDAO implements OrdersDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:49161:xe";
	String userid = "DA106G5";
	String passwd = "DA106G5";

	private static final String INSERT_STMT = "Insert into ORDERS(OD_NO, MB_ID, OD_TOTALPRICE, OD_ADD) values(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(orders_seq.NEXTVAL), 6, '0'),?,?,?)";
	private static final String GET_ALL_STMT = "SELECT  OD_NO, MB_ID, OD_TIME, OD_STATUS, OD_TOTALPRICE, CP_NO, OD_DISCOUNT, OD_ADD  FROM Orders order by OD_TIME DESC ";
	private static final String GET_ONE_STMT = "SELECT * FROM Orders where OD_NO = ?";
	private static final String USE_MB_ID_SEARCH_ORDERS = "SELECT * FROM Orders where mb_id = ?";
	private static final String DELETE = "DELETE FROM ORDERS where od_no = ?";
	private static final String UPDATE = "UPDATE orders set MB_ID = ?, OD_TOTALPRICE = ?, OD_ADD = ? where OD_NO = ?";

	@Override
	public OrdersVO addOrders(OrdersVO ordersVO) {
		System.out.println("進入DAO");
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String cols[] = { "OD_NO" };
			pstmt = con.prepareStatement(INSERT_STMT, cols);

			pstmt.setString(1, ordersVO.getMb_id());
			pstmt.setInt(2, ordersVO.getOd_totalPrice());
			pstmt.setString(3, ordersVO.getOd_add());

			pstmt.executeUpdate();

			// 掘取對應的自增主鍵值
			ResultSet rs = pstmt.getGeneratedKeys();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			if (rs.next()) {
				do {
					for (int i = 1; i <= columnCount; i++) {
						String key = rs.getString(i);
						System.out.println("自增主鍵值(" + i + ") = " + key + "(剛新增成功的訂單編號)");
					}
				} while (rs.next());
			} else {
				System.out.println("NO KEYS WERE GENERATED.");
			}
			rs.close();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
		return ordersVO;
	}

	@Override
	public int updateOrdersInformation(OrdersVO ordersVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, ordersVO.getMb_id());
			pstmt.setInt(2, ordersVO.getOd_totalPrice());
			pstmt.setString(3, ordersVO.getOd_add());
			pstmt.setString(4, ordersVO.getOd_no());

			updateCount = pstmt.executeUpdate();

			System.out.println("修改訂單資料");
			System.out.println("");
			System.out.println("輸入該訂單編號：" + ordersVO.getMb_id());

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
		return updateCount;
	}

	@Override
	public int deleteOrders(String od_no) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, od_no);

			updateCount = pstmt.executeUpdate();

			System.out.println("輸入該訂單編號：" + od_no);

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
		return updateCount;
	}

	@Override
	public OrdersVO searchOneOrders(String od_no) {

		OrdersVO ordersVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, od_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				ordersVO = new OrdersVO();
				ordersVO.setOd_no(rs.getString("od_no"));
				ordersVO.setMb_id(rs.getString("mb_id"));
				ordersVO.setOd_time(rs.getTimestamp("od_time"));
				ordersVO.setOd_status(rs.getInt("od_status"));
				ordersVO.setOd_totalPrice(rs.getInt("od_totalPrice"));
				ordersVO.setCp_no(rs.getString("cp_no"));
				ordersVO.setOd_add(rs.getString("od_add"));

			}
			System.out.println("輸入查詢的號碼為：" + od_no);
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
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
		return ordersVO;
	}

	@Override
	public List<OrdersVO> getAll() {
		List<OrdersVO> list = new ArrayList<OrdersVO>();
		OrdersVO ordersVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				ordersVO = new OrdersVO();
				ordersVO.setOd_no(rs.getString("od_no"));
				ordersVO.setMb_id(rs.getString("mb_id"));
				ordersVO.setOd_status(rs.getInt("od_status"));
				ordersVO.setOd_totalPrice(rs.getInt("od_totalprice"));
				ordersVO.setOd_add(rs.getString("od_add"));
				ordersVO.setOd_time(rs.getTimestamp("od_time"));
				ordersVO.setCp_no(rs.getString("cp_no"));
				ordersVO.setOd_add(rs.getString("od_add"));
				list.add(ordersVO); // Store the row in the vector

//				System.out.print("訂單編號：" + ordersVO.getOd_no() + ",");
//				System.out.print("會員帳號：" + ordersVO.getMb_id() + ",");
//				System.out.println("訂單產生時間：" + ordersVO.getOd_time() + ",");
//				System.out.println("訂單狀態：" + ordersVO.getOd_status() + ",");
//				System.out.print("訂單總金額：" + ordersVO.getOd_totalPrice() + ",");
//				System.out.println("優貨券編號：" + ordersVO.getCp_no());
//				System.out.print("收貨地址：" + ordersVO.getOd_add() + ",");

			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
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
		return list;
	}

	public String addOrdersWithPd_detail(OrdersVO ordersVO, List<Od_detailVO> list) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String test_no = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);

			System.out.println("經過DAO");

			// 先新增訂單編號
			String cols[] = { "od_no" };
			pstmt = con.prepareStatement(INSERT_STMT, cols);
			pstmt.setString(1, ordersVO.getMb_id());
			pstmt.setInt(2, ordersVO.getOd_totalPrice());
			pstmt.setString(3, ordersVO.getOd_add());
			pstmt.executeUpdate();
			// 掘取對應的自增主鍵值
			String next_od_no = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_od_no = rs.getString(1);
				test_no = next_od_no;
				System.out.println("自增主鍵值= " + next_od_no + "(剛新增成功的訂單編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}

			rs.close();
			// 在同時新增訂單明細
			Od_detailDAO dao = new Od_detailDAO();
			for (Od_detailVO aOd_detail : list) {
				aOd_detail.setOd_no(next_od_no);
				dao.addOd_detail2(aOd_detail, con);
			}

			// 設定於pstmt.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("list.size()-B=" + list.size());
			System.out.println("新增訂單" + next_od_no + "時,共有訂單明細" + list.size() + "筆同時被新增");

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-dept");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
		return test_no;
	}

	public List<OrdersVO> searchMemberOrders(String mb_id) {
		List<OrdersVO> list = new ArrayList<OrdersVO>();
		OrdersVO ordersVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(USE_MB_ID_SEARCH_ORDERS);
			pstmt.setString(1, mb_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ordersVO = new OrdersVO();
				ordersVO.setOd_no(rs.getString("od_no"));
				ordersVO.setMb_id(rs.getString("mb_id"));
				ordersVO.setOd_time(rs.getTimestamp("od_time"));
				ordersVO.setOd_status(rs.getInt("od_status"));
				ordersVO.setOd_totalPrice(rs.getInt("od_totalPrice"));
				ordersVO.setCp_no(rs.getString("cp_no"));
				ordersVO.setOd_discount(rs.getInt("od_discount"));
				ordersVO.setOd_add(rs.getString("od_add"));
				list.add(ordersVO);
			}

		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
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
		return list;
	}

	public static void main(String[] args) {

		OrdersDAO dao = new OrdersDAO();

		// 新增，新增商品訂單
//		OrdersVO ordersVO1 = new OrdersVO();
//		ordersVO1.setMb_id("soowii123");
//		ordersVO1.setOd_totalPrice(20000);
//		ordersVO1.setOd_add("中壢喔");		
//		dao.addOrders(ordersVO1);
//		System.out.println("訂單新增資料");
//				

		// 修改，用訂單編號，修改該訂單資料
//		OrdersVO ordersVO2 = new OrdersVO();
//		ordersVO2.setOd_no("20200408-000017");
//		ordersVO2.setMb_id("soowii123");
//		ordersVO2.setOd_totalPrice(100000);
//		ordersVO2.setOd_add("XXX");
//		 int updateCount_update = dao.updateOrdersInformation(ordersVO2);
//		 if(updateCount_update == 1) {
//			 System.out.println("修改後訂單資料");
//			 System.out.println("會員帳號："+ordersVO2.getMb_id());
//			 System.out.println("訂單總金額："+ordersVO2.getOd_totalPrice());
//			 System.out.println("收貨地址："+ordersVO2.getOd_add());
//		 }

		// 刪除，用訂單編號刪除該訂單
//		 int updateCount_delete = dao.deleteOrders("20200408-000018");
//		 System.out.println("");
//		 if(updateCount_delete==1) {
//			 System.out.println("該訂單資料已經刪除");
//		 }

		// 查詢，用訂單編號查詢該訂單資料
//		OrdersVO ordersVO3 = dao.searchOneOrders("20200329-000020");
//		System.out.println("會員帳號："+ordersVO3.getMb_id());
//		System.out.println("訂單狀態："+ordersVO3.getOd_status());
//		System.out.println("訂單總金額："+ordersVO3.getOd_totalPrice());
//		System.out.println("優惠券編號："+ordersVO3.getCp_no());
//		System.out.println("收貨地址："+ordersVO3.getOd_add());
//		System.out.println("訂單產生時間："+ordersVO3.getOd_time());
//		System.out.println("");
//		System.out.println("---------------------");

//		// 查詢，查詢資料庫全部訂單
//		List<OrdersVO> list = dao.getAll();
//		System.out.println("資料庫全部訂單查詢");
//		System.out.println("");
//		for (OrdersVO aOrdersVO : list) {
//			System.out.print("訂單編號：" + aOrdersVO.getOd_no() + ",");
//			System.out.print("會員帳號：" + aOrdersVO.getMb_id() + ",");
//			System.out.print("訂單產生時間：" + aOrdersVO.getOd_time() +",");
//			System.out.print("訂單狀態：" + aOrdersVO.getOd_status() + ",");
//			System.out.print("訂單總金額：" + aOrdersVO.getOd_totalPrice() + ",");
//			System.out.print("優貨券編號：" + aOrdersVO.getCp_no());
//			System.out.println("收貨地址：" + aOrdersVO.getOd_add());
//			
//		}

		// 新增訂單與訂單編號(同時)

//		OrdersVO ordersVO = new OrdersVO();
//		ordersVO.setMb_id("soowii123");
//		ordersVO.setOd_totalPrice(1000);
//		ordersVO.setOd_add("收穫地址");
//		
//		List<Od_detailVO> testList = new ArrayList<Od_detailVO>();
//		Od_detailVO od_detailVO = new Od_detailVO();
//		od_detailVO.setPd_no("PDN00003");
//		od_detailVO.setOd_price(2);
//		od_detailVO.setOd_amount(1);
//		
//		Od_detailVO od_detailVO1 = new Od_detailVO();
//		od_detailVO1.setPd_no("PDN00004");
//		od_detailVO1.setOd_price(4);
//		od_detailVO1.setOd_amount(3);
//		testList.add(od_detailVO);
//		testList.add(od_detailVO1);
//        dao.addOrdersWithPd_detail(ordersVO, testList);

		// 用會員搜尋該會員所有訂單編號

		List<OrdersVO> list = dao.searchMemberOrders("michael123");
		             
		  for(OrdersVO aOrdersVO : list) {
			  System.out.println(aOrdersVO.getOd_no());
		  }
	}
}