<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
   <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <meta charset="UTF-8">
      <title></title>
      <script type="text/javascript">
      window.onload = function() {
         $(function(){
            $("#mgMov_Check").click(function(){
               var f=document.movin_form;
               
               var mov=$("#mgMovie").val();
               var dir=$("#mgDirector").val();
               var code=$("#mgMovCode").val()
               var mov_check={"movie_ch":mov,"director_ch":dir,"code":code};
               var mov_check=JSON.stringify(mov_check);
               
               if(mov == ""){
                  alert("'제목' 입력란이 공백입니다");
                  f.mgMovie.select();
                  return false;
               }
               if(dir == ""){
                  alert("'감독' 입력란이 공백입니다");
                  f.mgDirector.select();
                  return false;
               }
                  
               $.ajax({
                  type:"post",
                  async:true,
                  url:"MgMoviCheck",//controll servlet에서 받을 맵핑 value 값
                  data:{mcheck:mov_check}, //servlet에서 request로 받을 이름
                  success:function(fixMov){
                     if(fixMov=="0"){
                        alert("등록 가능한 영화제목입니다.");
                        $("#nn").attr("value","0");
                     }else if(fixMov=="1"){
                        var mvResult = confirm("[중복]입력하신 영화 '"+mov+"'은(는) 이미 등록된 영화입니다. \n 새 영화로 추가 하시겠습니까?");
                        if(mvResult){
                                $("#nn").attr("value","0");
                        }
                        else {
                           $("#mgMovie").val('');
                           $("#mgPoster").val('');
                           $("#mgDirector").val('');
                                $("#nn").attr("value","1");
                           }//no 클릭 시   
                     }else if(fixMov=="2"){
                        var mvResult2 = confirm("' "+mov+" '로 등록된 영화가 2개 이상입니다. \n 정말 등록하시겠습니까?");
                        if(mvResult2){
                           $("#nn").attr("value","0");
                        }
                        else {
                           mov='';
                           return;
                        }
                     }else if(fixMov=="ME"){
                        var dirResult = confirm("' 영화제목 '이 변경되지 않았습니다. \n 그대로 등록하시겠습니까?");
                        if(dirResult){
                           $("#nn").attr("value","0");
                        }
                        else {
                           $("#mgMovie").val('');
                           $("#mgPoster").val('');
                           $("#mgDirector").val('');
                                $("#nn").attr("value","1");
                           return;
                        }
                     }else {
                        alert("[오류] 쿼리문에서 받아온 값이 int 값이 아닙니다. 코딩을 확인해주세요")
                     }
                  },//성공 시,
                  error:function(fixMov){
                     alert("[오류] 전송에 실패하였습니다. jQuery 코딩을 확인해주세요")
                  }//실패시
               });//ajax
            });//영화 중복검사
            
            $("#mgMov_submit").click(function(){
               var result = $("#nn").val();
               if(result !== "0"){
                  alert("영화 중복 확인을 먼저 해주세요.");
                  return false;
               }
               else{
                  var f=document.movin_form;
                  var mov=$("#mgMovie").val();
                  var dir=$("#mgDirector").val();
                  var act=$("#mgActor").val();
                  var file=$("#mgPoster").val();
                  var g1=$("#g1").val();
                  var g2=$("#g2").val();
                  var g3=$("#g3").val();
                  var g4=$("#g4").val();
                  
                  if(mov == ""){
                     alert("'제목' 입력란이 공백입니다");
                     f.mgMovie.select();
                     return false;
                  }
                  if(dir == ""){
                     alert("'감독' 입력란이 공백입니다");
                     f.mgDirector.select();
                     return false;
                  }
                  if(act == ""){
                     alert("'배우' 입력란이 공백입니다");
                     f.mgActor.select();
                     return false;
                  }
                  if(file == ""){
                     alert("'포스터' 이미지가 등록되지 않았습니다");
                     f.mgPoster.select();
                     return false;
                  }
                  if(g1==""){
                     alert("'장르' 첫 번 째가 미선택 상태입니다.");
                     f.g1.select();
                     return false;
                  }

                  if(g2==""){
                     console.log(g2);
                     var a=$("#g3_gibon").val();
                     var b=$("#g3_null");
                     if(a!=""||g3!=""){
                        alert("'장르3'을 선택할 수 없습니다.　 '장르2'가 없습니다.");
                        b.find("option[value='']").prop("selected", true);
                        return false;
                     }
                  }//g2 없이 g3 선택하는 경우
                  if(g3==""){
                     var a=$("#g4_gibon").val();
                     var b=$("#g4_null");
                     if(a!=""||g4!=""){
                        alert("'장르4'를 선택할 수 없습니다.　 '장르3'이 없습니다.");
                        b.find("option[value='']").prop("selected", true);
                        return false;
                     }
                  }//g3 없이 g4 선택하는 경우
                  var day=$("#mgReleasedate").val();
                  var date = day.split("-");                   
                  var y = parseInt(date[0], 10),
                     m = parseInt(date[1], 10),
                     d = parseInt(date[2], 10);
                  var dateRegex = /^(?=\d)(?:(?:31(?!.(?:0?[2469]|11))|(?:30|29)(?!.0?2)|29(?=.0?2.(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(?:\x20|$))|(?:2[0-8]|1\d|0?[1-9]))([-.\/])(?:1[012]|0?[1-9])\1(?:1[6-9]|[2-9]\d)?\d\d(?:(?=\x20\d)\x20|$))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
                  var rr = dateRegex.test(d+'-'+m+'-'+y);
                  
                   if(rr = false){
                      alert("'개봉일' 을 다시 확인해주세요");
                     f.mgReleasedate.select();
                     return false;
                   }
                   console.log(g2);
                   if(g2==""){
                	   console.log("빈칸");
                   }else{
                	   console.log("빈칸아님");
                   }
                   
                  f.submit();
               }
            });//영화등록
         });//함수 끝   
         
         var g1 = document.getElementById("g1");
         var g2 = document.getElementById("g2");
         var g3 = document.getElementById("g3");
         var g4 = document.getElementById("g4");
         g2.disabled = true;
          g3.disabled = true;
          g4.disabled = true;
          g1.addEventListener("change", function() {
             var chooseOption = g1.value;
             g2.querySelectorAll("option[value='" + chooseOption + "']").forEach(function(option) {
                 if(option.value !== "") {
                        option.remove();
                    }
             });//g2
             g3.querySelectorAll("option[value='" + chooseOption + "']").forEach(function(option) {
                 if(option.value !== "") {
                        option.remove();
                    }
             });//g3
             g4.querySelectorAll("option[value='" + chooseOption + "']").forEach(function(option) {
                 if(option.value !== "") {
                        option.remove();
                    }
             });
             g2.disabled = false;
             g3.disabled = true;
             g4.disabled = true;
          });//1번에 따른 2,3,4바꾸기
          g2.addEventListener("change", function() {
             var chooseOption = g2.value;
             g3.querySelectorAll("option[value='" + chooseOption + "']").forEach(function(option) {
                 if(option.value !== "") {
                        option.remove();
                    }
             });//g3
             g4.querySelectorAll("option[value='" + chooseOption + "']").forEach(function(option) {
                 if(option.value !== "") {
                        option.remove();
                    }
             });
             g3.disabled = false;
             g4.disabled = true;
          });//2번에 따른 3,4바꾸기
          g3.addEventListener("change", function() {
             var chooseOption = g3.value;
             g4.querySelectorAll("option[value='" + chooseOption + "']").forEach(function(option) {
                 if(option.value !== "") {
                        option.remove();
                    }
             });
             g4.disabled = false;
          });//3번에 따른 4바꾸기   
          const rdate = document.getElementById('mgReleasedate');
          rdate.addEventListener('input', function() {
           const minDate = new Date(rdate.min);
           const maxDate = new Date(rdate.max);
           const chooseDay = new Date(rdate.value);
           if (chooseDay < minDate) {
              rdate.value = rdate.min;
           } else if (chooseDay > maxDate) {
              rdate.value = rdate.max;
           }
         });
        //날짜
          window.addEventListener("DOMContentLoaded", () => {
             const today = new Date();
             const matDay = new Date(today.setMonth(today.getMonth() + 3)).toISOString().split('T')[0];
             const mgReleasedateEl = document.getElementById("mgReleasedate");
             mgReleasedateEl.setAttribute("max", matDay);
          });
      };
         
      </script>
   </head>
   <body>
   <div id="wrap">
      <div class="mainBody_area">
         <div class="mg_movInpt_form_area">
            <form action="movie_Update" method="post" name="movin_form" enctype="multipart/form-data">
               <table class="mvInput_table" align="center">
                  <caption><h3>영화 수정</h3></caption>
                  <tr>
                     <th>영화제목 *</th>
                     <td colspan="4"><input type="text" name="mgMovie" size="45px" id="mgMovie" value="${modi.movie_name}"></td>
                     <td>
                        <input type="button" value="확인" id="mgMov_Check" name="mgMov_Check">
                     </td>
                  </tr>
                  <tr>
                     <th>포스터 *</th>
                     <td colspan="4"><input type="file" name="mgPoster" id="mgPoster"></td>
                     <td><img src="imgsave/movieImg/${modi.movie_poster}" height="80"></td>
                  </tr>
                  <tr>
                     <th>감　독 *</th>
                     <td colspan="4"><input type="text" name="mgDirector" id="mgDirector" size="45px" value="${modi.movie_director}"></td>
                     <td><input type="hidden" value="${modi.movie_code}" id="mgMovCode" name="mgMovCode"></td>
                  </tr>
                  <tr>   
                     <th>주연배우 *</th>
                     <td colspan="5"><input type="text" name="mgActor" id="mgActor" size="58px" value="${modi.movie_actor}"></td>
                  </tr>
                  <tr>
                  </tr>
                  <tr>
                     <th>분 류</th>
                     <td class="selectBox_td"><select id="mgGroup" name="mgGroup">
                           <option value="${modi.movie_group}" selected>기존:${modi.movie_state}</option>
                           <option value="1">국내</option>
                           <option value="2">아시아</option>
                           <option value="3">아메리카</option>
                           <option value="4">유럽</option>
                           <option value="5">아프리카</option>
                           <option value="6">중동</option>
                           <option value="7">오세아니아</option>
                     </select></td>
                     <th>개봉일</th>
                     <td><input type="date" name="mgReleasedate"
                        id="mgReleasedate" min="1895-12-28" max="2023-12-31" value="${modi.movie_day}"></td>
                     <th>러닝타임</th>
                     <td><input type="number" min="5" max="999"
                        name="mgRunningtime" id="mgRunningtime" value="${modi.movie_rtime}">분</td>
                  </tr>
                  <tr>
                     <th>장 르</th>
                     <td class="selectBox_td" colspan="5"><select id="g1" name="mgGenre_s1">
                           <option value="${a}" selected>기존(${a})</option>
                           <option value="액션">액션</option>
                           <option value="로맨스">로맨스</option>
                           <option value="로맨스코미디">로맨스코미디</option>
                           <option value="다큐멘터리">다큐멘터리</option>
                           <option value="애니메이션">애니메이션</option>
                           <option value="SF">SF</option>
                           <option value="코미디">코미디</option>
                           <option value="범죄">범죄</option>
                           <option value="스릴러">스릴러</option>
                           <option value="드라마">드라마</option>
                           <option value="가족">가족</option>
                           <option value="판타지">판타지</option>
                           <option value="역사">역사</option>
                           <option value="재난">재난</option>
                           <option value="공포">공포</option>
                           <option value="뮤지컬">뮤지컬</option>
                           <option value="미스터리">미스터리</option>
                           <option value="어드밴처">어드밴처</option>
                           <option value="스포츠">스포츠</option>
                           <option value="전쟁">전쟁</option>
                           <option value="종교">종교</option>
                     </select> <select class="aa" id="g2" name="mgGenre_s2">
                           <option value="${b}" selected>기존(${b})</option>
                           <option value="" >(선택없음)</option>
                           <option value="액션">액션</option>
                           <option value="로맨스">로맨스</option>
                           <option value="로맨스코미디">로맨스코미디</option>
                           <option value="다큐멘터리">다큐멘터리</option>
                           <option value="애니메이션">애니메이션</option>
                           <option value="SF">SF</option>
                           <option value="코미디">코미디</option>
                           <option value="범죄">범죄</option>
                           <option value="스릴러">스릴러</option>
                           <option value="드라마">드라마</option>
                           <option value="가족">가족</option>
                           <option value="판타지">판타지</option>
                           <option value="역사">역사</option>
                           <option value="재난">재난</option>
                           <option value="공포">공포</option>
                           <option value="뮤지컬">뮤지컬</option>
                           <option value="미스터리">미스터리</option>
                           <option value="어드밴처">어드밴처</option>
                           <option value="스포츠">스포츠</option>
                           <option value="전쟁">전쟁</option>
                           <option value="종교">종교</option>
                           <option value="무성영화">무성영화</option>
                           <option value="흑백영화">흑백영화</option>
                           <option value="리메이크">리메이크</option>
                           <option value="재개봉">리마스터</option>
                     </select> <select class="aa" id="g3" name="mgGenre_s3">
                           <option id="g3_gibon" value="${c}" selected>기존(${c})</option>
                           <option id="g3_null" value="" >(선택없음)</option>
                           <option value="액션">액션</option>
                           <option value="로맨스">로맨스</option>
                           <option value="로맨스코미디">로맨스코미디</option>
                           <option value="다큐멘터리">다큐멘터리</option>
                           <option value="애니메이션">애니메이션</option>
                           <option value="SF">SF</option>
                           <option value="코미디">코미디</option>
                           <option value="범죄">범죄</option>
                           <option value="스릴러">스릴러</option>
                           <option value="드라마">드라마</option>
                           <option value="가족">가족</option>
                           <option value="판타지">판타지</option>
                           <option value="역사">역사</option>
                           <option value="재난">재난</option>
                           <option value="공포">공포</option>
                           <option value="뮤지컬">뮤지컬</option>
                           <option value="미스터리">미스터리</option>
                           <option value="어드밴처">어드밴처</option>
                           <option value="스포츠">스포츠</option>
                           <option value="전쟁">전쟁</option>
                           <option value="종교">종교</option>
                           <option value="무성영화">무성영화</option>
                           <option value="흑백영화">흑백영화</option>
                           <option value="리메이크">리메이크</option>
                           <option value="재개봉">리마스터</option>
                     </select> <select class="aa" id="g4" name="mgGenre_s4">
                           <option id="g4_gibon" value="${d}" selected>기존(${d})</option>
                           <option id="g4_null" value="" >(선택없음)</option>
                           <option value="액션">액션</option>
                           <option value="로맨스">로맨스</option>
                           <option value="로맨스코미디">로맨스코미디</option>
                           <option value="다큐멘터리">다큐멘터리</option>
                           <option value="애니메이션">애니메이션</option>
                           <option value="SF">SF</option>
                           <option value="코미디">코미디</option>
                           <option value="범죄">범죄</option>
                           <option value="스릴러">스릴러</option>
                           <option value="드라마">드라마</option>
                           <option value="가족">가족</option>
                           <option value="판타지">판타지</option>
                           <option value="역사">역사</option>
                           <option value="재난">재난</option>
                           <option value="공포">공포</option>
                           <option value="뮤지컬">뮤지컬</option>
                           <option value="미스터리">미스터리</option>
                           <option value="어드밴처">어드밴처</option>
                           <option value="스포츠">스포츠</option>
                           <option value="전쟁">전쟁</option>
                           <option value="종교">종교</option>
                           <option value="무성영화">무성영화</option>
                           <option value="흑백영화">흑백영화</option>
                           <option value="리메이크">리메이크</option>
                           <option value="재개봉">리마스터</option>
                     </select></td>
                  </tr>
               <tr>
                     <th>키워드</th>
                     <td colspan="5"><input type="text" name="mgKeyword" size="58px" value="${modi.movie_keyword}"></td>
                  </tr>
                  <tr>
                     <th>내　용</th>
                     <td colspan="5">
                        <textarea rows="10" cols="60" name="mgPlot" id="mgPlot">${modi.movie_plot}</textarea>
                     </td>
                  </tr>
                  <tr>
                     <th>예매주소</th>
                     <td colspan="5"><input type="text" name="mgReserve" size="58px" value="${modi.movie_reserve}"></td>
                  </tr>
                  <tr>
                     <th>예고편</th>
                     <td colspan="5"><input type="text" name="mgLink" size="58px" value="${modi.movie_link}"></td>
                  </tr>
                  <tr>
                     <td class="button_td" colspan="6">
                        <input type="hidden" id="nn">
                        <input type="button" value="수정" id="mgMov_submit">
                        <a href="movie_Del?a=${modi.movie_code}"><input type="button" value="삭제"></a>
                     </td>
                  </tr>
               </table>
            </form>
         </div>
      </div>
    </div>  
   </body>
</html>