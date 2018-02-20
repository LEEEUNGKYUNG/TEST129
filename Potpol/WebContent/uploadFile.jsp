<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="db.beans.*, java.sql.*, java.util.*, java.io.*, java.text.SimpleDateFormat, java.util.Date"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>

<%
	request.setCharacterEncoding("utf-8");

	String contentType = request.getContentType();
	
	if ((contentType == null) || (contentType.indexOf("multipart/form-data") == -1))
		throw new Exception("ContentType is NOT mulipart/form-data.");
	
	String uploadDir = getServletContext().getRealPath("/") + "upload"; //저장할 폴더 설정
	
	out.println("업로드 서버 경로 ->"+uploadDir);
	
	int maxSize = 100 * 1024 * 1024; //업로드파일 최대크기
	
	MultipartRequest mRequest = new MultipartRequest(request, uploadDir, maxSize, "utf-8", new DefaultFileRenamePolicy());
	//파일을 업로드한다.
	
	String imgText = mRequest.getParameter("imgText");
	String fileName = mRequest.getOriginalFileName("file1"); //파일이름
	long fileSize = mRequest.getFile("file1").length(); //파일사이즈
	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd_HHmmss", Locale.KOREA);
	Date currentTime = new Date();
	String dTime = formatter.format(currentTime);
	//날짜 설정
	String[] f_name_arr = fileName.split("\\.");
	String f_end = f_name_arr[1]; //파일 확장자를 추출
	
	String strOldFile = uploadDir + "\\" + fileName;
	String strNewFile = uploadDir + "\\" + dTime + "." + f_end; //저장할 파일명을 현재시간으로 지정
	
	File oldFile = new File(strOldFile);
	File newFile = new File(strNewFile);
	
	try
	{
		if(newFile.exists())
		{
			newFile.delete();
		}
		oldFile.renameTo(newFile);
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
%>
<html>
<head>
	<title>Image File Upload</title>
</head>

<body>
	<div id="div_popup" style="position:absolute; left:0px; top:20px; width:500px">
		<table align="center" border="0" width="500" cellpadding="0" cellspacing="1">
			<tr height="40">
				<td colspan="3" align="center"><b>Upload Result</b></td>
			</tr>
			<tr height="70">
				<td width="500" colspan="2" align="center"><%=fileName%>==><br>
				<%=strNewFile%><br>(<%=fileSize%>byte) 파일을 서버에 업로드 하였습니다.</td>
			</tr>
			<tr height="35">
				<td width="400">&nbsp;</td>
				<td width="100"><input type="button" value="OK" onClick="javascript:window.close();"></td>
				</tr>
		</table>
	</div>
</body>
</html>