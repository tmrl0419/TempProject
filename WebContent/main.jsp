 <%@ page import="datateam.BaekjoonCrawler,datateam.Cookie,java.util.*" language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BAEKJOON.GG</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />

</head>

<%
	String userid = null;
	String id = request.getParameter("id"), pw = request.getParameter("pw");
	if ( id != null && pw != null ) {
		BaekjoonCrawler boj = new BaekjoonCrawler(id, pw);
		Cookie ck = Cookie.getInstance();
		ck.setCookie(boj.getCookie());
		ck.setUserId(boj.getuserID());
		userid = ck.userID;
	}
%>
<body>
	<form id="problem" action="problems.jsp" method="post" style="display:none"></form>
		<!-- <img alt="MainLogo" src="img/main_logo.png" width="650" height="220"><p> -->
		
			<header id="header">
				<div class="inner">
					<a href="main.jsp" class="logo">BACKJOON.GG</a>
					<nav id="nav">
						<!-- <a href="main.jsp">메인</a> -->
						<a href="#" onclick="myinfo()">내정보</a>
						<a href="main.jsp" onclick="logout()">로그 아웃</a>
					</nav>
				</div>
			</header>
			<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>
			
			<section id="banner" style="min-height:550px">
			<div id="welcome" class="inner">
				<h1><%=userid %> 님 환영합니다.</h1>
			</div>

			<form id="send" class="form-inline" action="main.jsp" method="post" style="display:none">
				<div class="inner">
					<h1>BackJoon.GG:</h1>
				</div>
				
				<div class="inner">
					<form method="post" action="#">
						<div class="field half first">
							<label for="name"></label>
							<input type="text" name="id" placeholder="ID" style="font-weight: bold; color:black; background-color: white; background-color:rgba(256,256,256,0.8)" />
						</div>
						<div class="field half">
							<label for="email"></label>
							<input type="password" name="pw" placeholder="Password" style="font-weight: bold; color:black; background-color: white; background-color:rgba(256,256,256,0.8)"/>
						</div>
						<ul class="actions">
							<center><li><input type="submit" value="Login" class="alt"/></li></center>
						</ul>
					</form>
				</div>
			</form>
	
</body>
	
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>
	
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