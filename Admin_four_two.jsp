<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Average Number of Days for Declaration of Results</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        table {
            width: 70%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .icon-button {
            border: none;
            background: none;
            cursor: pointer;
            font-size: 24px;
            margin: 5px;
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
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
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
</head>
<body>
    <table>
        <tr>
            <th>Program Name</th>
            <th>Program Code</th>
            <th>Semester/Year</th>
            <th>Last Semester End Year</th>
            <th>Results of the Semester</th>
            <th>Number of Days</th>
            <th>Actions</th>
        </tr>
        <%
            String url = "jdbc:mysql://localhost:3306/project";
            String username = "root";
            String password = "sowjanyapassword";
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            List<Integer> daysList = new ArrayList<>();
            int totalDays = 0;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

              

                // Retrieve all records from the database
                String query = "SELECT programmename, programmecode, `Semester/Year`, lastsemesterendyear, resultsofthesemester FROM semesteryear WHERE programmename='Information Technology' AND `Semester/Year` ='IV-II'";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

                while (rs.next()) {
                    String program = rs.getString("programmename");
                    int code = rs.getInt("programmecode");
                    String semYear = rs.getString("Semester/Year");
                    LocalDate lastEndYear = LocalDate.parse(rs.getString("lastsemesterendyear"), formatter);
                    LocalDate resultsOfSemester = LocalDate.parse(rs.getString("resultsofthesemester"), formatter);

                    long daysDifference = ChronoUnit.DAYS.between(lastEndYear, resultsOfSemester);
                    daysList.add((int) daysDifference);

                    out.println("<tr>");
                    out.println("<td>" + program + "</td>");
                    out.println("<td>" + code + "</td>");
                    out.println("<td>" + semYear + "</td>");
                    out.println("<td>" + lastEndYear.format(formatter) + "</td>");
                    out.println("<td>" + resultsOfSemester.format(formatter) + "</td>");
                    out.println("<td>" + daysDifference + "</td>");
                    out.println("<td>");
                    out.println("<button class='icon-button edit-btn' data-code='" + code + "' data-program='" + program + "' data-semyear='" + semYear + "' data-lastendyear='" + lastEndYear.format(formatter) + "' data-resultsofsemester='" + resultsOfSemester.format(formatter) + "'><i class='fas fa-edit'></i></button>");
                    out.println("<button class='icon-button delete-btn' data-code='" + code + "' onclick='deleteRow(" + code + ")'><i class='fas fa-trash'></i></button>");
                    out.println("</td>");
                    out.println("</tr>");
                }

                int averageDays = daysList.size() > 0 ? (int) daysList.stream().mapToInt(Integer::intValue).average().getAsDouble() : 0;

                out.println("<tr>");
                out.println("<td colspan='5'><strong>Average Number of Days:</strong></td>");
                out.println("<td>" + averageDays + "</td>");
                out.println("<td></td>");
                out.println("</tr>");

            } catch (Exception e) {
                out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>

    <button class='add-row-btn' onclick='showAddModal()'>Add Row</button>

    <!-- Modal for Adding -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeAddModal()">&times;</span>
            <h2>Add New Record</h2>
            <form id="addForm" method="post" action="AdminsemAddIV-II.jsp">
                <label for="addProgram">Program Name:</label>
                <input type="text" id="addProgram" name="program" required><br>
                <label for="addCode">Program Code:</label>
                <input type="text" id="addCode" name="code" required><br>
                <label for="addSemYear">Semester/Year:</label>
                <input type="text" id="addSemYear" name="semyear" required><br>
                <label for="addLastEndYear">Last Semester End Year:</label>
                <input type="text" id="addLastEndYear" name="lastendyear" required><br>
                <label for="addResultsOfSemester">Results of the Semester:</label>
                <input type="text" id="addResultsOfSemester" name="resultsofsemester" required><br>
                <input type="submit" value="Add Record">
            </form>
        </div>
    </div>

    <!-- Modal for Editing -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Edit Record</h2>
            <form id="editForm" method="post" action="AdminsemEditIV-II.jsp">
                <input type="hidden" id="editId" name="code"> <!-- Hidden field for Program Code -->
                <label for="editProgram">Program Name:</label>
                <input type="text" id="editProgram" name="program" required><br>
                <label for="editCode">Program Code:</label>
                <input type="text" id="editCode" name="code" required><br>
                <label for="editSemYear">Semester/Year:</label>
                <input type="text" id="editSemYear" name="semyear" required><br>
                <label for="editLastEndYear">Last Semester End Year:</label>
                <input type="text" id="editLastEndYear" name="lastendyear" required><br>
                <label for="editResultsOfSemester">Results of the Semester:</label>
                <input type="text" id="editResultsOfSemester" name="resultsofsemester" required><br>
                <input type="submit" value="Update">
            </form>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.edit-btn').forEach(function(button) {
            button.addEventListener('click', function() {
                const code = this.getAttribute('data-code');
                const program = this.getAttribute('data-program');
                const semYear = this.getAttribute('data-semyear');
                const lastEndYear = this.getAttribute('data-lastendyear');
                const resultsOfSemester = this.getAttribute('data-resultsofsemester');
                
                document.getElementById('editId').value = code; // Hidden field value
                document.getElementById('editProgram').value = program;
                document.getElementById('editCode').value = code;
                document.getElementById('editSemYear').value = semYear;
                document.getElementById('editLastEndYear').value = lastEndYear;
                document.getElementById('editResultsOfSemester').value = resultsOfSemester;
                document.getElementById('editModal').style.display = "block";
            });
        });

        document.querySelectorAll('.delete-btn').forEach(function(button) {
            button.addEventListener('click', function() {
                const code = this.getAttribute('data-code');
                deleteRow(code);
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

    function deleteRow(code) {
        if (confirm("Are you sure you want to delete this record?")) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "AdminsemDeleteIV-II.jsp?code=" + code, true);
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
