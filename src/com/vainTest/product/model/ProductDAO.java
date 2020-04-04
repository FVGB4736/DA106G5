package com.vainTest.product.model;

import java.util.*;
import java.util.Map.Entry;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.*;

public class ProductDAO implements ProductDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:49161:xe";
	String userid = "DA106G5";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO product (pd_no, pd_name, pd_price, pd_detail, pd_typeno) VALUES ('PDN'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 5, '0'), ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT pd_no,pd_name,pd_price,pd_detail,pd_typeno, pd_status FROM product order by pd_no";
	private static final String GET_ONE_STMT = "SELECT pd_no,pd_name,pd_price,pd_typeno, pd_status FROM product where pd_no = ?";
	private static final String DELETE = "DELETE FROM product where pd_no = ?";
	private static final String UPDATE = "UPDATE product set pd_name=?, pd_price=?, pd_detail=?, pd_typeno=?where pd_no = ?";
	private static final String CHANGE_STATUS = "update product set pd_status = ? where pd_no = ?";
	private static final String TYPE_SEARCH = "select pd_no, pd_name from product where pd_typeno = ?";
	private static final String UPDATE_PIC = "UPDATE product SET pd_PIC = ? WHERE pd_NO = ?";

	@Override
	public int addProduct(ProductVO productVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String cols[] = { "pd_no" };

			pstmt = con.prepareStatement(INSERT_STMT, cols);
			pstmt.setString(1, productVO.getPd_name());
			pstmt.setInt(2, productVO.getPd_price());
			pstmt.setString(3, productVO.getPd_detail());
			pstmt.setString(4, productVO.getPd_typeNo());
			

			updateCount = pstmt.executeUpdate();

			// 掘取對應的自增主鍵值
			ResultSet rs = pstmt.getGeneratedKeys();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			if (rs.next()) {
				do {
					for (int i = 1; i <= columnCount; i++) {
						String key = rs.getString(i);
						System.out.println("自增主鍵值(" + i + ") = " + key + "(剛新增成功的商品編號)");
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
		} 
		finally {
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
	public int updateProductInformation(ProductVO productVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, productVO.getPd_name());
			pstmt.setInt(2, productVO.getPd_price());
			pstmt.setString(3, productVO.getPd_detail());
			pstmt.setString(4, productVO.getPd_typeNo());
			pstmt.setString(5, productVO.getPd_no());

			updateCount = pstmt.executeUpdate();

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
	public int deleteProduct(String pd_no) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, pd_no);

			updateCount = pstmt.executeUpdate();

			System.out.println("刪除編號" + pd_no + "商品");

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
	public ProductVO findOneProduct(String pd_no) {

		ProductVO productVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, pd_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				productVO = new ProductVO();
				productVO.setPd_no(rs.getString("pd_no"));
				productVO.setPd_name(rs.getString("pd_name"));
				productVO.setPd_price(rs.getInt("pd_price"));
				productVO.setPd_typeNo(rs.getString("pd_typeNo"));
				productVO.setPd_status(rs.getInt("pd_status"));
			}

			System.out.println("查詢商品：" + pd_no);

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
		return productVO;
	}

	@Override
	public List<ProductVO> getAll() {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;

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
				productVO = new ProductVO();
				productVO.setPd_no(rs.getString("pd_no"));
				productVO.setPd_name(rs.getString("pd_name"));
				productVO.setPd_price(rs.getInt("pd_price"));
				productVO.setPd_detail(rs.getString("pd_detail"));
				productVO.setPd_typeNo(rs.getString("pd_typeno"));
				productVO.setPd_status(rs.getInt("pd_status"));
				list.add(productVO); // Store the row in the vector
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

	@Override
	public int changeStatus(ProductVO productVO) {
		int updateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(CHANGE_STATUS);

			pstmt.setInt(1, productVO.getPd_status());
			pstmt.setString(2, productVO.getPd_no());

			updateCount = pstmt.executeUpdate();
			if (productVO.getPd_status() == 2) {
				System.out.println("商品編號：" + productVO.getPd_no() + "已經'上架'。");
			} else if (productVO.getPd_status() == 1) {
				System.out.println("商品編號：" + productVO.getPd_no() + "已經'下架'。");
			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return updateCount;
	}

	public List<ProductVO> useTypeSearchProducts(String pd_typeNo) {

		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(TYPE_SEARCH);
			pstmt.setString(1, pd_typeNo);
			rs = pstmt.executeQuery();
			System.out.println("搜尋的類別編號：" + pd_typeNo);
			while (rs.next()) {
				productVO = new ProductVO();
				productVO.setPd_no(rs.getString("pd_no"));
				productVO.setPd_name(rs.getString("pd_name"));
				list.add(productVO);

			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		}

		return list;

	}

	@Override
	public List<ProductVO> getAll(Map<String, String[]> map) {
		StringBuilder sb = new StringBuilder();

		List<ProductVO> list_map = new ArrayList<ProductVO>();
		ProductVO productVO = null;

		Connection con = null;
		PreparedStatement pstmt_map = null;
		ResultSet rs_map = null;

		sb.append("SELECT * FROM product where ");
		for (Entry<String, String[]> entry : map.entrySet()) {
			sb.append("(");
			for (int i = 0; i < entry.getValue().length; i++) {
				if (i == 0) {
					sb.append(entry.getKey() + " = " + entry.getValue()[i]);
				} else {
					sb.append(" OR " + entry.getKey() + " = " + entry.getValue()[i]);
				}
			}
			sb.append(") and ");
		}
		sb.append(" 1=1 ");

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt_map = con.prepareStatement(sb.toString());
			rs_map = pstmt_map.executeQuery();
			while (rs_map.next()) {
				// empVO 也稱為 Domain objects
				productVO = new ProductVO();
				// WEATHER_TIME, WEATHER_PLACE, WTH_STATUS, WTH_HIGH, WTH_LOW, WTH_COMFORT,
				// WTH_RAIN_CHANCE
				productVO.setPd_no(rs_map.getString("pd_no"));
				productVO.setPd_name(rs_map.getNString("pd_name"));
				productVO.setPd_price(rs_map.getInt("pd_price"));
				productVO.setPd_detail(rs_map.getString("pd_detail"));
				productVO.setPd_status(rs_map.getInt("pd_status"));
				productVO.setPd_typeNo(rs_map.getString("pd_typeNo"));

				list_map.add(productVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs_map != null) {
				try {
					rs_map.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt_map != null) {
				try {
					pstmt_map.close();
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
		return list_map;
	}

	public int updatePic(String pd_no, String pic_path) {
		int updateCount = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_PIC);

			FileInputStream in = new FileInputStream(pic_path);
			BufferedInputStream bf = new BufferedInputStream(in);
			byte[] image = new byte[bf.available()];
			bf.read(image);

			pstmt.setString(2, pd_no);
			pstmt.setBytes(1, image);
			updateCount = pstmt.executeUpdate();
			bf.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}

		return updateCount;

	}

	public static void main(String[] args) {

		ProductDAO dao = new ProductDAO();

		// 新增
//		ProductVO productVO1 = new ProductVO();
//		productVO1.setPd_name("ccccc");
//		productVO1.setPd_price(50000);
//		productVO1.setPd_detail("XXXXXX");
//		productVO1.setPd_typeNo("PTN00003");
//		int updateCount_insert = dao.addProduct(productVO1);
//		System.out.println("商品資料庫新增" + updateCount_insert + "筆商品資料");
//		System.out.println("商品名稱：" + productVO1.getPd_name() + " " + "商品價格：" + productVO1.getPd_price() + " " + "商品詳述："
//				+ productVO1.getPd_detail() + " " + "商品類型：" + productVO1.getPd_typeNo());

//		 修改
		 ProductVO productVO2 = new ProductVO();	
		 productVO2.setPd_no("PDN00222");
		 productVO2.setPd_name("測試用球鞋");
		 productVO2.setPd_price(1111111);
		 productVO2.setPd_detail("XXXXXX");
		 productVO2.setPd_typeNo("PTN00003");
		
		 int updateCount_update = dao.updateProductInformation(productVO2);
		 System.out.println("更新"+updateCount_update+"筆商品資料");		
		 System.out.println("商品編號"+productVO2.getPd_no()+"更新內容");
		 System.out.println("商品名稱："+productVO2.getPd_name());
		 System.out.println("商品價格："+productVO2.getPd_price());
		 System.out.println("商品詳述："+productVO2.getPd_detail());
		 System.out.println("商品分類："+productVO2.getPd_typeNo());

		// 刪除（此功能僅刪除未成立訂單明細之商品）

//		 int updateCount_delete = dao.deleteProduct("PDN00011");
//		  System.out.println("");
//		  if(updateCount_delete ==1) {
//			  System.out.println("刪除成功");
//		  }

		// 查詢單一商品
//      System.out.println("-----查詢單一商品-----");
//      System.out.println("");
//		ProductVO productVO3 = dao.findOneProduct("PDN00002");
//		System.out.println("商品名稱："+productVO3.getPd_name());
//		System.out.println("商品價格："+productVO3.getPd_price());
//		System.out.println("商品類型："+productVO3.getPd_typeNo());
//		System.out.println("商品狀態："+productVO3.getPd_status());

		// 修改物品狀態
//		ProductVO productVO4 = new ProductVO();
//		productVO4.setPd_status(2);
//		productVO4.setPd_no("PDN00002");
//		int updateCount = dao.changeStatus(productVO4);
//		if(updateCount==1) {
//			System.out.println("商品狀態修改成功");
//		}

		// 用分類搜尋，列出商品編號、商品名稱。
//		List<ProductVO> list1 = dao.useTypeSearchProducts("PTN00005");		
//		for(ProductVO aproductVO : list1) {
//			System.out.print("商品編號："+aproductVO.getPd_no()+" ");
//			System.out.print("商品名稱："+aproductVO.getPd_name()+" ");
//			System.out.println("");
//		}
//	
		// 查詢 所有商品
//		System.out.println("-----列出所有商品-----");
//		System.out.println("");
//		List<ProductVO> list = dao.getAll();
//		for (ProductVO aProductVO : list) {
//			System.out.print("商品編號：" + aProductVO.getPd_no() + " ");
//			System.out.print("商品名稱：" + aProductVO.getPd_name() + " ");
//			System.out.print("商品價格：" + aProductVO.getPd_price() + " ");
//			System.out.print("商品詳述：" + aProductVO.getPd_detail() + " ");
//			System.out.print("商品類別：" + aProductVO.getPd_typeNo() + " ");
//			System.out.println("商品狀態：" + aProductVO.getPd_status());
//			System.out.println();
//		}

		// 上傳圖片單一圖片
//		int updateCount = dao.updatePic("PDN00002","items/pic.jpg"); //輸入產品編號、圖片路徑。
//             
//		 if(updateCount == 1) {
//			 System.out.println("ok");
//		 }

		// 萬用複合查詢，需修正
//		Map<String, String[]> map = new HashMap<>();
//		map.put("pd_no", new String[] { "'pdn00001'" });
//		
//		System.out.println("getAll(map)：");
//		List<ProductVO> all_map = dao.getAll(map);
//		for (ProductVO aProductVO : all_map) {
//			System.out.println(aProductVO.getPd_price());
//		}

	}

}