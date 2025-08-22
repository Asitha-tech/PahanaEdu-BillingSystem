<%@ page import="java.util.*, com.pahanaedu.dao.CustomerDAO, com.pahanaedu.model.Customer" %>
<%
    List<Customer> customers = CustomerDAO.getAllCustomers();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Customers</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Customer List</h2>

    <table border="1">
        <tr>
            <th>Name</th>
            <th>Address</th>
            <th>Age</th>
            <th>Telephone</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>

        <% for (Customer customer : customers) { %>
            <tr>
                <td><%= customer.getName() %></td>
                <td><%= customer.getAddress() %></td>
                <td><%= customer.getAge() %></td>
                <td><%= customer.getTelephone() %></td>
                <td><%= customer.getEmail() %></td>
                <td>
                    <a href="edit-customer.jsp?id=<%= customer.getCustomerID() %>">Edit</a> |
                    <a href="delete-customer?id=<%= customer.getCustomerID() %>" 
                       onclick="return confirm('Are you sure you want to delete this customer?');">
                       Delete
                    </a>
                </td>
            </tr>
        <% } %>
    </table>

    <br>
    <a href="add-customer.jsp">Add New Customer</a> |
    <div class="buttons">
        <a href="dashboard.jsp"> Back to Dashboard</a>
    </div>

</body>
</html>
