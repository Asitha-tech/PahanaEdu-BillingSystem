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
    <title>Help - Pahana Edu</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Help & User Guide</h2>
    <p>Welcome, <%= user.getUsername() %>! Here you can find instructions on how to use the system.</p>

    <h3>📌 Navigation Guide</h3>
    <ul>
        <li><b>Order Processing</b> – Create and manage new customer orders.</li>
        <li><b>Edit/View Customer</b> – Update customer details or view customer list.</li>
        <li><b>Add Customer</b> – Register a new customer.</li>
        <li><b>Add Item</b> – Add new products/items to the system.</li>
        <li><b>Edit/View Item</b> – Modify or view existing items.</li>
        <li><b>Order History</b> (Admin only) – Review past orders and invoices.</li>
        <li><b>Logout</b> – Safely exit your session.</li>
    </ul>

    <h3>⚙️ Common Issues</h3>
    <ul>
        <li>If you cannot log in, check your username and password or contact admin.</li>
        <li>If a page redirects to login, your session may have expired—log in again.</li>
        <li>Use the <b>Back to Dashboard</b> link to quickly return to the main menu.</li>
    </ul>

    <h3>📞 Support</h3>
    <p>
        For further assistance, contact the system administrator:<br>
        Email: <a href="mailto:support@pahanaedu.com">support@pahanaedu.com</a><br>
        Phone: +94 71 234 5678
    </p>

    <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    </div>
</div>
</body>
</html>
