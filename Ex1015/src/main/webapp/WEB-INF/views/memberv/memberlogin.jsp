<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		var key = getCookie("key"); //
		$("#mid").val(key);
		
		if($("#mid").val() !=""){
			$("idSaveCheck").attr("checked", true);
		}
		
		$("idSaveCheck").change(function(){
			if($("idSaveCheck").is(":checked")){
				setCookie("key", $("#mid").val(), 7);
			} else {
				deleteCookie("key");
			}
		});
		
		$("#mid").keyup(function(){
			if($("#idSaveCheck").is(":checked")){
				setCooki("key", $("#mid").val(), 7);
			}
		});
	});
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue; //쿠키에 넣는다
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1); //쿠키 제거
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	
</script>
</head>
<body>
	<form action="memberlogingo" method="post">
		아이디<input type="text" name="mid">
		비밀번호<input type="text" name="mpassword">
		<button>로그인</button>
	</form>
	
	
	
</body>
</html>