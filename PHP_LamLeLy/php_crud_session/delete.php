<?php
//including the database connection file
include_once("config.php");
//include_once("config_local.php");
 
//getting id of the data from url
$idfilms = $_GET['idfilms'];
 
//deleting the row from table
$sql = "DELETE FROM films WHERE idfilms=:idfilms";
$query = $pdo->prepare($sql);
$query->execute(array(':idfilms' => $idfilms));
 
//redirecting to the display page (index.php in our case)
header("Location:welcome.php");
?>
