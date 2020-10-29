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
	//검색
	function boardsearch(){
		searchform.submit();
	}
	
	//상세조회
	function boardviewgo(bnum){
		location.href="boardview?bnum="+bnum;
	};
	
	//삭제
	function boarddelete(bnumber){
		$.ajax({
			type : "post",
			url : "boarddelete",
			data : {"bnumber" : bnumber},
			dataType : "text",
			success : function(result){
				
			},
			error : function(){
				
			}
		});
		
	};
	
	//수정
	function boardupdate(bnumber){
		location.href="boardupdate?bnumber="+bnumber+"&page="+${paging.page};
	};
	
	//조회순 정렬
	function boardarrange(){
		$.ajax({
			type :"post",
			url : "boardarrange",
			dataType : "json",
			success : function(result){
				output="<table border='1'>";
				output+="<tr>";
				output+="<th>글번호</th><th>작성자</th><th>글제목</th><th>작성일</th><th>조회수</th>";
				output+="</tr>";
				for(var i in result)
				   {output+="<tr>";
					output+="<td>"+result[i].btitle +"</td>";
					output+="<td>"+result[i].bcontents +"</td>";
					output+="<td>"+result[i].bwriter +"</td>";
					output+="<td>"+result[i].bdate +"</td>";
					output+="<td>"+result[i].bhits +"</td>";
					output+="<td><button onclick='boardupdate("+result[i].bnumber+")'>수정</button></td>";
					output+="<td><button onclick='boarddelete("+result[i].bnumber+")'>삭제</button></td>";
					output+="</tr>";
				   }
				output+="</table>";
				$("#listdiv").html(output);
			},
			error : function(){
			}
		});
	};
	
	function memberlist(){
		location.href="memberlistpaging"
	};

	function logout(){
		location.href="logout";
	};
	function mypage(){
		location.href="mypage?mid="+"${sessionScope.loginid}";
	};
	
	function filedown(fn){
		location.href="filedownload?filename="+fn;
	};
	
	
	
</script>
</head>
<body>
	<% 
	Cookie[] cookies = request.getCookies();
	for(Cookie cookie : cookies)
		{ String cookiename1 =cookie.getName();
		  String cookieval12 =cookie.getValue();
	%>
			<%=cookiename1 %>  
			<%=cookieval12 %>
	
	<% 
		}
	%>
	<h2>메인화면</h2>
	<form action="naversearch" name="sform" method="get">
	네이버 통합검색<input type="text" name="nsearch">
	<input type="submit" value="검색">
	</form>
	
		<button onclick="mypage()">마이페이지</button>
		<button onclick="logout()">로그아웃</button>
	
	
		<button onclick="boardarrange()">조회순 정렬</button>
		<button onclick="memberlist()">회원목록</button>
	
	
		<form action="boardsearch" method="get" name="searchform">
			<select id="searchtype" name="searchtype">
				<option value="searchtitle">제목</option>
				<option value="searchwriter">작성자</option>
			</select>
			<input type="text" name="keyword">
			<input type="button" onclick="boardsearch()" value="검색">
		</form>
		
		
		
		<button onclick="boardarrange()">조회순 정렬</button>
		<button onclick="memberlist()">회원목록</button>
	
	<div id="listdiv">
		<table border="1">
		<tr>
			<td>글번호</td>
			<td>작성자</td>
			<td>글제목</td>
			<td>작성일자</td>
			<td>조회수</td>
			<td>파일</td>
		</tr>
		<c:forEach var="board" items="${boardlist}" >
			<tr>
				<td>${board.bnumber}</td>
				<td>${board.bwriter}</td>
				<td>
				<a href="#" onclick="boardviewgo('${board.bnumber}')">${board.btitle}</a></td>
				<td>${board.bdate}</td>
				<td>${board.bhits}</td>
				<td>${board.bfilename}</td>
				<td><button onclick="filedown('${board.bfilename}')">파일 다운로드</button></td>
			<c:if test="${sessionScope.loginid eq 'admin'}">	
				<td><button onclick="boardupdate('${board.bnumber}')">수정</button></td>
				<td><button onclick="boarddelete('${board.bnumber}')">삭제</button></td>
			</c:if>	
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5"><button onclick="location.href='boardwritego'">글쓰기</button> </td>
		</tr>
	</table>
	</div>
	
	

	<!-- 페이징 처리 -->
	<c:if test="${paging.page<=1}">
	[이전]&nbsp;
	</c:if>
	
	<c:if test="${paging.page>1}">
		<a href="boardlistpaging?page=${paging.page-1}">[이전]</a>&nbsp;
	</c:if>
	
	<c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="i" step="1">
		<c:choose>
			<c:when test="${i eq paging.page}">
			${i}
			</c:when>
			<c:otherwise>
				<a href="boardlistpaging?page=${i}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<c:if test="${paging.page>=paging.maxpage}">
		[다음]
	</c:if>
	
	<c:if test="${paging.page<paging.maxpage}">
		<a href="boardlistpaging?page=${paging.page+1}">[다음]</a>
	</c:if>

	<div id="viewdiv"></div>
	
	
	
</body>
</html>