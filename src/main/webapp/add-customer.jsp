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
    <title>Add Customer - Pahana Edu</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Add Customer</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form action="add-customer" method="post">
        <label>Name:</label><br>
        <input type="text" name="name" required><br><br>

        <label>Address:</label><br>
        <input type="text" name="address" required><br><br>

        <label>Age:</label><br>
        <input type="number" name="age" required><br><br>

        <label>Telephone:</label><br>
        <input type="text" name="telephone" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <input type="submit" value="Add Customer">
        
        <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    </div>

    </form>

    
</body>
</html>
