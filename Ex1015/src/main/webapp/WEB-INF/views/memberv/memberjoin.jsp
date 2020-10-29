<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function idcheck(){
		var mid = document.getElementById("mid").value;
		$.ajax({
			type : "post",
			url : "idcheck",
			data : {"mid": mid},
			datatype : "text",
			success : function(result){
				var idc = document.getElementById("idcheckdiv");
				if(result=="ok")
					{idc.innerHTML ="사용가능한 아이디 입니다";
					 idc.style.color="green";
					}
				else
					{idc.innerHTML ="이미 사용 중인 아이디 입니다";
					 idc.style.color="red";
					}
			},
			error : function(){
				alert("ajax실패");
			}
		});
		
	}
	
	function phonech()  {var pnum=document.getElementById("mphone").value;
    var exp = /^\d{3}-\d{4}-\d{4}$/;
    var num=document.getElementById("pch");
    if(pnum.match(exp))
       {num.style.color="green";
        num.innerHTML="전화번호 형식 맞음";
        num.style.fontSize= "12px";
       }
    else
       {num.style.color="red";
        num.style.fontSize= "12px";
        num.innerHTML="전화번호 형식 안맞음";
       }
   }
	
	 function pwdCheck() {var exp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%#?&])[A-Za-z\d$@$!%#?&]{8,16}$/;
     //비밀번호 검증을 위한 정규식(어떠한 것이 들어가야만 한다)
     // 소문자,대문자,숫자,특수문자가 포함되고 자릿수는 8~16[]   
     var pwd = document.getElementById("mpassword").value;
     var pwdch=document.getElementById("pwdch");
     if(pwd.match(exp))
        {pwdch.style.color="green";
         pwdch.innerHTML="비밀번호 형식 맞음";
         pwdch.style.fontSize= "12px";
        }
     else
        {pwdch.style.color="red";
         pwdch.innerHTML="비밀번호 형식 안맞음";
         pwdch.style.fontSize= "12px";
        }
    }
	 function joingo(){
		 joinform.submit();
	 }
	 
	 function pwdEqFn()  {var pwd = document.getElementById("mpassword").value;
     var pwdch = document.getElementById("mpasswordch").value;
     var eqmsg = document.getElementById("pwdEq");
     if(pwd==pwdch)
        {eqmsg.style.color = "green";
        eqmsg.style.fontSize= "12px";
        eqmsg.innerHTML="일치";
        }
     else
        {eqmsg.style.color = "red";
        eqmsg.style.fontSize= "12px";
        eqmsg.innerHTML="불일치";
        }
    }

</script>
</head>
<body>
	<form action="memberjoingo" method="post" enctype="multipart/form-data" name="joinform">
		아이디<input type="text" name="mid" id="mid">
		<input type="button" onclick="idcheck()" value="아이디 중복체크"><br>
		<div id="idcheckdiv"></div><br>
		
		비밀번호<input type="text" name="mpassword" id="mpassword" onkeyup="pwdCheck()"><br>
		<div id="pwdch"></div><br>
		
		 <div style="background-color: white; margin-top: 5px;" class="boxradious">
        비밀번호확인<input  style="width: 90%;border: white;"  class ="boxsize boxradious" 
        type="text" id="mpasswordch" name="mpasswordch" placeholder="비밀번호를 입력하세요"
            onkeyup="pwdEqFn()">
            <i class="fas fa-unlock-alt"  style="margin-left: 5px;"></i>
            <!-- onkeyup : 키보드가 눌릴 때마다 함수가 호출 -->
        </div>
    
    <div id="pwdEq"></div><br>
		
		
		이름<input type="text" name="mname" id="mname"><br>
		
		생년월일<input type="date" name="mbirth" id="mbirth"><br>
		이메일<input type="email" name="memail" id="memail"><br>
		
		주소<br>
		<input type="text" id="sample6_postcode" placeholder="우편번호" name="maddress1">
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="sample6_address" placeholder="주소" name="maddress2"><br>
		<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="maddress3">
		<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="maddress4">
		<br>
				
		휴대폰<input type="text" name="mphone" id="mphone"><br>
		<div id="pch"></div><br>
		프로필사진<input type="file" name="mphoto" id="mphoto"><br>
	</form>
	<button onclick="joingo()">회원가입</button>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>