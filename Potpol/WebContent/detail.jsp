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
<title>���� ��������</title>
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
				var num = objRes.datas.length; //�ҷ��� �������� ����
				var res = "<table cellpadding='3' cellspacing='0' border='1' width='900'>";
				var resDiv = document.getElementById("div_res");
				
				if(num < 1){
					res += "<tr><td width='980' height='100' align='center' style='font-size:50;'>�˻� ����� �����ϴ�.</td></tr>";
				}else{
						
						res +="<tr>";
						res +="<td width='980' align='center' style='font-size:30' bgcolor='#D0E6FC'>���̵�</td>";
						res +="<td width='980' align='center' style='font-size:30' bgcolor='#FFFFCC'>�̸�</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>Ÿ��</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>�ο���</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>����</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>�ʵ��л�</td>";
						res +="<td width='980' align='center' style='font-size:30;' bgcolor='#FFFFCC'>�Ƶ�</td>";
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
				res +="<a href = 'javascript:write_type(\""+room_id+"\",\""+room_name+"\",\""+room_type+"\",\""+adult_price+"\",\""+stu_price+"\",\""+child_price+"\");'>���డ��</a>";
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
		res +="<font color='#FFFFFF'><br>���� ��� �������Դϴ�.<br><br><br>";
		res +="�̸�:";
		res +="<input type='text' name='name' value=''>";
		res +="<br><br><br>";
		res +="���� �̸�:"+room_name+"<br>";
		res +="���� Ÿ��:"+room_type+"<br><br>";
		res +="üũ�� ��¥:"+checkyy+"��"+checkmm+"��"+checkdd+"��<br>";
		res +="üũ�ƿ� ��¥:"+choutyy+"��"+choutmm+"��"+choutdd+"��<br><br>";
		res +="����:"+adultprice+"��<br>";
		res +="�ʵ��л�:"+stutprice+"��<br>";
		res +="���:"+childprice+"��<br><br>";
		res +="���հ�:"+sum+"��<br><br><br>";
		res +="<input type='button' value='���� �Ϸ�' onclick='javascript:write_result("+room_id+","+adult_price+","+stu_price+","+child_price+");'>";
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
					alert("���� ����");
					
				//var num = objRes.datas.length; //�ҷ��� �������� ����
				var resDiv=document.getElementById("div_Res");
				var res="������ �Ϸ� �Ǿ����ϴ�";
				resDiv.innerHTML=res;
				
			}
		}
 	}
</script>
</head>
<body bgcolor="black" onload="javascript:getRoomInfo();">
<header class="header">
<img width="950px" height="300px" alt = "�����̹���" src="image/35.jpg">
</header>
<nav id="topMenu">
</nav>	

<section class="container">

	<div id="div_res" class="content">
	<FONT color="#FFFFFF">���� �̹����Դϴ�.</FONT>
	
	</div>

</section>

<div class="clear"></div>

<footer class="footer">
��ĭ����Ʈ�� �������~
</footer>

</body>
</html>