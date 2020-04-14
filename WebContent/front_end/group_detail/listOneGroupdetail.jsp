<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.group_detail.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	Grp_detailVO grp_detailVO = (Grp_detailVO) request.getAttribute("grp_detailVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>員工資料 - listOneGroup.jsp</title>

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
	width: 600px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>揪團資料 - ListOneGroup.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>會員編號</th>
		<th>揪團編號</th>
		<th>報到狀態</th>
		
	</tr>
	<tr>		
		<td><%=grp_detailVO.getMb_id()%></td>
		<td><%=grp_detailVO.getGrp_no()%></td>
		<td><%=grp_detailVO.getGrp_register()%></td>

	</tr>
	
</table>

</body>
</html>