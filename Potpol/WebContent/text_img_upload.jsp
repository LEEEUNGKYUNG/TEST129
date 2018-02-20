<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.beans.*" %>
<%@ page import="java.util.*, java.sql.*, java.io.*" %>
<%
	request.setCharacterEncoding("utf-8");

	String imgText = "그림 설명을 넣으세요~!";
%>

<html>
<head>
<script language="JavaScript" type="text/JavaScript">
	var fileUrl;
	
	function onInitMap(){
		var tableRes ='';
		tableRes += '<table width="500" height="500" border="0" cellspacing="0" cellpadding="0">';
		tableRes += '	<tr>';
		tableRes += '		<td>';
		tableRes += '			<img id="img_view" src="./img/upload_wait.jpg" width="500" height="500">';
		tableRes += '		</td>';
		tableRes += '	</tr>';
		tableRes += '</table>';
		
		var divNew = document.getElementById("div_img_new");
		if(divNew)
		{
			document.getElementById("div_img").removeChile(divNew);
		}
		
		var divNew = document.createElement("div");
		divNew.id = "div_img_new";
		divNew.style.zIndex = "3";
		divNew.style.position = "relative";
		divNew.innerHTML = tableRes; //HTML로 출력
		document.getElementById("div_img").appendChild(divNew); //div_img 있는곳에 divNew(이미지 테이블)을 추가한다.
	}
	
	function readImg(input){
		if(input.files && input.files[0]){
			var reader = new FileReader(); //FileReader 객체를 생성
			reader.onload = function(e){//파일리더기로 읽어들인다.
				document.getElementById("img_view").src = e.target.result;
			}; //img태그안의 src속성=upload_wait 자리에 저장하는 이미지 파일을 넣는다.
			reader.readAsDataURL(input.files[0]);
		}
		divSubmitChange();
	}
	
	function divSubmitChange()
	{
		var newDiv = document.getElementById("div_submit");
		newDiv.innerHTML = "";
		newDiv.innerHTML = '<input type="submit" value="서버로 전송">';
	}//div_submit을 가져와서 넣기
</script>
</head>
<body onLoad="onInitMap();"><!--이함수를 자동으로 호출-->
	<div id="div_popup" style="position:absolute; left:0px; top:20px; width:500px" class="bbsCont">
		<form name="fileUpload" method="post" action="./uploadFile.jsp" enctype="multipart/form-data">
			<table align="center" border="0" width="500" cellpadding="0" cellspacing="1">
				<tr height="40">
					<td colspan="3" align="center"><b>(이미지 업로드) 웹 클라이언트</b></td>
				</tr>
				<tr height="500">
					<td colspan="3" align="left" valign="top"><div id="div_img"></div></td>
				</tr>
				<tr height="35">
					<td width="70" align="right">이름:</td>
					<td width="430" colspan="2">
						<input type="text" name="img_name" style='width: 90%; border: none;' value='<%=imgText%>'>
					</td>
				</tr>
				<tr height="35">
					<td width="70" align="right">FILE : </td>
					<td colspan="2">
						<input type="file" name="file1" style='width: 90%; height: 20px' onchange="javascript:readImg(this);">
					</td>
				</tr>
				<tr height="35">
					<td width="70">&nbsp;</td>
					<td width="330">&nbsp;</td>
					<td width="100"><div id="div_submit"></div></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>