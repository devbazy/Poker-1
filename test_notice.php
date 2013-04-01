<?php
$con = mysql_connect("localhost","","");
if (!$con){
  die('Could not connect: ' . mysql_error());
}
mysql_select_db("poker", $con);
$result = mysql_query("SELECT event FROM notice");
var_dump($result);
$i=0;
while($row = mysql_fetch_array($result)){
	var_dump($row);
}
echo "<br />";
mysql_close($con);
?>
