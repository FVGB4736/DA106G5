<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*"%>
<%@ page import="com.vainTest.product.model.*"%>

<%
ProductVO productVO = (ProductVO) request.getAttribute("productVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<%= productVO == null %> 


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	<form method="POST" action="ProductServlet" name="form1">
		<table>
            <tr>
				<td>商品編號:<font color=red><b>*</b></font></td>
		     <td><input type="TEXT" name="pd_name" value=""></td>
			</tr>

			<tr>
				<td>商品名稱：</td>
				<td><input type="TEXT" name="pd_name" value=""></td>
			</tr>
			<tr>
				<td>商品價格：</td>
				<td><input type="TEXT" name="pd_price" value=""></td>
			</tr>
			<tr>
				<td>商品詳述：</td>
				<td><input type="TEXT" name="pd_detail" value=""></td>
			</tr>
				
			<tr>
				<td>產品商品分類：</td>
				<td><select size="1" name="pd_typeNo">
				<option value="PTN00001">服飾-上身</option>
				<option value="PTN00002">服飾-下身</option>
				<option value="PTN00003">鞋類</option>
				<option value="PTN00004">配件</option>
				<option value="PTN00005">健康食品</option>
				</select></td>
			</tr>


		</table>

		<input type="hidden" name="action" value="updateProduct"> <input
			type="submit" name=新增商品>
	</form>

<br>
<br>
<a href="ShpoManager.jsp">回管理商城首頁</a>



</body>
</html>