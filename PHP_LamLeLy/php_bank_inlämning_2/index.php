<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        // Call documents needed to run the program
        require ("config.php");
        
        // Call store procedure and inputs an in parameter
        $sql = "CALL Account('Sohail')";
        $result = $conn->query($sql);
        
        // Fetches all rows with rowCount
        if ($result->rowCount()) {
            $result->setFetchMode(PDO::FETCH_CLASS, "bank");
            // Prints the Fname variable from the bank class
            while($row = $result->fetch()) {
                echo $row->Fname;
            }
        }
        ?>
    </body>
</html>
