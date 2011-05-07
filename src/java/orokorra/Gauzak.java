/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package orokorra;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ugaitz
 */
public class Gauzak {
	int mota = -1;
	String user = "guest";
	Connection webDb;
	int inziPark = 0;
	String taula = "";
	int dbAktibo = 0;
	
	public Gauzak(){
		try {
			konexioakEgin();
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(Gauzak.class.getName()).log(Level.SEVERE, null, ex);
		} catch (SQLException ex) {
			Logger.getLogger(Gauzak.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

	public String getTaula(){return taula;}
	public int getMota(){return mota;}

	private void konexioakEgin() throws ClassNotFoundException, SQLException {
		Class.forName("org.postgresql.Driver");
		webDb = DriverManager.getConnection("jdbc:postgresql://localhost:5432/web", "web", "1111");
		System.out.println("webdb sortuta");
		//CMDB-ra konektatu
	}


	public void logout(){
		user = "guest";
		mota = -1;
	}

	public boolean logeatu(String user, String pass){
		try {
			if(webDb == null)
				System.out.println("null da");
			PreparedStatement stmt = webDb.prepareStatement("select checkUser(?, ?)");
			stmt.setString(1, user);
			stmt.setString(2, pass);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()){
				mota = rs.getInt(1);
				this.user = user;
			} else {
				return false;
			}
			return true;
		} catch (SQLException ex) {
			Logger.getLogger(Gauzak.class.getName()).log(Level.SEVERE, null, ex);
		}
		return false;
	}

	public boolean erregistratu(String user, String pass, String email, int modo){
		try {
			PreparedStatement stmt = webDb.prepareStatement("select bidaliErabiltzailea(?::text, ?::text, ?, ?::text)");
			stmt.setString(1, user);
			stmt.setString(2, pass);
			stmt.setString(4, email);
			stmt.setInt(3, modo);
			return stmt.execute();
		} catch (SQLException ex) {
			Logger.getLogger(Gauzak.class.getName()).log(Level.SEVERE, null, ex);
		}
		return false;
	}

	
        public String getMenuaCas(){
		if(mota == 0){//normal
			return "<h2>Login :</h2>"
					 + "	<p>Bienvenido <b>"+user+"</b></p><br>"
					 + "<p><a href=kontrol.jsp?action=logout>Logout</a>"
					 + ""
					 + "		<h2>Menu :</h2>"
					 + ""
					 + "<ul>"
					 + "<li><a href=\"tarifak.jsp\">Tarifas</a></li>"
					 + "<li><a href=\"kalkulatu.jsp\">Cálculo de la ruta</a></li>"
					 + "</ul>";
		}
		if(mota == 1){//mantenu
			return "<h2>Login :</h2>"
					 + "	<p>Bienvenido <b>"+user+"</b></p><br>"
					 + "<p><a href=kontrol.jsp?action=logout>Logout</a>"
					 + ""
					 + "		<h2>Menu :</h2>"
					 + ""
					 + "<ul>"
					 + "<li><a href=\"tarifak.jsp\">Tarifas</a></li>"
					 + "<li><a href=\"kalkulatu.jsp\">Cálculo de la ruta</a></li>"
					 + "<li><a href=\"inzidentziak.jsp\">Incidencias</a></li>"
					 + "</ul>";

		}
		if(mota == 2){//admin
			return "<h2>Login :</h2>"
					 + "	<p>Bienvenido <b>"+user+"</b></p><br>"
					 + "<p><a href=kontrol.jsp?action=logout>Logout</a>"
					 + ""
					 + "		<h2>Menu :</h2>"
					 + ""
					 + "<ul>"
					 + "<li><a href=\"tarifak.jsp\">Tarifas</a></li>"
					 + "<li><a href=\"kalkulatu.jsp\">Cálculo de la ruta</a></li>"
					 + "<li><a href=\"adminregister.jsp\">Registro de administrador</a></li>"
					 + "<li><a href=\"inzidentziak.jsp\">Incidencias</a></li>"
					 + "<li><a href=\"konfiguratzaile.jsp\">Administrador del base de datos</a></li>"
					 + "</ul>";
		}
		return "<form action=\"kontrol.jsp\" method=\"post\" onsubmit=\"return checkForm(this);\">"
				 + "<input type=\"hidden\" name=\"action\" value=\"login\" />"
				 + "<h2>Login :</h2>"
				 + "	<table>"
				 + "		<tr>"
				 + "			<td> <div align=\"right\"><span class=\"Estilo2\"> Usuario : </span></div></td>"
				 + "			<td> <input name=\"username\" size=12 type=\"text\"/> </td>"
				 + "		</tr>"
				 + "		<tr>"
				 + "			<td> <div align=\"right\"><span class=\"Estilo2\"> Contraseña : </span></div></td>"
				 + "			<td> <input name=\"password\" size=12 type=\"password\" /> </td>"
				 + "		</tr>"
				 + "		<tr>"
				 + "			<td> <div align=\"right\"><input name=\"submit\" type=\"submit\" value=\"login\" /></div></td>"
				 + "		  <td><ul>"
				 + "			<li><a href=\"erregistroa.jsp\">Registrarse</a></li>"
				 + "		  </ul></td>"
				 + "		</tr>"
				 + "	</table>"
				 + "</form>"
				 + ""
				 + "		<h2>Menu :</h2>"
				 + ""
				 + "<ul>"
				 + "<li><a href=\"tarifak.jsp\">Tarifas</a></li>"
				 + "<li><a href=\"kalkulatu.jsp\">Cálculo de la ruta</a></li>"
				 + "</ul>";
	}

	public String getMenua(){
		if(mota == 0){//normal
			return "<h2>Login :</h2>"
					 + "	<p>Ongi etorri <b>"+user+"</b></p><br>"
					 + "<p><a href=kontrol.jsp?action=logout>Logout</a>"
					 + ""
					 + "		<h2>Menua :</h2>"
					 + ""
					 + "<ul>"
					 + "<li><a href=\"tarifak.jsp\">Tarifak kontsultatu</a></li>"
					 + "<li><a href=\"kalkulatu.jsp\">Bidea kalkulatu</a></li>"
					 + "</ul>";
		}
		if(mota == 1){//mantenu
			return "<h2>Login :</h2>"
					 + "	<p>Ongi etorri <b>"+user+"</b></p><br>"
					 + "<p><a href=kontrol.jsp?action=logout>Logout</a>"
					 + ""
					 + "		<h2>Menua :</h2>"
					 + ""
					 + "<ul>"
					 + "<li><a href=\"tarifak.jsp\">Tarifak kontsultatu</a></li>"
					 + "<li><a href=\"kalkulatu.jsp\">Bidea kalkulatu</a></li>"
					 + "<li><a href=\"inzidentziak.jsp\">Inzidentziak kudeatu</a></li>"
					 + "</ul>";

		}
		if(mota == 2){//admin
			return "<h2>Login :</h2>"
					 + "	<p>Ongi etorri <b>"+user+"</b></p><br>"
					 + "<p><a href=kontrol.jsp?action=logout>Logout</a>"
					 + "" 
					 + "		<h2>Menua :</h2>"
					 + ""
					 + "<ul>"
					 + "<li><a href=\"tarifak.jsp\">Tarifak kontsultatu</a></li>"
					 + "<li><a href=\"kalkulatu.jsp\">Bidea kalkulatu</a></li>"
					 + "<li><a href=\"adminregister.jsp\">Administratzaile erregistroa</a></li>"
					 + "<li><a href=\"inzidentziak.jsp\">Inzidentziak kudeatu</a></li>"
					 + "<li><a href=\"konfiguratzaile.jsp\">Datu base kudeatzailea</a></li>"
					 + "</ul>";
		}
		return "<form action=\"kontrol.jsp\" method=\"post\" onsubmit=\"return checkForm(this);\">"
				 + "<input type=\"hidden\" name=\"action\" value=\"login\" />"
				 + "<h2>Login :</h2>"
				 + "	<table>"
				 + "		<tr>"
				 + "			<td> <div align=\"right\"><span class=\"Estilo2\"> Erabiltzailea : </span></div></td>"
				 + "			<td> <input name=\"username\" size=12 type=\"text\"/> </td>"
				 + "		</tr>"
				 + "		<tr>"
				 + "			<td> <div align=\"right\"><span class=\"Estilo2\"> Pasahitza : </span></div></td>"
				 + "			<td> <input name=\"password\" size=12 type=\"password\" /> </td>"
				 + "		</tr>"
				 + "		<tr>"
				 + "			<td> <div align=\"right\"><input name=\"submit\" type=\"submit\" value=\"login\" /></div></td>"
				 + "		  <td><ul>"
				 + "			<li><a href=\"erregistroa.jsp\">Erregistratu</a></li>"
				 + "		  </ul></td>"
				 + "		</tr>"
				 + "	</table>"
				 + "</form>"
				 + ""
				 + "		<h2>Menua :</h2>"
				 + ""
				 + "<ul>"
				 + "<li><a href=\"tarifak.jsp\">Tarifak kontsultatu</a></li>"
				 + "<li><a href=\"kalkulatu.jsp\">Bidea kalkulatu</a></li>"
				 + "</ul>";
	}


	/*public String getInzidentziak(){
            String taula="Errorea datu basetik kargatzerakoan.";
            PreparedStatement stmt;
            ResultSet rs;
            try {
                    stmt=parkingDb[dbAktibo].prepareStatement("select * from jasoinzidentziak() as (kod integer, time timestamp, zer varchar, mikrokod int, sentskod int);");
                    rs=stmt.executeQuery();
                    taula=      "<table class=inzidentziak>\n"
                               +"<thead>\n"
                               +    "<tr>\n"
                               +"        <td>Inzidentzi Kodea</td>\n"
                               +"        <td>Inzidenatzia Ordua</td>\n"
                               +"        <td>Deskribapena</td>\n"
                               +"        <td>Mikro Kodea</td>\n"
                               +"        <td>Sentsore Kodea</td>\n"
                               +"        <td>Konponketa</td>\n"
                               +"   </tr>\n"
                               +"</thead>\n"
                               +"<tbody>\n";

                    while(rs.next()){
                        taula+=         "<tr>\n"
                                        +"         <td>"+rs.getInt(1)+"</td>\n"
                                        +"         <td>"+rs.getTime(2)+"</td>\n"
                                        +"         <td>"+rs.getString(3)+"</td>\n"
                                        +"         <td>"+rs.getInt(4)+"</td>\n"
                                        +"         <td>"+rs.getInt(5)+"</td>\n"
                                        +"         <td><a href=kontrol.jsp?action=konpondu&mikroa="+rs.getInt(4)+"&sents="+rs.getInt(5)+">Konpondu</a>\n"
                                        +"</tr>\n";
                    }
                    taula+=  "<tbody>\n"
                            +"</table>\n";
					return taula;
            } catch (SQLException e) {
				e.printStackTrace();
            }
			return "";
        }*/
	
	//Inzidentzia konpondu funtzioa egin

}
