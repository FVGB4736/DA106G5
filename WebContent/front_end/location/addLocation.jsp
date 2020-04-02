<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.location.model.LocationVO"%>
<%@ page import="com.location.model.*"%>

<%
	LocationVO locationVO = (LocationVO) request.getAttribute("locationVO");
%>
<%=locationVO == null%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>���u��Ʒs�W - addLocation.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>���u��Ʒs�W - addLocation.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="select_page.jsp"><img src="images/tomcat.png"
						width="100" height="100" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>��Ʒs�W:</h3>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="location.do" name="form1">
		<table>
			<tr>
				<td>�a�����O�s��:</td>
				<!-- 				loc_no, loc_typeno, longitude, latitude, loc_status, loc_address, loc_pic -->
				<td><input type="TEXT" name="loc_typeno" size="45"
					value="<%=(locationVO == null) ? "3" : locationVO.getLoc_typeno()%>" /></td>
			</tr>
			<tr>
				<td>�g��:</td>
				<td><input type="TEXT" name="longitude" size="45"
					value="<%=(locationVO == null) ? "123.456" : locationVO.getLongitude()%>" /></td>
			</tr>
			<tr>
				<td>�n��:</td>
				<td><input type="TEXT" name="latitude" size="45"
					value="<%=(locationVO == null) ? "78.90" : locationVO.getLatitude()%>" /></td>
			</tr>
			<!-- 			<tr> -->
			<!-- 				<td>���Τ��:</td> -->
			<!-- 				<td><input name="hiredate" id="f_date1" type="text"></td> -->
			<!-- 			</tr> -->
			<tr>
				<td>�a�Ъ��A:</td>
				<td><input type="TEXT" name="loc_status" size="45"
					value="<%=(locationVO == null) ? "1" : locationVO.getLoc_status()%>" /></td>
			</tr>
			<tr>
				<td>�a�Цa�}:</td>
				<td><input type="TEXT" name="loc_address" size="45"
					value="<%=(locationVO == null) ? "1" : locationVO.getLoc_address()%>" /></td>
			</tr>
			<tr>
				<td>�a�йϤ�:</td>
				<td><input type="image" name="loc_status" size="45"
					value="<%=(locationVO == null) ? "1" : locationVO.getLoc_pic()%>" /></td>
			</tr>


			<%-- 			<jsp:useBean id="deptSvc" scope="page" --%>
			<%-- 				class="com.dept.model.DeptService" /> --%>
			<!-- 			<tr> -->
			<!-- 				<td>����:<font color=red><b>*</b></font></td> -->
			<!-- 				<td><select size="1" name="deptno"> -->
			<%-- 						<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
			<%-- 							<option value="${deptVO.deptno}" --%>
			<%-- 								${(empVO.deptno==deptVO.deptno)? 'selected':'' }>${deptVO.dname} --%>
			<%-- 						</c:forEach> --%>
			<!-- 				</select></td> -->
			<!-- 			</tr> -->

		</table>
		<br> 
		<input type="hidden" name="action" value="insert"> 
		<input type="submit" value="�e�X�s�W">
	</FORM>
</body>
</html>