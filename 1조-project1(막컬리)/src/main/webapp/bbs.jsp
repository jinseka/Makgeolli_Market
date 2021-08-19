<%@page import="bbs.BbsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
  <%
  BbsDAO dao = new BbsDAO();
  ArrayList<BbsDTO> list = dao.read();
  %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- icon Style -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
  <!-- swiper Style -->
  <link rel="stylesheet"href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
  <!-- common Style -->
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/bbs.css">
  <!-- jquery CDN -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  <script src="js/index.js"></script>
  <title>막컬리::매일매일 신선한 장보기</title>
</head>
<body>
  <div id="wrap">
  	<!-- header 건들지마시오 -->
    <jsp:include page="header.jsp"></jsp:include>
    <div id="contents">
<div class= "container">
<div class = "row">
<table class = "bbstable" style = "text-align: center; border: 1px soild #DDDDDD">
<tr>
<th style= "background-color : #EEEEEE; text-align : center;">번호</th>
<th style= "background-color : #EEEEEE; text-align : center;">종류</th>
<th style= "background-color : #EEEEEE; text-align : center;">제목</th>
<th style= "background-color : #EEEEEE; text-align : center;">내용</th>
<th style= "background-color : #EEEEEE; text-align : center;">작성자</th>
<th style= "background-color : #EEEEEE; text-align : center;">작성일</th>
</tr>
<% 
  for(BbsDTO bag : list){
  %>
  	<tr>
  	<td><%= bag.getNoticeNum() %> </td>
  	<td><%= bag.getNoticeKinds() %> </td>
  	<td><%= bag.getNoticeTitle() %> </td>
  	<td><%= bag.getNoticeContents() %> </td>
  	<td><%= bag.getNoticeWriter() %> </td>
  	<td><%= bag.getNoticeDate() %></td>
  	</tr>
  <% } %>
</table>
<a href = "write.jsp"><button class = "btn">글쓰기</button></a>
</div>
</div>
    </div>
    <!-- footer 건들지마시오 -->
    <jsp:include page="footer.jsp"></jsp:include>
  </div>
</body>
</html>