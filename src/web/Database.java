package web;

import java.sql.*;
import java.util.*;
// jsp�뿉�꽌 �벝 �븣 癒쇱� db 媛앹껜瑜� 留뚮뱾�뼱�꽌 db �뿰寃곗쓣 �닔由�
// db.selectUserInformations濡� user�쓽 �썝�븯�뒗 �젙蹂� �뱾怨좎삤怨�
// db.getClosed()濡� �닔由쎈맂 �뿰寃� �빐�젣
public class Database {
	private Connection con = null;
	private final String DBNAME = "root";
	private final String PASSWORD = "qorwnsgg";
	
	// constructor
	public Database() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			con = DriverManager.getConnection("jdbc:mysql://buga.iptime.org:3306/web?characterEncoding=UTF-8&serverTimezone=UTC", DBNAME, PASSWORD);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("error occured");
			e.printStackTrace();
		}
	}
	// db �뿰寃� �빐�젣
	public void getClosed() {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	// �젙蹂� 諛쏆븘�삤湲�
	public ArrayList<String[]> readUserdata(final String userID, final String infoType) {
		ArrayList<String[]> ret = new ArrayList<String[]>();
		try {
			Statement stmt = con.createStatement();
			String selectSQL = "SELECT date, numberofproblem\r\n" + 
					"FROM " + infoType + "\r\n" + 
					"WHERE userid = \'" + userID + "\'\r\n" + 
					"ORDER BY date ASC\r\n" + 
					"LIMIT 30;";
			ResultSet resultSet = stmt.executeQuery(selectSQL);
			while(resultSet.next()) {
				ret.add(new String[] {resultSet.getString("date"), resultSet.getString("numberofproblem")});
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			ret.clear();
			e.printStackTrace();
		}
		return ret;
	}

}