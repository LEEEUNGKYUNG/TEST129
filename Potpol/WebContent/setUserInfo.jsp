<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*"/>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("UTF-8");
	
	String name = request.getParameter("name") == null ? "" : request.getParameter("name").trim();
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
 	
 	String sum = request.getParameter("sum") == null ? "" : request.getParameter("sum").trim();
	
	
	System.out.println("room_id: " + room_id);

	
	QueryBean.getConnection(); //연결하기
	
	int res=0;
	
	try
	{
		res = QueryBean.setUserInfo(name,room_id,checkyy,checkmm,checkdd,choutyy,choutmm,choutdd,adult,student,child,sum);
	}
	catch(Exception e)
	{
		out.print(e.toString());
	}
	finally
	{
		QueryBean.closeConnection();
	}
	out.print("[");
	out.print("{ ");
	out.print("\"RESULT_OK\": \"" + res + "\" ");
	out.print("} ");
	out.print("] ");
	
	System.out.println("res: " + res);
	
	
%>
