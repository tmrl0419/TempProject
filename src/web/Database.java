package web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
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
			String selectSQL = "SELECT today, numberofproblem\r\n" + 
					"FROM " + infoType + "\r\n" + 
					"WHERE userid = \'" + userID + "\'\r\n" + 
					"ORDER BY today ASC\r\n" + 
					"LIMIT 30;";
			ResultSet resultSet = stmt.executeQuery(selectSQL);
			while(resultSet.next()) {
				ret.add(new String[] {resultSet.getString("today"), resultSet.getString("numberofproblem")});
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			ret.clear();
			e.printStackTrace();
		}
		return ret;
	}
	public void update(String userId, final String tableName, final String list, final int size) {
		String updateSQL = "UPDATE " + tableName + "\r\n"
				+ "SET list = '" + list + "' , " + size
				+ "WEHRE userid = " + userId + "AND today = sysdate()";
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate(updateSQL);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void insert(String userId, final String tableName, ArrayList<String> crawledData ) {
		String list = "";
		try {
			Statement stmt = con.createStatement();
			// INSERT INTO solvedproblem(userid, today, list, numberofproblem)
			// VALUES ('ksaid0203', '2019-05-06', '1001, 1002, 1003', 3);
			
			for(int i = 0 ; i < crawledData.size() ; ++i) {
				list = list.concat(crawledData.get(i));
				if(i != crawledData.size() - 1) list = list.concat(", ");
			}
//			System.out.println(list);
			String insertSQL = "INSERT INTO " + tableName + "(userid, today, list, numberofproblem)\r\n" + 
					"VALUES('" + userId + "', sysdate(), '" + list +"', " + crawledData.size() + ")"
							+ " ON DUPLICATE KEY UPDATE userid='" + userId + "', today=sysdate();";
			System.out.println(insertSQL);
//			String selectSQL = "INSERT INTO solvedproblem"
//					+ " VALUES('" + userId + "', sysdate(),'" + number + "')"
//					+ " ON DUPLICATE KEY UPDATE userid='" + userId + "', date=sysdate();";
			
			// 삽입 불가하면 update 한다
			stmt.executeUpdate(insertSQL);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			update(userId, tableName, list, crawledData.size());
			e.printStackTrace();
		}
	}

}