<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Group: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Group: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Group: Home</p>

<h3>��Ƭd��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllEmp.jsp'>List</a> all Groups.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="group.do" >
        <b>��J���νs�� (�pgrp00001):</b>
        <input type="text" name="Grp_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="grpSvc" scope="page" class="com.grouper.model.GrouperService" />
   
  <li>
     <FORM METHOD="post" ACTION="group.do" >
       <b>��ܴ��νs��:</b>
       <select size="1" name="grp_no">
         <c:forEach var="GrouperVO" items="${grpSvc.all}" > 
          <option value="${GrouperVO.grp_no}">${GrouperVO.grp_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="group.do" >
       <b>��ܭ��u�m�W:</b>
       <select size="1" name="grp_no">
         <c:forEach var="GrouperVO" items="${grpSvc.all}" > 
          <option value="${GrouperVO.grp_no}">${GrouperVO.grp_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
</ul>


<h3>���u�޲z</h3>

<ul>
  <li><a href='addGroup.jsp'>Add</a> a new Group.</li>
</ul>

</body>
</html>