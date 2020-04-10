<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.grouper.model.GrouperVO"%>
<%@ page import="com.grouper.model.GrouperService"%>
<%@ page import="com.grouper.model.*"%>

<%
	GrouperVO grouperVO = (GrouperVO) request.getAttribute("grouperVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>揪團資料修改 - update_group_input.jsp</title>

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
		 <h3>揪團資料修改 - update_group_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="group.do" name="form1">
<table>
	<tr>
		<td>揪團名稱:</td>
		<td><input type="TEXT" name="grp_no" size="45" 
			 value="<%= (grouperVO==null)? "gro00010" : grouperVO.getGrp_no()%>" /></td>
	</tr>
	<tr>
		<td>發起人會員編號:</td>
		<td><input type="TEXT" name="mb_id" size="45"
			 value="<%= (grouperVO==null)? "Tommy" : grouperVO.getMb_id()%>" /></td>
	</tr>
	<tr>
		<td>地標編號:</td>
		<td><input type="TEXT" name="loc_no" size="45"
			 value="<%= (grouperVO==null)? "loc00003" : grouperVO.getLoc_no()%>" /></td>
	</tr>
	
	<tr>
		<td>報名開始時間:</td>
		<td><input name="grp_applystart" id="a_date1" type="text"></td>
	</tr>
	
	<tr>
		<td>報名結束時間:</td>
		<td><input name="grp_applyend" id="a_date2" type="text"></td>
	</tr>
	
	<tr>
		<td>活動開始時間:</td>
		<td><input name="grp_start" id="s_date1" type="text"></td>
	</tr>
	
	<tr>
		<td>活動結束時間:</td>
		<td><input name="grp_end" id="s_date2" type="text"></td>
	</tr>
	
	<tr>
		<td>揪團標題:</td>
		<td><input type="TEXT" name="grp_name" size="45"
			 value="<%= (grouperVO==null)? "晨跑" : grouperVO.getGrp_name()%>" /></td>
	</tr>
	
	<tr>
		<td>揪團內容:</td>
		<td><input type="TEXT" name="grp_content" size="45"
			 value="<%= (grouperVO==null)? "別睡了，起床" : grouperVO.getGrp_content()%>" /></td>
	</tr>
	
	<tr>
		<td>揪團人數上限:</td>
		<td><input type="TEXT" name="grp_personmax" size="45"
			 value="<%= (grouperVO==null)? "25" : grouperVO.getGrp_personmax()%>" /></td>
	</tr>
	
	<tr>
		<td>揪團人數下限:</td>
		<td><input type="TEXT" name="grp_personmin" size="45"
			 value="<%= (grouperVO==null)? "5" : grouperVO.getGrp_personmin()%>" /></td>
	</tr>
	
	<tr>
		<td>揪團人數:</td>
		<td><input type="TEXT" name="grp_personcount" size="45"
			 value="<%= (grouperVO==null)? "18" : grouperVO.getGrp_personcount()%>" /></td>
	</tr>
	
	<tr>
		<td>揪團狀態:</td>
		<td><input type="TEXT" name="grp_status" size="45"
			 value="<%= (grouperVO==null)? "1" : grouperVO.getGrp_status()%>" /></td>
	</tr>
	<tr>
		<td>揪團追蹤人數:</td>
		<td><input type="TEXT" name="grp_follow" size="45"
			 value="<%= (grouperVO==null)? "80" : grouperVO.getGrp_follow()%>" /></td>
	</tr>
	

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="grp_no" value="<%=grouperVO.getGrp_no()%>">
<input type="submit" value="送出修改"></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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
 	       timepicker:true,        //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: '${grouperVO.grp_applystart}', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#a_date2').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,        //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: '${grouperVO.grp_applyend}', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#s_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,        //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: '${grouperVO.grp_start}', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#s_date2').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:true,        //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: '${grouperVO.grp_end}', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
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

        
        //      2.以下為某一天之後的日期無法選擇
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


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
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