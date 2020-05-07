<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mb.model.*"%>
<%@ page import="com.abl.model.*"%>
<%@ page import="com.auth.model.*"%>
<%@ page import="java.util.*"%>

<%
	// �|���b���Y�O���Ʀr�A�|�����D(�v���C�����})
	MemberService memberSvc = new MemberService();
    List<MemberVO> list = memberSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>�Ҧ��|����� - listAllMember.jsp</title>
<style>
  	#wrap{
        text-align:center;
        font-family: 'Mamelon';	
	}
	b{
		font-size: 2.5vh;
	}
	#wrap_title{
		text-align:center;
	}
	#title{
		font-family: 'italics_hollow';
		line-height:10vh;
		font-size: 5.5vh;
		font-weight:bold;
		letter-spacing: 0.3vw;
		
		color:#0373f0;
		border-bottom:3px solid #0373f0;
	}
  
  table {
	width: 80vw;
	background-color: white;
	margin:2vh auto 0px auto;
	
	letter-spacing: 0.1vw;
	font-size: 2.5vh;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
  
  .btn{
		font-size: 2.5vh;
		line-height:1vh;
		color: #fff;
		font-family: 'Mamelon';
		background-color: #60A5F3;
		border-radius: 50px;
		
		height: 5vh;
		width: 4vw;
	}
  form{
  	margin:0px;
  }
  #mb_pic{
  	height: 13vh;
	width: 6.5vw;
  }
</style>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
		//  ��EL
	$(document).ready(function(){
		<c:if test="${'back_end_update'.equals(param.action)}">
			Swal.fire({
			  icon: 'success',
			  title: '�ק令�\',
			  showConfirmButton: false,
			  timer: 1500
			})
		</c:if>
	});
	
</script>
</head>
<body>
<div id="wrap_title">
	<span id="title">�Ҧ��|�����</span><br>
</div>
<div id="wrap">

<table>
	<tr>
		<th>�|��ID</th>
<!-- 		<th>�|���K�X</th> -->
		<th>�m�W</th>
		<th>�ʧO</th>
		<th>�ͤ�</th>
		<th>�H�c</th>
		<th>�Ӥ�</th>
		<th>�|��<br>����</th>
		<th>�Q���|<br>����</th>
		<th>
			Status<br>
<!-- 			<select> -->
<!-- 				<option value="0">����</option> -->
<%-- 				<c:forEach var="map" items="${memberStatus}"> --%>
<%-- 					<option value="${map.key}">${map.value}</option> --%>
<%-- 				</c:forEach> --%>
<!-- 			</select> -->
		</th>
<!-- 		<th>�|��Line ID</th> -->
<!-- 		<th>�|��Line�Y�K</th> -->
<!-- 		<th>�|��Line�W��</th> -->
<!-- 		<th>�|��Line���A</th> -->
		<th>�ק�<br>���</th>
	</tr>
	
	<%@ include file="pages/page1.file" %>
	<c:forEach var="memberVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr ${param.mb_id.equals(memberVO.mb_id)?"bgcolor='#d4e7fa'":""}>
			<td>${memberVO.mb_id}</td>
<%-- 			<td>${memberVO.mb_pwd}</td> --%>
			<td>${memberVO.mb_name}</td>
			<td>${memberGender[memberVO.mb_gender]}</td>
			<td>${memberVO.mb_birthday}</td>
			<td>${memberVO.mb_email}</td>
			<td><img id="mb_pic" src="<%= request.getContextPath()%>/MemberPicReader?mb_id=${memberVO.mb_id}"></td>
			<td>${memberVO.mb_lv}</td>
			<td>${memberVO.mb_rpt_times}</td>
			<td>${memberStatus[memberVO.mb_status]}</td>
<%-- 			<td>${memberVO.mb_line_id}</td> --%>
<%-- 			<td>${memberVO.mb_line_pic}</td> --%>
<%-- 			<td>${memberVO.mb_line_display}</td> --%>
<%-- 			<td>${memberVO.mb_line_status}</td> --%>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/staff/member.do" style="margin-bottom: 0px;">
			     <input type="hidden" name="mb_id"  value="${memberVO.mb_id}">
			     <input type="hidden" name="includePath" value="${includePath}">
			     <button class="btn" type="submit" name="action" value="getOne_Member_For_Update">�ק�</button>
			  </FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="pages/page2.file" %>
</div>

</body>
</html>