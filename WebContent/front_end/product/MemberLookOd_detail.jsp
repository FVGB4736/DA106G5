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
