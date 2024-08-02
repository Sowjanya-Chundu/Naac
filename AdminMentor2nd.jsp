<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
</head>
<body>

<% 
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

    // Create and execute SQL query
    String sql = "SELECT * FROM project.councelling4thbtech";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet result = st.executeQuery();
   
    // Display student details in a table
    out.println("<table id='dataTable'>");
    out.println("<thead><tr><th>S.No</th><th>4th Btech</th><th>Name of the Counseller</th><th>Mobile No</th><th>Actions</th></tr></thead>");
    out.println("<tbody>");
    while (result.next()) {
        try {
            int sno = result.getInt("S.No");
            String regdno = result.getString("IV B.TECH");
            String studentname = result.getString("Name of the Counselor");
            String mobileno = result.getString("CounselorMobileNumber");
            out.println("<tr data-id='" + sno + "'>");
            out.println("<td>" + sno + "</td>");
            out.println("<td>" + regdno + "</td>");
            out.println("<td>" + studentname + "</td>");
            out.println("<td>" + mobileno + "</td>");
            out.println("<td>");
            out.println("<button class='icon-btn' onclick='showEditModal(" + sno + ", \"" + regdno + "\", \"" + studentname + "\", \"" + mobileno + "\")'><i class='fas fa-edit'></i></button>");
            out.println("<button class='icon-btn' onclick='deleteRow(" + sno + ")'><i class='fas fa-trash'></i></button>");
            out.println("</td>");
            out.println("</tr>");
        } catch (SQLException e) {
            System.out.println("Error processing row: " + e.getMessage());
        }
    }
    out.println("</tbody>");
    out.println("</table>");

    // Download button
    out.println("<button class=\"download-btn\" onclick=\"downloadData();\">Download Data</button>");

    // Close resources
    result.close();
    st.close();
    con.close();
} catch (SQLException e) {
    out.println("SQL Exception: " + e.getMessage());
    e.printStackTrace();
} catch (Exception e) {
    out.println("Exception: " + e);
}
%>

<!-- Add Row Button -->
<button class='add-row-btn' onclick='showAddModal()'>Add Row</button>

<!-- Modal for Adding -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeAddModal()">&times;</span>
        <h2>Add New Record</h2>
        <form id="addForm" method="post" action="AdminStudTeacAddRecord.jsp">
            <label for="addSno">S.No:</label>
            <input type="text" id="addSno" name="sno" required><br>
            <label for="addRegdno">4th Btech:</label>
            <input type="text" id="addRegdno" name="regdno" required><br>
            <label for="addName">Name of the Counseller:</label>
            <input type="text" id="addName" name="name" required><br>
            <label for="addMobile">Mobile No:</label>
            <input type="text" id="addMobile" name="mobile" required><br>
            <input type="submit" value="Add Record">
        </form>
    </div>
</div>

<!-- Modal for Editing -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditModal()">&times;</span>
        <h2>Edit Record</h2>
        <form id="editForm" method="post" action="AdminStudTeacEditRecord.jsp">
            <input type="hidden" id="editId" name="sno">
            <label for="editRegdno">4th Btech:</label>
            <input type="text" id="editRegdno" name="regdno" required><br>
            <label for="editName">Name of the Counseller:</label>
            <input type="text" id="editName" name="name" required><br>
            <label for="editMobile">Mobile No:</label>
            <input type="text" id="editMobile" name="mobile" required><br>
            <input type="submit" value="Update">
        </form>
    </div>
</div>

<script>
    function downloadData() {
        var element = document.getElementById('dataTable');
        var opt = {
            margin:       1,
            filename:     '4th_btech_councelling_list.pdf',
            image:        { type: 'jpeg', quality: 0.98 },
            html2canvas:  { scale: 2 },
            jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
        };
        html2pdf().set(opt).from(element).save();
    }

    function showEditModal(sno, regdno, name, mobile) {
        document.getElementById('editId').value = sno;
        document.getElementById('editRegdno').value = regdno;
        document.getElementById('editName').value = name;
        document.getElementById('editMobile').value = mobile;
        document.getElementById('editModal').style.display = "block";
    }

    function closeEditModal() {
        document.getElementById('editModal').style.display = "none";
    }

    function showAddModal() {
        document.getElementById('addModal').style.display = "block";
    }

    function closeAddModal() {
        document.getElementById('addModal').style.display = "none";
    }

    function deleteRow(sno) {
        if (confirm("Are you sure you want to delete this record?")) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "AdminStudTeacDeleteRecord.jsp?sno=" + sno, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = xhr.responseText;
                    alert(response);
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
