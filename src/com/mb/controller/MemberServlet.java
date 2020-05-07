package com.mb.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONObject;

import com.common.MailService;
import com.mb.model.MemberService;
import com.mb.model.MemberVO;
import com.msg.model.MessageService;

@MultipartConfig
public class MemberServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		// 通知
		// 忘記密碼
		// 登入過再進入登入頁面會導到首頁(用濾器)
		// **** 登入就會IllegalArgumentException ****

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		String servletPath = req.getParameter("servletPath"); // 從哪裡來

		if ("searchMb".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String mb_id = req.getParameter("mb_id");
				if (mb_id == null || (mb_id.trim()).length() == 0) {
					errorMsgs.add("帳號不得為空白");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher(servletPath);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/index.jsp?pageRun=personal_page_ws/personal_page_other.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MemberService memberSvc = new MemberService();
				MemberVO searchMbVO = memberSvc.getOneMember(mb_id);
				
				if (searchMbVO == null || (mb_id.trim()).length() == 0) {
					errorMsgs.add("查無此帳號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/index.jsp?pageRun=personal_page_ws/personal_page_other.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("searchMbVO", searchMbVO); // 資料庫取出的VO物件,存入Session
				
				String url = "/front_end/index.jsp?pageRun=personal_page_ws/personal_page_other.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 onePage.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/index.jsp?pageRun=personal_page_ws/personal_page_other.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Display".equals(action)) { // 登入
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String mb_id = req.getParameter("mb_id");
				if (mb_id == null || (mb_id.trim()).length() == 0) {
					errorMsgs.add("帳號不得為空白");
				}

				String mb_pwd = req.getParameter("mb_pwd");
				if (mb_pwd == null || (mb_pwd.trim()).length() == 0) {
					errorMsgs.add("密碼不得為空白");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(servletPath);
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMember(mb_id);
				if (memberVO == null || !memberVO.getMb_pwd().equals(mb_pwd)) {
					errorMsgs.add("帳號或密碼有誤");
				}else if(memberVO.getMb_status() == 1) {  // 未驗證
					errorMsgs.add("此帳號信箱尚未驗證");
					errorMsgs.add("請至信箱點選驗證連結");
				}else if(memberVO.getMb_status() == 3) {  // 停權
					errorMsgs.add("此帳號已被停權");
				}
				// 把Line資訊塞進去
				if (memberVO != null && memberVO.getMb_pic() == null && memberVO.getMb_line_pic() == null) {
					MemberVO memberLineVO = memberSvc.getOneMemberPG(mb_id);
					if (memberLineVO != null) {
						memberSvc.updateLine(memberLineVO.getMb_line_id(), memberLineVO.getMb_line_pic(),
											 memberLineVO.getMb_line_display(), memberLineVO.getMb_line_status(), mb_id);
					}
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(servletPath);
					failureView.forward(req, res);
					return;// 程式中斷
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				session.setAttribute("memberVO", memberVO); // 資料庫取出的VO物件,存入Session
				
//				String url = req.getContextPath() + "/front_end/member/listOneMember.jsp";  // 測試
				String url = req.getContextPath() + "/front_end/index.jsp?pageRun=personal_page/personal_page.jsp";
				
				String originalJSP = (String)session.getAttribute("originalJSP");  // 
				if(originalJSP != null) {
					url = originalJSP;
					if((req.getContextPath() + "/front_end/index.jsp").equals(originalJSP)) {
						url = req.getContextPath() + "/front_end/index.jsp?pageRun=personal_page/personal_page.jsp";
					}
					session.removeAttribute("originalJSP");
				}
				res.sendRedirect(url);
				return;

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(servletPath);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 修改
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			MemberService memberSvc = new MemberService();
			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String mb_id = req.getParameter("mb_id");

				String mb_pwd = req.getParameter("mb_pwd");
				if (mb_pwd == null || mb_pwd.trim().length() == 0) {
					errorMsgs.add("密碼不得為空白");
				}

				String mb_name = req.getParameter("mb_name");
				if (mb_name == null || mb_name.trim().length() == 0) {
					errorMsgs.add("姓名不得為空白");
				}

				String mb_email = req.getParameter("mb_email");
				if (mb_email == null || mb_email.trim().length() == 0) {
					errorMsgs.add("e-mail不得為空白");
				}

				Integer mb_gender = Integer.parseInt(req.getParameter("mb_gender"));

				java.sql.Date mb_birthday = null;
				String date = req.getParameter("mb_birthday");
				if (date != null && date.length() != 0)
					mb_birthday = java.sql.Date.valueOf(date.trim());
				;

				// 圖片

				byte[] mb_pic = null;
				Part part = req.getPart("mb_pic");
				if (part.getSize() != 0) { // 有上傳圖片

					InputStream in = part.getInputStream();
					mb_pic = new byte[in.available()];
					in.read(mb_pic);
					in.close();

				} else { // 沒有上傳圖片，用原來的圖片
					mb_pic = memberSvc.getOneMember(mb_id).getMb_pic();
				}

				Integer mb_lv = Integer.parseInt(req.getParameter("mb_lv"));
				Integer mb_rpt_times = Integer.parseInt(req.getParameter("mb_rpt_times"));
				Integer mb_status = Integer.parseInt(req.getParameter("mb_status"));

				MemberVO memberVO = new MemberVO();
				memberVO.setMb_id(mb_id);
				memberVO.setMb_pwd(mb_pwd);
				memberVO.setMb_name(mb_name);
				memberVO.setMb_gender(mb_gender);
				memberVO.setMb_birthday(mb_birthday);
				memberVO.setMb_email(mb_email);
				memberVO.setMb_pic(mb_pic);
				memberVO.setMb_lv(mb_lv);
				memberVO.setMb_rpt_times(mb_rpt_times);
				memberVO.setMb_status(mb_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的memberVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/index.jsp?pageRun=member/update_member.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始查詢資料 *****************************************/
				
				memberVO = memberSvc.updateMember(mb_id, mb_pwd, mb_name, mb_gender, mb_birthday, mb_email, mb_pic,
						mb_lv, mb_rpt_times, mb_status);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				String url = null;
//				if(servletPath.contains("front_end")) {  // 從前端修改( 前端尚未include，所以還沒改 )
					session.setAttribute("memberVO", memberVO);
					url = "/front_end/member/listOneMember.jsp"; 
//				}else {  // 從後端修改
//					req.setAttribute("includePath", "/back_end/staff/listAllMember.jsp");
//					url = servletPath; 
//				}
				
				RequestDispatcher successView = req.getRequestDispatcher("/front_end/index.jsp?pageRun=member/update_member.jsp"); // 成功轉交 onePage.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/index.jsp?pageRun=member/update_member.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 新增
			
			
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String mb_id = req.getParameter("mb_id");
				if (mb_id == null || mb_id.trim().length() == 0) {
					errorMsgs.add("帳號不得為空白");
				}

				String mb_pwd = req.getParameter("mb_pwd");
				if (mb_pwd == null || mb_pwd.trim().length() == 0) {
					errorMsgs.add("密碼不得為空白");
				}

				String mb_name = req.getParameter("mb_name");
				if (mb_name == null || mb_name.trim().length() == 0) {
					errorMsgs.add("姓名不得為空白");
				}

				// 性別
				String gender = req.getParameter("mb_gender");
				Integer mb_gender = null;
				if (gender == null) {
					errorMsgs.add("請選擇性別");
				} else {
					mb_gender = Integer.parseInt(gender);
				}

				String mb_email = req.getParameter("mb_email");
				if (mb_email == null || mb_email.trim().length() == 0) {
					errorMsgs.add("e-mail不得為空白");
				}

				java.sql.Date mb_birthday = null;
				String date = req.getParameter("mb_birthday");
				if (date != null && date.length() != 0)
					mb_birthday = java.sql.Date.valueOf(date.trim());
				;

				// 圖片
				Part part = req.getPart("mb_pic");
				byte[] mb_pic = null;
				String picBase64 = req.getParameter("picBase64");
				if (part.getSize() != 0) { // 有上傳圖片
					InputStream in = part.getInputStream();
					mb_pic = new byte[in.available()];
					in.read(mb_pic);
					in.close();
				} else if (picBase64 != null && picBase64.trim().length() != 0) { // 第一次有上傳圖片，第二次無，使用參數傳進來的picBase64
					mb_pic = Base64.getDecoder().decode(picBase64.getBytes("UTF-8"));
				} // 若都沒有，mb_pic 以 null 送出

				MemberVO memberVO = new MemberVO();
				memberVO.setMb_id(mb_id);
				memberVO.setMb_pwd(mb_pwd);
				memberVO.setMb_name(mb_name);
				memberVO.setMb_gender(mb_gender);
				memberVO.setMb_birthday(mb_birthday);
				memberVO.setMb_email(mb_email);
				memberVO.setMb_pic(mb_pic);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的memberVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher(servletPath);
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MemberService memberSvc = new MemberService();
				memberVO = memberSvc.addMember(mb_id, mb_pwd, mb_name, mb_gender, mb_birthday, mb_email, mb_pic);
				
				String subject = "Runnable 可以跑 - 會員註冊驗證信";
//				String content = mb_name + "您好，請點選以下網址，進行信箱驗證\r\n"
//				   		+ "http://localhost:8081/DA106_G5/front_end/member/member.do?action=verification&"
//						+ "captcha="
//						+ Base64.getEncoder().encodeToString(mb_id.getBytes("utf-8"));
				
				String content = mb_name + "您好，請點選以下網址，進行信箱驗證\r\n"
				   		+ "https://35.229.147.85/DA106_G5/front_end/member/member.do?action=verification&"
						+ "captcha="
						+ Base64.getEncoder().encodeToString(mb_id.getBytes("utf-8"));
				
				// 寄驗證信
				MailService mailService = new MailService(mb_email, subject, content);
				mailService.start();

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				String url = "/front_end/member/login_New.jsp"; //
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 onePage.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(servletPath);
				failureView.forward(req, res);
			}
		}

		if ("check_id".equals(action)) { // Ajax 檢查ID OK

			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();

			JSONObject jsonObj = new JSONObject();
			String result = null;
			try {
				String mb_id = req.getParameter("mb_id");
				if (mb_id == null || (mb_id.trim()).length() == 0) {
					result = "帳號不得為空白";
				}

				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMember(mb_id);
				if (memberVO != null) {
					result = "此帳號已被使用";
				}

				if (result != null) { // 錯誤回傳
					jsonObj.put("result", result);
					out.write(jsonObj.toString());
					out.flush();
					out.close();
					return;
				}

				result = "此帳號可以使用"; // 正確
				jsonObj.put("result", result);
				out.write(jsonObj.toString());
				out.flush();
				out.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if ("logout".equals(action)) { // 登出
			session.invalidate();
			res.sendRedirect(req.getContextPath() + "/front_end/member/login_New.jsp");
			return;
		}
		
		
		// **************************後台部分*****************************
		// 後台 - 會員管理
		if ("getOne_Member_For_Update".equals(action)) { // 顯示一筆會員資料For更新 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String indexPath = "/back_end/staff/index.jsp";
			
			String includePath = req.getParameter("includePath");
			req.setAttribute("includePath", includePath);  // 放入來源路徑，用以錯誤回去include用
			try {
				
				/***************************查詢資料****************************************/
				String mb_id = req.getParameter("mb_id");
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMember(mb_id);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("memberVO", memberVO);         
				req.setAttribute("includePath", "/back_end/staff/update_member.jsp");  // 成功include畫面
				RequestDispatcher successView = req.getRequestDispatcher(indexPath);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(indexPath);
				failureView.forward(req, res);
			}
		}
		
		if ("back_end_update".equals(action)) { // 後台 - 會員修改
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			MemberService memberSvc = new MemberService();
			
			String indexPath = "/back_end/staff/index.jsp";
			
			String includePath = req.getParameter("includePath"); 
			req.setAttribute("includePath", includePath);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String mb_id = req.getParameter("mb_id");

				String mb_pwd = req.getParameter("mb_pwd");
				if (mb_pwd == null || mb_pwd.trim().length() == 0) {
					errorMsgs.add("密碼不得為空白");
				}

				String mb_name = req.getParameter("mb_name");
				if (mb_name == null || mb_name.trim().length() == 0) {
					errorMsgs.add("姓名不得為空白");
				}

				String mb_email = req.getParameter("mb_email");
				if (mb_email == null || mb_email.trim().length() == 0) {
					errorMsgs.add("e-mail不得為空白");
				}

				Integer mb_gender = Integer.parseInt(req.getParameter("mb_gender"));

				java.sql.Date mb_birthday = null;
				String date = req.getParameter("mb_birthday");
				if (date != null && date.length() != 0)
					mb_birthday = java.sql.Date.valueOf(date.trim());
				;

				// 圖片

				byte[] mb_pic = null;
				Part part = req.getPart("mb_pic");
				if (part.getSize() != 0) { // 有上傳圖片

					InputStream in = part.getInputStream();
					mb_pic = new byte[in.available()];
					in.read(mb_pic);
					in.close();

				} else { // 沒有上傳圖片，用原來的圖片
					mb_pic = memberSvc.getOneMember(mb_id).getMb_pic();
				}

				Integer mb_lv = Integer.parseInt(req.getParameter("mb_lv"));
				Integer mb_rpt_times = Integer.parseInt(req.getParameter("mb_rpt_times"));
				Integer mb_status = Integer.parseInt(req.getParameter("mb_status"));

				MemberVO memberVO = new MemberVO();
				memberVO.setMb_id(mb_id);
				memberVO.setMb_pwd(mb_pwd);
				memberVO.setMb_name(mb_name);
				memberVO.setMb_gender(mb_gender);
				memberVO.setMb_birthday(mb_birthday);
				memberVO.setMb_email(mb_email);
				memberVO.setMb_pic(mb_pic);
				memberVO.setMb_lv(mb_lv);
				memberVO.setMb_rpt_times(mb_rpt_times);
				memberVO.setMb_status(mb_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的memberVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher(indexPath);
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始查詢資料 *****************************************/
				
				memberVO = memberSvc.updateMember(mb_id, mb_pwd, mb_name, mb_gender, mb_birthday, mb_email, mb_pic,
						mb_lv, mb_rpt_times, mb_status);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("includePath", "/back_end/staff/listAllMember.jsp");
				
				RequestDispatcher successView = req.getRequestDispatcher(indexPath); // 成功轉交 onePage.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(indexPath);
				failureView.forward(req, res);
			}
		}
		
		if ("back".equals(action)) { // 返回
			String indexPath = "/back_end/staff/index.jsp";
			String backPath = req.getParameter("backPath");
			req.setAttribute("includePath", backPath);
			RequestDispatcher failureView = req.getRequestDispatcher(indexPath);
			failureView.forward(req, res);
		}
		
		if ("verification".equals(action)) { // 驗證
			String captcha = req.getParameter("captcha");
			String mb_id = new String(Base64.getDecoder().decode(captcha), "UTF-8");
			MemberService memberSvc = new MemberService();
			MemberVO memberVO = memberSvc.getOneMember(mb_id);
			if(memberVO.getMb_status() == 1) {
				memberVO.setMb_status(2);
				memberSvc.updateMember(memberVO.getMb_id(), memberVO.getMb_pwd(), memberVO.getMb_name(), 
						memberVO.getMb_gender(), memberVO.getMb_birthday(), memberVO.getMb_email(), 
						memberVO.getMb_pic(), memberVO.getMb_lv(), memberVO.getMb_rpt_times(), memberVO.getMb_status());
			}
			session.setAttribute("memberVO", memberVO);
			
			RequestDispatcher successView = req.getRequestDispatcher("/front_end/index.jsp?pageRun=personal_page/personal_page.jsp");
			successView.forward(req, res);
			return;
		}
	}
}
