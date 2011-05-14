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
		//CMDB-ra konektatu
	}


	public void logout(){
		user = "guest";
		mota = -1;
	}

	public boolean logeatu(String user, String pass){
		try {
			PreparedStatement stmt = webDb.prepareStatement("select checkUser(?, ?)");
			stmt.setString(1, user);
			stmt.setString(2, pass);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			if(rs.getString(1) != null){
				mota = rs.getInt(1);
				this.user = user;
			} else {
				return false;
			}
			return true;
		} catch (SQLException ex) {
			Logger.getLogger(Gauzak.class.getName()).log(Level.SEVERE, null, ex);
		} catch (Exception e) {
			Logger.getLogger(Gauzak.class.getName()).log(Level.SEVERE, null, e);
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


	public String getMenua(){
		if(mota == 0){//normal
			return "<h2>Login :</h2>"
					 + "	<p>Ongi etorri <b>"+user+"</b></p><br>"
					 + "<p><a href=kontrol.jsp?action=logout>Logout</a>"
					 + ""
					 + "		<h2>Menua :</h2>"
					 + ""
					 + "<ul>"
					 + "<li><a href=\"aktiboak.jsp\">TI-ak kontsultatu</a></li>"
					 + "<li><a href=\"inzidentziaSortu.jsp\">Inzidentzia berria</a></li>"
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
					 + "<li><a href=\"aktiboak.jsp\">TI-ak kontsultatu</a></li>"
					 + "<li><a href=\"inzidentziaSortu.jsp\">Inzidentzia berria</a></li>"
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
					 + "<li><a href=\"aktiboak.jsp\">TI-ak kontsultatu</a></li>"
					 + "<li><a href=\"inzidentziaSortu.jsp\">Inzidentzia berria</a></li>"
					 + "<li><a href=\"adminregister.jsp\">Administratzaile erregistroa</a></li>"
					 + "<li><a href=\"inzidentziak.jsp\">Inzidentziak kudeatu</a></li>"
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
				 + "<li><a href=\"aktiboak.jsp\">TI-ak kontsultatu</a></li>"
				 + "<li><a href=\"inzidentziaSortu.jsp\">Inzidentzia berria</a></li>"
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


	public String getInzidentziak(){
		String buff = "";

		buff += placeholderTable(10, 10);

		return buff;
	}

	public String getAktiboak(){
		String buff = "";

		buff += placeholderTable(15, 30);

		return buff;
	}

	public String getInzidentziaMotak(){
		String buff = "";

		buff += placeholderOption(5);

		return buff;
	}

	private String placeholderOption(int num){
		String buff = "";
		for(int i=0; i<num; i++)
			buff += "<option>Option"+i+"</option>";
		return buff;
	}

	private String placeholderTable(int columns, int rows) {
		String buff = "";

		buff += "<table class=inzidentziak>\n"
				+	"\t<thead>\n"
                +		"\t\t<tr>\n";
		for(int i = 0; i<columns; i++)
			buff +=			"\t\t\t<td>Zutabe"+i+"</td>\n";
        buff +=			"\t\t</tr>\n"
                +	"\t</thead>\n"
                +	"\t<tbody>\n";

		for(int i=0; i<rows; i++){
			buff += "\t\t<tr>\n";
			for(int j=0; j<columns; j++){
				buff += "\t\t\t<td>zutabe"+j+"row"+i+"</td>\n";
			}
			buff += "\t\t</tr>\n";
		}
		buff += "\t<tbody>\n";
		buff += "<table>\n";

		return buff;
	}

}
