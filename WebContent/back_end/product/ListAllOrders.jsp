<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.orders.model.*"%>

<%  
    
List<OrdersVO>	list = (List<OrdersVO>)session.getAttribute("list");
	session.setAttribute("list", list);

%>

<jsp:useBean id="couponService" scope="page" class="com.coupon.model.CouponService" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理所有訂單</title>
</head>
<body>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form method="POST"
		action="<%=request.getContextPath()%>/OrdersServlet" name="form1">
		<table>
			<tr>
				<td>會員名稱：</td>
				<td><input type="TEXT" name="mb_id"></td>
			</tr>
		</table>
		<input type="hidden" name="action" value="searchMemberOrders">
		
		<input type="submit" name="Submit" value="搜尋該會員訂單">
		
	</form>


	<table border="1">

		<tr>
			<th width="100" align="center">訂單編號</th>
			<th width="100" align="center">會員名稱</th>
			<th width="100" align="center">訂單時間</th>
			<th width="100" align="center">訂單狀態</th>
			<th width="100" align="center">訂單總金額</th>
			<th width="100" align="center">優惠券號碼</th>
			<th width="100" align="center">優惠後金額</th>
			<th width="100" align="center">收貨地址</th>
			<th width="100" align="center"></th>
			<th width="100" align="center"></th>

		</tr>
		<%@ include file="page1ForListAllOrders.file"%>
		<c:forEach var="ordersVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr>

				<td align="center">${ordersVO.od_no}</td>
				<td align="center">${ordersVO.mb_id}</td>
				<td align="center">${ordersVO.od_time}</td>
				<td align="center">${ordersVO.od_status==1?'已發貨':'未發貨'}</td>
				<td align="center">${ordersVO.od_totalPrice}</td>
				<td align="center">${couponService.searchCoupon(ordersVO.cp_no).cp_name} 
				<c:if test="${ordersVO.cp_no==null}">
	                   無使用優惠券
  </c:if>
				</td>
				<td align="center">${ordersVO.od_discount}</td>
				<td align="center">${ordersVO.od_add}</td>
     
				<td align="center"><FORM method="POST"
						ACTION="<%=request.getContextPath()%>/OrdersServlet">

						<input type="submit" value="查詢訂單明細"> <input type="hidden"
							name="od_no" value="${ordersVO.od_no}"> <input
							type="hidden" name="action" value="getOne_For_Od_detail">
					</FORM></td>
				<td align="center"><FORM METHOD="post" ACTION="OrdersServlet"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="pd_no" value="${productVO.pd_no}"> <input
							type="hidden" name="action" value="delete">
							
					</FORM></td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2ForListAllOrders.file"%>

	<br>
	<br>
	<a href="<%=request.getContextPath()%>/OrdersServlet?action=getAllList">回到管理所有訂單</a>
	<a
		href="<%=request.getContextPath()%>/back_end/product/ShopManager.jsp">回管理商城首頁</a>

</body>
</html>