<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="java.util.* "%>
<%@ page import="com.product.model.*"%>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Mode II �d�ҵ{�� - Checkout.jsp</title>
</head>
<body bgcolor="#FFFFFF">
<img src="images/tomcat.gif"> <font size="+3">�����ѩ� - ���b </font>
<hr><p><center>

<table border="1" width="720">
	<tr bgcolor="#999999">
		<th width="200">���~����</th>
		<th width="100">���~�W��</th>
		<th width="100">���</th>
		<th width="100">���~�ƶq</th>
		<th width="100">�ƶq</th>
		<th width="120"></th>
	</tr>
	
	<%
		Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingCart");
		String amount =  (String) request.getAttribute("amount");
	%>	
	<%	for (int i = 0; i < buylist.size(); i++) {
			ProductVO order = buylist.get(i);
			String pd_no = order.getPd_no();
			String pd_name = order.getPd_name();
			int pd_price = order.getPd_price();
		     String pd_typeNo = order.getPd_typeNo();
			int pd_quantity = order.getPd_quantity();
	%>
	<tr>
	    <td width="100"><div align="center"><b><%=pd_typeNo%></b></div></td>
	    <td width="100"><div align="center"><b><%=pd_name%></b></div></td>
		<td width="200"><div align="center"><b><%=pd_no%></b></div></td>
		<td width="100"><div align="center"><b><%=pd_price%></b></div></td>
		<td width="100"><div align="center"><b><%=pd_quantity%></b></div></td>
	</tr>
	<%
		}
	%>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td><div align="center"><font color="red"><b>�`���B�G</b></font></div></td>
		<td></td>
		<td> <font color="red"><b>$<%=amount%></b></font> </td>
		<td></td>
	</tr>
</table>
<p><a href="front_end/product/ShopHome.jsp">�O�_�~���ʪ�</a>
</center>
</body>
</html>
