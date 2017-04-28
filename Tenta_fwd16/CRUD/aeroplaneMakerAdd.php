<?php
//include_once("config_local.php");
include_once("config.php");

/*
 * Vi organiserar sidan på sån sätt att vi har all processkod här i toppen av
 * sidan. All information som vi behöver processa hämtas från den nedre delen
 * av sidan där html formuläret finns. 
 * Där finns namnen på formulärfälten som vi använder i php koden här upp för 
 * att processas.
*/

/*
 * Session start koden lägger vi till på samtliga sidor som ska vara skyddade
*/
session_start();
if(empty($_SESSION['email']))
{
 header("location:index.php");
}

echo "Welcome ".$_SESSION['name']."<br>";

if(isset($_POST['Submit'])) { 
   $planeMakerName = $_POST['planeMakerName'];
        
    // checking empty fields
    if(empty($planeMakerName)){ 
            echo "<font color='red'>Name field is empty.</font><br/>";
        } else {        
        $sql = "INSERT INTO plane_maker(planeMakerName) VALUES(:planeMakerName)";
        $query = $pdo->prepare($sql);
        // if all the fields are filled (not empty) 
		//insert data to database      
       
                
        $query->bindparam(':planeMakerName', $planeMakerName); 
        $query->execute();
        
        // Alternative to above bindparam and execute
        // $query->execute(array(':movieName' => $movieName, ':fk_categoryId' => $fk_categoryId));
        
        //display success message
        echo "<font color='green'>Data added successfully.";
        echo "<br/><a href='aeroplaneMaker.php'>View Result</a> | ";
    }
}
     
?>

<!DOCTYPE html>

<html>
    <head>
        <title>Add Maker</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
		body {
    background-color: lightblue;
}

td {
    border-bottom: 6px solid red;
    background-color: lightgrey;
    border: 2px solid red;
    border-radius: 5px;
}
        </style>
    </head>
    <body>
       <a href="aeroplane.php">Home</a>  | <a href="aeroplaneMaker.php">Back</a><br/><br/>

    <form action="aeroplaneMakerAdd.php" method="post" name="form1">
        <table width="25%" border="0">
            <tr> 
<!-- Här lägger vi till det nya input -->                
<td>
Aeroplane Maker <br><input type='text' name="planeMakerName" placeholder="aeroplane maker name">
<br><br>
</td>
 
            <td><input type="submit" name="Submit" value="Add"></td>
            </tr>
        </table>
    </form>
<!--För att logga ut skickar vi användaren till en sida där sessionen avslutas
med session_destroy-->    
    <a href="logout.php">Logout</a>
    </body>
</html>


