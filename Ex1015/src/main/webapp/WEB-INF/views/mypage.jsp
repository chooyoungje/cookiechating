<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
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
			console.log("성공");
		},
		error : function(){
			console.log("실패");
		}
	});
};

//수정
function boardupdate(bnumber){
	location.href="boardupdate?bnumber="+bnumber+"&page="+${paging.page};
};

//회원수정
function memupdate(){
	var mid = "${sessionScope.loginid}";
	location.href="memberupdate?mid="+mid;
};

</script>
</head>
<body>
내가쓴글 ${myboard}개
<table border="1">
		<tr>
			<td>회원ID</td>
			<td>이름</td>
			<td>생년월일</td>
			<td>이메일</td>
			<td>전화번호</td>
			<td>주소</td>
			<td>주소</td>
			<td>주소</td>
			<td>주소</td>
			<td>파일</td>
		</tr>
			<tr>
				<td>${mdto.mid}</td>
				<td>${mdto.mname}</td>
				<td>${mdto.mbirth}</td>
				<td>${mdto.memail}</td>
				<td>${mdto.mphone}</td>
				<td>${mdto.maddress1}</td>
				<td>${mdto.maddress2}</td>
				<td>${mdto.maddress3}</td>
				<td>${mdto.maddress4}</td>
				<td>${mdto.mphotoname}</td>
			</tr>
	</table><br>
	<button onclick="memupdate()">회원수정</button>
	
	<div id="listdiv">
	<table border="1">
		<tr>
			<td>글번호</td>
			<td>작성자</td>
			<td>글제목</td>
			<td>작성일자</td>
			<td>조회수</td>
		</tr>
		<c:forEach var="board" items="${boardlist}" >
			<tr>
				<td>${board.bnumber}</td>
				<td>${board.bwriter}</td>
				<td>
				<a href="#" onclick="boardviewgo('${board.bnumber}')">${board.btitle}</a></td>
				<td>${board.bdate}</td>
				<td>${board.bhits}</td>
			<c:if test="${sessionScope.loginid eq 'admin'}">	
				<td><button onclick="boardupdate('${board.bnumber}')">수정</button></td>
				<td><button onclick="boarddelete('${board.bnumber}')">삭제</button></td>
			</c:if>	
			</tr>
		</c:forEach>
	</table>
	</div>

</body>
</html>