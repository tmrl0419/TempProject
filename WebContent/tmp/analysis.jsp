<%@ page import="swTeam.BaekjoonCrawler_tmp,swTeam.Cookie, swTeam.SourceAnalysis, java.util.*" language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
   <style>
      .code {
         border:inset 2px silver; 
         min-width:700px;
         min-height:200px; 
         padding:1 1 1 1;
         font-size:9pt; 
         overflow:auto;
      }
   </style>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
Cookie ck = Cookie.getInstance();
BaekjoonCrawler_tmp boj = new BaekjoonCrawler_tmp(ck.loginCookie);
SourceAnalysis sa = new SourceAnalysis(request.getParameter("type"));
String code = boj.getSource(request.getParameter("source"));
%>
<h1>제출 번호 : <%=request.getParameter("source") %></h1>
<h2>소스 코드</h2>
<div class="code">
<pre>
<%
	out.print(code);
%>
</pre>
</div>
<h2>분석 결과</h2>
<div class="code">
<pre>
<%
	out.print(sa.Analysis(ck.userID, request.getParameter("pronum"), code));
%>
</pre>
</div>
</body>
</html>