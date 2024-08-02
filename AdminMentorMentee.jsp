<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Department and Academic Year Selection</title>
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
    .form-group select {
        width: calc(100% - 130px);
    }
    .form-group button {
        margin-top: 10px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .top-left {
        position: absolute;
        top: 10px;
        left: 10px;
    }
    .icon-button {
        background: none;
        border: none;
        cursor: pointer;
        font-size: 24px;
        margin-right: 10px;
    }
</style>
</head>
<body>

<div class="top-left">
    <button class="icon-button" onclick="goBack()">
        <i class="fas fa-arrow-left"></i>
    </button>
    <button class="icon-button" onclick="goHome()">
        <i class="fas fa-home"></i>
    </button>
</div>

<div class="container">
    <h2 style="text-align:center;">Department and Academic Year Selection</h2>
    <form id="departmentForm">
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
                <option value="">All</option>
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
            <button type="submit">Submit</button>
        </div>
    </form>
</div>

<!-- This is where fetched data will be displayed outside the container -->
<div id="fetchedData"></div>

<script>
    // Form submission handler
    document.getElementById('departmentForm').addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent default form submission
        
        // Fetch and display data based on selected department and academic year
        const selectedAcademicYear = document.getElementById('academicyear').value;
        const selectedDepartment = document.getElementById('department').value;
        
        if (selectedAcademicYear && selectedDepartment) {
            fetchAndDisplayData(selectedAcademicYear, selectedDepartment);
        } else {
            alert('Please select both academic year and department.');
        }
    });

    // Function to fetch and display data
    function fetchAndDisplayData(academicYear, department) {
        let url = "";
        
        // Construct URL based on academic year and department
        if (academicYear === "2019-2020" && department === "2") {
            url = "AdminMentor2nd.jsp";
        } else if (academicYear === "2020-2021" && department === "2") {
            url = "AdminMentor2nd.jsp";
        } else if (academicYear === "2021-2022" && department === "2") {
            url = "AdminMentor3rd.jsp";
        } else if (academicYear === "2022-2023" && department === "2") {
            url = "AdminMentor.jsp";
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
