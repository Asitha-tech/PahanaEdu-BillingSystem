<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.pahanaedu.model.Order, com.pahanaedu.dao.OrderDAO, com.pahanaedu.dao.CustomerDAO, com.pahanaedu.model.Customer" %>
<%
    List<Order> orderList = OrderDAO.getAllOrders();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
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
        h2 {
            margin-bottom: 15px;
        }
        .buttons {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Order History</h2>

    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Total (Rs.)</th>
            <th>Order Date</th>
            <th>Action</th>
        </tr>
        <% 
            if (orderList != null && !orderList.isEmpty()) {
                for (Order order : orderList) { 
                    Customer customer = CustomerDAO.getCustomerByID(order.getCustomerID());
        %>
            <tr>
                <td><%= order.getOrderID() %></td>
                <td><%= (customer != null) ? customer.getName() : "Unknown" %></td>
                <td><%= String.format("%.2f", order.getTotal()) %></td>
                <td><%= order.getOrderDate() %></td>
                <td>
                    <a href="order-details.jsp?orderID=<%= order.getOrderID() %>">View Details</a>
                </td>
            </tr>
        <% 
                }
            } else { 
        %>
            <tr>
                <td colspan="5">No orders found.</td>
            </tr>
        <% } %>
    </table>

    <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    </div>
</body>
</html>
