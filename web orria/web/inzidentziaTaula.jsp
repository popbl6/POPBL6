<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="gauzak" class="orokorra.Gauzak" scope="session"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<link rel="stylesheet" type="text/css" href="style.css" media="screen" />
<link rel="stylesheet" type="text/css" href="print.css" media="print" />
<style type="text/css">
<!--
.Estilo2 {color: #FFFFFF}
-->

</style>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inzidentzia taula</title>
    </head>
    <body>
        <%
			if(gauzak.getMota() < 1){
				response.sendRedirect(request.getContextPath()+"/index.jsp");
			}
		%>
		<%=gauzak.getInzidentziak()%>
    </body>
</html>
