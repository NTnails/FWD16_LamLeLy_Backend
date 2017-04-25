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
    $title = $_POST['title'];
$description=$_POST['description']; 
$duration=$_POST['duration']; 
$rating=$_POST['rating']; 						
$date=$_POST['date'];   
    $fl_iddirectors = $_POST['fl_iddirectors'];
        
    // checking empty fields
    if(empty($title) || empty($fl_iddirectors)) {
                
        if(empty($title)) {
            echo "<font color='red'>Name field is empty.</font><br/>";
        }
        
        if(empty($fl_iddirectors)) {
            echo "<font color='red'>Email field is empty.</font><br/>";
        }
        
        //link to the previous page
        echo "<br/><a href='javascript:self.history.back();'>Go Back</a>";
    } else { 
        // if all the fields are filled (not empty) 
            
        //insert data to database        
        $sql = "INSERT INTO films(title, description, duration, rating, date, fl_iddirectors) VALUES(:title, :description, :duration, :rating, :date, :fl_iddirectors)";
        $query = $pdo->prepare($sql);
                
        $query->bindparam(':title', $title); 
		$query->bindparam(':description', $description); 
		$query->bindparam(':duration', $duration); 
		$query->bindparam(':rating', $rating); 
		$query->bindparam(':date', $date); 
        $query->bindparam(':fl_iddirectors', $fl_iddirectors);
        $query->execute();
        
        // Alternative to above bindparam and execute
        // $query->execute(array(':title' => $title, ':fl_iddirectors' => $fl_iddirectors));
        
        //display success message
        echo "<font color='green'>Data added successfully.";
        echo "<br/><a href='welcome.php'>View Result</a>";
    }
}

/*
 * För att inte användaren ska behöva skriva siffror för en fl_iddirectors, så vill vi
 * skapa en dropdown så att användare kan välja från namnlista från databasen
 * som ladda i en dropdown.
 * Nedanståend sql fråga är basen för den dropdown
*/
$directorsSql = "SELECT * FROM directors"; 
$directorsQuery = $pdo->prepare($directorsSql); 
$directorsQuery->execute(); 
        
?>

<!DOCTYPE html>

<html>
    <head>
        <title>Add Form Input</title>
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
        <a href="welcome.php">Home</a>
    <br/><br/>

    <form action="add_form.php" method="post" name="form1">
        <table width="25%" border="0">
            <tr> 
<!-- Här lägger vi till det nya skämtet -->                
<td>
Title <br><input type='text' name="title" >
<br><br>
Description <br><input type='text' name="description" > 
<br><br>
Duration: min <br><input type='number' name="duration" > 
<br><br>
Rating: *** <br><input type='text' name="rating" > 
<br><br>
Date <br><input type='date' name="date" >
<br><br>
</td>
            </tr>
            
            <tr> 
<td>Director</td> 
<td>

<!-- Vi skapar en dropdown som laddas med författare från databasen, så att inte
användare inte lägger till författare som inte existerar-->    
<select name="fl_iddirectors"> 
<?php

$fl_iddirectors="";
while($directors = $directorsQuery->fetch()) { 
if ($directors['iddirectors'] == $fl_iddirectors) { 
//The directors is currently associated to the films, select it by default 
echo "<option value=\"{$directors['iddirectors']}\" selected>{$directors['name']}</option>"; 
} else { 
//The directors is not currently associated to the films 
echo "<option value=\"{$directors['iddirectors']}\">{$directors['name']}</option>"; 
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


