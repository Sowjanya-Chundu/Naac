<%@ page import="java.sql., javax.servlet., javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Data Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 800px;
            margin: 50px auto;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .form-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .form-group label {
            margin-bottom: 5px;
            text-align: left;
            font-size: 16px;
        }
        .form-group select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 150px;
            font-size: 16px;
        }
        button {
            padding: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .update-button, .delete-button, .upload-button, .add-data-button {
            padding: 5px 10px;
            margin: 2px;
            font-size: 14px;
        }
        .update-button {
            background-color: #28a745;
        }
        .update-button:hover {
            background-color: #218838;
        }
        .delete-button {
            background-color: #dc3545;
        }
        .delete-button:hover {
            background-color: #c82333;
        }
        .upload-button {
            background-color: #ffc107;
        }
        .upload-button:hover {
            background-color: #e0a800;
        }
        .add-data-button {
            background-color: #17a2b8;
        }
        .add-data-button:hover {
            background-color: #138496;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        .home-button {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .home-button:hover {
            background-color: #0056b3;
        }
        #addModal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 8px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script>
        function filterData() {
            document.forms["filterForm"].submit();
        }

        function updateRow(id) {
            // Open a dialog or redirect to an update page
            alert("Update functionality for ID: " + id);
        }

        function deleteRow(id) {
            if (confirm("Are you sure you want to delete this row?")) {
                document.forms["deleteForm"].id.value = id;
                document.forms["deleteForm"].submit();
            }
        }

        function openAddModal() {
            document.getElementById("addModal").style.display = "block";
        }

        function closeAddModal() {
            document.getElementById("addModal").style.display = "none";
        }

        function handleFileUpload(event) {
            event.preventDefault();
            var formData = new FormData(event.target);
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "index.jsp?fileUpload=true", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("result").innerHTML = xhr.responseText;
                }
            };
            xhr.send(formData);
        }
    </script>
</head>
<body>
    <div class="container">
        <button class="home-button" onclick="window.location.href='home.jsp'">Home</button>
        <h1>Data Management</h1>
        <form name="filterForm" class="form-container" method="post" action="index.jsp">
            <div class="form-group">
                <label for="academicYear">Academic Year:</label>
                <select id="academicYear" name="academicYear">
                    <option value="2023" <%= "2023".equals(request.getParameter("academicYear")) ? "selected" : "" %>>2023</option>
                    <option value="2024" <%= "2024".equals(request.getParameter("academicYear")) ? "selected" : "" %>>2024</option>
                </select>
            </div>
            <div class="form-group">
                <label for="dept">Department:</label>
                <select id="dept" name="dept">
                    <option value="CSE" <%= "CSE".equals(request.getParameter("dept")) ? "selected" : "" %>>Computer Science</option>
                    <option value="ECE" <%= "ECE".equals(request.getParameter("dept")) ? "selected" : "" %>>Electronics and Communication</option>
                </select>
            </div>
            <button type="button" onclick="filterData()">Submit</button>
        </form>

        <!-- Displaying data -->
        <div id="result">
            <%
                String academicYear = request.getParameter("academicYear");
                String dept = request.getParameter("dept");
                if (academicYear != null && dept != null) {
                    try {
                        // Database connection details
                        String url = "jdbc:mysql://localhost:3306/yourdatabase";
                        String user = "root";
                        String password = "yourpassword";
                        Connection con = DriverManager.getConnection(url, user, password);
                        
                        String query = "SELECT * FROM students WHERE academic_year = ? AND department = ?";
                        PreparedStatement pst = con.prepareStatement(query);
                        pst.setString(1, academicYear);
                        pst.setString(2, dept);
                        ResultSet rs = pst.executeQuery();
                        
                        out.println("<table>");
                        out.println("<tr><th>ID</th><th>Name</th><th>Year</th><th>Department</th><th>Actions</th></tr>");
                        
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String year = rs.getString("academic_year");
                            String department = rs.getString("department");
                            
                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + name + "</td>");
                            out.println("<td>" + year + "</td>");
                            out.println("<td>" + department + "</td>");
                            out.println("<td><button class='update-button' onclick='updateRow(" + id + ")'>Update</button>");
                            out.println("<button class='delete-button' onclick='deleteRow(" + id + ")'>-</button></td>");
                            out.println("</tr>");
                        }
                        
                        out.println("</table>");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
            <form name="deleteForm" method="post" action="index.jsp">
                <input type="hidden" name="delete" value="">
            </form>
            <form onsubmit="handleFileUpload(event);" enctype="multipart/form-data">
                <input type="file" name="file" required>
                <button class="upload-button" type="submit">Upload File</button>
            </form>
        </div>

        <!-- Add Data Modal -->
        <div id="addModal">
            <div class="modal-content">
                <span class="close" onclick="closeAddModal()">&times;</span>
                <h2>Add Data</h2>
                <form method="post" action="index.jsp">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="addAcademicYear">Academic Year:</label>
                        <select id="addAcademicYear" name="academicYear">
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addDept">Department:</label>
                        <select id="addDept" name="dept">
                            <option value="CSE">Computer Science</option>
                            <option value="ECE">Electronics and Communication</option>
                        </select>
                    </div>
                    <button type="submit" class="add-data-button" name="addData">Add</button>
                </form>
            </div>
        </div>
        <button class="add-data-button" onclick="openAddModal()">Add Data</button>
    </div>
</body>
</html>