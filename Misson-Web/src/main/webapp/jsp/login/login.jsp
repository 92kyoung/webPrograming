<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/Mission-Web/resources/css/layout.css">
<link rel="stylesheet" href="/Mission-Web/resources/css/table.css">
<script src="/Mission-Web/resources/js/myJS.js"></script>
<script>

	function checkForm(){
		let f = document.loginForm
		
		if( isNull(f.id,'아이디를 입력하세요') || isNull(f.password,'비밀번호를 입력하세요') ){
			return false
		}
		
		
/* 		if(f.id.value == ''){
			alert('아이디를 입력하세요')
			f.id.focus()
			return false
		}
		if(f.password.value == ''){
			alert('비밀번호를 입력하세요')
			f.password.focus()
			return false
		}
		 */
		
	}
</script>
</head>
<body>
	<header>
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	<section>
		<div align="center">
			<hr>
			<h2>로그인</h2>
			<hr>
			
			<br>
			
			<form action="loginProcess.jsp" method="post" onsubmit="return checkForm()" name="loginForm">
			 	<table style="width: 100%">
			 		<tr>
			 			<th>아이디</th>
			 			<td><input type="text" name="id"></td>
			 		</tr>
			 		<tr>
			 			<th>패스워드</th>
			 			<td><input type="text" name="password"></td>
			 		</tr>
			 	</table>
			 	<br>
			 	<input type="submit" value="로그인">
			 	<input type="button" value="회원가입" onclick="location.href='/Mission-Web/jsp/member/writeMemberForm.jsp';">
			</form>
		</div>
	</section>
	<footer>
		<%@ include file="/jsp/include/footer.jsp" %> <!-- 지시자 include --> <!--절대경로 : 루트는 보통 localhost:9999를 의미하지만 (xml,include,forward에서만 루트는 Mission-Web을 의미한다)  -->
	</footer>
</body>
</html>