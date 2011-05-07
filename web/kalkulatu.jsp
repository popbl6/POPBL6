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
function bidali(zenbat){
	var url = "kontrol.jsp?";
	var form = document.getElementById('form');
	url += "ateAltueraMin="+form.ateAltueraMin.value;
	url += "&prezioMax="+form.prezioMax.value;
	url += "&plazaLibreMin="+form.plazaLibreMin.value;
	url += "&elbarrituak="+form.elbarrituak.checked;
	url += "&nodoa="+zenbat;
	url += "&action=kalkulatu"
	window.location = url;
	//alert(url);
}

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
<title>Bidea kalkulatu</title>
<meta http-equiv="Content-Language" content="English" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>

<div id="wrap">

<div id="header">
<h1><a href="index.jsp"><img src="images/Zigka.png" alt="Zigka" width="128" height="134" /></a> <img src="images/parking.jpg" alt="parking" width="800" height="134" /></h1>
</div>

<div id="breadcrumb">
<ul><a href="index.jsp">Etxea </a>><a href="kalkulatu.jsp"> Bidea kalkulatu</a></ul>
</div>

<div id="menu">
<ul>
<li><a href="index.jsp">Etxea</a></li>
<li><a href="erabili.jsp">Nola Erabili</a></li>
<li><a href="kontaktua.jsp">Kontaktua</a></li>
<li><a href="cas/kalkulatu.jsp">En castellano</a></li>
</ul>
</div>

<div id="content">
<div class="right">

<h2>Bidea kalkulatu</h2>
<br />
<center>

<form action="kontrol.jsp" id="form">
	<table border="0" width="600px">
		<tbody>
			<tr>
				<td>Ate altuera minimoa: <input type="text" name="ateAltueraMin" value="" /></td>
				<td>Prezio maximoa orduko: <input type="text" name="prezioMax" value="" /></td>
			</tr>
			<tr>
				<td>Plaza libre minimoa: <input type="text" name="plazaLibreMin" value="" /></td>
				<td>Elbarrituendako: <input type="checkbox" name="elbarrituak" value="ON" /></td>
			</tr>
		</tbody>
	</table>
	<br/>
	<br/>
	<div align="left">Aukeratu zauden puntua:</div><br/>
	<img alt=""  src="images/mapaTxikia.png" width="600" height="422" usemap="#mapamap"/>

	<map name="mapamap">
		<area shape="circle" coords="255,4,10" href="javascript:bidali(1)" />
		<area shape="circle" coords="477,140,10" href="javascript:bidali(2)" />
		<area shape="circle" coords="575,183,10" href="javascript:bidali(3)" />
		<area shape="circle" coords="548,285,10" href="javascript:bidali(4)" />
		<area shape="circle" coords="522,353,10" href="javascript:bidali(5)" />
		<area shape="circle" coords="497,404,10" href="javascript:bidali(6)" />
		<area shape="circle" coords="269,382,10" href="javascript:bidali(7)" />
		<area shape="circle" coords="232,387,10" href="javascript:bidali(8)" />
		<area shape="circle" coords="77,419,10" href="javascript:bidali(9)" />
		<area shape="circle" coords="67,369,10" href="javascript:bidali(10)" />
		<area shape="circle" coords="57,305,10" href="javascript:bidali(11)" />
		<area shape="circle" coords="37,192,10" href="javascript:bidali(12)" />
		<area shape="circle" coords="84,137,10" href="javascript:bidali(13)" />
		<area shape="circle" coords="137,137,10" href="javascript:bidali(14)" />
		<area shape="circle" coords="210,140,10" href="javascript:bidali(15)" />
		<area shape="circle" coords="317,183,10" href="javascript:bidali(16)" />
		<area shape="circle" coords="387,188,10" href="javascript:bidali(17)" />
		<area shape="circle" coords="435,186,10" href="javascript:bidali(18)" />
		<area shape="circle" coords="429,147,10" href="javascript:bidali(19)" />
		<area shape="circle" coords="502,278,10" href="javascript:bidali(20)" />
		<area shape="circle" coords="467,276,10" href="javascript:bidali(21)" />
		<area shape="circle" coords="373,291,10" href="javascript:bidali(22)" />
		<area shape="circle" coords="321,293,10" href="javascript:bidali(23)" />
		<area shape="circle" coords="321,349,10" href="javascript:bidali(24)" />
		<area shape="circle" coords="231,356,10" href="javascript:bidali(25)" />
		<area shape="circle" coords="224,330,10" href="javascript:bidali(26)" />
		<area shape="circle" coords="184,277,10" href="javascript:bidali(27)" />
		<area shape="circle" coords="216,270,10" href="javascript:bidali(28)" />
		<area shape="circle" coords="158,282,10" href="javascript:bidali(29)" />
		<area shape="circle" coords="103,191,10" href="javascript:bidali(30)" />
		<area shape="circle" coords="195,335,10" href="javascript:bidali(31)" />
	</map>
</form>
</center>
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