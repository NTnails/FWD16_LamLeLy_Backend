<?php
//including the database connection file
include_once("config.php");
//include_once("config_local.php");
 
//getting id of the data from url
$movieId = $_GET['movieId'];
 
//deleting the row from table
$sql = "DELETE FROM movie WHERE movieId=:movieId";
$query = $pdo->prepare($sql);
$query->execute(array(':movieId' => $movieId));
 
//redirecting to the display page (index.php in our case)
header("Location:movie.php");
?>
