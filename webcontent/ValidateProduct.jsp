<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyme.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		//Get parameters from the HTML form
		String person = session.getAttribute("user").toString();
		float minimum = Float.parseFloat(request.getParameter("min-price")); 
		float amount = Float.parseFloat(request.getParameter("amount"));
		float increment = Float.parseFloat(request.getParameter("bid-increment"));
		String date = request.getParameter("end-date");
		String category = request.getParameter("category");
		String sub = request.getParameter("sub-category");
		String specification = request.getParameter("specification");
		
		//Get the database connection
		Database db = new Database();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Make an insert statement for the Users table:
		System.out.println("`%"+sub+"/"+specification+"%';");
		String querry = "SELECT link FROM Assets WHERE link LIKE \"%"+sub+"/"+specification+"%\";";
		ResultSet result = stmt.executeQuery(querry);
		String link = "";
		if(result.next()){
			link = result.getString("link");
		}
		
		System.out.println(link);
		
		
		
		//Make an insert statement for the Users table:
		String insert = "INSERT INTO Sellsproduct(aid, username, minimumprice, amount, bidincrement, deadline, category, subcategory, specifications, link)"+ "VALUES (null,?,?,?,?,?,?,?,?,?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		
		ps.setString(1, person);
		ps.setString(2, minimum+"");
		ps.setString(3, amount+"");
		ps.setString(4, increment+"");
		ps.setString(5, date);
		ps.setString(6, category);
		ps.setString(7, sub);
		ps.setString(8, specification);
		ps.setString(9, link);
		
		
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("insert succeeded");
		response.sendRedirect("ProductListing.jsp");
	%>
	
	
</body>
</html>