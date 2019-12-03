<php

if($_SERVER["REQUEST_METHOD"] == "POST"){
	if(!empty($_POST['u_name'])){
		$uName = mysqli_real_escape_string($conn, $_POST['u_name']);
	}
	if(!empty($_POST['u_pass'])){
		$uPass = mysqli_real_escape_string($conn, $_POST['u_pass']);
	}

	
}
?>
<!DOCTYPE html>
<html>
<head>
	<title>Admin Panel</title>

 <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
      body {
        font-family: Arial, Helvetica, sans-serif;
      }
      form {
        border: 3px solid #f1f1f1;
      }

      input[type='text'],
      input[type='password'] {
        width: 100%;
        padding: 12px 20px;
        margin: 8px 0;
        display: inline-block;
        border: 1px solid #ccc;
        box-sizing: border-box;
      }

      button {
        background-color: #4caf50;
        color: white;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        cursor: pointer;
        width: 100%;
      }

      button:hover {
        opacity: 0.8;
      }
</style>	
</head>
<body>
 <form action=<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?> method="POST">
<div align="center">
	<h1 >Admin Panel</h1>
	<button type="Submit" id="fid">Faculty</button>
	<br>
	<button type="Submit" id="sid">Student</button>
    <br>
    <button type="Submit" id="pid">Project</button>
    <br>
    <button type="Submit" id="tid">Thesis</button>
    <br>
</div>
</form>

</body>
</html>