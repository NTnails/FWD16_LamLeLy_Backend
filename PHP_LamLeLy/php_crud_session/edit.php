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
$idfilms = $_GET['idfilms'];

/*
 * vi använder värdet på id från föregående sida som vi fick från get och 
 * skriver en sql fråga där vi använder :id för vara basis för en where fråga.
 * Vi vill alltså bara presentera ett enskild filmtitlet baserat på den films id vi
 * sprarade från raden från förra sidan.
 */
$sql = "SELECT * FROM films WHERE idfilms=:idfilms"; 
$query = $pdo->prepare($sql); 
$query->execute(array(':idfilms' => $idfilms)); 
/*
 * Resultatet av nedanstående kod kommer vi fylla ut i en html forumlär längre
 * ner på sidan. 
*/
while($row = $query->fetch()) 
{ 
$title = $row['title']; 
$description = $row['description']; 
$duration = $row['duration']; 
$rating = $row['rating']; 
$date = $row['date']; 
$fl_iddirectors = $row['fl_iddirectors']; 
}

/*
 * På redigerings sidan så kommer vi se en textruta för en enskild filmtitlet.
 * Vi vill däremot inte att användaren ska behöva skriva en fl_iddirectors för
 * skämtet. Förutom att möjligheten till misstförstånd blir större att hålla 
 * koll pa en siffra så försämrar det avsevärt användarupplevelsen.
 * Vi skapar en seperat fråga som kommer vara basis för en dropdown senare i 
 * html formuläret
*/
$directorsSql = "SELECT * FROM directors"; 
$directorsQuery = $pdo->prepare($directorsSql); 
$directorsQuery->execute();


?> 
<?php 

/*
 * vi kontrollerar om vi har tryckt på uppdatera knappen som har namnet update
 * i formuläret, i så fall så lagrar vi id och fälten filmtitle och fl_iddirectors i 
 * respektive variabel, som ska finnas i vår db tabell.
*/
if(isset($_POST['update'])) 
{ 
$idfilms = $_POST['idfilms']; 

$title=$_POST['title']; 
$description=$_POST['description']; 
$duration=$_POST['duration']; 
$rating=$_POST['rating']; 
$date=$_POST['date']; 

$fl_iddirectors=$_POST['fl_iddirectors']; 


// checking empty fields

if(empty($title) || empty($fl_iddirectors)) { 

if(empty($title)) { 
echo "<font color='red'>Name field is empty.</font><br/>"; 
} 

if(empty($fl_iddirectors)) { 
echo "<font color='red'>Director field is empty.</font><br/>"; 
} 


} else { 
/*
 * vi använder sql syntaxen för uppdateringar och skickar med id för raden.
 * OBS att man i PDO använder platshållare (title=:title) där :title är
 * namnet på platshållaren för att para ihop det som finns i  formuläret till
 *  databasen. Detta läggs till i variablen $sql
*/

$sql = "UPDATE films SET title=:title, description=:description, duration=:duration, rating=:rating, date=:date, fl_iddirectors=:fl_iddirectors WHERE idfilms=:idfilms";

/*
 * vi använder pdo objektets prepare metod som tar $sql som argument och sparar
 * resultaet i variabeln $query
*/
$query = $pdo->prepare($sql); 
/*Sedan binder vi det som finns i platshållaren till variabeln*/
$query->bindparam(':idfilms', $idfilms); 
$query->bindparam(':title', $title); 
$query->bindparam(':description', $description); 
$query->bindparam(':duration', $duration); 
$query->bindparam(':rating', $rating); 
$query->bindparam(':date', $date); 
$query->bindparam(':fl_iddirectors', $fl_iddirectors);
//vi använder det som nu finns i $query för att köra sql frågan 
$query->execute(); 

// Alternative to above bindparam and execute 
// $query->execute(array(':id' => $id, ':title' => $title)); 

//header används för att skicka tillbaka efter proccesn är klart till en sida
header("Location: welcome.php"); 
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
<meta charset="UTF-8"> 
<title>Edit input text</title> 
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

<form name="form1" method="post" action="edit.php"> 
<table border="0"> 
<tr> 
<!-- Resultatet av vår sql fråga från rad34 lägger vi en textarea, man kan alltid
blanda html och php som ni ser, genom att flika in php taggar som start och slut-->
<td>
Title <br><input type='text' name="title" > <?php echo $title;?>
<br><br>
Description <br><input type='text' name="description" > <?php echo $description;?>
<br><br>
Duration: min <br><input type='number' name="duration" > <?php echo $duration;?>
<br><br>
Rating: *** <br><input type='text' name="rating" > <?php echo $rating;?>
<br><br>
Date <br><input type='date' name="date" > <?php echo $date;?>
<br><br>
</td>
</tr> 
<tr> 
<td>Director</td> 
<td>
<!-- För att användare inte ska behöva stoppa in siffror för en fl_iddirectors så skapar
vi en dropdown, där resultatet av sql frågan från rad 47 $directorQuery stoppar in
i $author-->    
<select name="fl_iddirectors"> 
<?php 
while($directors = $directorsQuery->fetch()) { 
if ($directors['iddirectors'] == $fl_iddirectors) { 
/*
 * Vi använder id som vi har för att, som defualt visa den directors som var
 * kopplat till ett viss skämt vald från föregående sida.
*/ 
echo "<option value=\"{$directors['iddirectors']}\" selected>{$directors['name']}</option>"; 
} else { 
/*
 * Skulle vi däremot vilj ändra directors till nåt annat det som vi fick från
 * förra sidan, så väljer vi det nu och också fångar upp id:et för den
 * directors
*/ 
echo "<option value=\"{$directors['iddirectors']}\">{$directors['name']}</option>"; 
} 
} 
?> 
</select> 
</td> 
</tr> 

<tr>
<!-- Vi visar inte id för den skämtet vi vill redigera -->    
<td><input type="hidden" name="idfilms" value=<?php echo $_GET['idfilms'];?></td> 
<td><input type="submit" name="update" value="Update"></td> 
</tr> 
</table> 
</form>
<!--För att logga ut skickar vi användaren till en sida där sessionen avslutas
med session_destroy--> 
<a href="logout.php">Logout</a>
    </body>
</html>
