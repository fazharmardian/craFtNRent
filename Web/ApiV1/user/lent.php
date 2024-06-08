<?php
header("Access-Control-Allow-Origin: *");

if (!isset($_POST['id_user']) ||  !isset($_POST['id_item']) || 
    !isset($_POST['total_request']) || !isset($_POST['return_date']) ) {
    echo json_encode(["status" => "error", "message" => "All parameters are required"]);
    exit();
}

$borrower_id = $_POST['id_user'];
$id_item = $_POST['id_item'];
$total = $_POST['total_request'];
$return = $_POST['return_date'];

$db = mysqli_connect('localhost', 'root', '', 'craftnrent');

$sql = "SELECT * FROM item WHERE id = '$id_item' AND status = 'available'";
$item_result = mysqli_query($db, $sql);

if (!$item_result || mysqli_num_rows($item_result) == 0) {
    echo json_encode(["status" => "error", "message" => "Item not available for lending"]);
    exit();
}

$insert_sql = "INSERT INTO request (id_user, id_item, total_request, type, request_date, status, return_date) VALUES ('$borrower_id', '$id_item', '$total', 'renting', NOW(), 'pending', '$return')";
$insert_result = mysqli_query($db, $insert_sql);

if ($insert_result) {
    echo json_encode(["status" => "success", "message" => "Borrowing request sent successfully"]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to send borrowing request"]);
}

mysqli_close($db);
?>
