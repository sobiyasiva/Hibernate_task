<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <style>
        body {
            background-color: #f8fafc;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px;
            color: #333;
        }

        h1 {
            font-size: 35px;
            color: #444;
            margin-bottom: 30px;
            text-align: center;
        }

        .button-container {
            display: flex;
            gap: 20px;
        }

        .button {
            background-color: #1d72b8;
            color: #fff;
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-size: 20px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            /* transition: background-color 0.3s; */
        }

        .button:hover {
            background-color: #155a8a;
        }
    </style>
</head>
<body>
    <h1>Welcome to the Product and Customer Management System</h1>
    <div class="button-container">
        <a href="customerListServlet" class="button">View Customers</a>
        <a href="product" class="button">View Products</a>
    </div>
</body>
</html>
