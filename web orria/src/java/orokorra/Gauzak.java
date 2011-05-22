/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package orokorra;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author ugaitz
 */
public class Gauzak {
	int mota = -1;
	String user = "guest";
	Connection webDb, CMDB;
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
		CMDB = DriverManager.getConnection("jdbc:postgresql://localhost:5432/CMDB", "web", "1111");
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


	public String getInzidentziak(){
		try{
			String buff = "";
			PreparedStatement stmt = CMDB.prepareStatement("select getInzidentziak()");
			ResultSet rs = stmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			rs.next();
			Hashtable<Integer, String> zutabeak = new Hashtable<Integer, String>();
			buff += "<table class=inzidentziak>\n"
				+	"\t<thead>\n"
                +		"\t\t<tr>\n";
			for(int i=1; i<=rsmd.getColumnCount(); i++){
				if(rs.getString(i) != null){
					zutabeak.put(i, rsmd.getColumnName(i));
					buff +=	"\t\t\t<td>"+rsmd.getColumnName(i)+"</td>\n";
				}
			}
			buff += "\t\t\t<td>Itxi</td>\n";
			buff +=	"\t\t</tr>\n"
                +	"\t</thead>\n"
                +	"\t<tbody>\n";
			do{
				Enumeration<Integer> zenb = zutabeak.keys();
				buff += "\t\t<tr>\n";
				while(zenb.hasMoreElements()){
					buff += "\t\t\t<td>"+rs.getString(zenb.nextElement())+"</td>\n";
				}
				buff += "\t\t\t<td><<input type=\"submit\" value=\"Itxi\" name=\""+rs.getString(1)+"\" /></td>\n";
				buff += "\t\t</tr>\n";
			} while(rs.next());
			buff += "\t<tbody>\n";
			buff += "<table>\n";


			//buff += placeholderTable(10, 10);

			return buff;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "Errore bat egon da";
	}
	
	public boolean inzidentziaItxi(String inziKod, String nola, String langKod){
		try{
			PreparedStatement stmt = CMDB.prepareStatement("select checkUser(?)");
			stmt.setInt(1, Integer.parseInt(langKod));
			ResultSet rs = stmt.executeQuery();
			if(!rs.next())
				return false;
			if(rs.getString(1) == null)
				return false;
			stmt = CMDB.prepareStatement("select InzidentziaItxi(?, ?, ?)");
			stmt.setInt(1, Integer.parseInt(langKod));
			stmt.setString(2, nola);
			stmt.setInt(3, Integer.parseInt(inziKod));
			return stmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}


	public boolean inzidentziaZabaldu(String langKod, String desk, String CIkod, String mota){
		try{
			//Erabiltzailea existitzen dela frogatu
			PreparedStatement stmt = CMDB.prepareStatement("select checkUser(?)");
			stmt.setInt(1, Integer.parseInt(langKod));
			ResultSet rs = stmt.executeQuery();
			if(!rs.next())
				return false;
			if(rs.getString(1) == null)
				return false;
			//CI-a existitzen dela frogatu
			stmt = CMDB.prepareStatement("select checkCI(?)");
			stmt.setInt(1, Integer.parseInt(CIkod));
			rs = stmt.executeQuery();
			if(!rs.next())
				return false;
			if(!rs.getBoolean(1))
				return false;
			//Inzidentzia sortu
			stmt = CMDB.prepareStatement("select InzidentziaSortu(?, ?, ?, ?)");
			stmt.setInt(1, Integer.parseInt(langKod));
			stmt.setString(2, desk);
			stmt.setInt(3, Integer.parseInt(CIkod));
			stmt.setInt(4, Integer.parseInt(mota));
			return stmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public String getAktiboak(String mota){
		try{
			String buff = "";
			if(mota == null || mota.equals("null"))
				mota = "1";
			int kod = Integer.parseInt(mota);
			PreparedStatement stmt = CMDB.prepareStatement("select * from ci where idmota=?");
			stmt.setInt(1, kod);
			ResultSet rs = stmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			rs.next();
			Hashtable<Integer, String> zutabeak = new Hashtable<Integer, String>();
			buff += "<table class=inzidentziak>\n"
				+	"\t<thead>\n"
                +		"\t\t<tr>\n";
			for(int i=1; i<=rsmd.getColumnCount(); i++){
				if(rs.getString(i) != null){
					zutabeak.put(i, rsmd.getColumnName(i));
					buff +=	"\t\t\t<td>"+rsmd.getColumnName(i)+"</td>\n";
				}
			}
			buff +=			"\t\t</tr>\n"
                +	"\t</thead>\n"
                +	"\t<tbody>\n";
			do{
				ArrayList<Integer> zenb = Collections.list(zutabeak.keys());
				//Collections.reverse(zenb);
				Collections.sort(zenb);
				buff += "\t\t<tr>\n";
				for(Integer i : zenb){
					System.out.println("Zenbaki "+i+"\tZutabe "+zutabeak.get(i)+"\tDatua "+rs.getString(i));
					buff += "\t\t\t<td>"+rs.getString(i)+"</td>\n";
				}
				buff += "\t\t</tr>\n";
			} while(rs.next());
			buff += "\t<tbody>\n";
			buff += "<table>\n";


			//buff += placeholderTable(15, kod*2);

			return buff;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "Errore bat egon da";
	}

	public String getInzidentziaMotak(){
		try{
			String buff = "";
			PreparedStatement stmt = CMDB.prepareStatement("select * from inzidentziaMotak");
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){
				buff += "<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>";
			}

			//buff += placeholderOption(5);
			
			return buff;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "Errore bat egon da";
	}


	/**
	 * Funtzio honetako option denek onClick="this.form.submit()" izan behar dute
	 *
	 * @return
	 */
	public String getAktiboMotak(String aukeratua){
		try{
			String buff = "";
			PreparedStatement stmt = CMDB.prepareStatement("select * from motak() as (id integer, mota varchar)");
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){
				String auk = "";
				if(rs.getString(1).equals(aukeratua)){
					auk = "selected=selected";
				}
				buff += "<option value="+rs.getString(1)+" onClick=\"this.form.submit()\" "+auk+">"+rs.getString(2)+"</option>";
			}

			//buff += placeholderOption(10);

			return buff;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "Errore bat egon da";
	}

	private String placeholderOption(int num){
		String buff = "";
		for(int i=0; i<num; i++)
			buff += "<option value="+i+" onClick=\"this.form.submit()\">Option"+i+"</option>";
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
