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

if(isset($_POST['Submit'])) {    
    $title = $_POST['title'];
    $fl_iddirector = $_POST['fl_iddirector'];
        
    // checking empty fields
    if(empty($title) || empty($fl_iddirector)) {
                
        if(empty($title)) {
            echo "<font color='red'>Name field is empty.</font><br/>";
        }
        
        if(empty($fl_iddirector)) {
            echo "<font color='red'>Email field is empty.</font><br/>";
        }
        
        //link to the previous page
        echo "<br/><a href='javascript:self.history.back();'>Go Back</a>";
    } else { 
        // if all the fields are filled (not empty) 
            
        //insert data to database        
        $sql = "INSERT INTO film(title, fl_iddirector) VALUES(:title, :fl_iddirector)";
        $query = $pdo->prepare($sql);
                
        $query->bindparam(':title', $title);
        $query->bindparam(':fl_iddirector', $fl_iddirector);
        $query->execute();
        
        // Alternative to above bindparam and execute
        // $query->execute(array(':title' => $title, ':fl_iddirector' => $directorId));
        
        //display success message
        echo "<font color='green'>Data added successfully.";
        echo "<br/><a href='index.php'>View Result</a>";
    }
}

/*
 * För att inte användaren ska behöva skriva siffror för en fl_iddirector, så vill vi
 * skapa en dropdown så att användare kan välja från namnlista från databasen
 * som ladda i en dropdown.
 * Nedanståend sql fråga är basen för den dropdown
*/
$directorSql = "SELECT * FROM director"; 
$directorQuery = $pdo->prepare($directorSql); 
$directorQuery->execute(); 
        
?>

<!DOCTYPE html>

<html>
    <head>
        <title>Add Film</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <a href="index.php">Home</a>
    <br/><br/>

    <form action="add_form.php" method="post" name="form1">
        <table width="25%" border="0">
            <tr> 
                <td>Film</td>
<!-- Här lägger vi till det nya skämtet -->                
                <td><td><textarea name="title" rows="6" cols="40" ></textarea></td>
            </tr>
            
            <tr> 
<td>Director</td> 
<td>

<!-- Vi skapar en dropdown som laddas med författare från databasen, så att inte
användare inte lägger till författare som inte existerar-->    
<select name="fl_iddirector"> 
<?php

$fl_iddirector="";
while($director = $directorQuery->fetch()) { 
if ($director['iddirector'] == $fl_iddirector) { 
//The author is currently associated to the joke, select it by default 
echo "<option value=\"{$director['iddirector']}\" selected>{$director['name']}</option>"; 
} else { 
//The author is not currently associated to the joke 
echo "<option value=\"{$director['iddirector']}\">{$director['name']}</option>"; 
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
    </body>
</html>


