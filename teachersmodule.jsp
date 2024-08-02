<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .container {
            margin: 0 auto;
            width: 50%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .top-left {
            position: absolute;
            top: 20px;
            left: 20px;
        }
        .icon-button {
            background: none;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

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
</div>

<!-- Back and Home icons on the top left -->
<div class="top-left">
    <button class="icon-button" onclick="goBack()">
        <i class="fas fa-arrow-left"></i>
    </button>
    <button class="icon-button" onclick="goHome()">
        <i class="fas fa-home"></i>
    </button>
</div>

<!-- This is where fetched data will be displayed outside the container -->
<div id="fetchedData"></div>

<script>
    function fetchAndDisplayData() {
        const academicYear = document.getElementById("academicyear").value;
        const department = document.getElementById("department").value;

        let url = "";
        if (academicYear === "2019-2020" && department === "2") {
            url = "2019-20faculty.jsp";
        } else if (academicYear === "2020-2021" && department === "2") {
            url = "2020-21faculty.jsp";
        } else if (academicYear === "2021-2022" && department === "2") {
            url = "2021-22faculty.jsp";
        } else if (academicYear === "2022-2023" && department === "2") {
            url = "2022-23faculty.jsp";
        } else if (academicYear === "2023-2024" && department === "2") {
            url = "2023-24faculty.jsp";
        } else {
            // Handle no matching data case
            document.getElementById("fetchedData").innerHTML = "No matching data found.";
            return;
        }

        // Use AJAX to fetch data and update fetchedData div
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    // Update the fetchedData div outside the container
                    document.getElementById("fetchedData").innerHTML = xhr.responseText;
                } else {
                    document.getElementById("fetchedData").innerHTML = "Error fetching data.";
                }
            }
        };

        xhr.open("GET", url, true);
        xhr.send();
    }

    function goBack() {
        window.history.back();
    }

    function goHome() {
        window.location.href = 'home.html'; // Change 'home.jsp' to your home page URL
    }
</script>

</body>
</html>
