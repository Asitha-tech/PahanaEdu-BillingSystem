<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Staff" %>
<%@ page import="com.pahanaedu.dao.StaffDAO" %>
<%
    List<Staff> staffList = StaffDAO.getAllStaff();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Staff</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Manage Staff</h2>

<form action="StaffServlet" method="post">
    <input type="hidden" name="action" value="add"/>
    Name: <input type="text" name="name" required/><br/>
    Email: <input type="email" name="email" required/><br/>
    Phone: <input type="text" name="phone"/><br/>
    Role: <input type="text" name="role"/><br/>
    Password: <input type="password" name="password" required/><br/>
    <button type="submit">Add Staff</button>
</form>

<h3>Staff List</h3>
<table border="1">
    <tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Action</th></tr>
    <%
        for (Staff s : staffList) {
    %>
        <tr>
            <td><%= s.getStaffId() %></td>
            <td><%= s.getName() %></td>
            <td><%= s.getEmail() %></td>
            <td><%= s.getPhone() %></td>
            <td><%= s.getRole() %></td>
            <td>
                <form action="StaffServlet" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="staffId" value="<%= s.getStaffId() %>"/>
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
    <%
        }
    %>
</table>

</body>
</html>
