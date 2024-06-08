<?php
header("Access-Control-Allow-Origin: *");
$db = mysqli_connect('localhost','root','','craftnrent');
$data = mysqli_query($db,"select * from item");
$rows = array();
while($r = mysqli_fetch_assoc($data))
{
	$rows[] = $r;
}
print json_encode($rows);
?>