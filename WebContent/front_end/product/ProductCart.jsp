<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css" media="screen">
.productlist {
	cellpadding: "10";
	cellspacing: "5";
	
}

  table {

	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 3px solid 	#FFFFFF;
  }
  th, td {
    padding: 1px;
    text-align: center;
  }
  #Footer {
　height: 100px;
　position: relative;
　margin-top: -100px;
}
 .buttonBar{
width:100%;
background-color:#3960D0;
height:100px;
margin-top:100;
}
.followlist {
	cellpadding: "10";
	cellspacing: "5";
	padding-bottom: 100px;
	
}

</style>
<title>Mode II 範例程式 - Cart.jsp</title>
</head>
<jsp:useBean id="pd_typeService" scope="page"
	class="com.pd_type.model.Pd_typeService" />
<jsp:useBean id="couponService" scope="page"
	class="com.coupon.model.CouponService" />
<body bgcolor="#FFFFFF">
	<%
		Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingCart");
	%>
	<%
		if (buylist == null || buylist.size() == 0) {
	%>
	購物車沒東西喔
	<%
		}
	%>


	<%
		if (buylist != null && (buylist.size() > 0)) {
	%>

	<jsp:include page="/front_end/product/ShopHomeBar.jsp" flush="ture" />
	<div style="width:100%; height:100px; border-style:solid; background-color:#FFD382;"></div>
	<div align="center" style=" background-color:#FFD382;">
		<font size="+3">目前您購物車的內容如下：</font>
		<hr>
		<p></div>
		<div style="border-style:solid; height:600px;" align="center" >
		<div style="border-style:solid;" align="center">
			<form name="deleteForm"
				action="<%=request.getContextPath()%>/ShoppingServlet" method="POST">
				<table style="width: 800px;">
					<tr bgcolor="#999999" align="center">
						<th width="100px"><font color="black">產品圖片</font></th>
						<th width="100px"><font color="black">產品分類</font></th>
						<th width="200px"><font color="black">產品名稱</font></th>
						<th width="100px"><font color="black">單價</font></th>
						<th width="100px"><font color="black">尺寸</font></th>
						<th width="100px"><font color="black">數量</font></th>
						<th width="100px"></th>
					</tr>

					<%
						for (int index = 0; index < buylist.size(); index++) {

								ProductVO order = buylist.get(index);

								pageContext.setAttribute("order", order);
					%>


					<tr bgcolor=#C4E1FF>
						<td align="center" style="width: 50px; height: 125px;"><a
							href='<%=request.getContextPath()%>/ShoppingServlet?action=findOneProduct&pd_no=${order.pd_no}'><img 
								src="<%=request.getContextPath()%>/ProductPicReader?pd_no=<%=order.getPd_no()%>" style="width:auto;"></a></td>
						<td height="100px"><div align="center">
								<b>${pd_typeService.searchType(order.pd_typeNo).pd_typeName}</b>
							</div></td>
						<td width="100px"><div align="center">
								<b><%=order.getPd_name()%></b>
							</div></td>
						<td width="100px"><div align="center">
								<b>$<%=order.getPd_price()%></b>
							</div></td>
						<td width="100px"><div align="center">
								<b><%=order.getPd_typeSize()%></b>
							</div></td>
						<td width="100px"><div align="center">
								<b><%=order.getPd_quantity()%></b>
							</div></td>


						<td width="100"><div align="center">

								<input type="hidden" name="action" value="DELETE"> <input
									type="hidden" name="del" value="<%=index%>"> <input class="btn btn-primary btn-sm" type="submit" name="Submit" 
							value="刪除">
							</div></td>

					</tr>

					<%
						}
					%>
					
					<tr bgcolor=#C4E1FF>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td><div align="center">
							<font color="red"><b>目前金額：</b></font>
						</div></td>
					<td align="center"><font color="red"><b>$${total}</b></font></td>
					</tr>
				</table>
			</form>
			</div>
			
			<div align="center">
			<form name="checkoutForm"
				action="<%=request.getContextPath()%>/ShoppingServlet" method="POST">
				<table style="width: 800px;" >
					<tr bgcolor=#C4E1FF>
						<td width="155px">可使用的優惠券：</td>
						<td width="100px" align="center"><select size="1" name="cp_get" >
								<option value="請選擇">請選擇
									<c:forEach var="cp_getVO" items="${couponList}">
										<option value="${cp_getVO.cp_no}">${couponService.searchCoupon(cp_getVO.cp_no).cp_name}
									</c:forEach>
						</select></td>
						<td width="200px"> </td>
					<td width="100px"></td>
					<td width="100px"></td>
					<td width="100px"></td>
					<td width="100px"><input type="submit" value="填寫購買資訊"></td>
				</table>
				<input type="hidden" name="action" value="GoToWriteShopInformation">
				
			</form>
		</div>
		</div>
		<%
			}
		%>

<div id="Footer" class="buttonBar" style="margin-top:100px;" ></div>
</body>
</html>