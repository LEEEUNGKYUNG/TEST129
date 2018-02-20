<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*"/>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("UTF-8");
	
	String checkyy = request.getParameter("checkyy") == null ? "" : request.getParameter("checkyy").trim();
	String checkmm = request.getParameter("checkmm") == null ? "" : request.getParameter("checkmm").trim();
	String checkdd = request.getParameter("checkdd") == null ? "" : request.getParameter("checkdd").trim();
	
	String choutyy = request.getParameter("choutyy") == null ? "" : request.getParameter("choutyy").trim();
	String choutmm = request.getParameter("choutmm") == null ? "" : request.getParameter("choutmm").trim();
	String choutdd = request.getParameter("choutdd") == null ? "" : request.getParameter("choutdd").trim();
	
	String adult = request.getParameter("adult") == null ? "" : request.getParameter("adult").trim();
	String student = request.getParameter("student") == null ? "" : request.getParameter("student").trim();
	String child = request.getParameter("child") == null ? "" : request.getParameter("child").trim();
	
	String pricestart = request.getParameter("pricestart") == null ? "" : request.getParameter("pricestart").trim();
	String priceend = request.getParameter("priceend") == null ? "" : request.getParameter("priceend").trim();
	
	String roomtype1_va = request.getParameter("roomtype1_va") == null ? "" : request.getParameter("roomtype1_va").trim();
	String roomtype2_va = request.getParameter("roomtype2_va") == null ? "" : request.getParameter("roomtype2_va").trim();
	
	QueryBean.getConnection(); //연결하기
	
	ArrayList resArr=new ArrayList();
	
	try
	{
		resArr = QueryBean.getRoomOne(checkyy,checkmm,checkdd,choutyy,choutmm,choutdd,adult,student,child,pricestart,priceend,roomtype1_va,roomtype2_va);
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
