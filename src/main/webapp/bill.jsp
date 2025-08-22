<%@ page import="com.pahanaedu.dao.OrderDAO, com.pahanaedu.dao.OrderItemDAO, com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.model.Order, com.pahanaedu.model.OrderItem, com.pahanaedu.model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Bill</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 80%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .total-row { font-weight: bold; }
    </style>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%
    // 1. Get orderID from request
    String orderIdStr = request.getParameter("orderID");
    if (orderIdStr == null) {
        out.println("<h3>No order specified.</h3>");
        return;
    }

    int orderID = Integer.parseInt(orderIdStr);

    // 2. Fetch order details
    Order order = OrderDAO.getOrderByID(orderID);
    if (order == null) {
        out.println("<h3>Order not found.</h3>");
        return;
    }

    // 3. Fetch customer details
    Customer customer = CustomerDAO.getCustomerByID(order.getCustomerID());

    // 4. Fetch order items
    List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderID(orderID);
%>

<h2>Order Bill</h2>

<h3>Order ID: <%= order.getOrderID() %></h3>
<h4>Order Date: <%= order.getOrderDate() %></h4>

<h3>Customer Details</h3>
<table>
    <tr><th>Name</th><td><%= customer != null ? customer.getName() : "N/A" %></td></tr>
    <tr><th>Address</th><td><%= customer != null ? customer.getAddress() : "N/A" %></td></tr>
    <tr><th>Age</th><td><%= customer != null ? customer.getAge() : "N/A" %></td></tr>
    <tr><th>Telephone</th><td><%= customer != null ? customer.getTelephone() : "N/A" %></td></tr>
    <tr><th>Email</th><td><%= customer != null ? customer.getEmail() : "N/A" %></td></tr>
</table>

<h3>Order Items</h3>
<table>
    <tr>
        <th>Item ID</th>
        <th>Quantity</th>
        <th>Discount (%)</th>
        <th>Total (Rs.)</th>
    </tr>
<%
    for (OrderItem item : orderItems) {
%>
    <tr>
        <td><%= item.getItemID() %></td>
        <td><%= item.getQuantity() %></td>
        <td><%= item.getDiscount() %></td>
        <td><%= String.format("%.2f", item.getTotal()) %></td>
    </tr>
<%
    }
%>
    <tr class="total-row">
        <td colspan="3" style="text-align: right;">Order Total:</td>
        <td><%= String.format("%.2f", order.getTotal()) %></td>
    </tr>
</table>

<button onclick="window.print()">Print / Save as PDF</button>

    
            <a href="order-form.jsp">New Order</a>


    <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    </div>



</body>
</html>
