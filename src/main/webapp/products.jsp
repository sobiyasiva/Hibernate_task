<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <style>
       body {
            background-color: #f8fafc;
            /* color: #333; */
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px;
            font-family: Arial, sans-serif;
        }

        h1 {
            font-size: 35px;
            color: #444;
            margin-bottom: 25px;
            text-align: center;
        }

        .add-button-container {
            margin-bottom: 20px;
        }

        .add-button {
            background-color: #1d72b8;
            color: #fff;
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 20px;
            transition: background-color 0.3s;
        }

        .add-button:hover {
            background-color: #155a8a;
        }

        table {
            width: 100%;
            max-width: 1000px;
            border-collapse: collapse;
            margin-bottom: 25px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #1d72b8;
            color: white;
            font-weight: normal;
        }

        td {
            background-color: #ffffff;
            color: #555;
        }

        tr:nth-child(even) td {
            background-color: #f1f5f9;
        }

        tr:hover td {
            background-color: #e3eaf2;
        }

        button {
            margin-bottom: 8px;
            padding: 8px 16px;
            margin-right: 5px;
            font-size: 15px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button[type="submit"] {
            background-color: #e74c3c;
            color: #fff;
        }

        button[type="submit"]:hover {
            background-color: #c0392b;
        }

        button[onclick^="openEditModal"] {
            background-color: #3498db;
            color: #fff;
        }

        button[onclick^="openEditModal"]:hover {
            background-color: #2980b9;
        }

        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 90%;
            max-width: 600px;
            background-color: rgba(0, 0, 0, 0.4);
            justify-content: center;
            align-items: center;
            z-index: 10;
        }

        .modal-content {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
            position: relative;
            text-align: center;
        }

        .close {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 25px;
            color: #aaa;
            cursor: pointer;
            transition: color 0.3s;
        }

        .close:hover {
            color: #000;
        }

        .modal-content label {
            display: block;
            margin: 15px 0 5px;
            font-weight: bold;
            color: #333;
        }

        .modal-content input[type="text"],
        .modal-content input[type="email"],
        .modal-content input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 20px;
        }

        .modal-content input[type="submit"] {
            background-color: #1d72b8;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 20px;
            transition: background-color 0.3s;
        }

        .modal-content input[type="submit"]:hover {
            background-color: #155a8a;
        }
    </style>
    <script>
        function openAddModal(){
            document.getElementById("addProductModal").style.display="block";
        }
        function closeModal() {
            document.getElementById("addProductModal").style.display = "none";
            document.getElementById("editProductModal").style.display = "none";
        }

        function openEditModal(productId, name, price) {
            const isConfirmed = confirm('Are you sure you want to edit this product?');
            if (isConfirmed) {
            document.getElementById("editId").value = productId;
            document.getElementById("editName").value = name;
            document.getElementById("editPrice").value = price;
            document.getElementById("editProductModal").style.display = "block";
            }
        } 
        function openDeleteModal(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                document.getElementById('deleteProductId').value = productId;
                document.getElementById('deleteForm').submit();
            }
        }
    </script>
</head>
<body>
    <h2>Product List</h2>
    <div class="add-button-container">
        <button class="add-button" onclick="openAddModal()">Add Product</button>
    </div>
        <table>
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
                List<Product> productList=(List<Product>) request.getAttribute("productList");
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
                    <td colspan="7">No products found.</td>
                </tr>
            <%
                }
            %>                              
            </tbody>
        </table>
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

    <!-- Add Product Modal -->
     <div id="addProductModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Add New Product</h2>
            <form action="addProductServlet" method="post">
                <label for="addName">Name:</label>
                <input type="text" id="addName" name="name" required>
                <label for="addPrice">Price:</label>
                <input type="text" id="addPrice" name="price" required>
                
                <input type="submit" value="Add Product">

            </form>
        </div>
     </div>



      <!-- Edit Product Modal -->
    <div id="editProductModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Edit Product</h2>
            <form action="editProductServlet" method="post">
                <input type="hidden" id="editId" name="id">

                <label for="editName">Name:</label>
                <input type="text" id="editName" name="name" required>

                <label for="editPrice">Price:</label>
                <input type="text" id="editPrice" name="price" required>

                <input type="submit" value="Update Product">
                            </form>
        </div>
    </div>

</body>
</html>
