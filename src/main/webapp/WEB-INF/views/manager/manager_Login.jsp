<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script type="text/javascript">
      $(function(){
         $("#mgLogin_submit").click(function(){
               var f=document.mgLoginForm;
               var id=$("#mglogin_id_INPUT").val();
               var pw=$("#mgLogin_pw_Input").val();
               var idpw={"mgId":id,"mgPw":pw};
               var idpw=JSON.stringify(idpw);
               if(id == ""){
                  alert("'아이디' 입력란이 공백입니다");
                  f.id.select();
                  return false;
               }
               if(pw == ""){
                  alert("'비밀번호' 입력란이 공백입니다");
                  f.pw.select();
                  return false;
               }
               $.ajax({
                  type:"post",
                  async:true,
                  url:"adminLogin",
                  data:{idpw:idpw},
                  success:function(no){
                     if(no=="1"){
                        f.submit();
                     }else if(no=="2"){
                        var returnAlert = confirm("이곳은 관리자 전용 로그인 화면입니다. 메인으로 돌아가시려면 확인 버튼을 눌러주세요.");
                        if(returnAlert){
                           window.location.href = "home";
                        }
                        else {
                           $("#mglogin_id_INPUT").val('');
                           $("#mgLogin_pw_Input").val('');
                           }//no 클릭 시   
                     }else{
                        alert("[오류] 메소드에서 받은 값이 null입니다. 코딩을 수정해주세요");
                     }
                  },//성공 시,
                  error:function(no){
                     alert("[오류] 전송에 실패하였습니다. 코딩을 확인해주세요")
                  }//실패시
               });//ajax끝
         });//로그인버튼 클릭 함수 끝
      });//javaScript 끝
      </script>
   </head>
   <body>
   <div id="wrap">
      <div class="outer">
         <div class="memberinputArea">
            <h2>관리자 접속</h2>

               <form name="mgLoginForm" action="managerLogin_Actionpage" method="post">
                  <div class="membertitle">아이디</div>
                  <span class="input_area">
                     <input type="text" name="id" id="mglogin_id_INPUT"></span>
                <br><br>
                 <div class="membertitle">비밀번호</div>
                 <span class="input_area">
                     <input type="password" name="pw" id="mgLogin_pw_Input"></span>
                 
                  <div class="btnArea">
                     <a href="home"><button type="button">되돌아가기</button></a>
                     <button type="button" name="mgLogin_submit" id="mgLogin_submit">로그인</button>
                  </div>
               </form>
            </div>

      </div>
    </div>  
   </body>
</html>