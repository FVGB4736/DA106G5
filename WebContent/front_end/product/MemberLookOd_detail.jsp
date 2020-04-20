<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cp_get.model.*, java.util.List"%>


<%
	String mb_id = (String)session.getAttribute("mb_id");

	Cp_getService cp_getService = new Cp_getService();
	Cp_getVO cp_getVO = new Cp_getVO();
	cp_getVO.setMb_id(mb_id);
	cp_getVO.setCp_status(1);
	List<Cp_getVO> list = cp_getService.listAmemberCpGetStatus(cp_getVO);
	
	pageContext.setAttribute("list", list );
	
	
%>
<jsp:useBean id="couponService" scope="page" class="com.coupon.model.CouponService" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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



<table >
<tr>  
<th width="100">會員帳號</th>
<th width="100">可使用的優惠券</th>
</tr>
<tr>
<td width="100">${mb_id}</td>


<c:forEach var="cp_getVO" items="${list}">

<td width="100">${couponService.searchCoupon(cp_getVO.cp_no).cp_name}</td>


</c:forEach>
</tr>
</table>



       <select size="1" name="cp_non">
         <c:forEach var="cp_getVO2" items="${list}" > 
          <option value="${cp_getVO2.cp_no}">${couponService.searchCoupon(cp_getVO2.cp_no).cp_name}
         </c:forEach>   
       </select>

<%-- <table>
<tr>
<% for(Cp_getVO cp_getVO : list){%>
<td><%=cp_getVO.getCp_no()%></td>
<%}%>
</tr>
</table> --%>

<a href="<%=request.getContextPath()%>/front_end/product/ShopHome.jsp">回商城首頁</a>

</body>
</html>
=======
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="java.util.* "%>
<%@ page import="com.product.model.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>�q�����</title>


<% request.getAttribute("ordersVO"); %>
<jsp:useBean id="pd_typeService" scope="page" class="com.pd_type.model.Pd_typeService" />
</head>
<body bgcolor="#FFFFFF">
	<img src="images/tomcat.gif">
	<font size="+3">�q����� </font>
	<hr>
	<p>
	
	�q��s��${ordersVO.od_no}
	<table border="1" width="720">
		<tr bgcolor="#999999">
		    <th width="200">���~�Ϥ�</th> 
		    <th width="100">���~�W��</th>
			<th width="200">���~����</th>
			<th width="100">���</th>
			<th width="100">���~�ƶq</th>
			<th width="120"></th>
		</tr>




		<%
			Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingCart");
			String amount = (String) request.getAttribute("amount");
		%>
		<%
			for (int i = 0; i < buylist.size(); i++) {
				ProductVO order = buylist.get(i);
				String pd_no = order.getPd_no();
				String pd_name = order.getPd_name();
				int pd_price = order.getPd_price();
				String pd_typeNo = order.getPd_typeNo();
				int pd_quantity = order.getPd_quantity();
				pageContext.setAttribute("pd_typeNo", pd_typeNo);
		%>

		<form ac>
		
			<tr>
				
				<td width="100"><div align="center">
						<a
							href='<%=request.getContextPath()%>/ShoppingServlet?action=findOneProduct&pd_no=<%=order.getPd_no()%>'><img
							src="<%=request.getContextPath()%>/ProductPicReader?pd_no=<%=order.getPd_no()%>"
							width="100px"></a> ${pd_typeService.searchType(productVO.pd_typeNo).pd_typeName}
					</div></td>
					
				<td width="100"><div align="center">
						<b><%=pd_name%></b>
					</div></td>
					
					<td width="100"><div align="center">
						<b>${pd_typeService.searchType(pd_typeNo).pd_typeName}</b>
					</div></td>
					
				<td width="200"><div align="center">
						<b><%=pd_no%></b>
					</div></td>
				<td width="100"><div align="center">
						<b><%=pd_price%></b>
					</div></td>
				<td width="100"><div align="center">
						<b><%=pd_quantity%></b>
					</div></td>
			</tr>

			<%
				}
			%>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="center">
						<font color="red"><b>�`���B�G</b></font>
					</div></td>
				<td></td>
				<td><font color="red"><b>${ordersVO.od_totalPrice}</b></font></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="center">
						<font color="red"><b>�u�f�᪺���B�G</b></font>
					</div></td>
				<td></td>
				<td><font color="red"><b>${ordersVO.od_discount}</b></font></td>
				<td></td>
			</tr>
			<td>�I�O�覡:</td><td>${payMethod}</td>
			<td> ${ordersVO.od_add}</td>
	</table>
	</form ac>




	<p>
		<a href="<%=request.getContextPath()%>/front_end/product/ShopHome.jsp">�O�_�~���ʪ�</a>
</body>
</html>
>>>>>>> branch 'master' of https://github.com/SoowiiXie/DA106G5.git
