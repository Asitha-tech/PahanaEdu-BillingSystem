package com.pahanaedu.servlet;

import com.pahanaedu.dao.StaffDAO;
import com.pahanaedu.model.Staff;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class StaffServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Staff s = new Staff();
            s.setName(request.getParameter("name"));
            s.setEmail(request.getParameter("email"));
            s.setPhone(request.getParameter("phone"));
            s.setRole(request.getParameter("role"));
            s.setPassword(request.getParameter("password"));

            StaffDAO.addStaff(s);
        } else if ("delete".equals(action)) {
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            StaffDAO.deleteStaff(staffId);
        }

        response.sendRedirect("manageStaff.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<Staff> staffList = StaffDAO.getAllStaff();
        request.setAttribute("staffList", staffList);
        RequestDispatcher rd = request.getRequestDispatcher("manageStaff.jsp");
        rd.forward(request, response);
    }
}
