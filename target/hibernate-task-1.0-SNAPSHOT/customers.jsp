<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Customer" %>
<html>
<head>
    <title>Customer List</title>
    <style>
       /* Body styling */
body {
    background-color: #f8fafc;
    color: #333;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 30px;
}

/* Page Title */
h1 {
    font-size: 2.5em;
    color: #444;
    margin-bottom: 25px;
    text-align: center;
}

/* Add Button Positioning */
.add-button-container {
    position: absolute;
    top: 20px;
    right: 20px;
}

.add-button {
    background-color: #1d72b8;
    color: #fff;
    padding: 12px 24px;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s;
}

.add-button:hover {
    background-color: #155a8a;
}

/* Table Styling */
table {
    width: 100%;
    max-width: 1000px;
    border-collapse: collapse;
    margin-bottom: 25px;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

table, th, td {
    border: none;
}

th, td {
    padding: 15px;
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

/* Action Buttons */
button {
    padding: 8px 16px;
    margin-right: 5px;
    font-size: 0.9em;
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

/* Centered Modal Styling */
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

/* Close Button */
.close {
    position: absolute;
    top: 15px;
    right: 20px;
    font-size: 1.5em;
    color: #aaa;
    cursor: pointer;
    transition: color 0.3s;
}

.close:hover {
    color: #000;
}

/* Form Inputs in Modal */
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
    font-size: 1em;
}

.modal-content input[type="submit"] {
    background-color: #1d72b8;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s;
}

.modal-content input[type="submit"]:hover {
    background-color: #155a8a;
}


    </style>
    <script>
        
        function openAddModal() {
            document.getElementById("addCustomerModal").style.display = "block";
        }

        
        function closeModal() {
            document.getElementById("addCustomerModal").style.display = "none";
            document.getElementById("editCustomerModal").style.display = "none";
        }

        
        function openEditModal(customerId, name, email, phoneNumber, address, dateOfBirth) {
            document.getElementById("editId").value = customerId;
            document.getElementById("editName").value = name;
            document.getElementById("editEmail").value = email;
            document.getElementById("editPhoneNumber").value = phoneNumber;
            document.getElementById("editAddress").value = address;
            document.getElementById("editDateOfBirth").value = dateOfBirth;

            document.getElementById("editCustomerModal").style.display = "block";
        }    

        function openDeleteModal(customerId) {
            if (confirm('Are you sure you want to delete this customer?')) {
                document.getElementById('deleteCustomerId').value = customerId;
                document.getElementById('deleteForm').submit();
            }
        }

        
        window.onclick = function(event) {
            const addModal = document.getElementById("addCustomerModal");
            const editModal = document.getElementById("editCustomerModal");
            if (event.target === addModal || event.target === editModal) {
                closeModal();
            }
        }

        // Alert messages for success operations
        function showAlert(message) {
            alert(message);
        }

        // Show alert messages based on URL parameters
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has("success")) {
                const message = urlParams.get("success");
                showAlert(message);
            }
        });
    </script>
</head>
<body>
    <h1>Customer List</h1>
    <div class="add-button-container">
        <button class="add-button" onclick="openAddModal()">Add Customer</button>
    </div>
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

    <!-- Add Customer Modal -->
    <div id="addCustomerModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Add New Customer</h2>
            <form action="addCustomerServlet" method="post">
                <label for="addName">Name:</label>
                <input type="text" id="addName" name="name" required><br><br>
                
                <label for="addEmail">Email:</label>
                <input type="email" id="addEmail" name="email" required><br><br>
                
                <label for="addPhoneNumber">Phone Number:</label>
                <input type="text" id="addPhoneNumber" name="phoneNumber" required><br><br>
                
                <label for="addAddress">Address:</label>
                <input type="text" id="addAddress" name="address" required><br><br>
                
                <label for="addDateOfBirth">Date of Birth:</label>
                <input type="date" id="addDateOfBirth" name="dateOfBirth" required><br><br>
                
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
                <input type="text" id="editName" name="name" required><br><br>
                
                <label for="editEmail">Email:</label>
                <input type="email" id="editEmail" name="email" required><br><br>
                
                <label for="editPhoneNumber">Phone Number:</label>
                <input type="text" id="editPhoneNumber" name="phoneNumber" required><br><br>
                
                <label for="editAddress">Address:</label>
                <input type="text" id="editAddress" name="address" required><br><br>
                
                <label for="editDateOfBirth">Date of Birth:</label>
                <input type="date" id="editDateOfBirth" name="dateOfBirth" required><br><br>
                
                <input type="submit" value="Update Customer">
            </form>
        </div>
    </div>
</body>
</html>
