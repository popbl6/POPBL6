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

		function checkForm2(form){
			if(form.langKod.value == "" || form.langKod.value == null){
				alert("Mesedez sartu langile id bat");
				form.langKod.focus;
				return false;
			}
			if(form.nola.value == "" || form.nola.value == null){
				alert("Mesedez sartu arazoa nola konpondu den");
				form.nola.focus;
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

	<%
	if(gauzak.getMota() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}
	%>
	<p style="margin-top:0.7em">
		Kodea: <%=request.getParameter("Itxi")%><br />
		<form action="kontrol.jsp" onsubmit="return checkForm2(this);">
			<input type="hidden" name="action" value="inzidentziaItxi" />
			<input type="hidden" name="inziKod" value="<%=request.getParameter("Itxi")%>" />
			Langile kodea: <input type="text" name="langKod" value="" /><br />
			Konpontzeko pausuak: <br />
			<textarea name="nola" rows="7" cols="90"></textarea><br />
			<center>
			<input type="submit" value="OK" name="OK" style="width:100px;height:30px "/>
			</center>
		</form>
	</p>

</body>
</html>
