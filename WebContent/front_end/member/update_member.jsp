<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>update_member</title>
</head>
<body>
	<form METHOD="POST" action="member.do" enctype="multipart/form-data">
	
		�b���G${memberVO.mb_id}<br>
		�K�X�G<input type="password" name="mb_pwd" value="${memberVO.mb_pwd}"><br>
		�W�r�G<input type="text" name="mb_name" value="${memberVO.mb_name}"><br>
		
		�ʧO�G
		<input type="radio" id="gender1" name="mb_gender">
    	<label for="gender1">�k</label>
    	<input type="radio" id="gender2" name="mb_gender">
    	<label for="gender2">�k</label><br>
    	
		Line�G<input type="text" name="mb_line" value="${memberVO.mb_line}"><br>
		�ͤ�G<input type="text" name="mb_birthday" value="${memberVO.mb_birthday}"><br>
		e-mail�G<input type="text" name="mb_email" value="${memberVO.mb_email}"><br>
		�j�Y�ӡG<input type="file" name="mb_pic"><br>
		
        <input type="hidden" name="action" value="update"><br>
        <input type="reset" value="�M��">
        <input type="submit" value="�e�X"><br>
        
	</form>
</body>
</html>