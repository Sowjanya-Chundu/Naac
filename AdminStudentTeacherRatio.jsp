<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            margin: 20px auto;
            width: 50%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            background-color: #fff;
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
            width: 100%; /* Full width for better layout */
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
        /* Styling for inline data display */
        #dataDisplay {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            min-height: 100px;
            width: 100%; /* Ensure it fits within the container */
            box-shadow: 0 0 10px rgba(0,0,0,0.1); /* Optional for better visibility */
            display: none; /* Initially hidden */
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
                <option value="2023-2024">2017-2018</option>
                <option value="2023-2024">2018-2019</option>
                <option value="2019-2020">2019-2020</option>
                <option value="2020-2021">2020-2021</option>
                <option value="2021-2022">2021-2022</option>
                <option value="2022-2023">2022-2023</option>
                
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
            <input type="button" value="Submit" onclick="handleSubmit();">
        </div>
        
        <!-- Data display area within the same container -->
        <div id="dataDisplay"></div>
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

<script>
    function handleSubmit() {
        const academicYear = document.getElementById("academicyear").value;
        const department = document.getElementById("department").value;

        let url = "";
        if (academicYear === "All" && department === "All") {
            url = "http://localhost:8080/project1/StudentTeacher17-18.jsp";
        } else if (academicYear === "2017-2018" && department === "2") {
            url = "StudentTeacher17-18.jsp";
        } else if (academicYear === "2018-2019" && department === "2") {
            url = "StudentTeacher18-19.jsp";
        } else if (academicYear === "2019-2020" && department === "2") {
            url = "StudentTeacher19-20.jsp";
        } else if (academicYear === "2020-2021" && department === "2") {
            url = "StudentTeacher20-21.jsp";
        } else if (academicYear === "2021-2022" && department === "2") {
            url = "StudentTeacher21-22.jsp";
        } else if (academicYear === "2022-2023" && department === "2") {
            url = "StudentTeacher22-23.jsp";
        }else {
            document.getElementById("dataDisplay").innerHTML = "No matching data found.";
            document.getElementById("dataDisplay").style.display = "block"; // Show the div
            return;
        }

        // Use AJAX to fetch data and update dataDisplay div
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    // Update the dataDisplay div directly and make it visible
                    document.getElementById("dataDisplay").innerHTML = xhr.responseText;
                    document.getElementById("dataDisplay").style.display = "block"; // Show the div
                } else {
                    document.getElementById("dataDisplay").innerHTML = "Error fetching data.";
                    document.getElementById("dataDisplay").style.display = "block"; // Show the div
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
        window.location.href = 'home.html'; // Change 'home.html' to your home page URL
    }
</script>

</body>
</html>
