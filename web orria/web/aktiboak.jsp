<jsp:useBean id="gauzak" class="orokorra.Gauzak" scope="session"/>
<%@page import="java.util.Vector"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<link rel="stylesheet" type="text/css" href="style.css" media="screen" />
<link rel="stylesheet" type="text/css" href="print.css" media="print" />
<style type="text/css">
<!--
.Estilo2 {color: #FFFFFF}
-->

</style>

<head>
	<script type="text/javascript">
		function checkForm(form){
			if(form.username.value == "" || form.username.value == null){
				alert("Mesedez sartu erabiltzaile bat");
				form.username.focus;
				return false;
			}
			if(form.password.value == "" || form.password.value == null){
				alert("Mesedez sartu pasahitz bat");
				form.password.focus;
				return false;
			}
			return true;
		}
	</script>
<title>Zigka Web - Inzidentziak</title>
<meta http-equiv="Content-Language" content="English" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>
<body>

<div id="wrap">

<div id="header">
<h1><a href="index.jsp"><img src="images/Zigka.png" alt="Zigka" width="128" height="134" /></a> <img src="images/parking.jpg" alt="parking" width="800" height="134"/></h1>
</div>

<div id="breadcrumb">
<ul><a href="index.jsp">Etxea</a>><a href="aktiboak.jsp">aktiboak</a></ul>
</div>

<div id="menu">
<ul>
<li><a href="index.jsp">Etxea</a></li>
<li><a href="erabili.jsp">Nola Erabili</a></li>
<li><a href="kontaktua.jsp">Kontaktua</a></li>
</ul>
</div>

<div id="content">
<div class="right">
    <%--<%=gauzak.getInzidentziak()%>--%>
	<p style="margin-top:0.7em">
		<form action="aktiboak.jsp">
			<select name="mota">
				<%=gauzak.getAktiboMotak(request.getParameter("mota"))%>
			</select>
		</form>
		<iframe
			name="iframe1"
			width="700"
			height="400"
			src="aktiboTaula.jsp?mota=<%=request.getParameter("mota")%>"
			frameborder="no"
			scrolling="yes">
		</iframe>
	</p>

</div>

<div class="left">
	<%=gauzak.getMenua()%>
</div>

<div style="clear: both;"> </div>

</div>

<div id="footer">Zigka 2011 - <a href="sitemap.jsp">Site Map </a></div>

</div>

</body>
</html>
