package com.pahanaedu.dao;

import com.pahanaedu.model.Staff;
import com.pahanaedu.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    public static int addStaff(Staff staff) {
        int status = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO Staff(name, email, phone, role, password) VALUES (?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staff.getName());
            ps.setString(2, staff.getEmail());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getRole());
            ps.setString(5, staff.getPassword());
            status = ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }

    public static List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM Staff";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Staff s = new Staff();
                s.setStaffId(rs.getInt("staff_id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setRole(rs.getString("role"));
                s.setPassword(rs.getString("password"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public static int deleteStaff(int staffId) {
        int status = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "DELETE FROM Staff WHERE staff_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, staffId);
            status = ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }
}
