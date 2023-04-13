<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

//유효성 검사
$(function(){
	$("#loginCheck").click(function(){
		
		var login_id=$("#login_id").val();
		var login_pw=$("#login_pw").val();
		var idpw={"login_id":login_id,"login_pw":login_pw};
		var idpw=JSON.stringify(idpw);
		
		//아이디 공백
		if(login_id=="")
		{
			alert("ID를 입력해 주세요");
			$("#login_id").focus();
			return false;
		 }//공백
		//비밀번호 공백	
		if(login_pw=="")
		{
			alert("PW를 입력해 주세요");
			$("#login_pw").focus();
			return false;
		}//공백
		
		$.ajax({
            type:"post",
            async:true,
            url:"memberChk",
            data:{idpw:idpw},
            success:function(no)
           {
               if(no=="1")
               {
            	   f.submit();                 
               }
                 else if(no=="2")
                {
                	 alert("ID 또는 PW를 확인해 주세요");
                	  $("#login_id").val('');
                      $("#login_pw").val('');
                                
                }//값이 2일 때
            },//성공 시,
            
            error:function(no)
            {
               alert("전송에 실패하였습니다");
            }//실패시
           
         });//ajax끝
	   });//펑션
	});	//js
		
</script>
<div id="wrap">
<div class="outer">
	<div id="memberinputArea">
		<form id="login" action="member_Login_Save" method="post">
		<br>
			<h1>로그인</h1>
			<br><br>
	 		 <div class="membertitle">아이디</div>
	 		 <span class="input_area">
	 		 <input type="text" id="login_id" name="login_id"></span>
	 		 <br><br>
			 
			 <div class="membertitle">비밀번호</div>
	 	 	 <span class="input_area">
	 	 	 <input type="password" id="login_pw" name="login_pw"></span>
	
			<div class="btnArea">
				<button id="loginCheck">로그인</button>
			</div>
		</form>
	</div>
</div>
</div>		
</body>
</html>