<?php
header("Access-Control-Allow-Origin: *");
$id = $_GET['id_user'];
$db = mysqli_connect('localhost', 'root', '', 'craftnrent');

$query = "
    SELECT lending.*, item.name AS item_name, item.brand AS item_brand 
	FROM lending 
	JOIN item ON lending.id_item = item.id 
	WHERE lending.id_user = '$id' AND lending.status = 'returned'
	ORDER BY lending.lend_date DESC
	LIMIT 10;;";

$data = mysqli_query($db, $query);
$rows = array();
while($r = mysqli_fetch_assoc($data)) {
    $rows[] = $r;
}
print json_encode($rows);
?>
