 <%@ page import="datateam.BaekjoonCrawler_tmp,datateam.Cookie, java.util.*" language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BAEKJOON.GG</title>
<link rel="stylesheet" href="css/bootstrap.css">
<title>Insert title here</title>
</head>
<body>
<%
	String userid = null;
	String id = request.getParameter("id"), pw = request.getParameter("pw");
	if ( id != null && pw != null ) {
		BaekjoonCrawler_tmp boj = new BaekjoonCrawler_tmp(id, pw);
		Cookie ck = Cookie.getInstance();
		ck.setCookie(boj.getCookie());
		ck.setUserId(boj.getuserID());
		userid = ck.userID;
	}
%>
	<form id="problem" action="problems.jsp" method="post"></form>
	<center>
		<img alt="MainLogo" src="img/main_logo.png" width="650" height="220"><p>
		<div id="welcome">
		<h1><%=userid %> 님 환영합니다.</h1>
		<a href="#" onclick="myinfo()">내정보</a>
		</div>
		<form id="send" class="form-inline" action="main.jsp" method="post" style="display:none">
		<div class="form-group">
			<p><input type="text" class="form-control" placeholder="아이디를 입력하세요" name="id"></p>
			<p><input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="pw"></p>
			<button class="btn btn-primary" type="submit" value="Login">Login</button>
		</div>
		</form>
	</center>
</body>
<script type="text/javascript">
	function check() {
		var id = <%=userid%>;
		var s = document.getElementById("send");
		var welcome = document.getElementById("welcome");
		if ( id == null ) {
			s.style.display = "block";
			welcome.style.display = "none";
		} else {
			s.style.display = "none";
			welcome.style.display = "block";
		}
	}
	function myinfo() {
		document.getElementById("problem").submit();
	}
	check();
</script>
</html>