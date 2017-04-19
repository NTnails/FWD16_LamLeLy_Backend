<?php
//including the database connection file
include_once("config.php");
//include_once("config_local.php");
 
//getting id of the data from url
$idfilm = $_GET['idfilm'];
 
//deleting the row from table
$sql = "DELETE FROM film WHERE idfilm=:idfilm";
$query = $pdo->prepare($sql);
$query->execute(array(':idfilm' => $idfilm));
 
//redirecting to the display page (index.php in our case)
header("Location:index.php");
?>
