<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllGroup.jsp'>查詢</a>揪團列表<br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="group.do" >
        <b>輸入揪團編號 (如grp00001):</b>
        <input type="text" name="grp_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="grpSvc" scope="page" class="com.grouper.model.GrouperService" />
   
  <li>
     <FORM METHOD="post" ACTION="group.do" >
       <b>選擇揪團編號:</b>
       <select size="1" name="grp_no">
         <c:forEach var="GrouperVO" items="${grpSvc.all}" > 
          <option value="${GrouperVO.grp_no}">${GrouperVO.grp_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
</ul>


<h3>揪團管理</h3>

<ul>
  <li><a href='addGroup.jsp'>成立</a>揪團</li>
</ul>

</body>
</html>