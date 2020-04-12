<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.grouper.model.*"%>

<%
  GrouperVO grouperVO = (GrouperVO) request.getAttribute("grouperVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���θ�Ʒs�W - addGroup.jsp</title>

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
		 <h3>���θ�Ʒs�W - addGroup.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~���C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="group.do" name="form1">
<table>
	<tr>
		<td>���ΦW��:</td>
		<td><input type="TEXT" name="grp_no" size="45" 
			 value="<%= (grouperVO==null)? "�d�ç�" : grouperVO.getGrp_no()%>" /></td>
	</tr>
	<tr>
		<td>�o�_�H�|���s��:</td>
		<td><input type="TEXT" name="mb_id" size="45"
			 value="<%= (grouperVO==null)? "MANAGER" : grouperVO.getMb_id()%>" /></td>
	</tr>
	<tr>
		<td>�a�нs��:</td>
		<td><input type="TEXT" name="loc_no" size="45"
			 value="<%= (grouperVO==null)? "MANAGER" : grouperVO.getLoc_no()%>" /></td>
	</tr>
	
	<tr>
		<td>���W�}�l�ɶ�:</td>
		<td><input name="grp_applystart" id="a_date1" type="text"></td>
	</tr>
	
	<tr>
		<td>���W�����ɶ�:</td>
		<td><input name="grp_applyend" id="a_date2" type="text"></td>
	</tr>
	
	<tr>
		<td>���ʶ}�l�ɶ�:</td>
		<td><input name="grp_start" id="s_date1" type="text"></td>
	</tr>
	
	<tr>
		<td>���ʵ����ɶ�:</td>
		<td><input name="grp_end" id="s_date2" type="text"></td>
	</tr>
	
	<tr>
		<td>���μ��D:</td>
		<td><input type="TEXT" name="grp_name" size="45"
			 value="<%= (grouperVO==null)? "�п�J���μ��D" : grouperVO.getGrp_name()%>" /></td>
	</tr>
	
	<tr>
		<td>���μ��D:</td>
		<td><input type="TEXT" name="grp_content" size="45"
			 value="<%= (grouperVO==null)? "�п�J���Τ��e" : grouperVO.getGrp_name()%>" /></td>
	</tr>
	
	<tr>
		<td>���μ��D:</td>
		<td><input type="TEXT" name="grp_personmax" size="45"
			 value="<%= (grouperVO==null)? "10000" : grouperVO.getGrp_personmax()%>" /></td>
	</tr>
	
	<tr>
		<td>���μ��D:</td>
		<td><input type="TEXT" name="grp_personmin" size="45"
			 value="<%= (grouperVO==null)? "10000" : grouperVO.getGrp_personmin()%>" /></td>
	</tr>
	
	<tr>
		<td>���μ��D:</td>
		<td><input type="TEXT" name="grp_personcount" size="45"
			 value="<%= (grouperVO==null)? "10000" : grouperVO.getGrp_personcount()%>" /></td>
	</tr>
	
	<tr>
		<td>���μ��D:</td>
		<td><input type="TEXT" name="grp_status" size="45"
			 value="<%= (grouperVO==null)? "10000" : grouperVO.getGrp_status()%>" /></td>
	</tr>
	<tr>
		<td>����:</td>
		<td><input type="TEXT" name="grp_follow" size="45"
			 value="<%= (grouperVO==null)? "100" : grouperVO.getGrp_follow()%>" /></td>
	</tr>

	<jsp:useBean id="deptSvc" scope="page" class="com.group_rpt.model.Group_rptService" />
	<tr>
		<td>����:<font color=red><b>*</b></font></td>
		<td><select size="1" name="deptno">
			<c:forEach var="deptVO" items="${deptSvc.all}">
				<option value="${deptVO.deptno}" ${(empVO.deptno==deptVO.deptno)? 'selected':'' } >${deptVO.dname}
			</c:forEach>
		</select></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<% 
  java.sql.Timestamp grp_applystart = null;
  try {
	  grp_applystart = grouperVO.getGrp_applystart();
   } catch (Exception e) {
	   grp_applystart = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>
<% 
  java.sql.Timestamp grp_applyend = null;
  try {
	  grp_applystart = grouperVO.getGrp_applyend();
   } catch (Exception e) {
	   grp_applystart = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>
<% 
  java.sql.Timestamp grp_start = null;
  try {
	  grp_applystart = grouperVO.getGrp_start();
   } catch (Exception e) {
	   grp_applystart = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>
<% 
  java.sql.Timestamp grp_end = null;
  try {
	  grp_applystart = grouperVO.getGrp_end();
   } catch (Exception e) {
	   grp_applystart = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#a_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=grp_applystart%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        $.datetimepicker.setLocale('zh');
        $('#a_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=grp_applyend%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        $.datetimepicker.setLocale('zh');
        $('#s_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=grp_start%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        $.datetimepicker.setLocale('zh');
        $('#s_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=grp_end%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        
   
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.�H�U���Y�@�Ѥ��᪺����L�k���
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>