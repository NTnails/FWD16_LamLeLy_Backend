<?php 
// including the database connection file 
include_once("config.php");
//include_once("config_local.php");

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

/*
 * Vi vill ta emot resultatet från föregående sida och med $_GET ta emot id för
 * den raden vi ska redigera
*/
$movieId = $_GET['movieId'];

/*
 * vi använder värdet på id från föregående sida som vi fick från get och 
 * skriver en sql fråga där vi använder :id för vara basis för en where fråga.
 * Vi vill alltså bara presentera ett enskild filmtitlet baserat på den films id vi
 * sprarade från raden från förra sidan.
 */
$sql = "SELECT * FROM movie WHERE movieId=:movieId"; 
$query = $pdo->prepare($sql); 
$query->execute(array(':movieId' => $movieId)); 
/*
 * Resultatet av nedanstående kod kommer vi fylla ut i en html forumlär längre
 * ner på sidan. 
*/
while($row = $query->fetch()) 
{ 
$movieName = $row['movieName']; 
$movieDuration = $row['movieDuration']; 
$movieCopies = $row['movieCopies']; 
$fk_categoryId = $row['fk_categoryId']; 
}

/*
 * På redigerings sidan så kommer vi se en textruta för en enskild filmtitlet.
 * Vi vill däremot inte att användaren ska behöva skriva en fk_categoryId för
 * skämtet. Förutom att möjligheten till misstförstånd blir större att hålla 
 * koll pa en siffra så försämrar det avsevärt användarupplevelsen.
 * Vi skapar en seperat fråga som kommer vara basis för en dropdown senare i 
 * html formuläret
*/
$categorySql = "SELECT * FROM category"; 
$categoryQuery = $pdo->prepare($categorySql); 
$categoryQuery->execute(); 


?> 
<?php 

/*
 * vi kontrollerar om vi har tryckt på uppdatera knappen som har namnet update
 * i formuläret, i så fall så lagrar vi id och fälten filmtitle och fk_categoryId i 
 * respektive variabel, som ska finnas i vår db tabell.
*/
if(isset($_POST['update'])) 
{ 
$movieId = $_POST['movieId']; 

$movieName=$_POST['movieName']; 
$movieDuration=$_POST['movieDuration']; 
$movieCopies=$_POST['movieCopies']; 
$fk_categoryId=$_POST['fk_categoryId']; 


// checking empty fields

if(empty($movieName) || empty($fk_categoryId)) { 

if(empty($movieName)) { 
echo "<font color='red'>Name field is empty.</font><br/>"; 
} 

if(empty($fk_categoryId)) { 
echo "<font color='red'>Director field is empty.</font><br/>"; 
} 


} else { 
/*
 * vi använder sql syntaxen för uppdateringar och skickar med id för raden.
 * OBS att man i PDO använder platshållare (movieName=:movieName) där :movieName är
 * namnet på platshållaren för att para ihop det som finns i  formuläret till
 *  databasen. Detta läggs till i variablen $sql
*/

$sql = "UPDATE movie SET movieName=:movieName, movieDuration=:movieDuration, movieCopies=:movieCopies, fk_categoryId=:fk_categoryId WHERE movieId=:movieId";

/*
 * vi använder pdo objektets prepare metod som tar $sql som argument och sparar
 * resultaet i variabeln $query
*/
$query = $pdo->prepare($sql); 
/*Sedan binder vi det som finns i platshållaren till variabeln*/
$query->bindparam(':movieId', $movieId); 
$query->bindparam(':movieName', $movieName); 
$query->bindparam(':movieDuration', $movieDuration); 
$query->bindparam(':movieCopies', $movieCopies); 
$query->bindparam(':fk_categoryId', $fk_categoryId);
//vi använder det som nu finns i $query för att köra sql frågan 
$query->execute(); 

// Alternative to above bindparam and execute 
// $query->execute(array(':id' => $id, ':movieName' => $movieName)); 

//header används för att skicka tillbaka efter proccesn är klart till en sida
header("Location: movie.php"); 
} 
}  
?> 
<!DOCTYPE html> 
<!-- 
To change this license header, choose License Headers in Project Properties. 
To change this template file, choose Tools | Templates 
and open the template in the editor. 
--> 
<html> 
<head> 
  <title>Edit film</title> 

<meta charset="UTF-8"> 
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
<a href="movie.php">Home</a>  | <a href="category.php">Category</a>
<br/><br/>

<form name="form1" method="post" action="movieEdit.php"> 
        <table  border="0">
<tr> 
<!-- Resultatet av vår sql fråga från rad34 lägger vi en textarea, man kan alltid
blanda html och php som ni ser, genom att flika in php taggar som start och slut-->
<td> 
Title: <?php echo $movieName;?> <br><input type='text' name="movieName" > 
<br><br>
Duration: <?php echo $movieDuration;?> min <br><input type='text' name="movieDuration" > 
<br><br>
Copies:  <?php echo $movieCopies;?>  <br><input type='number' name="movieCopies" > 
</td>
</tr> 
<tr> 
<td>Category</td> 
<td>
<!-- För att användare inte ska behöva stoppa in siffror för en fk_categoryId så skapar
vi en dropdown, där resultatet av sql frågan från rad 47 $directorQuery stoppar in
i $author-->    
<select name="fk_categoryId"> 
<?php 
while($category = $categoryQuery->fetch()) { 
if ($category['categoryId'] == $fk_categoryId) { 
/*
 * Vi använder id som vi har för att, som defualt visa den category som var
 * kopplat till ett viss skämt vald från föregående sida.
*/ 
echo "<option value=\"{$category['categoryId']}\" selected>{$category['categoryName']}</option>"; 
} else { 
/*
 * Skulle vi däremot vilj ändra category till nåt annat det som vi fick från
 * förra sidan, så väljer vi det nu och också fångar upp id:et för den
 * category
*/ 
echo "<option value=\"{$category['categoryId']}\">{$category['categoryName']}</option>"; 
} 
} 
?> 
</select> 
</td> 
</tr> 

<tr>
<!-- Vi visar inte id för den skämtet vi vill redigera -->    
<td><input type="hidden" name="movieId" value=<?php echo $_GET['movieId'];?></td> 
<td><input type="submit" name="update" value="Update"></td> 
</tr> 
</table> 
</form>
<!--För att logga ut skickar vi användaren till en sida där sessionen avslutas
med session_destroy--> 
<a href="logout.php">Logout</a>
    </body>
</html>
