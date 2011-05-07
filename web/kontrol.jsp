<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="gauzak" class="orokorra.Gauzak" scope="session"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
	String url="index.jsp";
	if(request.getParameter("action") != null){
		//Erabiltzaile bat logeatu
		if(request.getParameter("action").equals("login")){
			String username = request.getParameter("username");
			String pass = request.getParameter("password");
			if(request.getParameter("url") != null && !request.getParameter("url").equals(""))
				url = request.getParameter("url");
			if(!gauzak.logeatu(username, pass)){
				url = "loginerror.jsp";
			}
		}
		if(request.getParameter("action").equals("register")){
			String user = request.getParameter("username");
			String pass = request.getParameter("password");
			String email = request.getParameter("email");
			if(!gauzak.erregistratu(user, pass, email, 0)){
				url = "erregistroa.jsp?msg=Errore bat erregistratzean";
			}
			if(!gauzak.logeatu(user, pass)){
				url = "loginerror.jsp";
			}
		}
		if(request.getParameter("action").equals("registerAdmin")){
			String user = request.getParameter("username");
			String pass = request.getParameter("password");
			String email = request.getParameter("email");
			int mota;
			if(request.getParameter("mota").equals("mantenu"))
				mota = 1;
			else
				mota = 2;
			if(!gauzak.erregistratu(user, pass, email, mota)){
				url = "erregistroa.jsp?msg=Errore bat erregistratzean";
			}
		}
		if(request.getParameter("action").equals("logout")){
			gauzak.logout();
			url = "index.jsp";
		}
	}
		//String bidea = gauzak.bilatu("1", "7");

		
%>
		<%--<a href="<%=request.getContextPath()%>/Mapa?bidea=<%=bidea%>">aa</a>--%>
		<jsp:forward page="<%=url%>"/>