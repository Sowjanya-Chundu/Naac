function deleteData() {
  var idToDelete = document.getElementById('idToDelete').value;

  // Validate input (you might want to add more validation)
  if (!idToDelete) {
    alert('Please enter an ID to delete.');
    return;
  }

  // Perform AJAX request to the servlet
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function () {
    if (xhr.readyState === XMLHttpRequest.DONE) {
      if (xhr.status === 200) {
        document.getElementById('result').innerHTML = xhr.responseText;
      } else {
        alert('Error: ' + xhr.status);
      }
    }
  };

  // Replace 'http://localhost:8080/DeleteDataServlet' with the actual URL of your servlet
  xhr.open('DELETE', 'http://localhost:8080/DeleteDataServlet?id=' + idToDelete, true);
  xhr.send();
}
