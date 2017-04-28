<?php
//including the database connection file 
include_once("config.php");
//include_once("config_local.php");
 
//getting id of the data from url
$aeroplaneID = $_GET['aeroplaneID'];
 
//deleting the row from table
$sql = "DELETE FROM aeroplane WHERE aeroplaneID=:aeroplaneID";
$query = $pdo->prepare($sql);
$query->execute(array(':aeroplaneID' => $aeroplaneID));
 
//redirecting to the display page (index.php in our case)
header("Location:aeroplane.php");
?>
