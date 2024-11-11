<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Customer" %>
<html>
<head>
    <title>Customer List</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customer.css">
    <script src="${pageContext.request.contextPath}/js/customer.js" defer></script>
        </head>
<body>
    <h1>Customer List</h1>
    <div class="add-button-container">
        <button class="add-button" onclick="openAddModal()">Add Customer</button>
    </div>
    <div class="table-container">
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Address</th>
                <th>Date of Birth</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            //left-variable is of type list,right-getting objects and casting to list
                List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
                if (customerList != null && !customerList.isEmpty()) {
                    for (Customer customer : customerList) {
            %>
                        <tr>
                            <td><%= customer.getId() %></td>
                            <td><%= customer.getName() %></td>
                            <td><%= customer.getEmail() %></td>
                            <td><%= customer.getPhoneNumber() %></td>
                            <td><%= customer.getAddress() %></td>
                            <td><%= customer.getDateOfBirth() %></td>
                            <td>
                                <button onclick="openEditModal('<%= customer.getId() %>', '<%= customer.getName() %>', '<%= customer.getEmail() %>', '<%= customer.getPhoneNumber() %>', '<%= customer.getAddress() %>', '<%= customer.getDateOfBirth() %>')">
                                    Edit
                                </button>
                                <form action="deleteCustomerServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this customer?');" style="display:inline;">
                                    <button type="submit" name="id" value="<%= customer.getId() %>">Delete</button>
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="7">No customers found.</td>
                </tr>
            <%
                }
            %>
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
  <!-- Add Customer Modal -->
<div id="addCustomerModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Add New Customer</h2>
        <form action="addCustomerServlet" method="post">
            <label for="addName">Name:</label>
            <input type="text" id="addName" name="name" placeholder="e.g., John Doe" required>

            <label for="addEmail">Email:</label>
            <input type="email" id="addEmail" name="email" placeholder="e.g., john.doe@example.com" required>

            <label for="addPhoneNumber">Phone Number:</label>
            <input type="text" id="addPhoneNumber" name="phoneNumber" placeholder="e.g., 1234567890" required>

            <label for="addAddress">Address:</label>
            <input type="text" id="addAddress" name="address" placeholder="e.g., 1234 Elm Street" required>

            <label for="addDateOfBirth">Date of Birth:</label>
            <input type="date" id="addDateOfBirth" name="dateOfBirth" placeholder="e.g., 1990-01-01" required>

            <input type="submit" value="Add Customer">
        </form>
    </div>
</div>

<!-- Edit Customer Modal -->
<div id="editCustomerModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Edit Customer</h2>
        <form action="editCustomerServlet" method="post">
            <input type="hidden" id="editId" name="id">

            <label for="editName">Name:</label>
            <input type="text" id="editName" name="name" required>

            <label for="editEmail">Email:</label>
            <input type="email" id="editEmail" name="email" required>

            <label for="editPhoneNumber">Phone Number:</label>
            <input type="text" id="editPhoneNumber" name="phoneNumber" required>

            <label for="editAddress">Address:</label>
            <input type="text" id="editAddress" name="address" required>

            <label for="editDateOfBirth">Date of Birth:</label>
            <input type="date" id="editDateOfBirth" name="dateOfBirth" required>

            <input type="submit" value="Update Customer">
        </form>
    </div>
</div>
 <!-- Toast Container -->
    <div id="toastContainer" class="toast-container"></div>

    <!-- Back Button -->
    <div class="back-button-container">
        <a href="index.jsp" class="back-button">Back to Home</a>
    </div>
</body>
</html>
