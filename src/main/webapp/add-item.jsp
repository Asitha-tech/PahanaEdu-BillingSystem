<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Item</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Add New Item</h2>

    <form action="addItem" method="post">
        <label>Name:</label><br>
        <input type="text" name="name" required><br><br>

        <label>Description:</label><br>
        <textarea name="description" required></textarea><br><br>

        <label>Price:</label><br>
        <input type="number" name="price" step="0.01" required><br><br>

        <label>Quantity:</label><br>
        <input type="number" name="quantity" required><br><br>

        <label>Item Type:</label><br>
        <input type="text" name="item_type" required><br><br>

        <input type="submit" value="Add Item">
        
        <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    	</div>

    </form>

    <br>
    

    <p style="color:red;"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %></p>
</body>
</html>
