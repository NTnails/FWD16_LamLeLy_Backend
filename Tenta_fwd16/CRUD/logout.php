<?php
session_start();
/*Vi avslutar sessionen och skickar tillbaka användare till start sidan*/
session_destroy();

header("location:index.php");

?>