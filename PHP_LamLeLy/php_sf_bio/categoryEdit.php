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
$categoryId = $_GET['categoryId'];

/*
 * vi använder värdet på id från föregående sida som vi fick från get och 
 * skriver en sql fråga där vi använder :id för vara basis för en where fråga.
 * Vi vill alltså bara presentera ett enskild filmtitlet baserat på den films id vi
 * sprarade från raden från förra sidan.
 */
$sql = "SELECT * FROM category WHERE categoryId=:categoryId"; 
$query = $pdo->prepare($sql); 
$query->execute(array(':categoryId' => $categoryId)); 
/*
 * Resultatet av nedanstående kod kommer vi fylla ut i en html forumlär längre
 * ner på sidan. 
*/
while($row = $query->fetch()) 
{ 
$categoryId = $row['categoryId']; 
$categoryName = $row['categoryName']; 
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
$categoryId = $_POST['categoryId']; 

$categoryName=$_POST['categoryName']; 


// checking empty fields

if(empty($categoryId) || empty($categoryName)) { 

if(empty($categoryName)) { 
echo "<font color='red'>Name field is empty.</font><br/>"; 
} 




} else { 
/*
 * vi använder sql syntaxen för uppdateringar och skickar med id för raden.
 * OBS att man i PDO använder platshållare (movieName=:movieName) där :movieName är
 * namnet på platshållaren för att para ihop det som finns i  formuläret till
 *  databasen. Detta läggs till i variablen $sql
*/

$sql = "UPDATE category SET categoryName=:categoryName WHERE categoryId=:categoryId";

/*
 * vi använder pdo objektets prepare metod som tar $sql som argument och sparar
 * resultaet i variabeln $query
*/
$query = $pdo->prepare($sql); 
/*Sedan binder vi det som finns i platshållaren till variabeln*/
$query->bindparam(':categoryId', $categoryId); 
$query->bindparam(':categoryName', $categoryName); 

//vi använder det som nu finns i $query för att köra sql frågan 
$query->execute(); 

// Alternative to above bindparam and execute 
// $query->execute(array(':id' => $id, ':movieName' => $movieName)); 

//header används för att skicka tillbaka efter proccesn är klart till en sida
header("Location: category.php"); 
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

<form name="form1" method="post" action="categoryEdit.php"> 
        <table  border="0">
<tr> 
<!-- Resultatet av vår sql fråga från rad34 lägger vi en textarea, man kan alltid
blanda html och php som ni ser, genom att flika in php taggar som start och slut-->
<td> 
<br>
<?php echo $categoryId;?>.  Category Name: <br><br>
<?php echo $categoryName;?> <br><input type='text' name="categoryName" > 
<br><br>
<input type="submit" name="update" value="update">
<br><br>
</td>
</tr> 
<tr>
<!-- Vi visar inte id för den skämtet vi vill redigera -->    
<input type="hidden" name="categoryId" value=<?php echo $_GET['categoryId'];?>
</tr> 
</table> 
</form>
<!--För att logga ut skickar vi användaren till en sida där sessionen avslutas
med session_destroy--> 
<a href="logout.php">Logout</a>
    </body>
</html>
