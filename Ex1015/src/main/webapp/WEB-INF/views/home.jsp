<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
</head>
<body>

	<button onclick="location.href='memberjoin'">회원가입</button>
	<button onclick="location.href='memberlogin'">로그인</button>
	<button onclick="location.href='echogo'">로그인</button>
	
	<h3>카카오로 회원가입</h3>
	<a href="kakaojoin">
	<img src="${pageContext.request.contextPath}/resources/img/kakao_login_medium_narrow.png">
	</a>
	
	<h3>네이버로 회원가입</h3>
	<a href="naverjoin">
	<img src="${pageContext.request.contextPath}/resources/img/네이버 아이디로 로그인_축약형_Green.PNG">
	</a>
	<a href="filedownload">
	<img src="${pageContext.request.contextPath}/resources/mphotoTulips">
	</a>
</body>
</html>
