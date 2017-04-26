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
$movieName = $_POST['movieName'];
$movieDuration=$_POST['movieDuration']; 
$movieCopies=$_POST['movieCopies']; 
$fk_categoryId = $_POST['fk_categoryId'];
        
    // checking empty fields
    if(empty($movieName) || empty($fk_categoryId)) {
                
        if(empty($movieName)) {
            echo "<font color='red'>Name field is empty.</font><br/>";
        }
        
        if(empty($fk_categoryId)) {
            echo "<font color='red'>Email field is empty.</font><br/>";
        }
        
        //link to the previous page
        echo "<br/><a href='javascript:self.history.back();'>Go Back</a>";
    } else { 
        // if all the fields are filled (not empty) 
            
        //insert data to database        
        $sql = "INSERT INTO movie(movieName, movieDuration, movieCopies, fk_categoryId) VALUES(:movieName, :movieDuration, :movieCopies, :fk_categoryId)";
        $query = $pdo->prepare($sql);
                
        $query->bindparam(':movieName', $movieName); 
		$query->bindparam(':movieDuration', $movieDuration); 
		$query->bindparam(':movieCopies', $movieCopies); 
        $query->bindparam(':fk_categoryId', $fk_categoryId);
        $query->execute();
        
        // Alternative to above bindparam and execute
        // $query->execute(array(':movieName' => $movieName, ':fk_categoryId' => $fk_categoryId));
        
        //display success message
        echo "<font color='green'>Data added successfully.";
        echo "<br/><a href='movie.php'>View Result</a>";
    }
}

/*
 * För att inte användaren ska behöva skriva siffror för en fk_categoryId, så vill vi
 * skapa en dropdown så att användare kan välja från namnlista från databasen
 * som ladda i en dropdown.
 * Nedanståend sql fråga är basen för den dropdown
*/
$categorySql = "SELECT * FROM category"; 
$categoryQuery = $pdo->prepare($categorySql); 
$categoryQuery->execute(); 
        
?>

<!DOCTYPE html>

<html>
    <head>
        <title>Add New Movie</title>
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
        <a href="movie.php"> Home</a>  | <a href="category.php">Category</a><br/><br/>

    <form action="movieAdd.php" method="post" name="form1">
        <table width="25%" border="0">
            <tr> 
<!-- Här lägger vi till det nya input -->                
<td>
Movie name <br><input type='text' name="movieName" >
<br><br>
Duration in min: <br><input type='text' name="movieDuration" > 
<br><br>
Copies: <br><input type='number' name="movieCopies" > 
<br><br>
</td>
            </tr>
            
            <tr> 
<td>Category</td> 
<td>

<!-- Vi skapar en dropdown som laddas med författare från databasen, så att inte
användare inte lägger till författare som inte existerar-->    
<select name="fk_categoryId"> 
<?php

$fk_categoryId="";
while($category = $categoryQuery->fetch()) { 
if ($category['categoryId'] == $fk_categoryId) { 
//The category is currently associated to the movie, select it by default 
echo "<option value=\"{$category['categoryId']}\" selected>{$category['categoryName']}</option>"; 
} else { 
//The category is not currently associated to the movie 
echo "<option value=\"{$category['categoryId']}\">{$category['categoryName']}</option>"; 
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


