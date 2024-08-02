<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        table {
            border-collapse: collapse;
            width: 60%;
            margin: 50px auto;
            position: relative;
        }
        th, td {
            border: 1px solid #000;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .download-btn, .add-row-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 10px;
        }
        .add-row-btn {
            display: block;
            margin: 20px auto;
        }
        .icon-btn {
            border: none;
            background: none;
            cursor: pointer;
            padding: 0;
        }
        .icon-btn i {
            font-size: 16px;
        }
        .modal {
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
            max-width: 600px;
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
</head>
<body>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

    // Create and execute SQL query
    String sql = "SELECT * FROM project.`2023-24faculty`";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet rs = st.executeQuery();
   
    // Display faculty details in a table
    out.println("<table id='dataTable'>");
    out.println("<thead><tr><th>S.No</th><th>Name</th><th>Designation</th><th>Qualification</th><th>Area Of Specialization</th><th>Experience</th><th>Actions</th></tr></thead>");
    out.println("<tbody>");
    while (rs.next()) {
        int sno = rs.getInt("S.No");
        String name = rs.getString("Name");
        String designation = rs.getString("Designation");
        String qualification = rs.getString("Qualification");
        String specialization = rs.getString("Area of Specialization");
        int experience = rs.getInt("EXP");
        
        out.println("<tr>");
        out.println("<td>" + sno + "</td>");
        out.println("<td>" + name + "</td>");
        out.println("<td>" + designation + "</td>");
        out.println("<td>" + qualification + "</td>");
        out.println("<td>" + specialization + "</td>");
        out.println("<td>" + experience + "</td>");
        out.println("<td>");
        out.println("<button class='icon-btn edit-btn' data-sno='" + sno + "' data-name='" + name + "' data-designation='" + designation + "' data-qualification='" + qualification + "' data-specialization='" + specialization + "' data-experience='" + experience + "'><i class='fas fa-edit'></i></button>");
        out.println("<button class='icon-btn delete-btn' data-sno='" + sno + "'><i class='fas fa-trash'></i></button>");
        out.println("</td>");
        out.println("</tr>");
    }
    out.println("</tbody>");
    out.println("</table>");

    // Close resources
    rs.close();
    st.close();
    con.close();
} catch (SQLException e) {
    out.println("SQL Exception: " + e.getMessage());
    e.printStackTrace();
} catch (Exception e) {
    out.println("Exception: " + e);
    e.printStackTrace();
}
%>

<!-- Add Row Button -->
<button class='add-row-btn' onclick='showAddModal()'>Add Row</button>

<!-- Modal for Adding -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeAddModal()">&times;</span>
        <h2>Add New Record</h2>
        <form id="addForm" method="post" action="AdminfacultyAddRecord2023-24.jsp">
            <label for="addSno">S.No:</label>
            <input type="text" id="addSno" name="sno" required><br>
            <label for="addName">Name:</label>
            <input type="text" id="addName" name="name" required><br>
            <label for="addDesignation">Designation:</label>
            <input type="text" id="addDesignation" name="designation" required><br>
            <label for="addQualification">Qualification:</label>
            <input type="text" id="addQualification" name="qualification" required><br>
            <label for="addSpecialization">Area Of Specialization:</label>
            <input type="text" id="addSpecialization" name="specialization" required><br>
            <label for="addExperience">Experience:</label>
            <input type="text" id="addExperience" name="experience" required><br>
            <input type="submit" value="Add Record">
        </form>
    </div>
</div>

<!-- Modal for Editing -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditModal()">&times;</span>
        <h2>Edit Record</h2>
        <form id="editForm" method="post" action="AdminfacultyEditRecord2023-24.jsp">
            <input type="hidden" id="editId" name="sno"> <!-- Hidden field for S.No -->
            <label for="editSno">S.No:</label>
            <input type="text" id="editSno" name="sno" required><br>
            <label for="editName">Name:</label>
            <input type="text" id="editName" name="name" required><br>
            <label for="editDesignation">Designation:</label>
            <input type="text" id="editDesignation" name="designation" required><br>
            <label for="editQualification">Qualification:</label>
            <input type="text" id="editQualification" name="qualification" required><br>
            <label for="editSpecialization">Area Of Specialization:</label>
            <input type="text" id="editSpecialization" name="specialization" required><br>
            <label for="editExperience">Experience:</label>
            <input type="text" id="editExperience" name="experience" required><br>
            <input type="submit" value="Update">
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.edit-btn').forEach(function(button) {
            button.addEventListener('click', function() {
                const sno = this.getAttribute('data-sno');
                const name = this.getAttribute('data-name');
                const designation = this.getAttribute('data-designation');
                const qualification = this.getAttribute('data-qualification');
                const specialization = this.getAttribute('data-specialization');
                const experience = this.getAttribute('data-experience');
                
                console.log("Editing record with S.No:", sno);
                document.getElementById('editId').value = sno; // Set hidden field value
                document.getElementById('editSno').value = sno; // Set read-only field value
                document.getElementById('editName').value = name;
                document.getElementById('editDesignation').value = designation;
                document.getElementById('editQualification').value = qualification;
                document.getElementById('editSpecialization').value = specialization;
                document.getElementById('editExperience').value = experience;
                document.getElementById('editModal').style.display = "block";
            });
        });

        document.querySelectorAll('.delete-btn').forEach(function(button) {
            button.addEventListener('click', function() {
                const sno = this.getAttribute('data-sno');
                deleteRow(sno);
            });
        });
    });

    function closeEditModal() {
        document.getElementById('editModal').style.display = "none";
    }

    function showAddModal() {
        document.getElementById('addModal').style.display = "block";
    }

    function closeAddModal() {
        document.getElementById('addModal').style.display = "none";
    }

    // JavaScript function to delete a record
    function deleteRow(sno) {
        if (confirm("Are you sure you want to delete this record?")) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "AdminfacultyDeleteRecord2023-24.jsp?sno=" + sno, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = xhr.responseText;
                    alert(response); // Alert the response from server

                    // If deletion was successful, reload the page
                    if (response.trim() === "Record deleted successfully.") {
                        location.reload(); // Reload the page to reflect changes
                    }
                }
            };
            xhr.send();
        }
    }
</script>

</body>
</html>
