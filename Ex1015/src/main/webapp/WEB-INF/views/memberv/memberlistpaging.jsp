<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	
	//삭제
	function memberdelete(mid){
		location.href="memebrdelete?mid="+mid;
	}
	
</script>
</head>
<body>
	<h2>memberlistpaging.jsp</h2>
		<table border="1">
		<tr>
			<td>회원ID</td>
			<td>이름</td>
			<td>생년월일</td>
			<td>이메일</td>
			<td>전화번호</td>
		</tr>
		<c:forEach var="member" items="${memberlist}" >
			<tr>
				<td>${member.mid}</td>
				<td>${member.mname}</td>
				<td>
				<a href="#" onclick="memberviewgo('${member.mid}')">${member.mbirth}</a></td>
				<td>${member.memail}</td>
				<td>${member.mphone}</td>
				<td><button onclick="memberdelete('${member.mid}')">삭제</button></td>
			</tr>
		</c:forEach>
	</table>
	<!-- 페이징 처리 -->
	<c:if test="${paging.page<=1}">
	[이전]&nbsp;
	</c:if>
	
	<c:if test="${paging.page>1}">
		<a href="memberlistpaging?page=${paging.page-1}">[이전]</a>&nbsp;
	</c:if>
	
	<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="i" step="1">
		<c:choose>
			<c:when test="${i eq paging.page}">
			${i}
			</c:when>
			<c:otherwise>
				<a href="memberlistpaging?page=${i}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<c:if test="${paging.page>=paging.maxpage}">
		[다음]
	</c:if>
	
	<c:if test="${paging.page<paging.maxpage}">
		<a href="memberlistpaging?page=${paging.page+1}">[다음]</a>
	</c:if>

	
</body>
</html>