<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.location.model.LocationVO"%>
<%@ page import="com.location.model.LocationService"%>
<%@ page import="com.location.model.*"%>

<%
  LocationVO locationVO = (LocationVO) request.getAttribute("locationVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���u��ƭק� - update_location_input.jsp</title>

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
	<tr><td>
		 <h3>�a�и�ƭק� - update_location_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<!--loc_no, loc_typeno, longitude, latitude, loc_status, loc_address, loc_pic -->
<FORM METHOD="post" ACTION="location.do" name="form1">
<table>
	<tr>
		<td>�a�нs��:<font color=red><b>*</b></font></td>
		<td><%=locationVO.getLoc_no()%></td>
	</tr>
	<tr>
		<td>���O�s��:</td>
		<td><input type="TEXT" name="loc_typeno" size="45" value="<%=locationVO.getLoc_typeno()%>" /></td>
	</tr>
	<tr>
		<td>�g��:</td>
		<td><input type="TEXT" name="longitude" size="45"	value="<%=locationVO.getLongitude()%>" /></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>���Τ��:</td> -->
<!-- 		<td><input name="hiredate" id="f_date1" type="text" ></td> -->
<!-- 	</tr> -->
	<tr>
		<td>�n��:</td>
		<td><input type="TEXT" name="latitude" size="45"	value="<%=locationVO.getLatitude()%>" /></td>
	</tr>
	<tr>
		<td>�a�Ъ��A:</td>
		<td><input type="TEXT" name="loc_status" size="45" value="<%=locationVO.getLoc_status()%>" /></td>
	</tr>
	<tr>
		<td>�a�}:</td>
		<td><input type="TEXT" name="loc_address" size="45" value="<%=locationVO.getLoc_address()%>" /></td>
	</tr>

<%-- 	<jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>����:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="deptno"> -->
<%-- 			<c:forEach var="deptVO" items="${deptSvc.all}"> --%>
<%-- 				<option value="${deptVO.deptno}" ${(empVO.deptno==deptVO.deptno)?'selected':'' } >${deptVO.dname} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr> -->

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="loc_no" value="<%=locationVO.getLoc_no()%>">
<input type="submit" value="�e�X�ק�"></FORM>
</body>
</html>