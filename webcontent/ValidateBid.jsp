<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe | Validate</title>
</head>
<body>
	<%
		LocalDateTime dt = LocalDateTime.now();
		String[] arr = dt.toString().split("T");
		arr[1] = arr[1].substring(0,8);
		
		String date = arr[0]+" "+arr[1];
		String user = session.getAttribute("user").toString();
		String floor = request.getParameter("floor"); 
		String ceiling = request.getParameter("ceiling"); 
		String option = request.getParameter("type"); 
		String aid = request.getParameter("aid");
		
 		if(ceiling.isBlank()){
			if(option.equals("static")){
				ceiling=floor;
			}
		}
			
		
 		//Get the database connection
		Database db = new Database();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
	
		//Make an insert statement for the Users table:
		String insert = "INSERT INTO Bids(aid, username, floor, ceiling, type, date)"+ "VALUES (?,?,?,?,?,?);";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		
		ps.setString(1, aid);
		ps.setString(2, user);
		ps.setString(3, floor);
		ps.setString(4, ceiling);
		ps.setString(5, option);
		ps.setString(6, date);

		ps.executeUpdate();
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		response.sendRedirect("ProductListing.jsp?aid="+aid);
		
		
	%>

</body>
</html>