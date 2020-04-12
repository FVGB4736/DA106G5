<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cmt_rpt.model.Cmt_rptVO"%>
<%@ page import="com.cmt_rpt.model.Cmt_rptService"%>
<%@ page import="com.cmt_rpt.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	@SuppressWarnings("unchecked")
	List<Cmt_rptVO> list = (List<Cmt_rptVO>)request.getAttribute("cmt_rptVO_list");
	if(list==null || list.size() == 0){
		list=(List<Cmt_rptVO>)session.getAttribute("list");
	}
	session.setAttribute("list", list);
%>


<html>
<head>
<title>所有留言檢舉資料 - listAllUWish.jsp</title>

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

	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有留言檢舉資料 - listAllUWish.jsp</h3>
				<h4>
					<a href="<%= request.getContextPath() %>/back_end/cmt_rpt/select_page.jsp">
						<img src="<%= request.getContextPath() %>/back_end/cmt_rpt/images/back1.gif" width="100" height="32" border="0">
						回首頁
					</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<table>
		<tr>
			<th>檢舉編號</th>
			<th>原因</th>
			<th>狀態</th>
			<th>留言編號</th>
			<th>檢舉會員</th>
			<th>修改</th>
			<th>未審/已審</th>
		</tr>
<%-- 		<%@ include file="page1.file"%> --%>
<%-- 		<c:forEach var="cmt_rptVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> --%>
		<c:forEach var="cmt_rptVO" items="${list}">
			<tr>
				<td>${cmt_rptVO.cmt_rpt_no}</td>
				<td>${cmt_rptVO.rpt_reason}</td>
				<td>${cmt_rptVO.rpt_status}</td>
				<td>${cmt_rptVO.cmt_no}</td>
				<td>${cmt_rptVO.mb_id}</td>
				<td>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/cmt_rpt/cmt_rpt.do" style="margin-bottom: 0px;">
						<input type="submit" value="修改"> 
						<input type="hidden" name="cmt_rpt_no" value="${cmt_rptVO.cmt_rpt_no}"> 
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/cmt_rpt/cmt_rpt.do" style="margin-bottom: 0px;">
						<input type="submit" value="未審/已審"> 
						<!--//cmt_rpt_no, rpt_reason, rpt_status, cmt_no, mb_id -->
						<input type="hidden" name="cmt_rpt_no" value="${cmt_rptVO.cmt_rpt_no}"> 
						<input type="hidden" name="rpt_reason" value="${cmt_rptVO.rpt_reason}">
						<input type="hidden" name="rpt_status" value="${cmt_rptVO.rpt_status}">
						<input type="hidden" name="cmt_no" value="${cmt_rptVO.cmt_no}">
						<input type="hidden" name="mb_id" value="${cmt_rptVO.mb_id}">
						<input type="hidden" name="action" value="fakeDelete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
<%-- 	<%@ include file="page2.file"%> --%>

</body>
</html>