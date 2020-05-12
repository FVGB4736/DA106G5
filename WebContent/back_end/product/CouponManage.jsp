<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*"%>
<%@ page import="com.coupon.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>優惠券管理</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<%
	CouponService couponService = new CouponService();

	List<CouponVO> list = couponService.getAll();
	Collections.reverse(list);

	pageContext.setAttribute("list", list);
%>


<style type="text/css" media="screen">
table {
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 3px solid #FFFFFF;
}

th, td {
	padding: 1px;
	text-align: center;
}

 .buttonBar{
width:100%;
background-color:#FF004C;
height:100px;
margin-top:100;
}
</style>
</head>
<body>
	<jsp:include page="ShopManagerBar.jsp" />
<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
<div align="center" style="margin-top:50px;">
		<font size="+3">優惠券列表：</font>
		<hr>
		
<div class="2" style=" width:80%;">		
	<div align="center" style="margin-top: 50px;">
	
<form method="POST"
		action="<%=request.getContextPath()%>/CpGetServlet" name="form1"
		method="POST">
		<table style="width:100%;">
          
          <tr bgcolor="#999999">

				<th colspan="7">發放優惠券</th>
				
			</tr>
          
          
			<tr bgcolor=#C4E1FF>
			    <td style="width:12%;" bgcolor="#9CC7F6">會員等級</td>
			    <td style="width:8%;" bgcolor="#9CC7F6">
			      <select size="1" name="pd_typeNo">
					    <option value="">不限等級
						<option value="">等級1
						<option value="">等級2
						<option value="">等級3
						<option value="">等級4
						<option value="">等級5	
				  </select>
			    </td>
			    
				<td style="width:8%;" bgcolor="#9CC7F6">優惠券種類：</td>
				<td style="width:8%;" bgcolor="#9CC7F6">
				    <select size="1" name="cp_no">
					    <option value="">請選擇
							<c:forEach var="couponVO" items="${list}">
								<option value="${couponVO.cp_no}"
									>${couponVO.cp_name}
							</c:forEach>
					</select></td>
				
			    <td style="width:12%;" bgcolor="#9CC7F6">
			    <input type="hidden" name="action" value="giveCoupon"> 
			    
			    
			    <input type="submit" name="Submit" value="發送優惠券"></td>

			</tr>

		</table>

</form>	
	</div>
	
	
	
	<div align="center" style="margin-top: 50px;">
	
<form method="POST"
		action="<%=request.getContextPath()%>/CpGetServlet" name="form1"
		method="POST">
		<table style="width:100%;">
          
          <tr bgcolor="#999999">

				<th colspan="7">新增優惠券</th>
				
			</tr>
          
          
			<tr bgcolor=#C4E1FF>
				<td style="width:8%;" bgcolor="#9CC7F6">優惠券種類：</td>
				<td style="width:12%;" bgcolor="#9CC7F6"><input type="TEXT" name="cp_name"
					value="${couponVO.cp_name}" style="width: 100%; height: 100%" id="mcp_name"></td>
				<td style="width:8%;" bgcolor="#9CC7F6">優惠券金額：</td>
				<td style="width:12%;" bgcolor="#9CC7F6"><input type="TEXT" name="cp_price"
					value="${couponVO.cp_price}"style="width: 100%; height: 100%" id="mcp_price"></td>
				<td style="width:8%;" bgcolor="#9CC7F6">優惠券備註：</td>
				<td style="width:12%;" bgcolor="#9CC7F6"><input type="TEXT" name="cp_detail"
					value="${couponVO.cp_detail}"style="width: 100%; height: 100%" id="mcp_detail"></td>
					<td style="width:12%;" bgcolor="#9CC7F6"><input type="hidden" name="action" value="addCouponTypeNo"> <input
			type="submit" name="Submit" value="增加優惠券"></td>
                
			</tr>

		</table>

</form>
<button onClick="magic()">神奇小按鈕</button>
</div>
<div style="margin-top: 50px;">
<div style="float:left;">
<%@ include file="page1ForListAllCoupon1.file"%>
</div>
<div style="float:right;">
<%@ include file="page2ForListAllCoupon2.file"%>
</div>
		<table style=" width:100%;">
			<tr bgcolor="#999999">

				<th style="width: 14%;">優惠券編號</th>
				<th style="width: 14%;">優惠券種類</th>
				<th style="width: 14%;">優惠券價格</th>
				<th style="width: 14%;">優惠券備註</th>
				<th style="width: 14%;">產生日期</th>
				<th style="width: 14%;"></th>
				<th style="width: 14%;"></th>
			</tr>

			<c:forEach var="couponVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
				<tr bgcolor=#C4E1FF>
					<td align="center" bgcolor="#9CC7F6">${couponVO.cp_no}</td>
					<td align="center" bgcolor="#9CC7F6">${couponVO.cp_name}</td>
					<td align="center" bgcolor="#9CC7F6">${couponVO.cp_price}元</td>
					<td align="center" bgcolor="#9CC7F6">${couponVO.cp_detail}</td>
					<td align="center" bgcolor="#9CC7F6">${couponVO.cp_javaTime}</td>
					<td style="width:10%;" bgcolor="#9CC7F6"><input type="submit" name="Submit" value="修改"></td>
                <td style="width:10%;" bgcolor="#9CC7F6">
                <FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/CpGetServlet"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="cp_no" value="${couponVO.cp_no}"> <input
							type="hidden" name="whichPage" value="<%=whichPage%>"> <input
							type="hidden" name="action" value="delete">
					</FORM></td>
				</tr>
			</c:forEach>

		</table>

	</div>
</div>

</div>

  <div class="buttonBar" style="margin-top:100px; background-color:#F3F8FE; margin:5px 5px 5px 3px;"></div>
<script>

function magic(){
	
	$("#mcp_name").val("活動優惠券500元");
	$("#mcp_price").val("500");
	$("#mcp_detail").val("算你賺到");
}


if (${'true'.equals(param.give)}){
 Swal.fire(
   '',  
   '優惠券發送成功!',
   'success'
   )
}


</script>


</body>
</html>