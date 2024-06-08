<?php
$db = mysqli_connect('localhost', 'root', '', 'craftnrent');

$email = $_POST['email'];
$password = $_POST['password'];

header("Access-Control-Allow-Origin: *");

$sql = "SELECT id FROM user WHERE email = '$email' AND password = '$password'";
$result = mysqli_query($db, $sql);

if ($result && mysqli_num_rows($result) == 1) {
    $row = mysqli_fetch_assoc($result);
    $userId = $row['id'];
    
    echo json_encode(["message" => "Success", "user_id" => $userId]);
} else {    
    echo json_encode(["message" => "Error"]);
}

mysqli_close($db);
?>
