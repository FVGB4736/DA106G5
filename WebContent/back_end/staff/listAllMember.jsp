<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mb.model.*"%>
<%@ page import="com.abl.model.*"%>
<%@ page import="com.auth.model.*"%>
<%@ page import="java.util.*"%>

<%
	// �|���b���Y�O���Ʀr�A�|�����D(�v���C�����})
	MemberService staffSvc = new MemberService();
    List<MemberVO> list = staffSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>�Ҧ��|����� - listAllMember.jsp</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
  #table-1 {
  	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  #table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
  
  table {
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
  
  .authorityRow{
  	display:none;
  }
  form{
  	margin:0px;
  }
</style>

</head>
<body>

<table id="table-1">
	<tr>
		<td>
			<h3>�޲z��${staffVO.staff_name}</h3>
			<h3>�Ҧ��|����� - listAllStaff.jsp</h3>
			<h4><a href="select_page.jsp">�^����</a></h4>
		</td>
	</tr>
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
		<th>�|��ID</th>
<!-- 		<th>�|���K�X</th> -->
		<th>�|���m�W</th>
		<th>�|���ʧO</th>
		<th>�|���ͤ�</th>
		<th>�|���H�c</th>
		<th>�|���Ӥ�</th>
<!-- 		<th>�|������</th> -->
<!-- 		<th>�|���Q���|����</th> -->
		<th>�|�����A</th>
<!-- 		<th>�|��Line ID</th> -->
<!-- 		<th>�|��Line�Y�K</th> -->
<!-- 		<th>�|��Line�W��</th> -->
<!-- 		<th>�|��Line���A</th> -->
		<th>�ԲӸ��</th>
	</tr>
	<c:forEach var="memberVO" items="${list}">
		
		<tr ${param.member_id.equals(memberVO.mb_id)?"bgcolor='#CCCCFF'":""}>
			<td>${memberVO.mb_id}</td>
<%-- 			<td>${memberVO.mb_pwd}</td> --%>
			<td>${memberVO.mb_name}</td>
			<td>${memberGender[memberVO.mb_gender]}</td>
			<td>${memberVO.mb_birthday}</td>
			<td>${memberVO.mb_email}</td>
			<td><img src="<%= request.getContextPath()%>/MemberPicReader?mb_id=${memberVO.mb_id}" width="100px"></td>
<%-- 			<td>${memberVO.mb_lv}</td> --%>
<%-- 			<td>${memberVO.mb_rpt_times}</td> --%>
			<td>${memberStatus[memberVO.mb_status]}</td>
<%-- 			<td>${memberVO.mb_line_id}</td> --%>
<%-- 			<td>${memberVO.mb_line_pic}</td> --%>
<%-- 			<td>${memberVO.mb_line_display}</td> --%>
<%-- 			<td>${memberVO.mb_line_status}</td> --%>
			<td>
			  <FORM METHOD="post" ACTION="member.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�d��">
			     
			     <input type="hidden" name="mb_id"  value="${memberVO.mb_id}">
			     <input type="hidden" name="action"	value="getOne_Member_For_Update">
			     <input type="hidden" name="servletPath" value="<%=request.getServletPath()%>"><br>
			  </FORM>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>