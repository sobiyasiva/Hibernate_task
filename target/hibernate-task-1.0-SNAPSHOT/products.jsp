<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css">
    <script src="${pageContext.request.contextPath}/js/product.js" defer></script>
   
</head>
<body>
    <h1>Product List</h1>
    <div class="add-button-container">
        <button class="add-button" onclick="openAddModal()">Add Product</button>
    </div>
    <div class="table-container">
        <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            List<Product> productList = (List<Product>) request.getAttribute("productList");
            if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) {
            %>  
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getProductName() %></td>
                <td><%= product.getPrice() %></td>
                <td>
                    <button onclick="openEditModal('<%= product.getId() %>', '<%= product.getProductName() %>', '<%= product.getPrice() %>')">
                        Edit
                    </button>
                    <form action="deleteProductServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');" style="display:inline;">
                        <button type="submit" name="id" value="<%= product.getId() %>">Delete</button>
                    </form>
                </td>
            </tr>
            <% 
                }
            } else { 
            %>
            <tr>
                <td colspan="4" style="text-align: center;">No products found.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
    </div>

    <% 
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
%>
    <script>
        alert("<%= successMessage %>");
    </script>
<%
    session.removeAttribute("successMessage");
    }
%>
    <div class="overlay" onclick="closeModal()"></div>
    <!-- Add Product Modal -->
    <div id="addProductModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Add Product</h3>
            <form action="addProductServlet" method="post">
                <label for="addName">Product Name:</label>
                <input type="text" id="addName" name="productName" required><br>
                <label for="addPrice">Price:</label>
                <input type="text" id="addPrice" name="price" required><br>
                <button type="submit">Add Product</button>
            </form>
        </div>
    </div>

    <!-- Edit Product Modal -->
    <div id="editProductModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Edit Product</h3>
            <form action="editProductServlet" method="post">
                <input type="hidden" id="editId" name="id">
                <label for="editName">Product Name:</label>
                <input type="text" id="editName" name="productName" required><br>
                <label for="editPrice">Price:</label>
                <input type="text" id="editPrice" name="price" required><br>
                <button type="submit">Save Changes</button>
            </form>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer"></div>

    <!-- Back Button -->
    <div class="back-button-container">
        <a href="index.jsp" class="back-button">Back to Home</a>
    </div>
</body>
</html>
