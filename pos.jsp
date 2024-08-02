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
        background-color:brown;
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
            background-color:#fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            position: relative;
            margin-top:0px;
        }
        /* Style for the department dropdown */
        .department-select {
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

    <!-- Department Dropdown in top center -->
    <div class="container">
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
        <button class="submit-button" onclick="submitDepartment()">Submit</button>
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

        function submitDepartment() {
            const department = document.getElementById('department').value;
            const iframe = document.getElementById('content-frame');
            let url = '';

            switch (department) {
                case 'CSE':
                    url = 'CSEpos.html';
                    break;
                case 'ECE':
                    url = 'ECEpos.html';
                    break;
                case 'MECH':
                    url = 'MECHpos.html';
                    break;
                case 'CIVIL':
                    url = 'CIVILpos.html';
                    break;
                case 'IT':
                    url = 'POsPCOs.html';
                    break;
                case 'EEE':
                    url = 'EEEpos.html';
                    break;
                default:
                    url = 'default.html'; // Replace with a default file or page
            }

            iframe.src = url;
        }
    </script>
</body>
</html>
