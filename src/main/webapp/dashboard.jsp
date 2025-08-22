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
    <title>Pahana Edu - Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f6f9;
            color: #333;
        }

        header {
            background: #2c3e50;
            color: #fff;
            padding: 15px 30px;
            text-align: center;
        }

        header h2 {
            margin: 0;
            font-size: 26px;
        }

        .welcome {
            margin-top: 10px;
            font-size: 16px;
            color: #ecf0f1;
        }

        main {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 3px 10px rgba(0,0,0,0.1);
        }

        h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 22px;
        }

        ul.menu {
            list-style: none;
            padding: 0;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        ul.menu li {
            background: #3498db;
            border-radius: 8px;
            transition: 0.3s;
            text-align: center;
        }

        ul.menu li:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        ul.menu li a {
            display: block;
            padding: 15px;
            color: #fff;
            font-weight: bold;
            text-decoration: none;
            font-size: 16px;
        }

        footer {
            margin-top: 40px;
            text-align: center;
            font-size: 14px;
            color: #888;
        }
    </style>
</head>
<body>
    <header>
        <h2>Pahana Edu - Dashboard</h2>
        <div class="welcome">
            Welcome, <%= user.getUsername() %> (Role: <%= user.getRole() %>)
        </div>
    </header>

    <main>
        <h3>Main Menu</h3>
        <ul class="menu">
            <li><a href="order-form.jsp">Order Processing</a></li>
            <li><a href="view-customers.jsp">Edit/View Customer</a></li>
            <li><a href="add-customer.jsp">Add Customer</a></li>
            <li><a href="add-item.jsp">Add Item</a></li>
            <li><a href="view-items.jsp">Edit/View Item</a></li>
            <li><a href="order-history.jsp">Order History</a></li>
            <li><a href="help.jsp">Help</a></li>
            <% if ("admin".equals(user.getRole())) { %>
                <li><a href="manageStaff.jsp">Manage Staff</a></li>
            <% } %>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </main>

    <footer>
        © 2025 Pahana Edu. All Rights Reserved.
    </footer>
</body>
</html>
