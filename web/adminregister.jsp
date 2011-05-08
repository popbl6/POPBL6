<jsp:useBean id="gauzak" class="orokorra.Gauzak" scope="session"/>
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

		function checkForm2(form){
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
			if(form.email.value == "" || form.email.value == null || form.email.value.indexOf("@") == -1){
				alert("Mesedez sartu email balido bat");
				form.email.focus;
				return false;
			}
			return true;
		}
	</script>
<title>Zigka Web - Admin Erregistroa</title>
<meta http-equiv="Content-Language" content="English" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
	<%
	if(gauzak.getMota() != 2){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}
	%>

<div id="wrap">

<div id="header">
<h1><a href="index.jsp"><img src="images/Zigka.png" alt="Zigka" width="128" height="134" /></a> <img src="images/parking.jpg" alt="parking" width="800" height="134" /></h1>
</div>

<div id="breadcrumb">
<ul><a href="index.jsp">Etxea </a>><a href="adminregister.jsp"> Administratzaile erregistroa</a></ul>
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
	<p style="color:red"><% if(request.getParameter("msg") != null)
								out.println(request.getParameter("msg"));%></p>

<h2>Erregistroa bete </h2>
<br />
<form action="kontrol.jsp" method="post" onsubmit="return checkForm2(this);">
	<input type="hidden" name="action" value="registerAdmin" />
<table>
	<tr>
		<td> <div align="right"> Erabiltzailea : </div></td>
		<td> <input name="username" size=20 type="text"/> </td>
	</tr>
	<tr>
		<td> <div align="right"> Pasahitza : </div></td>
		<td> <input name="password" size=20 type="password" /> </td>
	</tr>
	<tr>
		<td> <div align="right"> Emaila : </div></td>
		<td> <input name="email" size=20 type="text" /> </td>
	</tr>
	<tr>
		<td> <input type="radio" name="mota" value="mantenu" checked="checked" /> Mantenu</td>
		<td> <input type="radio" name="mota" value="admin" /> Administratzailea</td>
	</tr>
	<tr>
		<td> <div align="right"><input name="submit" type="submit" value="Gorde"/></div></td>
	</tr>
	</table>
</form>
<br />
<br />
<br />
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