<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.pahanaedu.model.Customer, com.pahanaedu.model.Item, com.pahanaedu.dao.CustomerDAO, com.pahanaedu.dao.ItemDAO" %>
<%
    List<Customer> customerList = CustomerDAO.getAllCustomers();
    List<Item> itemList = ItemDAO.getAllItems();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Order</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        let itemData = {};

        // Preload item data for quick access
        <% for (Item item : itemList) { %>
            itemData[<%= item.getItemID() %>] = {
                price: <%= item.getPrice() %>,
                name: "<%= item.getName() %>"
            };
        <% } %>

        function updatePrice(index) {
            const itemSelect = document.getElementById("item_" + index);
            const quantityInput = document.getElementById("quantity_" + index);
            const discountInput = document.getElementById("discount_" + index);
            const priceField = document.getElementById("price_" + index);

            const itemId = itemSelect.value;
            const quantity = parseInt(quantityInput.value || 0);
            const discount = parseFloat(discountInput.value || 0);

            if (itemId && itemData[itemId]) {
                let basePrice = itemData[itemId].price;
                let total = basePrice * quantity;
                let discounted = total - (total * discount / 100);
                priceField.value = discounted.toFixed(2);
            }

            calculateTotal();
        }

        function calculateTotal() {
            let total = 0;
            const priceFields = document.querySelectorAll("input[name='itemTotal[]']");
            priceFields.forEach(p => {
                total += parseFloat(p.value || 0);
            });
            document.getElementById("total").innerText = total.toFixed(2);
        }

        function addItemRow() {
            const table = document.getElementById("itemsTable");
            const rowCount = table.rows.length;
            const index = rowCount - 1;

            const row = table.insertRow(index);

            row.innerHTML = `
                <td>
                    <select name="itemID[]" id="item_${index}" onchange="updatePrice(${index})" required>
                        <option value="">-- Select Item --</option>
                        <% for (Item item : itemList) { %>
                            <option value="<%= item.getItemID() %>"><%= item.getName() %></option>
                        <% } %>
                    </select>
                </td>
                <td><input type="number" name="quantity[]" id="quantity_${index}" min="1" value="1" oninput="updatePrice(${index})" required></td>
                <td><input type="number" name="discount[]" id="discount_${index}" min="0" max="100" value="0" oninput="updatePrice(${index})"></td>
                <td><input type="text" name="itemTotal[]" id="price_${index}" readonly></td>
            `;
        }

        window.onload = () => {
            addItemRow(); // start with one row
        }
    </script>
</head>
<body>
    <h2>Create New Order</h2>

    <form action="OrderServlet" method="post">
        <label for="customer">Select Customer:</label>
        <select name="customerID" required>
            <option value="">-- Select Customer --</option>
            <% for (Customer customer : customerList) { %>
                <option value="<%= customer.getCustomerID() %>"><%= customer.getName() %></option>
            <% } %>
        </select>
        <a href="add-customer.jsp" target="_blank">Add New Customer</a>
        <br><br>

        <table id="itemsTable" border="1">
            <tr>
                <th>Item</th>
                <th>Quantity</th>
                <th>Discount (%)</th>
                <th>Price (After Discount)</th>
            </tr>
            <!-- Item rows will be added dynamically -->
        </table>

        <button type="button" onclick="addItemRow()">+ Add Another Item</button>
        <br><br>

        <strong>Total: Rs. <span id="total">0.00</span></strong>
        <br><br>

        <button type="submit">Submit Order</button>
        
        <div class="buttons">
        <a href="dashboard.jsp">⬅ Back to Dashboard</a>
    	</div>

    </form>
    
</body>
</html>
