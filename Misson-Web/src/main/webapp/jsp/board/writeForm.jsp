<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="/Misson-Web/resource/js/jquery-3.6.0.min.js"></script>

<script>
	$(document).ready(function(){
		
		$('#listBtn').click(function(){/* 목록 버튼을 누르면 list.jsp(전체 게시글 조회) 페이지로 날라감 */
			location.href="list.jsp" 
		})
		
	})
	
	
	function checkForm(){
		let f = document.writeForm 
		
		if(f.title.value==''){  /* form 태그의 제목 값이 비어있으면 */
			f.title.focus()  //제목 항목에 포커스 
			alert('제목을 입력하세요')
			return false
		}
		
		if(f.writer.value==''){ 
			f.writer.focus() 
			alert('작성자를 입력하세요')
			return false
		}
		
		
		if(f.content.value==''){  
			f.content.focus()  
			alert('내용을 입력하세요')
			return false
		}
		return true
	}
	
</script>

</head>
<body>
	<div align="center">
		<hr>
		<h2>새글 등록 폼</h2>
		<hr>
		
		<br>
		
		<!-- 내가 작성한 값이 날라갈 경로를 설정해야하므로 action 을 설정한다. 
		     개인정보가 보호되야하니까 method 방식을 post로 설정
		  -->
		<form action="write.jsp" method="post" name="writeForm" onsubmit="return checkForm()">  
			<table border="1" style="width:80%">
				<tr>
					<th width="25%">제목</th>
					<td><input type="text" name="title" size="80" ></td>
					  <!-- <td><input type="text" name="title" size="80" required></td> 
					  
					    required 써서 필수 작성 항목을 만들어도되고 지금 상태로 checkForm() 함수를 생성해도 된다. 
					  -->
				</tr>
						
				<tr>
					<th width="25%">작성자</th>
					<td><input type="text" name="writer"></td>
				</tr>	
					
				<tr>
					<th width="25%">내용</th>
					<td><textarea row="5" cols="80" name="content" ></textarea></td>
				</tr>						
			</table>
				<input type="submit" value="새글등록">&nbsp;&nbsp;
				<button type="button" id="listBtn">목록</button>
				<!-- 버튼 타입을 버튼으로 설정안했을 때 오류남
						버튼 타입을 서브밋으로 인식했기 때문
						그래서 꼭 버튼 타입을 버튼으로 설정해주어야 한다. 
				 -->
		</form>
	</div>
</body>
<!-- 
값을 write.jsp 페이지로 보냄
paylode에 FormData 형식으로 값들이 날라감 -->
</html>

