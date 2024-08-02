<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert New Teacher</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"], 
        .form-group select {
            width: 100%;
            padding: 8px;
            font-size: 1em;
            box-sizing: border-box;
        }
        .form-group button {
            padding: 10px 20px;
            font-size: 1em;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #286090;
        }
          .navigation {
            position: fixed;
            bottom: 10px;
            right: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Insert New Teacher</h2>
        <form action="InsertTeacherServlet" method="post">
            <div class="form-group">
                <label for="name">Teacher Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="designation">Designation:</label>
                <select id="designation" name="designation" required>
                    <option value="">Select Designation</option>
                    <option value="Professor">Professor</option>
                    <option value="Associate Professor">Associate Professor</option>
                    <option value="Assistant Professor">Assistant Professor</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="form-group">
                <label for="sanctioned">Sanctioned Status:</label>
                <select id="sanctioned" name="sanctioned" required>
                    <option value="">Select Status</option>
                    <option value="Permanent">Permanent</option>
                    <option value="Regular">Regular</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="form-group">
                <label for="working">Still Working or Not:</label>
                <select id="working" name="working" required>
                    <option value="">Select Status</option>
                    <option value="YES">Yes</option>
                    <option value="NO">No</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="form-group">
                <button type="submit">Insert Teacher</button>
            </div>
        </form>
    </div>
 <div class="navigation">
    <a href="<%=request.getContextPath()%>/TeacherList.jsp">Back</a>  ||
    <a href="<%=request.getContextPath()%>/123.html">Home</a>
</div>
</body>
</html>
