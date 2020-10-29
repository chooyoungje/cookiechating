<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function write(){
		writeform.submit();
	}
</script>
</head>
<body>
<form action="boardwrite" method="post" name="writeform" enctype="multipart/form-data">
	작성자<input type="text" value="${sessionScope.loginid}" name="bwriter" readonly>
	제목<input type="text" name="btitle">
	내용<textarea rows="10" cols="5" name="bcontents"></textarea>
	첨부파일<input type="file" name="bfile">
	<input type="submit" value="작성">
</form>	

</body>
</html>