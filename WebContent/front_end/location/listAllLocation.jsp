<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.location.model.LocationVO"%>
<%@ page import="com.location.model.LocationService"%>
<%@ page import="com.location.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
	LocationService locationSvc = new LocationService();
	List<LocationVO> list = locationSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>�Ҧ����u��� - listAllLocation.jsp</title>

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
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>

	<h4>�����m�߱ĥ� EL ���g�k����:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>�Ҧ����u��� - listAllLocation.jsp</h3>
				<h4>
					<a href="/DA106_G5/front_end/location/select_page.jsp"><img src="/DA106_G5/front_end/location/images/back1.gif"
						width="100" height="32" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<!--loc_no, loc_typeno, longitude, latitude, loc_status, loc_address, loc_pic -->
	<table>
		<tr>
			<th>�a�нs��</th>
			<th>�a�����O�s��</th>
			<th>�g��</th>
			<th>�n��</th>
			<th>�a�Ъ��A</th>
			<th>�a�}</th>
			<th>�Ϥ�</th>
			<th>�ק�</th>
			<th>�R��</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="LocationVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
	<!--loc_no, loc_typeno, longitude, latitude, loc_status, loc_address, loc_pic -->
			<tr>
				<td>${LocationVO.loc_no}</td>
				<td>${LocationVO.loc_typeno}</td>
				<td>${LocationVO.longitude}</td>
				<td>${LocationVO.latitude}</td>
				<td>${LocationVO.loc_status}</td>
				<td>${LocationVO.loc_address}</td>
				<td>${LocationVO.loc_pic}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/location/location.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="�ק�"> <input type="hidden"
							name="loc_no" value="${LocationVO.loc_no}"> <input type="hidden"
							name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/location/location.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="�R��"> <input type="hidden"
							name="loc_no" value="${LocationVO.loc_no}"> <input type="hidden"
							name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>