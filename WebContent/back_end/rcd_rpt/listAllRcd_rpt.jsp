<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rcd_rpt.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    Rcd_rptService rcd_rptSvc = new Rcd_rptService();
    List<Rcd_rptVO> list = rcd_rptSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ����u��� - listAllEmp.jsp</title>

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
	<tr><td>
		 <h3>�Ҧ����u��� - listAllRCD_RPT.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>���|�s��</th>
		<th>���|���e</th>
		<th>���|���A</th>
		<th>�����s��</th>
		<th>�|���s��</th>
		<th>�ק�</th>
		<th>�f��</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="rcd_rptVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${rcd_rptVO.rcd_rpt_no}</td>
			<td>${rcd_rptVO.rpt_reason}</td>
			<td>${(rcd_rptVO.rpt_status)!=1?(rcd_rptVO.rpt_status==2?'���\':'����'):'�|���f��'}</td> 
			<td>${rcd_rptVO.rcd_no}</td>
			<td>${rcd_rptVO.mb_id}</td>
			<td>

			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/rcd_rpt/rcd_rpt.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="rcd_rpt_no"  value="${rcd_rptVO.rcd_rpt_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/back_end/rcd_rpt/rcd_rpt.do" style="margin-bottom: 0px;">
					<input type="submit" value="����/���\"> 
					<!-- 		//cmt_rpt_no, rpt_reason, rpt_status, cmt_no, mb_id -->
					<input type="hidden" name="rcd_rpt_no" value="${rcd_rptVO.rcd_rpt_no}"> 
					<input type="hidden" name="rpt_reason" value="${rcd_rptVO.rpt_reason}">
					<input type="hidden" name="rpt_status" value="${rcd_rptVO.rpt_status}">
					<input type="hidden" name="rcd_no" value="${rcd_rptVO.rcd_no}">						
					<input type="hidden" name="mb_id" value="${rcd_rptVO.mb_id}">
					<input type="hidden" name="action" value="fakeDelete">
				</FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>