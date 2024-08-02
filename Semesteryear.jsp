<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Page Title</title>
    <!-- Include Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Style for the icons */
        body{
            background-color: #ffff;
        }
        .icon-button {
            border: none;
            background: none;
            cursor: pointer;
            font-size: 24px;
            margin: 5px;
        }
        /* Positioning for top left corner */
        .top-left {
            position: absolute;
            top: 10px;
            left: 10px;
        }
        /* Centering container for department */
        .top-center-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        /* Container for department dropdown */
        .container {
            width: 40%;
            margin: 10px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            position: relative;
        }
        /* Style for the department dropdown */
        .department-select, .semesteryear {
            margin: 0 10px;
            padding: 5px;
            font-size: 16px;
            flex: 1; /* Allow the select box to grow and fill the container */
        }
        /* Style for the submit button */
        .submit-button {
            margin-top: 10px;
            margin-left: auto; /* Push the button to the right */
            padding: 5px 10px;
            font-size: 16px;
            cursor: pointer;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: lightblue;
            display: block; /* Ensures the button is a block element */
        }
        /* Style for iframe */
        .content-frame {
            width: 100%;
            height: 800px;
            border: none;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <!-- Back and Home Icons in top left corner -->
    <div class="top-left">
        <button class="icon-button" onclick="goBack()">
            <i class="fas fa-arrow-left"></i>
        </button>
        <button class="icon-button" onclick="goHome()">
            <i class="fas fa-home"></i>
        </button>
    </div>

    <!-- Department and Semester Year Dropdown in top center -->
    <div class="container">
        <label for="semesteryear">Semester Year:</label>
        <select id="semesteryear" name="semesteryear" class="semesteryear">
            <option value="ALL">ALL</option>
            <option value="I-I">I-I</option>
            <option value="I-II">I-II</option>
            <option value="II-I">II-I</option>
            <option value="II-II">II-II</option>
            <option value="III-I">III-I</option>
            <option value="III-II">III-II</option>
            <option value="IV-I">IV-I</option>
            <option value="IV-II">IV-II</option>
        </select>
        <label for="department">Department:</label>
        <select id="department" name="department" class="department-select">
            <option value="ALL">ALL</option>
            <option value="CSE">CSE</option>
            <option value="ECE">ECE</option>
            <option value="MECH">MECH</option>
            <option value="CIVIL">CIVIL</option>
            <option value="IT">IT</option>
            <option value="EEE">EEE</option>
        </select>
        <button class="submit-button" onclick="fetchAndDisplayData()">Submit</button>
    </div>

    <!-- Iframe to display content based on department selection -->
    <iframe id="content-frame" class="content-frame"></iframe>

  <script>
    function goBack() {
        window.history.back();
    }

    function goHome() {
        window.location.href = 'home.html'; // Change 'home.jsp' to your home page URL
    }

    function fetchAndDisplayData() {
        const semesteryear = document.getElementById("semesteryear").value;
        const department = document.getElementById("department").value;

        let url = "";

        if (semesteryear === "ALL" && department === "ALL") {
            url = "Allsemesters.jsp"; // Adjust this URL to your all details page
        } else {
            switch (semesteryear) {
                case "I-I":
                    url = department === "IT" ? "one_one.jsp" : "default.html";
                    break;
                case "I-II":
                    url = department === "IT" ? "one-two.jsp" : "default.html";
                    break;
                case "II-I":
                    url = department === "IT" ? "two_one.jsp" : "default.html";
                    break;
                case "II-II":
                    url = department === "IT" ? "two_two.jsp" : "default.html";
                    break;
                case "III-I":
                    url = department === "IT" ? "three_one.jsp" : "default.html";
                    break;
                case "III-II":
                    url = department === "IT" ? "three_two.jsp" : "default.html";
                    break;
                case "IV-I":
                    url = department === "IT" ? "four_one.jsp" : "default.html";
                    break;
                case "IV-II":
                    url = department === "IT" ? "four_two.jsp" : "default.html";
                    break;
                default:
                    url = "default.html"; // Replace with a default file or page
            }
        }

        const iframe = document.getElementById("content-frame");
        iframe.src = url;
    }
</script>

</body>
</html>
