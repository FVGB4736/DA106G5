<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.pd_type.model.*"%>





<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css" media="screen">


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
  
  .buttonBar{
width:100%;
background-color:#FF004C;
height:100px;
margin-top:100;
}

</style>
<meta charset="UTF-8">
<title>商品管理</title>


<%
	String pd_typeNo = (String) session.getAttribute("pd_typeNo");
	ProductService productService = new ProductService();

	List<ProductVO> list = (List<ProductVO>) session.getAttribute("list");

	if (pd_typeNo == null || ("").equals(pd_typeNo)) {

		list = productService.getAll();

		session.setAttribute("list", list);
		Collections.reverse(list);

	} else {
		list = productService.useTypeSearchProducts(pd_typeNo);
		 session.setAttribute("list", list);
		
		Collections.reverse(list);
	}
%>



<jsp:useBean id="pd_typeService" scope="page"
	class="com.pd_type.model.Pd_typeService" />
	<jsp:include page="ShopManagerBar.jsp" />
</head>
<body>
	<%-- <div style="border:2px #FFD382 groove; float:left;"><c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if></div> --%>


<div class="1" align="center" style="margin-top:50px;width:80%;margin-left:10%;" >
<font size="+3">商品列表：</font>
		<hr>
<form name="checkoutForm" action="<%=request.getContextPath()%>/ProductServlet?action=searchTypeList" method="POST">
<div style="float:left;"> <select size="1" name="pd_typeNo">
		 <option value="">全部商品類別
         <c:forEach var="pd_typeVO" items="${pd_typeService.all}" > 
          <option value="${pd_typeVO.pd_typeNo}">${pd_typeVO.pd_typeName}
         </c:forEach>   
       </select>
				<input type="submit" value="選取類別">
				
				<input type="hidden" name="pd_typeNo" value="${pd_typeVO.pd_typeNo}">
				<%@ include file="AllList2File1.file"%>
				</div>
				<div style="float:right;">
				<%@ include file="AllList2File2.file"%>
				
				<%@ include file="AllList2File3.file"%>
				</div>
			</form>
	




		
<div align="center">
                
	<table  class ="tableList" style="width:100%;">

		<tr bgcolor="#999999">
			<th width="10%">商品圖片</th>
			<th width="10%">商品編號</th>
			<th width="20%">商品名稱</th>
			<th width="10%">商品價格</th>
			<th width="10%">商品類別</th>
			<th width="10%">商品狀態</th>
			<th width="10%"></th>
			<th width="10%"></th>
			<th width="10%"></th>

		</tr>
		
		<c:forEach var="productVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr >
				<td align="center" style="height: 100px; width: 150px;"><div style="width:100%;overflow:hidden;"><img
					src="<%= request.getContextPath()%>/ProductPicReader?pd_no=${productVO.pd_no}"
					style="width:auto;"></div></td>
				<td bgcolor=#9CC7F6>${productVO.pd_no}</td>
				<td bgcolor=#9CC7F6>${productVO.pd_name}</td>
				<td bgcolor=#9CC7F6>${productVO.pd_price}元</td>
				<td bgcolor=#9CC7F6>${pd_typeService.searchType(productVO.pd_typeNo).pd_typeName}</td>
				<td bgcolor=#9CC7F6 class="UpOrDown">${productVO.pd_status==1?'下架':'上架'}</td>
				<td bgcolor=#9CC7F6 align="center" >
			
			<%-- 	<FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/ProductServlet">
				
				 <div >
				    <input type="submit" value="下架">
				    <input type="hidden" name="pd_no" value="${productVO.pd_no}">
				    <input type="hidden" name="action" value="changePd_status1">
				    <input type="hidden" name="whichPage" value="<%=whichPage%>">
				  </div>
				</FORM> --%>
				<div style="margin-button:3px;">
					<button class="upProduct">上架</button></div>
				 <input type="hidden" name="pd_no" value="${productVO.pd_no}">
				<div style="margin-top:3px;"><button class="downProduct">下架</button></div>
		   <input type="hidden" name="pd_no" value="${productVO.pd_no}">
				<%-- <div style="margin-top:4px; align:center;">	
				    <FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/ProductServlet">	
				    		
				<input type="submit" value="上架">
				<input type="hidden" name="pd_no" value="${productVO.pd_no}">
				<input type="hidden" name="action" value="changePd_status2">
				<input type="hidden" name="whichPage" value="<%=whichPage%>"></FORM>
				</div> --%>
		   
				
					</td>
				


				<td bgcolor=#9CC7F6><FORM METHOD="POST"
						ACTION="<%=request.getContextPath()%>/ProductServlet"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改">
						 <input type="hidden" name="pd_no" value="${productVO.pd_no}"> 
						<input type="hidden" name="pd_name" value="${productVO.pd_name}">
						<input type="hidden" name="action" value="getOne_For_update">
						<input type="hidden" name="whichPage" value="<%=whichPage%>">
					</FORM></td>
				<td bgcolor=#9CC7F6>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ProductServlet"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="pd_no" value="${productVO.pd_no}"> <input
							type="hidden" name="whichPage" value="<%=whichPage%>"> <input
							type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>

		</c:forEach>
	</table>
	</div>
</div>	
  <div class="buttonBar" style="margin-top:100px; background-color:#9CC7F6; margin:5px 5px 5px 3px;"></div>
  <script
		  src="https://code.jquery.com/jquery-3.5.0.js"
		  integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc="
		  crossorigin="anonymous">
	</script>
  
	
	<script>  

	// AJAX 關注

	$(document).ready(function(){
		
	
		$(".upProduct").on("click",function(){
			var upProduct = $(this);
			
		
			$.ajax({
				type:"POST",
				url: "ProductServlet",
				data:{
					"action":"upProduct",
					"pd_no":upProduct.parent().next().val()
				},	
			});
			upProduct.parent().parent().prevAll(".UpOrDown").text("上架");
		});
		
		$(".downProduct").on("click",function(){
			var downProduct = $(this);
			
		
			$.ajax({
				type:"POST",
				url: "ProductServlet",
				data:{
					"action":"downProduct",
					"pd_no":downProduct.parent().next().val()
				},				
			});
			downProduct.parent().parent().prevAll(".UpOrDown").text("下架");
		});
	});
	</script>
</body>
</html>