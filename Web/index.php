<?php
include 'koneksi.php';
include 'cek_session.php';

session_start();

if (isset($_SESSION['user_id'])) {
    header("Location: user.php");
    exit(); 
}
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="shortcut icon" href="img/crf.png" type="image/x-icon">

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
        .card {
            width: 370px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            background-color: rgba(255, 255, 255, 0.7);
        }
        .card-transparent {
            background-color: rgba(255, 255, 255, 0.3);
        }
        .btn-freak {
            width: 315px;
            background-color: rgba(0, 0, 0, 0.5);
            border: 2px solid rgba(0, 0, 0, 0.8);
            border-radius: 5px;
            color: white;
            transition: background-color 0.3s, border-color 0.3s;
        }
        .btn-freak:hover {
            background-color: rgba(0, 0, 0, 0.7);
            border-color: rgba(0, 0, 0, 1);
        }
        .btn-freak:active {
            background-color: rgba(0, 0, 0, 0.9);
            border-color: rgba(0, 0, 0, 1);
        }
    </style>
    <title>CraFtnRent</title>
</head>
<body>

<?php
if (isset($_POST['username'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = mysqli_query($koneksi, "SELECT * FROM admin WHERE username ='$username' AND password='$password'");
    if (mysqli_num_rows($query) > 0) {
        $data = mysqli_fetch_array($query);
        $_SESSION['user_id'] = $data['id']; 
        $_SESSION['username'] = $data['username'];
        echo "<script>location.href='user.php';</script>";
    } else {
        echo "<script>alert('Username/Password not correct.');</script>";
    }
}
?>

<div class="container">
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <img class="mb-2" src="img/crf.png" alt="" width="350" height="350">
            </div>
        </div>
        <div class="col-md-6">
            <div class="card card-transparent text-center">
                <form method="post" class="form-signin"><br>
                    <h1 class="h3 mb-3 font-weight-normal">Welcome Back</h1><br>
                    <label class="sr-only">Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Username" required><br>
                    <label class="sr-only">Password</label>
                    <input type="password" autocomplete="off" name="password" class="form-control" placeholder="Password" required><br>
                    <br>
                    <input type="submit" name="login" value="Log In" class="btn btn-freak"><br>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
