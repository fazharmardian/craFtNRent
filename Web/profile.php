<?php
include 'cek_session.php';
include 'koneksi.php';
session_start();

if (!isset($_SESSION['user_id'])) {
  echo "<script>alert('Please log in first.'); location.href='index.php';</script>";
  exit;
}

$user_id = $_SESSION['user_id'];

$query = mysqli_query($koneksi, "SELECT * FROM admin WHERE id='$user_id'");
$data = mysqli_fetch_array($query);
?>

<!doctype html>
<html lang="en">
  <head>
    <style>
      body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: "Helvetica", sans-serif;
            background: url('assets/img/login-bg.jpg') no-repeat center;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
      .profile-card {
            max-width: 400px;
            margin: auto;
            background-color: rgba(255, 255, 255, 0.5);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
    </style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

    <title>Profile Page</title>
  </head>
  <body>
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="card profile-card">
            <div class="card-body text-center">
              <img src="img/download (3).jpeg" class="rounded-circle img-fluid mb-3" alt="Profile Image" style="width: 150px; height: 150px;">
              <h1 class="mt-3"><?php echo $data['username']; ?></h1>
              <p class="lead">Software Developer</p>
              <p><?php echo $data['email']; ?></p>
              <p><?php echo $data['telephone']; ?></p> 
              <a href="user.php" class="btn btn-back"> <span>&larr;</span> Back</a>
            </div>
          </div>
          <div class="text-center mt-3">
           
          </div>
        </div>
      </div>
    </div>

    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    -->
  </body>
</html>

