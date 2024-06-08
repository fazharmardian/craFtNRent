<?php
header("Access-Control-Allow-Origin: *");
$id = $_GET['id'];
$db = mysqli_connect('localhost','root','','craftnrent');
$data = mysqli_query($db,"SELECT * FROM `user` WHERE id = '$id'");
$rows = array();
while($r = mysqli_fetch_assoc($data))
{
	$rows[] = $r;
}
print json_encode($rows);
?>