<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.pahanaedu.model.Order, com.pahanaedu.model.OrderItem, com.pahanaedu.model.Item, com.pahanaedu.model.Customer, com.pahanaedu.dao.OrderDAO, com.pahanaedu.dao.OrderItemDAO, com.pahanaedu.dao.ItemDAO, com.pahanaedu.dao.CustomerDAO" %>
<%
    String orderIDParam = request.getParameter("orderID");
    Order order = null;
    Customer customer = null;
    List<OrderItem> items = new ArrayList<>();

    if (orderIDParam != null) {
        int orderID = Integer.parseInt(orderIDParam);
        order = OrderDAO.getOrderByID(orderID);
        if (order != null) {
            customer = CustomerDAO.getCustomerByID(order.getCustomerID());
            items = OrderItemDAO.getOrderItemsByOrderID(orderID);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        h2, h3 {
            margin-bottom: 10px;
        }
        .buttons {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Order Details</h2>

    <% if (order != null) { %>
        <h3>Order ID: <%= order.getOrderID() %></h3>
        <p><strong>Customer:</strong> <%= (customer != null ? customer.getName() : "Unknown") %></p>
        <p><strong>Date:</strong> <%= order.getOrderDate() %></p>
        <p><strong>Total:</strong> Rs. <%= String.format("%.2f", order.getTotal()) %></p>

        <h3>Ordered Items</h3>
        <table>
            <tr>
                <th>Item Name</th>
                <th>Quantity</th>
                <th>Discount (%)</th>
                <th>Total (Rs.)</th>
            </tr>
            <% if (items != null && !items.isEmpty()) {
                   for (OrderItem oi : items) {
                       Item item = ItemDAO.getItemById(oi.getItemID());
            %>
                <tr>
                    <td><%= (item != null ? item.getName() : "Unknown") %></td>
                    <td><%= oi.getQuantity() %></td>
                    <td><%= oi.getDiscount() %></td>
                    <td><%= String.format("%.2f", oi.getTotal()) %></td>
                </tr>
            <%     }
               } else { %>
                <tr>
                    <td colspan="4">No items found for this order.</td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>⚠️ Order not found.</p>
    <% } %>

    <div class="buttons">
        <a href="order-history.jsp">⬅ Back to Order History</a>
    </div>
</body>
</html>
