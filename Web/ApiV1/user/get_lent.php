<?php
header("Access-Control-Allow-Origin: *");
$id = $_GET['id_user'];
$db = mysqli_connect('localhost', 'root', '', 'craftnrent');

$query = "SELECT lending.id, lending.id_user, lending.id_item, lending.lend_date, lending.return_date, lending.status, lending.total_request, 
        item.name AS item_name, item.brand AS item_brand, item.image AS item_image
        FROM lending 
        JOIN item ON lending.id_item = item.id 
        WHERE lending.id_user = '$id' AND lending.status = 'lent'
        ORDER BY lending.lend_date DESC
        LIMIT 10;";

$data = mysqli_query($db, $query);
$rows = array();
while($r = mysqli_fetch_assoc($data)) {
    $rows[] = $r;
}
print json_encode($rows);
?>
