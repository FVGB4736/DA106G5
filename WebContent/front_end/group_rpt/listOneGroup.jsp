<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.grouper.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
	GrouperVO grouperVO = (GrouperVO) request.getAttribute("grouperVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO����
%>

<html>
<head>
<title>���u��� - listOneEmp.jsp</title>

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

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>���θ�� - ListOneGroup.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>���νs��</th>
		<th>�o�_�H�|���s��</th>
		<th>�a�нs��</th>
		<th>���W�}�l�ɶ�</th>
		<th>���W�����ɶ�</th>
		<th>���ʶ}�l�ɶ�</th>
		<th>���ʵ����ɶ�</th>
		<th>���μ��D</th>
		<th>���Τ��e</th>
		<th>�H�ƤW��</th>
		<th>�H�ƤU��</th>
		<th>�ثe�H��</th>
		<th>���Ϊ��A</th>
		<th>���`���μƶq</th>
	</tr>
	<tr>
		<td><%=grouperVO.getGrp_no()%></td>
		<td><%=grouperVO.getMb_id()%></td>
		<td><%=grouperVO.getLoc_no()%></td>
		<td><%=grouperVO.getGrp_applystart()%></td>
		<td><%=grouperVO.getGrp_applyend()%></td>
		<td><%=grouperVO.getGrp_start()%></td>
		<td><%=grouperVO.getGrp_end()%></td>
		<td><%=grouperVO.getGrp_name()%></td>
		<td><%=grouperVO.getGrp_content()%></td>
		<td><%=grouperVO.getGrp_personmax()%></td>
		<td><%=grouperVO.getGrp_personmin()%></td>
		<td><%=grouperVO.getGrp_personcount()%></td>
		<td><%=grouperVO.getGrp_status()%></td>
		<td><%=grouperVO.getGrp_follow()%></td>
	</tr>
	
</table>

</body>
</html>