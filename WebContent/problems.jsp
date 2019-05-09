<%@ page import="datateam.BaekjoonCrawler_tmp,datateam.Cookie, java.util.*" language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="web.*" %>
<%
	Database db = new Database();
	request.setCharacterEncoding("UTF-8");
	Cookie ck = Cookie.getInstance();
	BaekjoonCrawler_tmp boj = new BaekjoonCrawler_tmp(ck.loginCookie);
	String userid = ck.userID;
	ArrayList<String> problems = boj.crawlSolvedProblem(ck.userID);
	ArrayList<String> unproblems = boj.crawlUnsolvedProblem(ck.userID);
	db.insert(userid, problems.size()+"");
	ArrayList<String[]> ans = db.readUserdata(userid, "solvedproblem");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['line']});
	google.charts.setOnLoadCallback(drawChart);	
	function drawChart() {
	    var data = new google.visualization.DataTable();
	    data.addColumn('string', 'date');
	    data.addColumn('number', '푼 문제 수');
	    <%
		    for(int i = 0 ; i < ans.size(); ++i) {
		    	out.println("data.addRow([\'" +ans.get(i)[0] + "\', " + ans.get(i)[1] + "]);");
		    }
	    %>
	    var options = {
			chart: {
	        	title: '<%=userid%>' + '님이 푼 문제 수 그래프',
			},
	      	width: 700,
	      	height: 400
	    };
	    var chart = new google.charts.Line(document.getElementById('linechart_material'));
	    chart.draw(data, google.charts.Line.convertOptions(options));
	}
	function change(val) {
		var value = val;
		document.getElementById("problem").value = value;
		document.getElementById("send").submit();
	}
</script>
<body>
<center>
	<img alt="MainLogo" src="img/main_logo.png" width="650" height="220"><p>
		<p id="data"> </p>
		<div id='linechart_material'></div>
		<form action="sourcelist.jsp" id="send" method="post">
			<input type="hidden" name="problem" id="problem">
			<div style=\"line-height:130%\">
				<h2>내가 푼 문제</h2>
					<h3>
						<%
							for ( int i = 0; i < problems.size(); i++ )
								out.print(problems.get(i)+"\t");
						%>
					</h3>
			</div>
			<div style=\"line-height:130%\">
				<h2>틀린 문제</h2>
					<h3>
						<%
							for ( int i = 0; i < unproblems.size(); i++ )
								out.print(unproblems.get(i)+"\t");
						%>
					</h3>
			</div>
		</form>
</center>
</body>
</html>