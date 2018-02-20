<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*"/>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("UTF-8");
	
	String room_id = request.getParameter("room_id") == null ? "" : request.getParameter("room_id").trim();
 	String checkyy = request.getParameter("checkyy") == null ? "" : request.getParameter("checkyy").trim();
 	String checkmm = request.getParameter("checkmm") == null ? "" : request.getParameter("checkmm").trim();
 	String checkdd = request.getParameter("checkdd") == null ? "" : request.getParameter("checkdd").trim();
 	
 	String choutyy = request.getParameter("choutyy") == null ? "" : request.getParameter("choutyy").trim();
 	String choutmm = request.getParameter("choutmm") == null ? "" : request.getParameter("choutmm").trim();
 	String choutdd = request.getParameter("choutdd") == null ? "" : request.getParameter("choutdd").trim();
 	
 	String adult = request.getParameter("adult") == null ? "" : request.getParameter("adult").trim();
 	String student = request.getParameter("student") == null ? "" : request.getParameter("student").trim();
 	String child = request.getParameter("child") == null ? "" : request.getParameter("child").trim();
	
	
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>객실 상세페이지</title>
<style type="text/css">
	*{
		margin: 0; padding: 0;
	}
	body {
		margin: 0 auto;
		width: 960px;
	}
	
	.header {height:300;}
	.container {background:#fff repeat-y top right; width:950px;}
	.content {width:947px; height:1000px; float:left; border: 2px solid #B70000;}
	.footer {height:100px; text-align: center; padding: .5em;}
	.clear{clear:both;}
</style>

<script language="JavaScript" type="text/JavaScript">

	
	var xhrObject;
	
	function createXHR()
	{
		if (window.ActioveXObject)
		{
			xhrObject=new ActiveXObject("Microsoft.XMLHTTP");
		} else if(window.XMLHttpRequest)
		{
			xhrObject=new XMLHttpRequest();	
		}
	}
	
	function getRoomInfo(){
		
		createXHR();
	  	var url= "./getRoomInfo.jsp";
 		var roomid =<%=room_id%>;
 		
		var reqparam ="roomid="+roomid;
			
		
		xhrObject.onreadystatechange = resGetRoomInfo;
		xhrObject.open("Post",url,"true");
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);
		
	}
	
	function resGetRoomInfo(){
		
		if(xhrObject.readyState == 4){
			if(xhrObject.status==200){
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.datas.length; //불러온 데이터의 길이
				var res = "<table cellpadding='3' cellspacing='0' border='1' width='900'>";
				var resDiv = document.getElementById("div_res");
				
				if(num < 1){
					res += "<tr><td width='980' height='100' align='center' style='font-size:50;'>검색 결과가 없습니다.</td></tr>";
				}else{
						
						res +="<tr>";
						res +="<td width='980' align='center' style='font-size:30' bgcolor='#D0E6FC'>아이디</td>";
						res +="<td width='980' align='center' style='font-size:30' bgcolor='#FFFFCC'>이름</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>타입</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>인원수</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>성인</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>초등학생</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>아동</td>";
						res +="</tr>";
					for(var i =0; i< num; i++){
						var room_id = objRes.datas[i].ROOMID;
						var room_name = objRes.datas[i].ROOMNAME;
						var room_type = objRes.datas[i].ROOMTYPE;
						var room_count = objRes.datas[i].ROOMCOUNT;
						var adult_price = objRes.datas[i].ADULTPRICE;
						var stu_price = objRes.datas[i].STUPRICE;
						var child_price = objRes.datas[i].CHILDPRICE;
						
						res +="<tr>";
						res +="<td width='980' align='center' style='font-size:30' bgcolor='#D0E6FC'><br>"+room_id+"</br></td>";
						res +="<td width='980' align='center' style='font-size:30' bgcolor='#FFFFCC'><br>"+room_name+"<br></td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'><br>"+room_type+"<br></td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'><br>"+room_count+"<br></td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'><br>"+adult_price+"<br></td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'><br>"+stu_price+"<br></td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'><br>"+child_price+"<br></td>";
						res +="</tr>";
						
						
					}
				}
				
				res +="</table>";
				res +="<a href = 'javascript:write_type(\""+room_id+"\",\""+room_name+"\",\""+room_type+"\",\""+adult_price+"\",\""+stu_price+"\",\""+child_price+"\");'>예약가기</a>";
				resDiv.innerHTML=res;
			}
		}
 	}
	function write_type(room_id,room_name,room_type,adult_price,stu_price,child_price){
		var room_id = room_id;
		
		var checkyy =<%=checkyy%>;
 		var checkmm =<%=checkmm%>;
 		var checkdd =<%=checkdd%>;
 		
 		var choutyy =<%=choutyy%>;
 		var choutmm =<%=choutmm%>;
 		var choutdd =<%=choutdd%>;
 		
 		var adult =<%=adult%>;
 		var student =<%=student%>;
 		var child =<%=child%>;
 		
 		var adultprice =adult*adult_price;
 		var stutprice =student*stu_price;
 		var childprice =child*child_price;
 		var sum = adultprice+stutprice+childprice;
 		
		var res = "<form name='write_main'>";
		var resDiv = document.getElementById("div_res");
		res +="<font color='#FFFFFF'><br>예약 양식 페이지입니다.<br><br><br>";
		res +="이름:";
		res +="<input type='text' name='name' value=''>";
		res +="<br><br><br>";
		res +="객실 이름:"+room_name+"<br>";
		res +="객실 타입:"+room_type+"<br><br>";
		res +="체크인 날짜:"+checkyy+"년"+checkmm+"월"+checkdd+"일<br>";
		res +="체크아웃 날짜:"+choutyy+"년"+choutmm+"월"+choutdd+"일<br><br>";
		res +="성인:"+adultprice+"원<br>";
		res +="초등학생:"+stutprice+"원<br>";
		res +="어린이:"+childprice+"원<br><br>";
		res +="총합계:"+sum+"원<br><br><br>";
		res +="<input type='button' value='예약 완료' onclick='javascript:write_result("+room_id+","+adult_price+","+stu_price+","+child_price+");'>";
		res +="</font>";
		res +="</form>";
		resDiv.innerHTML=res;
	}
	
	function write_result(room_id,adult_price,stu_price,child_price){
		
		var checkyy =<%=checkyy%>;
 		var checkmm =<%=checkmm%>;
 		var checkdd =<%=checkdd%>;
 		
 		var choutyy =<%=choutyy%>;
 		var choutmm =<%=choutmm%>;
 		var choutdd =<%=choutdd%>;
 		
 		var adult =<%=adult%>;
 		var student =<%=student%>;
 		var child =<%=child%>;
 		
 		var adultprice =adult*adult_price;
 		var stutprice =student*stu_price;
 		var childprice =child*child_price;
 		var sum = adultprice+stutprice+childprice;
 		
		var write_name="write_main";
		var name=document.forms[write_name].elements["name"].value;
		
		createXHR();
	  	var url= "./setUserInfo.jsp";
		var reqparam ="name="+name;
			reqparam+= "&room_id="+room_id;
			reqparam+= "&checkyy="+checkyy;
			reqparam+= "&checkmm="+checkmm;
			reqparam+= "&checkdd="+checkdd;
			reqparam+= "&choutyy="+choutyy;
			reqparam+= "&choutmm="+choutmm;
			reqparam+= "&choutdd="+choutdd;
			reqparam+= "&adult="+adult;
			reqparam+= "&student="+student;
			reqparam+= "&child="+child;
			reqparam+= "&sum="+sum;
		
			
			xhrObject.onreadystatechange = resWrite;
			xhrObject.open("Post",url,"true");
			xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			xhrObject.send(reqparam);
		
	}
	
	function resWrite(){
		if(xhrObject.readyState == 4){
			if(xhrObject.status==200){
				var result = xhrObject.responseText;
				//alert(result);
				var objRes = eval("(" + result + ")");
				//alert(objRes);
				
				var ok = objRes[0].RESULT_OK;
				if(ok ==1)
					getData();
				else
					alert("삽입 실패");
					
				//var num = objRes.datas.length; //불러온 데이터의 길이
				var resDiv=document.getElementById("div_Res");
				var res="예약이 완료 되었습니다";
				resDiv.innerHTML=res;
				
			}
		}
 	}
</script>
</head>
<body bgcolor="black" onload="javascript:getRoomInfo();">
<header class="header">
<img width="950px" height="300px" alt = "메인이미지" src="image/35.jpg">
</header>
<nav id="topMenu">
</nav>	

<section class="container">

	<div id="div_res" class="content">
	<FONT color="#FFFFFF">메인 이미지입니다.</FONT>
	
	</div>

</section>

<div class="clear"></div>

<footer class="footer">
료칸사이트에 어서오세여~
</footer>

</body>
</html>