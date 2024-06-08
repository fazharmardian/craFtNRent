<?php
$db = mysqli_connect('localhost', 'root', '', 'craftnrent');
header("Access-Control-Allow-Origin: *");

$username = isset($_POST['username']) ? mysqli_real_escape_string($db, $_POST['username']) : '';
$email = isset($_POST['email']) ? mysqli_real_escape_string($db, $_POST['email']) : '';
$telephone = isset($_POST['telephone']) ? mysqli_real_escape_string($db, $_POST['telephone']) : '';
$password = isset($_POST['password']) ? mysqli_real_escape_string($db, $_POST['password']) : '';

if (empty($username) || empty($email) || empty($telephone) || empty($password)) {
    echo json_encode(["status" => "error", "message" => "All fields are required"]);
    exit();
}


$sql = "SELECT * FROM user WHERE username = '$username' OR email = '$email'";
$result = mysqli_query($db, $sql);

if (!$result) {
    echo json_encode(["status" => "error", "message" => "Query error"]);
    exit();
}

if (mysqli_num_rows($result) > 0) {
    echo json_encode(["status" => "error", "message" => "Username or email already exists"]);
    exit();
}

$insert = "INSERT INTO user (username, email, telephone, password) VALUES ('$username', '$email', '$telephone', '$password')";
$query = mysqli_query($db, $insert);

if ($query) {
    echo json_encode(["status" => "success", "message" => "User registered successfully"]);
} else {
    echo json_encode(["status" => "error", "message" => "Registration failed"]);
}

mysqli_close($db);
?>
