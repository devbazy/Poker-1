<?php
require('libs/db.php');

$sql = "SELECT * FROM barrack";
$db = new DB;
$db->connect();
$db->query($sql);
$barrack = array();

while ($db->next_record()) {
	
	array_push($barrack, array(
		'role_id' => $db->f('role_id'),
		'telephone' => $db->f('telephone'),
		));
}
$sql = "SELECT * FROM notice ";
$db->query($sql);
while ($db->next_record()) {
	$event=$db->f('event');
	$role_id=$db->f('role_id');
	
	foreach ($barrack as $key => $value) {
		if ($role_id == $value[role_id]) {
			echo "$value[telephone]";
			echo "#";
			echo "$event";
			echo "<br/>";
		}
	}
}
?>