<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*"/>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("UTF-8");
	
	String room = request.getParameter("room") == null ? "room" : request.getParameter("room").trim();
	
	QueryBean.getConnection(); //연결하기
	
	ArrayList resArr=new ArrayList();
	
	try
	{
		resArr = QueryBean.getRoomList(room);
	}
	catch(SQLException e)
	{
		out.print(e.toString());
	}
	finally
	{
		QueryBean.closeConnection();
	}
	out.println("{");
	out.println("\"datas\":[");
	
	if(resArr.size() == 0)
	{
		out.println("]");
		out.println("}");
	}
	else
	{
		out.print("{ ");
		out.print("\"ROOMID\": \""          + (String)resArr.get(0) + "\", ");
		out.print("\"ROOMNAME\": \""          + (String)resArr.get(1) + "\", ");
		out.print("\"ROOMTYPE\": \""          + (String)resArr.get(2) + "\", ");
		out.print("\"ROOMCOUNT\": \""          + (String)resArr.get(3) + "\", ");
		out.print("\"ADULTPRICE\": \""          + (String)resArr.get(4) + "\", ");
		out.print("\"STUPRICE\": \""          + (String)resArr.get(5) + "\", ");
		out.print("\"CHILDPRICE\": \""          + (String)resArr.get(6) + "\" ");
		out.print("} ");
	
	
		for(int i=7; i<resArr.size(); i+=7)
		{	
			out.print(",");
			out.print("{ ");
			out.print("     \"ROOMID\": \""          		+ (String)resArr.get(i) + "\", ");
			out.print("     \"ROOMNAME\": \""          	+ (String)resArr.get(i+1) + "\", ");
			out.print("     \"ROOMTYPE\": \""          + (String)resArr.get(i+2) + "\", ");
			out.print("		\"ROOMCOUNT\": \""          + (String)resArr.get(i+3) + "\", ");
			out.print("		\"ADULTPRICE\": \""          + (String)resArr.get(i+4) + "\", ");
			out.print("		\"STUPRICE\": \""          + (String)resArr.get(i+5) + "\", ");
			out.print("		\"CHILDPRICE\": \""          + (String)resArr.get(i+6) + "\" ");
			out.print("} ");
		} //json 방식으로 값 넣기 웹페이지형식으로 나타낸다.
		out.println("]");
		out.println("}");
	}
	
%>
