<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Item> items = ItemDAO.getAllItems();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Items</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Items List</h2>

    <table border="1" cellpadding="10">
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Item Type</th>
            <th>Actions</th>
        </tr>
        <% for (Item item : items) { %>
            <tr>
                <td><%= item.getName() %></td>
                <td><%= item.getDescription() %></td>
                <td><%= item.getPrice() %></td>
                <td><%= item.getQuantity() %></td>
                <td><%= item.getItemType() %></td>
                <td>
                    <a href="edit-item.jsp?id=<%= item.getItemID() %>">Edit</a> |
                    <a href="deleteItem?id=<%= item.getItemID() %>" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        <% } %>
    </table>

    <br>
    <a href="add-item.jsp">Add New Item</a> |
    <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    </div>

</body>
</html>
