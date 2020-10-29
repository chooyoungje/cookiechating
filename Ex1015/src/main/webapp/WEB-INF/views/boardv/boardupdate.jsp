<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	
</script>
</head>
<body>


	<form action="boardupdatep" method="post" name="upform" enctype="multipart/form-data">
			${bdto.bfilename}
			<input type="hidden" name="bnumber" id="bnumber" value="${bdto.bnumber}"><br>
			작성자<input type="text" name="bwriter" id="bwriter" value="${bdto.bwriter}" readonly><br>
			글 제목<input type="text" name="btitle" id="btitle" value="${bdto.btitle}"><br>
			글 내용<textarea rows="10" cols="5" name="bcontents" id="bcontents" >${bdto.bcontents}</textarea><br>
			첨부파일<input type="file" name="bfile"  id="bfile" ><br>
			<input type="submit" value="수정하기">
	</form>
</body>
</html>