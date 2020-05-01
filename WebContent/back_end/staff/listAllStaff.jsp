<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.staff.model.*"%>
<%@ page import="com.abl.model.*"%>
<%@ page import="com.auth.model.*"%>
<%@ page import="java.util.*"%>

<%
	// �|���b���Y�O���Ʀr�A�|�����D(�v���C�����})
	StaffService staffSvc = new StaffService();
    List<StaffVO> list = staffSvc.getAll();
    pageContext.setAttribute("list",list);
    
    AbilityService abilitySvc = new AbilityService();
    Map<String, String> abilityMap = abilitySvc.getAllToMap();
    pageContext.setAttribute("abilityMap",abilityMap);
    
    AuthorityService authoritySvc = new AuthorityService();
    pageContext.setAttribute("authoritySvc",authoritySvc);
    
    String action = request.getParameter("action");  // �ΨӧP�_�O���^�Ӧ������A�M�walert����T��
    pageContext.setAttribute("action",action);
%>

<html>
<head>
<title>�Ҧ��޲z����� - listAllStaff.jsp</title>

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
  
  .authorityRow{
  	display:none;
  }
  form{
  	margin:0px;
  }
</style>

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
		//  ��EL
	$(document).ready(function(){
		$(".authorityRow").find("*").addClass("authorityRow");
		<%if("update_authority".equals(action) || "update".equals(action)){%>
			Swal.fire({
				  icon: 'success',
				  title: '�ק令�\',
				  showConfirmButton: false,
				  timer: 1500
				})
		<%}else if("insert".equals(action)){%>
			Swal.fire({
			  icon: 'success',
			  title: '�s�W���\',
			  showConfirmButton: false,
			  timer: 1500
			})
		<%};%>
	});
	
	function show(data){
		
		$(data).stop(false,true);
		if($(data).attr("style") == "height: 0px;"){
			$(data).toggleClass("authorityRow");
			$(data).animate({height:'30px'},"slow",function(){
				$(data).find("*").toggleClass("authorityRow");
			})
		}else{
			$(data).find("*").toggleClass("authorityRow");
			$(data).animate({height:'0px'},"slow",function(){
				$(data).toggleClass("authorityRow");
			})
		}
	}
	
</script>
</head>
<body>

<table id="table-1">
	<tr>
		<td>
			<h3>�޲z��${staffVO.staff_name}</h3>
			<h3>�Ҧ��޲z����� - listAllStaff.jsp</h3>
			<h4><a href="select_page.jsp">�^����</a></h4>
		</td>
	</tr>
</table>

	<!-- �s�W�޲z�� -->
	<form METHOD="POST" action="<%=request.getContextPath()%>/back_end/staff/staff.do">
		<button type="submit" name="action" value="for_addStaff">�s�W�޲z��</button>
	</form>	
	
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
		<th>�޲z��ID</th>
		<th>�޲z���m�W</th>
		<th>�[�J���</th>
		<th>���A   �z��</th>
		<th>��ƭק�</th>
		<th>�v���ק�</th>
	</tr>
	<c:forEach var="staffVO" items="${list}">
		
		<tr ${param.staff_id.equals(staffVO.staff_id)?"bgcolor='#CCCCFF'":""}>
			<td>${staffVO.staff_id}</td>
			<td>${staffVO.staff_name}</td>
			<td>${staffVO.staff_join}</td>
			<td>${staffStatus[staffVO.staff_status]}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/staff/staff.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     
			     <input type="hidden" name="staff_id"  value="${staffVO.staff_id}">
			     <input type="hidden" name="action"	value="getOne_For_Update">
			  </FORM>
			</td>
			<td><button onclick="show(${staffVO.staff_id})">�ק�</button></td>
		</tr>
		<%-- �v�� --%>
		<tr id="${staffVO.staff_id}" class="authorityRow" style="height: 0px;">
			<td colspan="6">
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/staff/authority.do">
				<c:set var="authoritySet" value="${authoritySvc.getOneStaffAuthority(staffVO.staff_id)}"/> 
				<c:forEach var="map" items="${abilityMap}">
					<label>
					<input type="checkbox" name="ability_no" value="${map.key}" ${authoritySet.contains(map.key)?'checked':''}>
					${map.value}
					</label>&emsp;
				</c:forEach>&emsp;
				
				<input type="hidden" name="staff_id"  value="${staffVO.staff_id}">
				<button type="submit" name="action" value="update_authority">�e�X�ק�</button>
				</FORM>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>