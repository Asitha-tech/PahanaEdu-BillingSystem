package com.pahanaedu.dao;

import com.pahanaedu.model.Order;
import com.pahanaedu.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public static int addOrder(Order order) {
        int orderID = -1;
        String sql = "INSERT INTO orders (customer_id, total, order_date) VALUES (?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, order.getCustomerID());
            stmt.setDouble(2, order.getTotal());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderID;
    }

    public static List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("order_id"));
                order.setCustomerID(rs.getInt("customer_id"));
                order.setTotal(rs.getDouble("total"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static Order getOrderByID(int orderID) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderID(rs.getInt("order_id"));
                order.setCustomerID(rs.getInt("customer_id"));
                order.setTotal(rs.getDouble("total"));
                order.setOrderDate(rs.getTimestamp("order_date"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }
}
