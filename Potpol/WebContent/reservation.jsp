<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*"/>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("UTF-8");
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>예약 페이지</title>
<style type="text/css">
	*{
		margin: 0; padding: 0;
	}
	body {
		margin: 0 auto;
		width: 960px;
	}
	#topMenu {
		height: 30px;
		width: 950px;
		position:relative;
		
	}
	#topMenu ul li {
		list-style: none;
		color: white;
		background-color: #B70000;
		line-height: 30px;
		vertical-align: middle;
		text-align: center;
		
	}
	#topMenu .menuLink {
		text-decoration: none;
		color: white;
		display: block;
		width: 150px;
		font-size: 20px;
		font-weight: bold;
		font-family: "Trebuchet MS", Dotum, Arial;
		
	}
	
	.header {height:300;}
	.container {background:#fff repeat-y top right; width:950px;}
	.search {width:947px; height:300px; float:left; border: 2px solid #C20000;background:#FFF}
	.content {width:947px; height:700px; float:left; border: 2px solid #B70000;}
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
	
	function getRoomList(){
		
		
		createXHR();
		var url= "./getRoomList.jsp";
		var room = "ROOM";
		var reqparam ="room="+room;
		
		xhrObject.onreadystatechange = resGetRoomList;
		xhrObject.open("Post",url,"true");
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);
		
	}
	
	function resGetRoomList(){
		
		if(xhrObject.readyState == 4){
			if(xhrObject.status==200){
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.datas.length; //불러온 데이터의 길이
				var res = "<table cellpadding='3' cellspacing='0' border='1' width='900'>";
				var resDiv = document.getElementById("div_result");
				
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
				resDiv.innerHTML=res;
			}
		}
 	}
	
	
	function getRoomOne(){
		
		var form_name="form_main";
		var checkyy=document.forms[form_name].elements["checkyy"].value;
		var checkmm=document.forms[form_name].elements["checkmm"].value;
		var checkdd=document.forms[form_name].elements["checkdd"].value;
		
		var choutyy=document.forms[form_name].elements["choutyy"].value;
		var choutmm=document.forms[form_name].elements["choutmm"].value;
		var choutdd=document.forms[form_name].elements["choutdd"].value;
		
		var adult=document.forms[form_name].elements["adult"].value;
		var student=document.forms[form_name].elements["student"].value;
		var child=document.forms[form_name].elements["child"].value;
		
		var pricestart=document.forms[form_name].elements["pricestart"].value;
		var priceend=document.forms[form_name].elements["priceend"].value;
		
		var roomtype1=document.forms[form_name].elements["roomtype1"];
		var roomtype2=document.forms[form_name].elements["roomtype2"];
		
		var roomtype1_va=document.forms[form_name].elements["roomtype1"].value;
		var roomtype2_va=document.forms[form_name].elements["roomtype2"].value;
		
		
		
		createXHR();
		var url= "./getRoomOne.jsp";
		//var url= "./testFile.jsp";
		var reqparam = "checkyy=" + checkyy;
			reqparam +="&checkmm=" + checkmm;
			reqparam +="&checkdd=" + checkdd;
			reqparam +="&choutyy=" + choutyy;
			reqparam +="&choutmm=" + choutmm;
			reqparam +="&choutdd=" + choutdd;
			reqparam +="&adult=" + adult;
			reqparam +="&student=" + student;
			reqparam +="&child=" + child;
			reqparam +="&pricestart=" + pricestart;
			reqparam +="&priceend=" + priceend;
			
			if(roomtype1.checked==true){
				reqparam +="&roomtype1_va=" + roomtype1_va;
			}//화실이 체크
			if(roomtype2.checked==true){
				reqparam +="&roomtype2_va=" + roomtype2_va;
			}//화양실이 체크
			if(roomtype1.checked==false && roomtype2.checked==false){
				reqparam +="&roomtype1_va=" + roomtype1_va;
				reqparam +="&roomtype2_va=" + roomtype2_va;
			}//둘다 체크가 안되있을경우에 다 출력한다.
			
			
		xhrObject.onreadystatechange = resGetRoomOne;
		xhrObject.open("Post",url,"true");
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);
		
		
		
	}
	
	function resGetRoomOne(){
		if(xhrObject.readyState == 4){
			if(xhrObject.status==200){
				var form_name="form_main";
				var checkyy=document.forms[form_name].elements["checkyy"].value;
				var checkmm=document.forms[form_name].elements["checkmm"].value;
				var checkdd=document.forms[form_name].elements["checkdd"].value;
				
				var choutyy=document.forms[form_name].elements["choutyy"].value;
				var choutmm=document.forms[form_name].elements["choutmm"].value;
				var choutdd=document.forms[form_name].elements["choutdd"].value;
				
				var adult=document.forms[form_name].elements["adult"].value;
				var student=document.forms[form_name].elements["student"].value;
				var child=document.forms[form_name].elements["child"].value;
				
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.datas.length; //불러온 데이터의 길이
				
				var res = "<table cellpadding='3' cellspacing='0' border='1' width='900'>";
				var resDiv = document.getElementById("div_result");
				
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
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>예약</td>";
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
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'><br><a href = 'detail.jsp?room_id="+room_id+"&checkyy="+checkyy+"&checkmm="+checkmm+"&checkdd="+checkdd+"&choutyy="+choutyy+"&choutmm="+choutmm+"&choutdd="+choutdd+"&adult="+adult+"&student="+student+"&child="+child+"'>예약</a><br></td>";
						
						res +="</tr>";
						
						
					}
				}
				
				res +="</table>";
				resDiv.innerHTML=res;
			}
		}
	}
	
	function makeSelYear(selYear)
	{
	
		for(var i=0; i < 5; ++i )
		{
			selYear.options[i] = new Option(2017 + i);
		}
		
	}
	
	function makeSelMonth(selMonth)
	{
		
		for(var i=0; i < 12; ++i )
		{
			var num2 = i+1;			
			if(num2 <10)
				num2 = "0" +num2;
			
			selMonth.options[i] = new Option(num2);
			
		}
	
	}
	
	function makeSelDay(day, type)
	{
		if(type==1){
			var selDay = document.getElementById('checkdd');
		}
		else{
			var selDay = document.getElementById('choutdd');
		}
		
		
		for(var i=0; i < selDay.length; ++i )
		{
			selDay.options[i] = null;
			
		}
		
		for(var i=0; i < day; ++i )
		{
			var num2 = i+1;			
			if(num2 <10)
				num2 = "0" +num2;
			
			selDay.options[i] = new Option(num2);
		
		}
				
	}
	
	function selChangeMonth(month,type)
	{
		var day = "31";
		switch(month)
		{
			case '01':
			case '03':
			case '05':
			case '07':
			case '08':
			case '10':
			case '12':
				day = "31";
				break;
			case '04':
			case '06':
			case '09':
			case '11':
				day = "30";
				break;
			case '02':
				day = "28";
				break;
			default:			
				return;
		}
		
		makeSelDay(day,type);
	}
	
	function onInit()
	{
		
		getRoomList();
		makeSelYear(document.getElementById('checkyy'));		
		makeSelMonth(document.getElementById('checkmm'));
		makeSelDay(31,1);
		
		makeSelYear(document.getElementById('choutyy'));
		makeSelMonth(document.getElementById('choutmm'));
		makeSelDay(31,2);
	}

</script>

</head>
<body bgcolor="black" onload="javascript:onInit();">
<header class="header">
<a href = "main.html"><img alt = "메인이미지" src="image/bada.jpg"></a>
</header>
<nav id="topMenu">

<!-- <input name ="txt_room" type='hidden' value='701'> -->
<!-- 	<ul> -->
<!-- 		<li><a class="menuLink" href="#">온천</a></li> -->
<!-- 		<li>|</li> -->
<!-- 		<li><a class="menuLink" href="#">객실</a></li> -->
<!-- 		<li>|</li> -->
<!-- 		<li><a class="menuLink" href="#">요리</a></li> -->
<!-- 		<li>|</li> -->
<!-- 		<li><a class="menuLink" href="#">찾아오는 길</a></li> -->
<!-- 		<li>|</li> -->
<%-- 		<li><a class="menuLink" target="_blank"  href="detail.jsp?room_no=<%=room_no %>">예약</a></li> --%>
<!-- 		<li>|</li> -->
<!-- 		<li><a class="menuLink" href="#">예약 조회</a></li> -->
<!-- 	</ul> -->

<ul>
	<li>검색조건</li>
</ul>
</nav>	

<section class="container">
<form name="form_main">
	<div class="search">
	
	<br><br>
	체크인  :
	<select style="cursor:pointer" name="checkyy" id="checkyy"></select>년
	
	<select style="cursor:pointer" name="checkmm" id="checkmm" onchange="javascript:selChangeMonth(this.value, 1);"></select>월

	<select style="cursor:pointer" name="checkdd" id="checkdd"></select>일
	<br>

	체크아웃 :
	<select style="cursor:pointer" name="choutkyy" id="choutyy"></select>년
	
	<select style="cursor:pointer" name="choutmm" id="choutmm" onchange="javascript:selChangeMonth(this.value, 2);"></select>월
	
	<select style="cursor:pointer" name="choutdd" id="choutdd"></select>일
	
	<br><br>
	인원:
	성인
	<select style="cursor:pointer" name="adult" id="adult">
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	</select>명
	
	초등학생
	<select style="cursor:pointer" name="student" id="student">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	</select>명
	
	유아
	<select style="cursor:pointer" name="child" id="child">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	</select>명
	
	<br><br>
	객실타입:
	<label for="ha1" style="cursor:pointer"><input type="checkbox" name="roomtype1" id="roomtype1" value="화실">화실</label>
	<label for="ha2" style="cursor:pointer"><input type="checkbox" name="roomtype2" id="roomtype2" value="화양실">화양실</label>

	
	<br><br>
	가격대:
	<select style="cursor:pointer" name="pricestart" id="pricestart">
	<option value="0">제한없음</option>
	<option value="60000">60000</option>
	<option value="70000">70000</option>
	<option value="80000">80000</option>
	<option value="90000">90000</option>
	<option value="100000">100000</option>
	<option value="120000">120000</option>
	<option value="140000">140000</option>
	<option value="160000">160000</option>
	<option value="180000">180000</option>
	<option value="200000">200000</option>
	<option value="300000">300000</option>
	</select>원
	
	~
	
	<select style="cursor:pointer" name="priceend" id="priceend">
	<option value="400000">제한없음</option>
	<option value="60000">60000</option>
	<option value="70000">70000</option>
	<option value="80000">80000</option>
	<option value="90000">90000</option>
	<option value="100000">100000</option>
	<option value="120000">120000</option>
	<option value="140000">140000</option>
	<option value="160000">160000</option>
	<option value="180000">180000</option>
	<option value="200000">200000</option>
	<option value="300000">300000</option>
	</select>원
	
	<input type="button" value="검색" onclick='javascript:getRoomOne();' style="cursor:pointer">
	</div>
	<div id="div_result" class="content">
	검색 결과창
	</div>
</form>
</section>
<div class="clear"></div>
<footer class="footer">
료칸사이트에 어서오세여~
</footer>
</body>
</html>