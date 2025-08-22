package com.pahanaedu.servlet;

import com.pahanaedu.dao.OrderDAO;
import com.pahanaedu.dao.OrderItemDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Order;
import com.pahanaedu.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

//@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        try {
            // Get customer ID
            int customerID = Integer.parseInt(request.getParameter("customerID"));

            // Get all arrays from form
            String[] itemIDs = request.getParameterValues("itemID[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] discounts = request.getParameterValues("discount[]");
            String[] itemTotals = request.getParameterValues("itemTotal[]");

            double orderTotal = 0;
            List<OrderItem> orderItems = new ArrayList<>();

            // Loop through all items
            for (int i = 0; i < itemIDs.length; i++) {
                int itemID = Integer.parseInt(itemIDs[i]);
                int quantity = Integer.parseInt(quantities[i]);
                double discount = Double.parseDouble(discounts[i]);
                double total = Double.parseDouble(itemTotals[i]);

                orderTotal += total;

                // Create order item object
                OrderItem orderItem = new OrderItem();
                orderItem.setItemID(itemID);
                orderItem.setQuantity(quantity);
                orderItem.setDiscount(discount);
                orderItem.setTotal(total);
                orderItems.add(orderItem);

                // Deduct stock
                ItemDAO.reduceQuantity(itemID, quantity);
            }

            // Create Order object
            Order order = new Order();
            order.setCustomerID(customerID);
            order.setTotal(orderTotal);

            // Save order in DB and get generated order ID
            int orderID = OrderDAO.addOrder(order);

            // Save order items
            for (OrderItem oi : orderItems) {
                oi.setOrderID(orderID);
                OrderItemDAO.addOrderItem(oi);
            }

            // Redirect to bill page with order ID
            response.sendRedirect("bill.jsp?orderID=" + orderID);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("order-form.jsp?error=1");
        }
    }
}
