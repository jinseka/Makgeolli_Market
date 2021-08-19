<%@page import="bbs.BbsDAO"%>
<%@page import="bbs.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String noticeKinds = request.getParameter("noticeKinds");
    String noticeTitle = request.getParameter("noticeTitle");
    String noticeDate = request.getParameter("noticeDate");
    String noticeWriter = request.getParameter("noticeWriter");
    String noticeContent = request.getParameter("noticeContent");
    
    BbsDTO dto = new BbsDTO();
    dto.setNoticeContents(noticeContent);
    dto.setNoticeKinds(noticeKinds);
    dto.setNoticeTitle(noticeTitle);
    dto.setNoticeWriter(noticeWriter);
    dto.setNoticeDate(noticeDate);
    
    BbsDAO dao = new BbsDAO();
    
    int rs = dao.create(noticeWriter, noticeTitle, noticeKinds, noticeContent, noticeDate);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var msg=setInterval(function(){
	    location.href="bbs.jsp"
	},2000);
</script>
</head>
<body>
<%= rs %>
작성이 완료되었습니다.
</body>
</html>