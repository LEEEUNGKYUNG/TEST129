package db.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class QueryBean 
{
	Connection conn; //연결
	Statement stmt; //질의
	ResultSet rs; //응답
	
	public QueryBean()
	{
		conn=null;
		stmt=null;
		rs=null;
	}//생성자
	
	public void getConnection()
	{
		try
		{
			conn=DBConnection.getConnection();
		}
		catch(Exception e1)
		{
			e1.printStackTrace();
		}
		try
		{
			stmt=conn.createStatement();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}//연결하기
	
	public void closeConnection()
	{
		if(stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
		
		if(conn !=null)
		{
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
	}//연결끊기
	
	public ArrayList getRoomList(String room) throws Exception
	{	
		StringBuffer sb = new StringBuffer();
		
		sb.append(" SELECT ");
		sb.append(" 	* ");
		sb.append(" FROM ");
		sb.append(" 	" + room +" ");
		
		//스트링 버퍼에 질의할 쿼리문 저장
		rs = stmt.executeQuery(sb.toString());
		
		ArrayList res =new ArrayList();
		while(rs.next())
		{
			res.add(rs.getString(1));
			res.add(rs.getString(2));
			res.add(rs.getString(3));
			res.add(rs.getString(4));
			res.add(rs.getString(5));
			res.add(rs.getString(6));
			res.add(rs.getString(7));
		}//응답한걸 res 배열리스트에 추가한다.
		
		System.out.println(sb.toString());
		
		return res;
	}
	
	public ArrayList getRoomOne(String checkyy, String checkmm, String checkdd,String choutyy,String choutmm,String choutdd,String adult, String student,String child,String pricestart,String priceend, String roomtype1_va,String roomtype2_va) throws Exception
	{	
		StringBuffer sb = new StringBuffer();
		int adult1 = Integer.parseInt(adult);
		int student1 = Integer.parseInt(student);
		int child1 = Integer.parseInt(child);
		int sum = adult1+student1+child1;
		
		int pricestart1 =Integer.parseInt(pricestart);
		int priceend1 =Integer.parseInt(priceend);
		
		
		
		String str = "20170321";
		String str1 = str.substring(2, 4);
		String str2 = str.substring(4, 6);
		String str3 = str.substring(6, 8);
		
		//checkyy = checkyy.substring(2, 4); //나중에 쓰시오
		
//		System.out.println(str1);
//		System.out.println(str2);
//		System.out.println(str3);
		
		sb.append(" SELECT ");
		sb.append(" 	* ");
		sb.append(" FROM ");
		sb.append(" 	ROOM ");
		sb.append(" WHERE ");
		sb.append(" 	ROOMID NOT IN(SELECT ROOMID");
		sb.append(" 	FROM ORDERS");
		sb.append(" 	WHERE ORDERDATE BETWEEN '"+checkyy+"/"+checkmm+"/"+checkdd+"' AND '"+choutyy+"/"+choutmm+"/"+choutdd+"')");
		sb.append(" 	AND ROOMCOUNT>="+sum);
		sb.append(" 	AND ADULTPRICE*"+adult1+"+STUPRICE*"+student1+"+CHILDPRICE*"+child1+">="+pricestart1);
		sb.append(" 	AND ADULTPRICE*"+adult1+"+STUPRICE*"+student1+"+CHILDPRICE*"+child1+"<="+priceend1);
		sb.append(" 	AND (ROOMTYPE ='"+roomtype1_va+"' OR ROOMTYPE ='"+roomtype2_va+"')");
		sb.append(" ORDER BY ");
		sb.append("		ROOMID ASC");
		
		System.out.println(sb.toString());
		
		//스트링 버퍼에 질의할 쿼리문 저장
		rs = stmt.executeQuery(sb.toString());
		
		ArrayList res =new ArrayList();
		while(rs.next())
		{
			res.add(rs.getString(1));
			res.add(rs.getString(2));
			res.add(rs.getString(3));
			res.add(rs.getString(4));
			res.add(rs.getString(5));
			res.add(rs.getString(6));
			res.add(rs.getString(7));
		}//응답한걸 res 배열리스트에 추가한다.
		
		
		return res;
	}
	
	public ArrayList getRoomInfo(String roomid) throws Exception
	{	
		StringBuffer sb = new StringBuffer();
		
		sb.append(" SELECT ");
		sb.append(" 	* ");
		sb.append(" FROM ");
		sb.append(" 	ROOM");
		sb.append(" WHERE");
		sb.append(" 	ROOMID="+roomid);
		
		//스트링 버퍼에 질의할 쿼리문 저장
		rs = stmt.executeQuery(sb.toString());
		
		ArrayList res =new ArrayList();
		while(rs.next())
		{
			res.add(rs.getString(1));
			res.add(rs.getString(2));
			res.add(rs.getString(3));
			res.add(rs.getString(4));
			res.add(rs.getString(5));
			res.add(rs.getString(6));
			res.add(rs.getString(7));
		}//응답한걸 res 배열리스트에 추가한다.
		
		System.out.println(sb.toString());
		
		return res;
	}
	
	public int setUserInfo(String name,String room_id,String checkyy, String checkmm, String checkdd,String choutyy,String choutmm,String choutdd,String adult, String student,String child,String sum) 
	{
		int result =0;
		
		StringBuffer sb = new StringBuffer();
		PreparedStatement pstmt = null;
		
		sb.append(" INSERT INTO ");
		sb.append("		ORDERS ");
		sb.append(" VALUES ");
		sb.append("		(4,(SELECT CUSTID FROM CUSTOMER WHERE CUSNAME='"+ name +"'),'" + room_id + "', '" +checkyy+"/"+checkmm+"/"+checkdd+"','"+adult+"','"+student+"','"+child+"','"+sum+"','예약')");
		
		System.out.println(sb.toString());
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(pstmt !=null)	{
					pstmt.close();
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int deleteUserInfo(String id) throws Exception
	{
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" DELETE ");
		sb.append("		FROM ");
		sb.append("			USER_INFO_SAMPLE ");
		sb.append("		WHERE ");
		sb.append("			U_ID = ? ");
		
		try
		{
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.clearParameters();
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if(pstmt != null)
				{
					pstmt.close();
				}
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int updateUserInfo(String id, String name, String phone, String grade) 
	{
		int result =0;
		
		StringBuffer sb = new StringBuffer();
		PreparedStatement pstmt = null;
		
		sb.append(" UPDATE USER_INFO_SAMPLE ");
		sb.append("		SET U_ID ='" + id + "',U_NAME='" + name + "',U_PHONE='" + phone + "',U_GRADE='" + grade +"'");
		sb.append(" WHERE ");
		sb.append("		U_ID ='" + id +"'");
		
		System.out.println(sb.toString());

		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(pstmt !=null)	{
					pstmt.close();
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
