<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);
    Item item = new ItemDAO().getItemById(id);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Item</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Edit Item</h2>
    <form action="updateItem" method="post">
        <input type="hidden" name="id" value="<%= item.getItemID() %>" />

        Name: <input type="text" name="name" value="<%= item.getName() %>" required><br><br>
        Description: <input type="text" name="description" value="<%= item.getDescription() %>" required><br><br>
        Price: <input type="number" name="price" step="0.01" value="<%= item.getPrice() %>" required><br><br>
        Quantity: <input type="number" name="quantity" value="<%= item.getQuantity() %>" required><br><br>
        Item Type: <input type="text" name="itemType" value="<%= item.getItemType() %>" required><br><br>

        <input type="submit" value="Update Item">
        <br>
        <a href="view-items.jsp">Back to Items</a>
    </form>
    
    
</body>
</html>
