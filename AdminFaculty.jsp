<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <style>
        /* Your existing styles here */
        .container {
            margin: 0 auto;
            width: 50%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            position: relative;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group select, .form-group input[type="file"], .form-group input[type="text"] {
            width: calc(100% - 130px);
        }
        #uploadResult {
            margin-top: 20px;
            padding: 10px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .actions img {
            width: 20px;
            cursor: pointer;
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
        .navigation {
            position: fixed;
            bottom: 10px;
            right: 10px;
        }
        
        /* Styles for icons */
        .top-left-icons {
            position: fixed;
            top: 10px;
            left: 10px;
            z-index: 1000; /* Ensure icons appear above other content */
        }
        .top-left-icons i {
            font-size: 24px;
            margin-right: 10px;
            cursor: pointer;
            color: #333; /* Adjust icon color as needed */
        }
    </style>
</head>
<body>
    <div class="top-left-icons">
        <i id="homeIcon" class="fa fa-home" title="Home"></i>
        <i id="backIcon" class="fa fa-arrow-left" title="Back"></i>
    </div>
    
    <div class="container">
        <h2 style="text-align:center;">Upload Form</h2>
        <form id="uploadForm" enctype="multipart/form-data">
            <div class="form-group">
                <label for="academicyear">Academic Year:</label>
                <select id="academicyear" name="academicyear">
                    <option value="All">All</option>
                    <option value="2019-2020">2019-2020</option>
                    <option value="2020-2021">2020-2021</option>
                    <option value="2021-2022">2021-2022</option>
                    <option value="2022-2023">2022-2023</option>
                    <option value="2023-2024">2023-2024</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="department">Department:</label>
                <select id="department" name="department">
                    <option value="All">All</option>
                    <option value="1">CSE</option>
                    <option value="2">IT</option>
                    <option value="3">ECE</option>
                    <option value="4">CSM</option>
                    <option value="5">CSO</option>
                    <option value="6">CIC</option>
                    <option value="7">CIVIL</option>
                    <option value="8">MECH</option>
                    <option value="9">EEE</option>
                </select>
            </div>
            
            <div class="form-group" style="text-align: center;">
                <input type="button" value="Upload" onclick="fetchAndDisplayData();">
            </div>
        </form>
        
        <div id="uploadResult"></div>
    </div>

    <script>
        // Event listener for back icon
        document.getElementById('backIcon').addEventListener('click', function() {
            window.location.href='123.html';
        });

        // Event listener for home icon
        document.getElementById('homeIcon').addEventListener('click', function() {
            window.location.href = 'home.html';
        });

        function fetchAndDisplayData() {
            const academicYear = document.getElementById("academicyear").value;
            const department = document.getElementById("department").value;

            let url = "";
            if (academicYear === "2019-2020" && department === "2") {
                url = "Admin2019-20.jsp";
            } else if (academicYear === "2020-2021" && department === "2") {
                url = "Admin2020-21.jsp";
            } else if (academicYear === "2021-2022" && department === "2") {
                url = "Admin2021-22.jsp";
            } else if (academicYear === "2022-2023" && department === "2") {
                url = "Admin2022-23.jsp";
            } else if (academicYear === "2023-2024" && department === "2") {
                url = "Admin2023-24.jsp";
            } else {
                document.getElementById("uploadResult").innerHTML = "No matching data found.";
                return;
            }

            fetch(url)
                .then(response => response.text())
                .then(data => {
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(data, 'text/html');

                    const table = doc.querySelector('table');
                    if (!table) {
                        document.getElementById("uploadResult").innerHTML = "No table found in the data.";
                        return;
                    }

                    // Clear previous results
                    document.getElementById("uploadResult").innerHTML = "";
                    // Append the table to the result div
                    document.getElementById("uploadResult").appendChild(table);
                })
                .catch(error => {
                    console.error('Error fetching or parsing data:', error);
                    document.getElementById("uploadResult").innerHTML = "Error fetching or parsing data.";
                });
        }
    </script>
</body>
</html>
