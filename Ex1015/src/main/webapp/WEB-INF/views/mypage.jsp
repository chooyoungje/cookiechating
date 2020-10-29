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
//����ȸ
function boardviewgo(bnum){
	location.href="boardview?bnum="+bnum;
};

//����
function boarddelete(bnumber){
	$.ajax({
		type : "post",
		url : "boarddelete",
		data : {"bnumber" : bnumber},
		dataType : "json",
		success : function(result){
			output="<table border='1'>";
			output+="<tr>";
			output+="<th>�۹�ȣ</th><th>�ۼ���</th><th>������</th><th>�ۼ���</th><th>��ȸ��</th>";
			output+="</tr>";
			for(var i in result)
			   {output+="<tr>";
				output+="<td>"+result[i].btitle +"</td>";
				output+="<td>"+result[i].bcontents +"</td>";
				output+="<td>"+result[i].bwriter +"</td>";
				output+="<td>"+result[i].bdate +"</td>";
				output+="<td>"+result[i].bhits +"</td>";
				output+="<td><button onclick='boardupdate("+result[i].bnumber+")'>����</button></td>";
				output+="<td><button onclick='boarddelete("+result[i].bnumber+")'>����</button></td>";
				output+="</tr>";
			   }
			output+="</table>";
			$("#listdiv").html(output);
			console.log("����");
		},
		error : function(){
			console.log("����");
		}
	});
};

//����
function boardupdate(bnumber){
	location.href="boardupdate?bnumber="+bnumber+"&page="+${paging.page};
};

//ȸ������
function memupdate(){
	var mid = "${sessionScope.loginid}";
	location.href="memberupdate?mid="+mid;
};

</script>
</head>
<body>
�������� ${myboard}��
<table border="1">
		<tr>
			<td>ȸ��ID</td>
			<td>�̸�</td>
			<td>�������</td>
			<td>�̸���</td>
			<td>��ȭ��ȣ</td>
			<td>�ּ�</td>
			<td>�ּ�</td>
			<td>�ּ�</td>
			<td>�ּ�</td>
			<td>����</td>
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
	<button onclick="memupdate()">ȸ������</button>
	
	<div id="listdiv">
	<table border="1">
		<tr>
			<td>�۹�ȣ</td>
			<td>�ۼ���</td>
			<td>������</td>
			<td>�ۼ�����</td>
			<td>��ȸ��</td>
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
				<td><button onclick="boardupdate('${board.bnumber}')">����</button></td>
				<td><button onclick="boarddelete('${board.bnumber}')">����</button></td>
			</c:if>	
			</tr>
		</c:forEach>
	</table>
	</div>

</body>
</html>