<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*"/>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("UTF-8");
	
	String num = request.getParameter("num") == null ? "" : request.getParameter("num").trim();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>메인 페이지</title>
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
		width: 980px;
		position:relative;
		top:-10px;
	}
	#topMenu ul li {
		list-style: none;
		color: white;
		background-color: #B70000;
		float: left;
		line-height: 30px;
		vertical-align: middle;
		text-align: center;
		
	}
	#topMenu .menuLink {
		text-decoration: none;
		color: white;
		display: block;
		width: 155.8px;
		font-size: 15px;
		font-weight: bold;
		font-family: "Trebuchet MS", Dotum, Arial;
		
	}
	#topMenu .menuLink:hover {
		color:  black;
		background-color: #BDBDBD;
		
	}
	.header {height:300;}
	.container {background:#fff repeat-y top right; width:950px;}
	.content {width:947px; height:1500px; float:left; border: solid #B70000; }
	.footer {height:100px; text-align: center; padding: .5em;}
	.clear{clear:both;}
</style>


<script language="JavaScript" type="text/JavaScript">

	function resOnsen(){
		var res = "<table cellpadding='3' cellspacing='0' border='1' width='947'>";
		var resDiv = document.getElementById("div_res");
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'><img alt='온천' src='image/onsen1.jpg'></td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'>이름</td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30;'>전화번호</td>";
		res +="</tr>";
		res +="</table>";
		resDiv.innerHTML=res;
	}
	
	function resRoom(){
		var res = "<table cellpadding='3' cellspacing='0' border='1' width='947'>";
		var resDiv = document.getElementById("div_res");
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'><img alt='고양이' src='image/cats.jpg'></td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'>이름</td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30;'>전화번호</td>";
		res +="</tr>";
		res +="</table>";
		resDiv.innerHTML=res;
	}
	
	function resFood(){
		var res = "<table cellpadding='3' cellspacing='0' border='1' width='947'>";
		var resDiv = document.getElementById("div_res");
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'><img alt='요리' src='image/food1.jpg'></td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'>이름</td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30;'>전화번호</td>";
		res +="</tr>";
		res +="</table>";
		resDiv.innerHTML=res;
	}
	
	function resRoad(){
		var res = "<table cellpadding='3' cellspacing='0' border='1' width='947'>";
		var resDiv = document.getElementById("div_res");
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'><img alt='온천' src='image/onsen1.jpg'></td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30'>이름</td>";
		res +="</tr>";
		res +="<tr>";
		res +="<td width='980' align='center' style='font-size:30;'>전화번호</td>";
		res +="</tr>";
		res +="</table>";
		resDiv.innerHTML=res;
	}
	function choice(){
		
		var num=<%=num%>;
		if(num==1){
			resOnsen();		
		}
		else if(num==2){
			resRoom();
		}
		else if(num==3){
			resFood();
		}
		else if(num==4){
			resRoad();
		}
	
	}
	
</script>

</head>
<body onload="choice()" bgcolor="black">

<header class="header">
<img alt = "메인이미지" src="image/hao.jpg">
</header>

<nav id="topMenu">
	<ul>
		<li><a class="menuLink" onClick='javascript:resOnsen();'>온천</a></li>
		<li>|</li>
		<li><a class="menuLink" onClick='javascript:resRoom();'>객실</a></li>
		<li>|</li>
		<li><a class="menuLink" onClick='javascript:resFood();'>요리</a></li>
		<li>|</li>
		<li><a class="menuLink" onClick='javascript:resRoad();'>찾아오는 길</a></li>
		<li>|</li>
		<li><a class="menuLink" target="_blank"  href="reservation.jsp">예약</a></li>
		<li>|</li>
		<li><a class="menuLink" href="#">예약 조회</a></li>
	</ul>
</nav>	

<section class="container">
	<div id="div_res" class="content">
	<table cellpadding='3' cellspacing='0' border='1' width='947'>
	<tr>
	<td align='center'><img alt = "책" src="image/road.jpg"  width='580'>
	<FONT color="#FFFFFF">오시는 길1</FONT></td>
	</tr>
	<tr>
	<td align='center'><img alt = "책" src="image/road1.jpg" width='580'>
	<FONT color="#FFFFFF">오시는 길2</FONT></td>
	</tr>
	<tr>
	<td align='center'><img alt = "책" src="image/road2.jpg"  width='580'>
	<FONT color="#FFFFFF">오시는 길3</FONT></td>
	</tr>
	</table>
	</div>
</section>

<div class="clear"></div>

<footer class="footer">
료칸사이트에 어서오세여~
</footer>

</body>
</html>