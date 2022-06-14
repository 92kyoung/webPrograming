<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지 입니다</title>

<link rel="stylesheet" href="/Mission-Web/resources/css/layout.css">
<link rel="stylesheet" href="/Mission-Web/resources/css/table.css">

<script>
/* 
	function checkForm(){
		let f = document.writeMemberForm
		
		if(f.id.value==''){
			f.id.focus()
			alter('아이디를 입력해주세요')
			return false
		}
		
		if(f.name.value==''){
			f.name.focus()
			alter('이름를 입력해주세요')
			return false
		}
		
		if(f.password.value==''){
			f.password.focus()
			alter('패스워드를 입력해주세요')
			return false
		}
		
		return true
		
	}
 */


</script>

</head>
<body>
	<header>
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	<section>
		<div align="center">
	<hr>
	<h2>회 원 가 입</h2>
	<hr>
	<br>
	
	<!-- form 은 post 방식 사용 (유일) 
	 action : writeMember.jsp로 이동
	 method
	 name
	 onsubmit : submit 버튼을 누르면 checkForm() 함수로 이동
	
	
	-->
	<form action="writeMember.jsp" method="post" name="writeMemberForm" onsubmit="return checkForm()">
		<table border="1" style="width: 80%">
			<tr>
				<th width="25%">아이디</th>
				<td><input type="text" name="id" size="80" required></td>
			</tr>
			<tr>
				<th width="25%">이름</th>
				<td><input type="text" name="name" size="80" required></td>
			</tr>
			<tr>
				<th width="25%">패스워드 </th>
				<td><input type="text" name="password" size="80" required></td>
			</tr>
			<tr>
				<th width="25%">이메일</th>
				<td><input type="text" name="email_id" size="20"> @
				    <input type="text" name="email_domain" size="50">
				</td>
			</tr>
			<tr>
				<th width="25%">전화번호</th>
				<td><input type="text" name="tel1" size="20">  - 
					<input type="text" name="tel2" size="20">  - 
					<input type="text" name="tel3" size="20"></td>
			</tr>
			<tr>
				<th width="25%">회원구분</th>
				<td>
					<input type="radio" name="type" value='U'/>일반회원
					<input type="radio" name="type" value='S'/>슈퍼회원		
				</td>
			</tr>
			<tr>
				<th width="25%">우편번호</th>
				<td><input type="text" name="post" size="80"></td>
			</tr>
			<tr>
				<th width="25%">basic_addr</th>
				<td><input type="text" name="basic_addr" size="80"></td>
			</tr>
			<tr>
				<th width="25%">detail_addr</th>
				<td><input type="text" name="detail_addr" size="80"></td>
			</tr>
		</table>
		
		<input type="submit" value="회원가입하기">&nbsp;&nbsp;
	</form>
	
	</div>
	</section>
	<footer>
		<%@ include file="/jsp/include/footer.jsp" %> <!-- 지시자 include --> <!--절대경로 : 루트는 보통 localhost:9999를 의미하지만 (xml,include,forward에서만 루트는 Mission-Web을 의미한다)  -->
	</footer>
</body>
</html>


