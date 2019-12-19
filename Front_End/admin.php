<?php 
if(isset($_POST['fid'])){
  header("location:faculty.html");

}elseif(isset($_POST['sid'])){


  header("location:student.html");
}elseif(isset($_POST['pid'])){

  header("location:project.html");
}elseif (isset($_POST['tid'])) {
  
  header("location:thesis.html");
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
        width: 50%;
      }

      button:hover {
        opacity: 0.8;
      }
</style>  
</head>
<body>
 <form action=<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?> method="POST">
<div id="1" align="center">
  <h1 >Admin Panel</h1>
  <button type="Submit" name="fid" >Faculty</button>
  <br>
  <button type="Submit" name="sid">Student</button>
    <br>
    <button type="Submit" name="pid">Project</button>
    <br>
    <button type="Submit" name="tid">Thesis</button>
    <br>
</div>
</form>
</body>
</html>