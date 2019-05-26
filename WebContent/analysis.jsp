<%@ page import="datateam.BaekjoonCrawler, datateam.Cookie, swTeam.*, java.util.*" language="java" contentType="text/html; charset=EUC-KR"
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
	String num = request.getParameter("source");
	BaekjoonCrawler boj = new BaekjoonCrawler(ck.loginCookie);
	CheckDuplication check = new CheckDuplication("p"+num);
	String code = boj.getSource(num);
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
	if ( check.Check() == 0 ) {
		SourceAnalysis sa = new SourceAnalysis(request.getParameter("type"));
		out.print(sa.Analysis("p"+num, code));
	} else {
		out.print(check.getResult());
	}
%>
</pre>
</div>
</body>
</html>