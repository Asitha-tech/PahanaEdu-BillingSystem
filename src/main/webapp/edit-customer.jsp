<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.model.Customer" %>

<%
    int customerId = Integer.parseInt(request.getParameter("id"));
    CustomerDAO dao = new CustomerDAO();
    Customer customer = dao.getCustomerById(customerId);
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Edit Customer</h2>
    <form action="update-customer" method="post">
        <input type="hidden" name="customerID" value="<%= customer.getCustomerID() %>">

        Name: <input type="text" name="name" value="<%= customer.getName() %>" required><br><br>
        Address: <input type="text" name="address" value="<%= customer.getAddress() %>" required><br><br>
        Age: <input type="number" name="age" value="<%= customer.getAge() %>" required><br><br>
        Telephone: <input type="text" name="telephone" value="<%= customer.getTelephone() %>" required><br><br>
        Email: <input type="email" name="email" value="<%= customer.getEmail() %>" required><br><br>

        <input type="submit" value="Update Customer">
        
        <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    	</div>

    </form>

    <br>
    
</body>
</html>
