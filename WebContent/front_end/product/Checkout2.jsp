<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="java.util.* "%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.cp_get.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mb.model.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mode II �d�ҵ{�� - ���b����</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="vendor/TWzipcode/jquery.twzipcode.min.js"></script>


<style>
.city, .town{width: 100%;}
.f1{float:left;margin-left:5px;margin-right:5px;width:calc(5% - 10px)}
.f2{float:left;margin-left:5px;margin-right:5px;width:calc(10% - 10px)}
.f3{float:left;margin-left:5px;margin-right:5px;width:calc(15% - 10px)}
.f4{float:left;margin-left:5px;margin-right:5px;width:calc(20% - 10px)}
.f5{float:left;margin-left:5px;margin-right:5px;width:calc(25% - 10px)}
.f6{float:left;margin-left:5px;margin-right:5px;width:calc(30% - 10px)}
.f7{float:left;margin-left:5px;margin-right:5px;width:calc(35% - 10px)}
.f8{float:left;margin-left:5px;margin-right:5px;width:calc(40% - 10px)}
.f9{float:left;margin-left:5px;margin-right:5px;width:calc(45% - 10px)}
.f10{float:left;margin-left:5px;margin-right:5px;width:calc(50% - 10px)}
.f11{float:left;margin-left:5px;margin-right:5px;width:calc(55% - 10px)}
.f12{float:left;margin-left:5px;margin-right:5px;width:calc(60% - 10px)}
.f13{float:left;margin-left:5px;margin-right:5px;width:calc(65% - 10px)}
.f14{float:left;margin-left:5px;margin-right:5px;width:calc(70% - 10px)}
.f15{float:left;margin-left:5px;margin-right:5px;width:calc(75% - 10px)}
.f16{float:left;margin-left:5px;margin-right:5px;width:calc(80% - 10px)}
.f17{float:left;margin-left:5px;margin-right:5px;width:calc(85% - 10px)}
.f18{float:left;margin-left:5px;margin-right:5px;width:calc(90% - 10px)}
.f19{float:left;margin-left:5px;margin-right:5px;width:calc(95% - 10px)}
.f20{float:left;margin-left:5px;margin-right:5px;width:calc(100% - 10px)}

.followlist {
	cellpadding: "10";
	cellspacing: "5";
	padding-bottom: 100px;
	
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
  
  .buttonBar{
width:100%;
background-color:#3960D0;
height:100px;
margin-top:100;
}
</style>
</head>
<jsp:useBean id="pd_typeService" scope="page" class="com.pd_type.model.Pd_typeService" />
<body bgcolor="#FFFFFF">
<jsp:include page="/front_end/product/ShopHomeBar.jsp" flush="ture" />



	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
<div align="center" style="margin-top:100px;">
	<font size="+3">�ӫ� - ��g���O�P���f��T </font></div>
	<hr>
	<p>
	<div align="center">
	<table  class="followlist" border="1" cellpadding="3" cellspacing="3" style="border: 3px solid #FFFFFF; ">
		<tr bgcolor="#999999"  align="center">
		    <th style ="width:150px;"><font color="black">���~�Ϥ�</font></th>
			<th style ="width:200px;"><font color="black">���~����</font></th>
			<th style ="width:100px;"><font color="black">���~�W��</font></th>
			<th style ="width:100px;"><font color="black">���~�s��</font></th>
			<th style ="width:100px;"><font color="black">���</font></th>
			<th style ="width:100px;"><font color="black">�ؤo</font></th>
			<th style ="width:100px;"><font color="black">�ƶq</font></th>
		</tr>
		<%
			MemberService memberSvc = new MemberService();
			MemberVO memberVO =(MemberVO)session.getAttribute("memberVO");
			//��memberVO�����o�|�`�ϥΨ쪺mb_id
			pageContext.setAttribute("mb_id", memberVO.getMb_id());

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

		
			<tr bgcolor=#C4E1FF>
				<td style ="height:100px;"><div align="center" >
				<a href='<%=request.getContextPath()%>/ShoppingServlet?action=findOneProduct&pd_no=<%=order.getPd_no()%>'></a>
				<img src="<%= request.getContextPath()%>/ProductPicReader?pd_no=<%=order.getPd_no()%>" style="width:auto;">
						
					</div></td>
					<td width="100" ><div align="center">
						<b><font color="black">${pd_typeService.searchType(order.pd_typeNo).pd_typeName}</font></b>
					</div></td>
				<td><div align="center">
						<b><font color="black"><%=pd_name%></font></b>
					</div></td>
				<td><div align="center">
						<b><font color="black"><%=pd_no%></font></b>
					</div></td>
				<td><div align="center">
						<b><font color="black"><%=pd_price%></font></b>
					</div></td>
					<td><div align="center">
						<b><font color="black"><%=pd_typeSize%></font></b>
					</div></td>
				<td><div align="center">
						<b><font color="black"><%=pd_quantity%></font></b>
					</div></td>
			</tr>
			
			
			
			
			<%
				}
			%>
			
			<tr bgcolor=#C4E1FF>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="center">
						<font color="red"><b>�`���B�G</b></font>
					</div></td>
				
				<td align="center"><font color="red"><b>$<%=totalPrice%></b></font></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr bgcolor=#C4E1FF>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="center">
						<font color="red"><b>�u�f����B�G</b></font>
					</div></td>
				<td align="center"><font color="red"><b>$${discount}</b></font></td>
				<td></td>
				
				<td></td>
			</tr>
			
	</table>
	
</div>
<div style="margin-left:260px; border-style:solid; width:900px;" >
	<form method="POST" action="<%=request.getContextPath()%>/CheckOutServlet">
		<div style="float:left;">
			��g���O�a�}
		</div>
		<div id="twzipcode" style="float:left;"></div>
		<div>
			<input type="TEXT" name="od_add" id="address">
		</div>
	    <div style="float:left;">
	    	��ܦ��O�覡
	    </div>
		<div>
			<input type="radio" name="payMethod" value="�f��I��">�f��I��
			<input type="radio" name="payMethod" value="�H�Υd�I�O">�H�Υd�I�O 
			<input type="radio" name="payMethod" value="ibonú�O">ibonú�O
			<input type="radio" name="payMethod" value="LinePay">LinePay
		</div>
		<input type="hidden" name="action" value="getOd_detail_Information"> 
		<input type="hidden" name="mb_id" value="${mb_id}"> 
		<input type="submit" name="Submit" value="���b">
	</form>
</div>

 <div class="buttonBar"></div>
<script type="text/javascript">
	$("#twzipcode").twzipcode({
	 /* zipcodeName: "number", */ // �ۭq�l���ϸ�input���Ҫ�name��,��K�e���
		zipcodeIntoDistrict: true
	});

// �g�@��jQuery���ܪ���r���a�}���,�ϥΪ̤͵�����
$("#twzipcode").on('change', function () {
	
 var county = $("#twzipcode").twzipcode('get','county');
 var district = $("#twzipcode").twzipcode('get','district');

 var result = county+district;
 $("#address").val(result);
 });
</script>

</body>
</html>
