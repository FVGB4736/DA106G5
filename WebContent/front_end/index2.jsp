<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cmt.model.CmtVO"%>
<%@ page import="com.cmt.model.CmtService"%>
<%@ page import="com.cmt.model.*"%>
<%@ page import="com.record.model.*"%>
<%@ page import="com.msg.model.*"%>
<%@ page import="com.live.model.*"%>
<%@ page import="com.mb.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<% 
	MemberService memberSvc = new MemberService();
	MemberVO memberVO =(MemberVO)session.getAttribute("memberVO");
	//登入畫面壞掉時用，其餘時候註解起來
// 	String mb_id=(String)session.getAttribute("mb_id");
// 	if(mb_id==null || "".equals(mb_id) || memberVO==null){
// 		session.setAttribute("mb_id","anjavababy520");
// 		session.setAttribute("memberVO",memberSvc.getOneMember(mb_id));
// 	}
	//正式上線時用
// 	if(memberVO==null){
// 		//還沒登入的話
// 		response.sendRedirect(request.getContextPath()+"/front_end/member/login.jsp");
// 	}else{
		//用memberVO先取得會常使用到的mb_id
		pageContext.setAttribute("mb_id", memberVO.getMb_id());
		//拿出所有紀錄
		RecordService recordSvc = new RecordService();
		List<RecordVO> list = recordSvc.getByMb_id((String)pageContext.getAttribute("mb_id"));
		pageContext.setAttribute("list", list);
		//拿出四則訊息
		MessageService messageSvc = new MessageService();
		List<MessageVO> messageList = messageSvc.getAllByMb_id_2((String)pageContext.getAttribute("mb_id"));
		pageContext.setAttribute("messageList", messageList);
		//拿出四個直播
		LiveService liveSvc = new LiveService();
		List<LiveVO> liveList = liveSvc.getAllTake4();
		pageContext.setAttribute("liveList", liveList);
// 	}
%>
<!--會員Service -->
<jsp:useBean id="memberSvcEL" scope="page" class="com.mb.model.MemberService" />
<!--紀錄Service -->
<jsp:useBean id="messageSvcEL" scope="page" class="com.msg.model.MessageService" />
<!--紀錄Service -->
<jsp:useBean id="recordSvcEL" scope="page" class="com.record.model.RecordService" />
<!--路徑Service -->
<jsp:useBean id="pathSvcEL" scope="page" class="com.path.model.PathService" />
<!--按讚Service -->
<jsp:useBean id="thumbSvcEL" scope="page" class="com.thumb.model.ThumbService" />
<!--meTooService -->
<jsp:useBean id="meTooSvcEL" scope="page" class="com.metoo.model.MeTooService" />
<!--留言Service -->
<jsp:useBean id="cmtSvcEL" scope="page"	class="com.cmt.model.CmtService" />
<!--訂單Service -->
<jsp:useBean id="ordersSvcEL" scope="page"	class="com.orders.model.OrdersService" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	

	<title>Runn able</title>
	<!-- Custom fonts for this template-->
	<link href="<%= request.getContextPath() %>/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />

	<!-- Custom styles for this template-->
	<link href="<%= request.getContextPath() %>/css/sb-admin-2.min.css" rel="stylesheet" />
	
	<!-- modal -->
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<!-- 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	
	<!-- 會員智慧搜尋 -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	
	
	<style>
		* {
			padding: 0;
			margin: 0;
			box-sizing: border-box;
			position: relative;
		}

		#fblightbox{
		  background: rgba(82, 82, 82, .7);
		  color: #333;
		  font-family: 'lucida grande', tahoma, verdana, arial, sans-serif;
		  border-radius: 8px;
		  padding:10px;
		  width: 575px;
		  position: fixed;
		  left:50%;
		  top:50%;
		  z-index: 99999;
		  display:none;
		}
		.fblightbox-wrap{
		  border: 1px solid #3B5998;
		}
		.fblightbox-header{
		  background:#6C83B8;
		  border-bottom: 1px solid #29447E;
		  color: #fff;
		  font-size: 14px;
		  padding:5px;
		}
		.fblightbox-header h3{
		  font-size:14px;
		}
		.fblightbox-content{
		  background:#fff;
		  font-size: 12px;
		  padding:10px;
		}
		.fblightbox-footer{
		  background: #f2f2f2;
		  border-top: 1px solid #ccc;
		  color: #333;
		  padding: 10px;
		  text-align:right;
		}
		.fbbutton{
		  text-decoration:none;
		  color:#fff;
		  font-family: 'lucida grande', tahoma, verdana, arial, sans-serif;
		  font-size: 13px;
		  border-style: solid;
		  background-image: url(https://i.imgur.com/tu8qPWG.png);
		  cursor: pointer;
		  font-weight: bold;
		  padding: 4px 8px 4px 8px;
		  text-align: center;
		  vertical-align: top;
		  white-space: nowrap;
		  border-width: 1px;
		  margin-left: 3px;
		  background-position: 125px 235px;
		  border-color: #29447E #29447E #1A356E;
		  line-height: normal !important;
		  display: inline-block;
		}
		.overlay{
		  background: rgba(0,0,0,0.2);
		  position:fixed;
		  width:100%;
		  height: 100%;
		  z-index: 99;
		  display:none;
		  top:0;
		  left:0;
		}
		
		.demo{
		  padding:30px 50px;
		}

		html {
			width: 100%;
			overflow-x: hidden;
		}

		.navbar {
			position: relative;
			top: 0px;
		}

		/* #accordionSidebar>*, */
		#stikyDiv, .collapseTwo, #contentTop{
			position: sticky !important;
			top: 0px !important;
			z-index: 1;
		}

		.collapseTwo>*, .collapseTwo {
			width: 88% !important;
			min-width: 0px !important;
			left: 0.1rem !important;
		}

		.collapse-item {
			padding-left: 0.1rem !important;
		}

		.topPic {
			/* height: 100%; */
			width: 100%;
		}

		#topPicA {
			padding: 0 !important;
			left: -0.2rem;
			background-color: rgba(255, 255, 255, 0) !important;
		}

		.topPic img {
			display: inline-block;
			height: 100%;
		}

		#sidebarToggleTop {
			margin-left: 1rem;
		}

		/* 給假高度(內容) */
		/* #contentTop {
			height: 4000px;
		} */

		#contentTop .btn, #contentRight .btn {
			height: 2.25rem;
			position: sticky;
			top: 0px;
		}

		#contentRow {
			height: 100%;
		}

		#contentLeft {
			padding-top: 4rem;
		}

		#contentLeft>*, #contentRight div {
			position: sticky;
			top: 4rem;
		}

		.live {
			top: 4rem;
			height: 4rem;
			width: 80%;
			margin: 0.25rem auto;
			padding: 0.1rem;
			overflow: hidden;
		}

		.liveImg {
			border-radius: 10px;
			width: 100%;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
		}
		
		.pathImg {
			width: 90%;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
		}

		.row {
			background-color: rgb(229, 233, 236) !important;
			width: 100%;
		}

		#sidebarToggleDiv {
			padding-top: 1rem;
		}

		nav.my_breadcrumb ol.breadcrumb {
			background-color: rgb(229, 233, 236);
		}

		nav.my_breadcrumb ol.breadcrumb .breadcrumb-item>a {
			color: rgb(154, 185, 250);
		}

		nav.my_breadcrumb ol.breadcrumb .breadcrumb-item.active {
			color: rgb(78, 115, 223);
		}

		nav.my_breadcrumb ol.breadcrumb .breadcrumb-item+.breadcrumb-item::before
			{
			content: ">";
			color: rgb(154, 185, 250);
		}

		.navbar {
			justify-content: flex-end;
		}

		#sidebarToggleDiv {
			text-align: center;
			position: relative;
			left: -0.2rem;
		}

		#sidebarToggle {
			margin: 0 !important;
		}

		.nav-link, .sidebar-brand {
			width: 100% !important;
			padding-left: 0.4rem !important;
		}

		#searchBar {
			margin-right: 1rem;
		}

		/* #wrapper {
					padding-right: 0.1rem;
				} */

		/* #wrapperRight {
					width: cal(100%-5rem);
				} */
				
		.sendBtn{
			float:right;
		}

	</style>
</head>

<body id="page-top">
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar -->
		<ul	class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
			<div id="stikyDiv">
				<!-- Sidebar - Brand -->
				<a	class="sidebar-brand d-flex align-items-center justify-content-center" id="topPicA" href="index.html">
					<div class="sidebar-brand-icon">
						<img src="<%= request.getContextPath() %>/img/LogoNoBack.png" class="topPic" />
						<!-- <img src="../images/LogoText2.png" class="topPic"> -->
					</div>
					<div class="sidebar-brand-text mx-3">
						ru<i>nn</i>able&nbsp&nbsp&nbsp&nbsp&nbsp
						<!-- <img src="../images/LogoText2.png" class="topPic"> -->
					</div>
				</a>

				<!-- Nav Item - Dashboard -->
				<li class="nav-item active">
					<!-- <li class="nav-item"> --> 
					<a class="nav-link"	href="index.html">
						<i class="fas fa-fw fa-thumbs-up"></i> 
						<span>
							個人<img src="<%= request.getContextPath() %>/img/ya.png" alt="" class="fas fa-fw">面
						</span>
					</a>
				</li>

				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item"><a class="nav-link collapsed" href="#"
					data-toggle="collapse" data-target="#collapseTwo"
					aria-expanded="true" aria-controls="collapseTwo"> <i
						class="fas fa-fw fa-cloud-sun-rain"></i> <span>準備</span>
				</a>
					<div id="collapseTwo" class="collapse collapseTwo"
						aria-labelledby="headingTwo" data-parent="#accordionSidebar">
						<div class="bg-white py-0 m-0 collapse-inner rounded">
							<!-- <h6 class="collapse-header">
                                Custom Components:
                            </h6> -->
							<a class="collapse-item py-1" href="buttons.html">天氣</a> <a
								class="collapse-item py-1" href="cards.html">地標</a>
						</div>
					</div></li>

				<!-- Nav Item - Utilities Collapse Menu -->
				<li class="nav-item"><a class="nav-link collapsed" href="#"
					data-toggle="collapse" data-target="#collapseUtilities"
					aria-expanded="true" aria-controls="collapseUtilities"> <i
						class="fas fa-fw fa-handshake"></i> <span>揪團</span>
				</a>
					<div id="collapseUtilities" class="collapse collapseTwo"
						aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
						<div class="bg-white py-0 m-0 collapse-inner rounded">
							<a class="collapse-item py-1"
								href="../ZacharyGrp/webFront/group.html">瀏覽揪團</a> <a
								class="collapse-item py-1" href="utilities-animation.html">我的揪團</a>
							<a class="collapse-item py-1" href="utilities-color.html">開團</a>
						</div>
					</div></li>

				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item">
					<a class="nav-link collapsed"
						href="../VainPd/eShopHome.html" data-toggle="collapse"
						data-target="#collapsePages" aria-expanded="true"
						aria-controls="collapsePages"> 
						<i class="fas fa-fw fa-store"></i>
						<span>商城</span>
					</a>
					<div id="collapsePages" class="collapse collapseTwo"
						aria-labelledby="headingPages" data-parent="#accordionSidebar">
						<div class="bg-white py-0 m-0 collapse-inner rounded">
							<a class="collapse-item py-1"
								href="../VainPd/forestage_html/eShopHome.html">瀏覽商城</a> <a
								class="collapse-item py-1" href="register.html">購物車</a> <a
								class="collapse-item py-1" href="forgot-password.html">我的訂單</a>
						</div>
					</div>
				</li>
				<!-- Sidebar Toggler (Sidebar) -->
				<div id="sidebarToggleDiv">
					<button class="rounded-circle border-0" id="sidebarToggle"></button>
				</div>
			</div>
		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<!-- <div id="content-wrapper" class="d-flex flex-column"> -->
		<!-- Main Content -->
		<div class="row" id="wrapperRight">
			<!-- Topbar -->
			<nav class="col-12 navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
				<!-- Sidebar Toggle (Topbar) -->
				<button id="sidebarToggleTop"
					class="btn btn-link d-md-none rounded-circle">
					<i class="fa fa-bars"></i>
				</button>

				<!-- <div id="navbarRight"> -->
				<!-- Topbar Search -->
				<form METHOD="post"	ACTION="<%=request.getContextPath()%>/front_end/member/member.do" 
				class="d-none d-sm-inline-block form-inline ml-md-3 my-2 my-md-0 mw-100 navbar-search"
				id="searchBar">
					<div class="input-group" id="memberSearch">
						<input type="text" class="form-control bg-light border-0 small tagsess" name="mb_id"
						 placeholder="查詢會員..." aria-label="Search" aria-describedby="basic-addon2" />
						<input type="hidden" name="action" value="searchMb">
						<div class="input-group-append">
							<button class="btn btn-primary" type="submit" name="submit_Btn">
								<i class="fas fa-search fa-sm"></i>
							</button>
						</div>
					</div>
				</form>

				<!-- Topbar Navbar -->
				<ul class="navbar-nav ml-0">
					<!-- Nav Item - Search Dropdown (Visible Only XS) -->
					<li class="nav-item dropdown no-arrow d-sm-none">
						<a	class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> 
							<i class="fas fa-search fa-fw"></i>
						</a> 
						<!-- Dropdown - Messages -->
						<div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
							 aria-labelledby="searchDropdown">
							<form class="form-inline mr-auto w-100 navbar-search">
								<div class="input-group">
									<input type="text" class="form-control bg-light border-0 small"
										placeholder="Search for..." aria-label="Search"
										aria-describedby="basic-addon2" />
									<div class="input-group-append">
										<button class="btn btn-primary" type="button">
											<i class="fas fa-search fa-sm"></i>
										</button>
									</div>
								</div>
							</form>
						</div>
					</li>

					<!-- Nav Item - Alerts -->
					<li class="nav-item dropdown no-arrow mx-1">
						<a	class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> 
							<i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
							<span class="badge badge-danger badge-counter">3+</span>
						</a> 
						<!-- Dropdown - Alerts -->
						<div
							class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
							aria-labelledby="alertsDropdown">
							<h6 class="dropdown-header">通知</h6>
							<a class="dropdown-item d-flex align-items-center" href="#">
								<div class="mr-3">
									<div class="icon-circle bg-primary">
										<i class="fas fa-file-alt text-white"></i>
									</div>
								</div>
								<div class="ml-2">
									<div class="small text-gray-500">December 12, 2019</div>
									<span class="font-weight-bold">這是一般通知</span>
								</div>
							</a> <a class="dropdown-item d-flex align-items-center" href="#">
								<div class="mr-3">
									<div class="icon-circle bg-success">
										<i class="fas fa-donate text-white"></i>
									</div>
								</div>
								<div class="ml-2">
									<div class="small text-gray-500">December 7, 2019</div>
									這是商城通知
								</div>
							</a> 
							<a class="dropdown-item d-flex align-items-center" href="#">
								<div class="mr-3">
									<div class="icon-circle bg-warning">
										<i class="fas fa-exclamation-triangle text-white"></i>
									</div>
								</div>
								<div class="ml-2">
									<div class="small text-gray-500">December 2, 2019</div>
									這是重要通知
								</div>
							</a> 
							<a class="dropdown-item text-center small text-gray-500" href="#">所有通知</a>
						</div>
					</li>

					<!-- Nav Item - Messages 訊息-->
					<li class="nav-item dropdown no-arrow mx-1">
						<a	class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> 
							<i class="fas fa-envelope fa-fw"></i> 
							<!-- Counter - Messages 計數器 -->
							<c:if test="${messageSvcEL.countNotReads(mb_id)>0}">
							<span class="badge badge-danger badge-counter">
								${messageSvcEL.countNotReads(mb_id)>9?"9+":messageSvcEL.countNotReads(mb_id)}
							</span>
							</c:if>
						</a> 
						<!-- Dropdown - Messages -->
						<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
							 aria-labelledby="messagesDropdown">
							<h6 class="dropdown-header">悄悄跟你說</h6>
							<!-- 所有訊息 -->
							<c:forEach var="messageVO" items="${messageList}">
							<a class="dropdown-item d-flex align-items-center" href="#">
								<div class="dropdown-list-image mr-3">
									<img class="rounded-circle" src="<%= request.getContextPath() %>/MemberPicReader?mb_id=${messageVO.mb_id_1}" alt="" />
									<div class="status-indicator bg-success"></div>
								</div>
								<c:if test="${messageVO.msg_status==1}">
								<div class="font-weight-bold ml-2 msgNotRead">
								</c:if>
								<c:if test="${messageVO.msg_status==2}">
								<div class="ml-2 msgRead">
								</c:if>
									<div class="text-truncate">${messageVO.msg_content}</div>
									<div class="small text-gray-500">${memberSvcEL.getOneMember(messageVO.mb_id_1).mb_name} · ${messageVO.msg_time} </div>
								</div>
							</a> 
							</c:forEach>
							<a class="dropdown-item text-center small text-gray-500" href="#">
								更多訊息
							</a>
						</div>
					</li>

					<div class="topbar-divider d-none d-sm-block"></div>

					<!-- Nav Item - User Information -->
					<li class="nav-item dropdown no-arrow">
					<a class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> 
					<!--會員姓名-->
					<span class="mr-2 d-none d-lg-inline text-gray-600 small" style="font-size:1.2rem;">${memberSvcEL.getOneMember(mb_id).mb_name}</span> 
					<!--會員照片-->
					<img class="img-profile rounded-circle" src="<%= request.getContextPath() %>/MemberPicReader?mb_id=${mb_id}" />
					<!--<img class="img-profile rounded-circle" src="https://profile.line-scdn.net/0hkW0Z-fy1NHgNIxwum5dLLzFmOhV6DTIwdUQuSiEqaxslEnN7NxcoHHx3PRtwQSN5Y0xzF3wqOUgi" /> -->
					</a> <!-- Dropdown - User Information -->
						<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
							<a class="dropdown-item" href="<%= request.getContextPath() %>/front_end/member/listOneMember.jsp"> 
								<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 個人資訊
							</a> 
							<a class="dropdown-item" href="#"> 
								<i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> 設定
							</a> 
							<a class="dropdown-item" href="#"> 
								<i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> 日誌
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"> 
							<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
								登出
							</a>
						</div></li>
				</ul>
				<!-- </div> -->
			</nav>
			<!-- End of Topbar -->
			
			<div class="w-100"></div>
			
			<!-- 當頁路徑 -->
			<!-- <div class="col-3">&nbsp&nbsp個人頁面</div> -->
			<nav aria-label="breadcrumb" class="col-12 my_breadcrumb">
				<ol class="breadcrumb m-0">
					<li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/front_end/member/login.jsp">登入畫面</a></li>
					<li class="breadcrumb-item active" aria-current="page">個人頁面</li>
				</ol>
			</nav>

			<div class="w-100"></div>
			<jsp:include page="maps/maps.html"/>
	</div>
		
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal -->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">確認登出？</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					你要離開了嗎? QAQ
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"	data-dismiss="modal">取消</button>
					<form METHOD="post"	ACTION="<%=request.getContextPath()%>/front_end/member/member.do">
						<input type="hidden"  name="${mb_id}" />
						<input type="hidden" name="action" value="logout">
						<input class="btn btn-primary" type="submit" value="登出">
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 檢舉或修改留言的燈箱 -->
	<div id="fblightbox" class="cmtNrpt">
	  <div class="fblightbox-wrap">
	    <div class="fblightbox-header">
	      	我來打打看
	    </div>
	    <div class="fblightbox-content">
	    	<jsp:include page="cmt/update_cmt_input.jsp" />
	    </div>
	  </div>
	</div>
	<div class="overlay"></div>
	
	<!-- 檢舉或修改留言的燈箱 -->
	<div id="fblightbox" class="msgLightBox">
	  <div class="fblightbox-wrap">
	    <div class="fblightbox-header">
	      	我來打打看
	    </div>
	    <div class="fblightbox-content">
			<jsp:include page="cmt/update_cmt_input.jsp" />
	    </div>
	  </div>
	</div>
	<div class="overlay"></div>

	<!-- Bootstrap core JavaScript-->
	<script src="<%= request.getContextPath() %>/vendor/jquery/jquery.min.js"></script>
	<script src="<%= request.getContextPath() %>/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="<%= request.getContextPath() %>/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="<%= request.getContextPath() %>/js/sb-admin-2.min.js"></script>
	
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.thumbBtn').click(function(){
				 var thumbImg = $(this);
				 $.ajax({
					 type: "GET",
					 url: "<%=request.getContextPath()%>/thumbAjaxResponse.do",
					 data: {"action":"insert", "rcd_no":$(this).siblings('.rcd_no').val(), "mb_id":$(this).siblings('.mb_id').val()},
					 dataType: "json",
					 success: function (data){
						 thumbImg.parent().next().text(data);
						 if ($(".thumbBtn").attr("src")=="<%= request.getContextPath() %>/img/thumb.png"){
						 	$(".thumbBtn").attr("src", "<%= request.getContextPath() %>/img/thumbColor.png");
						 }
						 else{
							$(".thumbBtn").attr("src", "<%= request.getContextPath() %>/img/thumb.png");
						 }
				     },
		             error: function(){alert("AJAX-thumbBtn發生錯誤囉!")}
		         });
			});
			 
			$('.meTooBtn').click(function(){
				 var meTooImg = $(this);
				 $.ajax({
					 type: "GET",
					 url: "<%=request.getContextPath()%>/meTooAjaxResponse.do",
						 data: {"action":"insert", "rcd_no":$(this).siblings('.rcd_no').val(), "mb_id":$(this).siblings('.mb_id').val()},
						 dataType: "json",
						 success: function (data){
							 meTooImg.parent().next().text(data);
							 if ($(".meTooBtn").attr("src")=="<%= request.getContextPath() %>/img/ya.png"){
							 	$(".meTooBtn").attr("src", "<%= request.getContextPath() %>/img/yaColor.png");
							 }
							 else{
								$(".meTooBtn").attr("src", "<%= request.getContextPath() %>/img/ya.png");
							 }
					     },
			             error: function(){alert("AJAX-thumbBtn發生錯誤囉!")}
			         });
			});
				 
			$('.cmtBtn').click(function(){
				 $(this).parents().siblings('.cmtDiv').toggle(function(){
// 						    $(this).animate({height:400},200);
// 						  },function(){
// 						    $(this).animate({height:10},200);
						height: 'toggle'
					  });
				 });
				 
			 $('.oneCmtDiv').hover(function(){
				 $(this).find('.flagBtn').css("display","");
				 $(this).find('.garbageBtn').css("display","");
					 },function(){
						 $(this).find('.flagBtn').css("display","none");
						 $(this).find('.garbageBtn').css("display","none");
				 });
				 
			 //燈箱共用參數
			 var fblightbox = $('#fblightbox');
			 fblightbox.css({'margin-left':'-' + (fblightbox.width()/2) + 'px' , 'margin-top' : '-' + (fblightbox.height()/2)+'px'});
				 
			 //檢舉和留言的燈箱
			 var cmtNrpt = $('.cmtNrpt');
			 $('.flagBtn').click(function(){
				 $.ajax({
					 type: "GET",
					 url: "<%=request.getContextPath()%>/cmt/cmt.do",
					 data: {"action":"ajaxGetOne4Update", "cmt_no":$(this).siblings('.cmt_no').val()},
					 dataType: "json",
					 success: function (data){
// 						 $("#cmt_contentFB").val(data.cmt_content);
						 $("#cmt_noFB").val(data.cmt_no);
					     $("#cmt_statusFB").val(data.cmt_status);
						 $("#cmt_timeFB").val(data.cmt_time);
						 $("#mb_idFB").val(data.mb_id);
						 $("#rcd_noFB").val(data.rcd_no);
						 $('.overlay').fadeIn();
						 cmtNrpt.fadeIn();
				 	 },					
				 error: function(){alert("AJAX-flagBtn發生錯誤囉!")}
		 		 });
			 });
				 
			 //訊息的燈箱
			 var msgLightBox = $('.msgLightBox');
			 $('.msgRead').click(function(){
			 	$.ajax({
					type: "GET",
					url: "<%=request.getContextPath()%>/msg/msg.do",
						 data: {"action":"ajaxGetOne4Read", "cmt_no":$(this).siblings('.cmt_no').val()},
						 dataType: "json",
						 success: function (data){
// 					   		 $("#cmt_contentFB").val(data.cmt_content);
							 $("#cmt_noFB").val(data.cmt_no);
							 $("#cmt_statusFB").val(data.cmt_status);
							 $("#cmt_timeFB").val(data.cmt_time);
							 $("#mb_idFB").val(data.mb_id);
							 $("#rcd_noFB").val(data.rcd_no);
							 $('.overlay').fadeIn();
							 msgLightBox.fadeIn();
					 	 },					
					 error: function(){alert("AJAX-flagBtn發生錯誤囉!")}
			 		});
			 });
				 
			 //讓燈箱共用關閉按鈕
			 $("#close").click(function() {
				  $('.overlay').fadeOut();
				  fblightbox.fadeOut();
			 });
			 
			 $(".overlay").click(function() {
				  $('.overlay').fadeOut();
				  fblightbox.fadeOut();
			 });
		});
	</script>
	
	<!-- 會員智慧搜尋 -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		var availableTags = [
			<%MemberDAO memberDAO = new MemberDAO();
						List<MemberVO> listMbAll = memberDAO.getAll();
		
						for (MemberVO mb : listMbAll) {
		
							out.print("'" + mb.getMb_name() + "',");
							out.print("'" + mb.getMb_id() + "',");
		
						}%>
			];
		$(function() { $( ".tagsess" ).autocomplete({ source: availableTags }); });
		     
		$("#memberSearch").on(
			"focus",".tagsess",function() { $( ".tagsess" ).autocomplete({ source: availableTags});}
		);
	</script>
</body>
</html>