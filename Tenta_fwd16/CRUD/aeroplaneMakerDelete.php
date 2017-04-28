<?php
//including the database connection file
include_once("config.php");
//include_once("config_local.php");
 
//getting id of the data from url
$planeMakerID = $_GET['planeMakerID'];
 
//deleting the row from table
$sql = "DELETE FROM plane_maker WHERE planeMakerID=:planeMakerID";
$query = $pdo->prepare($sql);
$query->execute(array(':planeMakerID' => $planeMakerID));
 
//redirecting to the display page (index.php in our case)
header("Location:aeroplaneMaker.php");
?>