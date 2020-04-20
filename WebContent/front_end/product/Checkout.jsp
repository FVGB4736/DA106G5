<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="java.util.* "%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.cp_get.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mode II �d�ҵ{�� - Checkout.jsp</title>
</head>
<jsp:useBean id="pd_typeService" scope="page" class="com.pd_type.model.Pd_typeService" />
<body bgcolor="#FFFFFF">

�|���G${mb_id}


	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<img src="images/tomcat.gif">
	<font size="+3">�ӫ� - ��g���O�P���f��T </font>
	<hr>
	<p>
	<table border="1" width="720">
		<tr bgcolor="#999999">
		    <th width="200">���~�Ϥ�</th>
			<th width="200">���~����</th>
			<th width="100">���~�W��</th>
			<th width="100">���~�s��</th>
			<th width="100">���</th>
			<th width="100">�ؤo</th>
			<th width="100">�ƶq</th>
			<th width="120"></th>
		</tr>
		<%

			Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingCart");
		Integer totalPrice =  (Integer)session.getAttribute("totalPrice");
			List<Cp_getVO> couponList = (List<Cp_getVO> )request.getAttribute("couponList");
			request.setAttribute("couponList", couponList);
		%>
		<%
			for (int i = 0; i < buylist.size(); i++) {
				ProductVO order = buylist.get(i);
				String pd_no = order.getPd_no();
				String pd_name = order.getPd_name();
				int pd_price = order.getPd_price();
				String pd_typeSize = order.getPd_typeSize();
				String pd_typeNo = order.getPd_typeNo();
				int pd_quantity = order.getPd_quantity();
				pageContext.setAttribute("order", order);
		%>

		<form ac>
			<tr>
				<td width="100"><div align="center">
				<a href='<%=request.getContextPath()%>/ShoppingServlet?action=findOneProduct&pd_no=<%=order.getPd_no()%>'><img src="<%= request.getContextPath()%>/ProductPicReader?pd_no=<%=order.getPd_no()%>" width="100px">
						
					</div></td>
					<td width="100"><div align="center">
						<b>${pd_typeService.searchType(order.pd_typeNo).pd_typeName}</b>
					</div></td>
				<td width="100"><div align="center">
						<b><%=pd_name%></b>
					</div></td>
				<td width="200"><div align="center">
						<b><%=pd_no%></b>
					</div></td>
				<td width="100"><div align="center">
						<b><%=pd_price%></b>
					</div></td>
					<td width="100"><div align="center">
						<b><%=pd_typeSize%></b>
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
				<td><font color="red"><b>$<%=totalPrice%></b></font></td>
				<td></td>
			</tr>
			
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="center">
						<font color="red"><b>�u�f����B�G</b></font>
					</div></td>
				<td></td>
				<td><font color="red"><b>${discount}</b></font></td>
				<td></td>
			</tr>
			
	</table>
	</form ac>

	<form method="POST"
		action="<%=request.getContextPath()%>/CheckOutServlet">
		<table>
			<tr>
				<td>��g���O�a�}</td>
				<td><input type="TEXT" name="od_add"></td>
			</tr>

			<tr>
				<td>��ܦ��O�覡</td>
				<td><input type="radio" name="payMethod" value="�f��I��">�f��I��
					<input type="radio" name="payMethod" value="�H�Υd�I�O">�H�Υd�I�O <input
					type="radio" name="payMethod" value="ibonú�O">ibonú�O</td>
			</tr>

		</table>
	   

		<input type="hidden" name="action" value="getOd_detail_Information"> <input
			type="submit" name="Submit" value="���b">
		
	</form>

	<p>
		<a href="<%=request.getContextPath()%>/front_end/product/ShopHome.jsp">�O�_�~���ʪ�</a>
</body>
</html>
