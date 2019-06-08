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
      .nodrag {
      	-ms-user-select: none;
      	-moz-user-select: -moz-none;
      	-webkit-user-select: none;
      	-khtml-user-select: none;
      	user-select:none;
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
	CheckDuplication check = new CheckDuplication(num);
	String code = boj.getSource(num);
	String[] print_code = code.replace("<", "&lt").replace(">", "&gt").split("\n");
%>
<h1>제출 번호 : <%=request.getParameter("source") %></h1>
<h2>소스 코드</h2>
<div class="code">
<pre style="font-size:15px; font-family:Roboto">
<%
	for ( int i = 1; i <= print_code.length; i++ ) {
		out.print("<span class='nodrag' style='display:inline-block; width:30px; text-align:center; font:bold; background-color:gray; color:white'>");
		out.print(i+"</span>");
		out.println("<span style='margin-left:10px'>"+print_code[i-1]+"</span>");
	}
%>
</pre>
</div>
<h2>분석 결과</h2>
<div class="code">
<pre style="margin-left:10px; font-size:15px; font-family:Roboto; line-height:150%">
<%
	
	if ( check.Check() == 0 ) {
		SourceAnalysis sa = new SourceAnalysis(request.getParameter("type"));
		out.print(sa.Analysis(num, code));
	} else {
		out.print(check.getResult());
	}
%>
</pre>
</div>
</body>
</html>