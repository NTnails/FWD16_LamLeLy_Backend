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
$aeroplaneName = $_POST['aeroplaneName'];
$aeroplaneTopSpeed=$_POST['aeroplaneTopSpeed']; 
$aeroplaneRange=$_POST['aeroplaneRange']; 
$planeMakerID = $_POST['planeMakerID'];
        
    // checking empty fields
    if(empty($aeroplaneName) || empty($planeMakerID)) {
                
        if(empty($aeroplaneName)) {
            echo "<font color='red'>Name field is empty.</font><br/>";
        }
        
        if(empty($planeMakerID)) {
            echo "<font color='red'>Email field is empty.</font><br/>";
        }
        
        //link to the previous page
        echo "<br/><a href='javascript:self.history.back();'>Go Back</a>";
    } else { 
        // if all the fields are filled (not empty) 
            
        //insert data to database        
        $sql = "INSERT INTO aeroplane(aeroplaneName, aeroplaneTopSpeed, aeroplaneRange, planeMakerID) VALUES(:aeroplaneName, :aeroplaneTopSpeed, :aeroplaneRange, :planeMakerID)";
        $query = $pdo->prepare($sql);
                
        $query->bindparam(':aeroplaneName', $aeroplaneName); 
		$query->bindparam(':aeroplaneTopSpeed', $aeroplaneTopSpeed); 
		$query->bindparam(':aeroplaneRange', $aeroplaneRange); 
        $query->bindparam(':planeMakerID', $planeMakerID);
        $query->execute();
        
        // Alternative to above bindparam and execute
        // $query->execute(array(':aeroplaneName' => $aeroplaneName, ':planeMakerID' => $planeMakerID));
        
        //display success message
        echo "<font color='green'>Data added successfully.";
        echo "<br/><a href='aeroplane.php'>View Result</a>";
    }
}

/*
 * För att inte användaren ska behöva skriva siffror för en planeMakerID, så vill vi
 * skapa en dropdown så att användare kan välja från namnlista från databasen
 * som ladda i en dropdown.
 * Nedanståend sql fråga är basen för den dropdown
*/
$plane_makerSql = "SELECT * FROM plane_maker"; 
$plane_makerQuery = $pdo->prepare($plane_makerSql); 
$plane_makerQuery->execute(); 
        
?>

<!DOCTYPE html>

<html>
    <head>
        <title>Add New Aeroplane</title>
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
        <a href="aeroplane.php"> Home</a>  | <a href="aeroplaneMaker.php">Plane maker</a><br/><br/>

    <form action="aeroplaneAdd.php" method="post" name="form1">
        <table width="25%" border="0">
            <tr> 
<!-- Här lägger vi till det nya input -->                
<td>
Aeroplane Name: <br><input type='text' name="aeroplaneName" placeholder="aeroplane name" >
<br><br>
Aeroplane Speed: <br><input type='text' name="aeroplaneTopSpeed" placeholder="aeroplane speed" > 
<br><br>
Aeroplane Range: <br><input type='number' name="aeroplaneRange" placeholder="aeroplane range"> 
<br><br>
</td>
            </tr>
            
            <tr> 
<td>Maker</td> 
<td>

<!-- Vi skapar en dropdown som laddas med författare från databasen, så att inte
användare inte lägger till författare som inte existerar-->    
<select name="planeMakerID"> 
<?php

$planeMakerID="";
while($plane_maker = $plane_makerQuery->fetch()) { 
if ($plane_maker['planeMakerID'] == $planeMakerID) { 
//The plane_maker is currently associated to the aeroplane, select it by default 
echo "<option value=\"{$plane_maker['planeMakerID']}\" selected>{$plane_maker['planeMakerName']}</option>"; 
} else { 
//The plane_maker is not currently associated to the aeroplane 
echo "<option value=\"{$plane_maker['planeMakerID']}\">{$plane_maker['planeMakerName']}</option>"; 
} 
} 
?> 
</select> 
</td> 
</tr> 
    <tr> 
        <td></td>
            <td><input type="submit" name="Submit" value="Add"></td>
            </tr>
        </table>
    </form>
<!--För att logga ut skickar vi användaren till en sida där sessionen avslutas
med session_destroy-->    
    <a href="logout.php">Logout</a>
    </body>
</html>


