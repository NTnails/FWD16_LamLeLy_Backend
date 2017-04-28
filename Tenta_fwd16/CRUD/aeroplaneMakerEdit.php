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
$planeMakerID = $_GET['planeMakerID'];

/*
 * vi använder värdet på id från föregående sida som vi fick från get och 
 * skriver en sql fråga där vi använder :id för vara basis för en where fråga.
 * Vi vill alltså bara presentera ett enskild filmtitlet baserat på den films id vi
 * sprarade från raden från förra sidan.
 */
$sql = "SELECT * FROM plane_maker WHERE planeMakerID=:planeMakerID"; 
$query = $pdo->prepare($sql); 
$query->execute(array(':planeMakerID' => $planeMakerID)); 
/*
 * Resultatet av nedanstående kod kommer vi fylla ut i en html forumlär längre
 * ner på sidan. 
*/
while($row = $query->fetch()) 
{ 
$planeMakerID = $row['planeMakerID']; 
$planeMakerName = $row['planeMakerName']; 
}

/*
 * På redigerings sidan så kommer vi se en textruta för en enskild filmtitlet.
 * Vi vill däremot inte att användaren ska behöva skriva en fk_categoryId för
 * skämtet. Förutom att möjligheten till misstförstånd blir större att hålla 
 * koll pa en siffra så försämrar det avsevärt användarupplevelsen.
 * Vi skapar en seperat fråga som kommer vara basis för en dropdown senare i 
 * html formuläret
*/
$plane_makerSql = "SELECT * FROM plane_maker"; 
$plane_makerQuery = $pdo->prepare($plane_makerSql); 
$plane_makerQuery->execute(); 


?> 
<?php 

/*
 * vi kontrollerar om vi har tryckt på uppdatera knappen som har namnet update
 * i formuläret, i så fall så lagrar vi id och fälten filmtitle och fk_categoryId i 
 * respektive variabel, som ska finnas i vår db tabell.
*/
if(isset($_POST['update'])) 
{ 
$planeMakerID = $_POST['planeMakerID']; 

$planeMakerName=$_POST['planeMakerName']; 


// checking empty fields

if(empty($planeMakerID) || empty($planeMakerName)) { 

if(empty($planeMakerName)) { 
echo "<font color='red'>Name field is empty.</font><br/>"; 
} 




} else { 
/*
 * vi använder sql syntaxen för uppdateringar och skickar med id för raden.
 * OBS att man i PDO använder platshållare (movieName=:movieName) där :movieName är
 * namnet på platshållaren för att para ihop det som finns i  formuläret till
 *  databasen. Detta läggs till i variablen $sql
*/

$sql = "UPDATE plane_maker SET planeMakerName=:planeMakerName WHERE planeMakerID=:planeMakerID";

/*
 * vi använder pdo objektets prepare metod som tar $sql som argument och sparar
 * resultaet i variabeln $query
*/
$query = $pdo->prepare($sql); 
/*Sedan binder vi det som finns i platshållaren till variabeln*/
$query->bindparam(':planeMakerID', $planeMakerID); 
$query->bindparam(':planeMakerName', $planeMakerName); 

//vi använder det som nu finns i $query för att köra sql frågan 
$query->execute(); 

// Alternative to above bindparam and execute 
// $query->execute(array(':id' => $id, ':movieName' => $movieName)); 

//header används för att skicka tillbaka efter proccesn är klart till en sida
header("Location: aeroplaneMaker.php"); 
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
<a href="aeroplane.php">Home</a>  | <a href="aeroplaneMaker.php">Plane Maker</a>
<br/><br/>

<form name="form1" method="post" action="aeroplaneMakerEdit.php"> 
        <table  border="0">
<tr> 
<!-- Resultatet av vår sql fråga från rad34 lägger vi en textarea, man kan alltid
blanda html och php som ni ser, genom att flika in php taggar som start och slut-->
<td> 
<br>
Maker Name: 
<br><input type='text' name="planeMakerName" placeholder="<?php echo $planeMakerName;?> "> 
<br><br>
<input type="submit" name="update" value="update">
<br><br>
</td>
</tr> 
<tr>
<!-- Vi visar inte id för den skämtet vi vill redigera -->    
<input type="hidden" name="planeMakerID" value=<?php echo $_GET['planeMakerID'];?>
</tr> 
</table> 
</form>
<!--För att logga ut skickar vi användaren till en sida där sessionen avslutas
med session_destroy--> 
<a href="logout.php">Logout</a>
    </body>
</html>
