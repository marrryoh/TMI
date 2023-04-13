<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

$(function(){
	//아이디 중복 검사
	$("#idCheck").click(function(){
		var user_id=$("#user_id").val();
		//영어,숫자 4-10
		var vuser_id =/^[a-zA-Z0-9]{4,10}$/;
		//공백 불가능
		if(user_id==""){
			alert("ID를 입력해주세요");
			$("#user_id").focus();
			return false;
		}	
		
		if(!vuser_id.test(user_id)){
			alert("ID는 영문자+숫자 4-10자리만 입력 가능합니다");
			$("#user_id").focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			async:true,
			dataType:"text",
			url:"idck",
			data:{"user_id":user_id},
			success:function(str){
				if(str=="ok")
				{
					$('#abc').val("Y");
					alert("사용 가능한 ID 입니다");
				}
				else
				{
					$('#abc').attr('abc','N');
					alert("사용 중인 ID 입니다");
					$("#user_id").val("");
				}
				
			}
		});
	});	
	
	//닉네임 중복 검사
	$("#nicCheck").click(function(){
		var user_nic=$("#user_nic").val();
		if(user_nic==""){
			alert("닉네임을 입력해주세요");
			$("#user_nic").focus();
			return false;
		}
		$.ajax({
			type:"post",
			async:true,
			dataType:"text",
			url:"nicck",
			data:{"user_nic":user_nic},
			success:function(str){
				if(str=="ok")
				{
					$('#nicCheck').val("Y");
					alert("사용 가능한 닉네임 입니다");
				}
				else
				{
					$('#nicCheck').attr('nicCheck','N');
					alert("사용 중인 닉네임 입니다");
					$("#user_nic").val("");
				}
			}
		});
	});	
	
	//유효성 검사
	$("#memberCheck").click(function(){
		//아이디
		var user_id=$("#user_id").val();
		//영어,숫자 4-10
		var vuser_id =/^[a-zA-Z0-9]{4,10}$/;
		//공백 불가능
		if(user_id==""){
			alert("ID를 입력해 주세요");
			$("#user_id").focus();
			return false;
		}	
		
		if(!vuser_id.test(user_id)){
			alert("ID는 영문자+숫자 4-10자리만 입력 가능합니다");
			$("#user_id").focus();
			return false;
		}
		
		var abc=$("#abc").val();
		if(abc!=='Y'){
			alert("ID 중복검사를 해주세요");		
			$("#abc").focus();
			return false;
		}
		
		//비밀번호
		var user_pw=$("#user_pw").val();
		var user_pw2=$("#user_pw2").val();
		//영어,숫자 6-20
		var vuser_pw =/^[a-zA-Z0-9]{6,20}$/;
		//비밀번호 공백
		if(user_pw==""){
			alert("비밀번호를 입력해 주세요");
			$("#user_pw").focus();
			return false;
		}
		//비밀번호 확인 공백
		if(user_pw2==""){
			alert("비밀번호를 한번 더 입력해 주세요");
			$("#user_pw2").focus();
			return false;
		}
		//비밀번호, 비밀번호 확인 일치 여부
		if(user_pw!=user_pw2){
			alert("비밀번호가 동일하지 않습니다");
			$("#user_pw").select();
			return false;
		}
		
		if(!vuser_pw.test(user_pw)){
			alert("비밀번호는 영문자+숫자 6-20자만 입력 가능합니다");
			$("#user_pw").focus();
			return false;
		}
		//닉네임
		var user_nic=$("#user_nic").val();
		if(user_nic==""){
			alert("닉네임을 입력해 주세요");
			$("#user_nic").focus();
			return false;
		}
		
		var nicCheck=$("#nicCheck").val();
		if(nicCheck!=='Y'){
			alert("닉네임 중복검사를 해주세요");		
			$("#nicCheck").focus();
			return false;
		}
		
		//생년월일
	      var year=$("#year").val();      
	      var month=$("#month").val();
	      var day=$("#day").val();
	      //공백
	      if(year==0 || month==0 || day==0){
	         alert("생년월일을 확인해 주세요");
	         return false;
	      }
		
		//성별
		var user_gender=$("#user_gender").val();
		//공백
		if($("input[name=user_gender]:radio:checked").length < 1){
			alert("성별을 선택해 주세요");
			$("#user_gender").focus();
			return false;
		}	
		
		//주소 시/도
		var sido1=$("#sido1").val();
		//공백
		if(sido1==""){
			alert("주소를 확인해 주세요");
			$("#sido1").focus();
			return false;
		}	
		//주소 구/군
		var gugun1=$("#gugun1").val();
		//공백
		if(gugun1==""){
			alert("주소를 확인해 주세요");
			$("#gugun1").focus();
			return false;
		}			
		$("#memberinput").submit();
	});		
});	

//생년월일
$(function(){            
    var now = new Date();
    var year = now.getFullYear();
    var month = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
    var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());           
    //년도     
    for(var i = 1900 ; i <= year ; i++) {
    	$('#year').append('<option value="' + i + '">' + i + '년</option>');  
    }
    
    // 월별           
    for(var i=1; i <= 12; i++) {
        var mm = i > 9 ? i : "0"+i ;            
        $('#month').append('<option value="' + mm + '">' + mm + '월</option>');    
    }
    
    // 일별
    for(var i=1; i <= 31; i++) {
        var dd = i > 9 ? i : "0"+i ;            
        $('#day').append('<option value="' + dd + '">' + dd+ '일</option>');    
    }
	
                 
      
});
//주소
$(function() {
	 var area0 = ["서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
	  var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	   var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	   var area3 = ["대덕구","동구","서구","유성구","중구"];
	   var area4 = ["광산구","남구","동구","북구","서구"];
	   var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	   var area6 = ["남구","동구","북구","중구","울주군"];
	   var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	   var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	   var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	   var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	   var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	   var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	   var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	   var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	   var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	   var area16 = ["서귀포시","제주시","남제주군","북제주군"];

	   // 시/도 선택 박스 초기화
 $("select[name^=sido]").each(function() {
	  $selsido = $(this);
	  
	  $.each(eval(area0), function() {
	   $selsido.append("<option value='"+this+"'>"+this+"</option>");
	  });
	  $selsido.next().append("<option value=''>구/군 선택</option>");
	 });

	 // 시/도 선택시 구/군 설정
$("select[name^=sido]").change(function() {
	  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
	  var $gugun = $(this).next(); // 선택영역 군구 객체
	  $("option",$gugun).remove(); // 구군 초기화

	  if(area == "area0")
	   $gugun.append("<option value=''>구/군 선택</option>");
	  else {
	   $.each(eval(area), function() {
	    $gugun.append("<option value='"+this+"'>"+this+"</option>");
	   });
	  }
	});
});
	
	
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="outer_join">
		<div id="memberinputArea">
			<form id="memberinput" action="member_Save" method="post">
				<h1>회원 가입</h1>
				<br><br>
				
				
				<div class="membertitle">아이디</div>
				<div class="mebertt_1"><span class="input_1_area">
				<input type="text" maxlength="10" name="user_id" id="user_id" required ></span>
				<button type="button" id="idCheck">중복확인</button></div>
				<input type="hidden" id="abc" name="abc">
				<br><br>
				
				<div class="membertitle">비밀번호</div>
				<span class="input_area"><input type="password" maxlength="20" name="user_pw" id="user_pw" required></span>
				<br><br>
				<div class="membertitle">비밀번호 확인</div>
				<span class="input_area"><input type="password" maxlength="20" name="user_pw2" id="user_pw2" required></span>
				<label id="pwdResult"></label>
				<br><br>
				
				<div class="membertitle">닉네임</div>		
				<div class="mebertt_1"><span class="input_1_area">
				<input type="text" maxlength="10" name="user_nic" id="user_nic" required></span>
				<button type="button" id="nicCheck" >중복확인</button></div>
				<br><br>
										
				<div class="membertitle">생년월일</div>
 					 <select class="input_area" id="year" name="year">
  						  <option selected value="">출생 연도</option>
 					 </select>
 					 <select class="input_area" id="month" name="month">
						  <option selected value="">월</option>
  					</select>
  					<select class="input_area" id="day" name="day">
    					<option selected value="">일</option>
  					</select>				
				<br><br>
				
				<div class="membertitle">성별</div><br>
				<span class="radio_area">
				<input type="radio" name="user_gender" id="user_gender" value="1">남자 &emsp; 
				<input type="radio" name="user_gender" id="user_gender" value="2">여자</span>
				<br><br>
				
				<div class="membertitle">주소</div>
					 <select class="input_area" name="sido1" id="sido1">
					 <option disabled selected value="">시/도 선택</option>
					 </select>
					 <select class="input_area" name="gugun1" id="gugun1"></select>
				<div class="btnArea">
					<button id="memberCheck">가입하기</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>