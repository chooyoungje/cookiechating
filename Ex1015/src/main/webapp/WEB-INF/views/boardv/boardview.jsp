<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
	//��� �ۼ�
	function replywrite(){
		var replyer = "${sessionScope.loginid}";
		var cbnumber =${bdto.bnumber};
		var reply =document.getElementById("reply").value;
		$.ajax({
			tyle :"post",
			url :"replywrite",
			data :{"cbnumber":cbnumber,"replyer":replyer,"reply":reply},
			datatype :"json",
			success :function(result){
				output="<table border='1'>";
				output+="<tr>";
				output+="<th>��۹�ȣ</th><th>�ۼ���</th><th>����</th><th>�ۼ���</th>";
				output+="</tr>";
				for(var i in result)
				{output+="<tr>";
				 output+="<td>"+result[i].cnumber+"</td>";
				 output+="<td>"+result[i].replyer+"</td>";
				 output+="<td>"+result[i].reply+"</td>";
				 output+="<td>"+result[i].rdate+"</td>";
				 output+="<td><button onclick='replydelete("+result[i].cnumber+")'>����</button></td>";
				 output+="</tr>";
				}
				$("#replydiv").html(output);
				$("#reply").val("");
			},
			error :function(){
				
			}
		})
	}
	
	//��� ����
	function replydelete(cnumber){
		var cbnumber =${bdto.bnumber};
		$.ajax({
			tyle :"post",
			url :"replydelete",
			data :{"cnumber":cnumber,"cbnumber":cbnumber},
			datatype :"json",
			success :function(result){
				output="<table border='1'>";
				output+="<tr>";
				output+="<th>��۹�ȣ</th><th>�ۼ���</th><th>����</th><th>�ۼ���</th>";
				output+="</tr>";
				for(var i in result)
					{output+="<tr>";
					 output+="<td>"+result[i].cnumber+"</td>";
					 output+="<td>"+result[i].replyer+"</td>";
					 output+="<td>"+result[i].reply+"</td>";
					 output+="<td>"+result[i].rdate+"</td>";
					 output+="<td><button onclick='replydelete("+result[i].cnumber+")'>��ۻ���</button></td>";
					 output+="</tr>";
					}
				$("#replydiv").html(output);
				$("#reply").val("");
			},
			error :function(){
				
			}
		})
	}
	

</script>
</head>
<body>

	<table border='1'>
		<tr>
			<th>����</th><th>����</th><th>�ۼ���</th><th>�ۼ���</th><th>��ȸ��</th>
		</tr>
		<tr>
			<td>${bdto.btitle}</td>
			<td>${bdto.bcontents} </td>
			<td>${bdto.bwriter}</td>
			<td>${bdto.bdate}</td>
			<td>${bdto.bhits}</td>
			<td>${bdto.bfile}</td>
		</tr>
	</table>
	�ۼ���<input type="text" value="${sessionScope.loginid}" readonly>
		����<input type="text" name="reply" id="reply">
		<input type="button" onclick="replywrite()" value="��� �ۼ�">
	
	<!--���  -->
	<div id="replydiv">
	<table border='1'>
		<tr>
			<th>����</th><th>����</th><th>�ۼ���</th><th>�ۼ���</th>
		</tr>
		<c:forEach var="i" items="${rlist}">
		<tr>
			<td>${i.cnumber}</td>
			<td>${i.replyer} </td>
			<td>${i.reply}</td>
			<td>${i.rdate}</td>
			<td><button onclick="replydelete('${i.cnumber}')">��� ����</button></td>
		</tr>
		</c:forEach>
	</table><br>
	</div>
		
	
	
</body>
</html>