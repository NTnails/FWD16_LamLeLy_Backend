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
 * Vi vill ta emot resultatet från föregående sida och med $_GET ta emot id för
 * den raden vi ska redigera
*/
$idfilm = $_GET['idfilm'];

/*
 * vi använder värdet på id från föregående sida som vi fick från get och 
 * skriver en sql fråga där vi använder :id för vara basis för en where fråga.
 * Vi vill alltså bara presentera ett enskild filmtitlet baserat på den film id vi
 * sprarade från raden från förra sidan.
 */
$sql = "SELECT * FROM film WHERE idfilm=:idfilm"; 
$query = $pdo->prepare($sql); 
$query->execute(array(':idfilm' => $idfilm)); 
/*
 * Resultatet av nedanstående kod kommer vi fylla ut i en html forumlär längre
 * ner på sidan. 
*/
while($row = $query->fetch()) 
{ 
$title = $row['title']; 
$fl_iddirector = $row['fl_iddirector']; 
}

/*
 * På redigerings sidan så kommer vi se en textruta för en enskild filmtitlet.
 * Vi vill däremot inte att användaren ska behöva skriva en fl_iddirector för
 * skämtet. Förutom att möjligheten till misstförstånd blir större att hålla 
 * koll pa en siffra så försämrar det avsevärt användarupplevelsen.
 * Vi skapar en seperat fråga som kommer vara basis för en dropdown senare i 
 * html formuläret
*/
$directorSql = "SELECT * FROM director"; 
$directorQuery = $pdo->prepare($directorSql); 
$directorQuery->execute();


?> 
<?php 

/*
 * vi kontrollerar om vi har tryckt på uppdatera knappen som har namnet update
 * i formuläret, i så fall så lagrar vi id och fälten filmtitle och fl_iddirector i 
 * respektive variabel, som ska finnas i vår db tabell.
*/
if(isset($_POST['update'])) 
{ 
$idfilm = $_POST['idfilm']; 

$title=$_POST['title']; 
$fl_iddirector=$_POST['fl_iddirector']; 


// checking empty fields

if(empty($title) || empty($fl_iddirector)) { 

if(empty($title)) { 
echo "<font color='red'>Name field is empty.</font><br/>"; 
} 

if(empty($fl_iddirector)) { 
echo "<font color='red'>Director field is empty.</font><br/>"; 
} 


} else { 
/*
 * vi använder sql syntaxen för uppdateringar och skickar med id för raden.
 * OBS att man i PDO använder platshållare (title=:title) där :title är
 * namnet på platshållaren för att para ihop det som finns i  formuläret till
 *  databasen. Detta läggs till i variablen $sql
*/

$sql = "UPDATE film SET title=:title, fl_iddirector=:fl_iddirector WHERE idfilm=:idfilm";

/*
 * vi använder pdo objektets prepare metod som tar $sql som argument och sparar
 * resultaet i variabeln $query
*/
$query = $pdo->prepare($sql); 
/*Sedan binder vi det som finns i platshållaren till variabeln*/
$query->bindparam(':idfilm', $idfilm); 
$query->bindparam(':title', $title); 
$query->bindparam(':fl_iddirector', $fl_iddirector);
//vi använder det som nu finns i $query för att köra sql frågan 
$query->execute(); 

// Alternative to above bindparam and execute 
// $query->execute(array(':id' => $id, ':title' => $title)); 

//header används för att skicka tillbaka efter proccesn är klart till en sida
header("Location: index.php"); 
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
<title></title> 
</head> 
<body> 
<a href="index.php">Home</a> 
<br/><br/> 

<form name="form1" method="post" action="edit.php"> 
<table border="0"> 
<tr> 
<td>Film</td> 
<!-- Resultatet av vår sql fråga från rad34 lägger vi en textarea, man kan alltid
blanda html och php som ni ser, genom att flika in php taggar som start och slut-->
<td><textarea name="title" rows="6" cols="40" ><?php echo $title;?></textarea></td>
</tr> 
<tr> 
<td>Director</td> 
<td>
<!-- För att användare inte ska behöva stoppa in siffror för en fl_iddirector så skapar
vi en dropdown, där resultatet av sql frågan från rad 47 $directorQuery stoppar in
i $author-->    
<select name="fl_iddirector"> 
<?php 
while($director = $directorQuery->fetch()) { 
if ($director['iddirector'] == $fl_iddirector) { 
/*
 * Vi använder id som vi har för att, som defualt visa den director som var
 * kopplat till ett viss skämt vald från föregående sida.
*/ 
echo "<option value=\"{$director['iddirector']}\" selected>{$director['name']}</option>"; 
} else { 
/*
 * Skulle vi däremot vilj ändra director till nåt annat det som vi fick från
 * förra sidan, så väljer vi det nu och också fångar upp id:et för den
 * director
*/ 
echo "<option value=\"{$director['iddirector']}\">{$director['name']}</option>"; 
} 
} 
?> 
</select> 
</td> 
</tr> 

<tr>
<!-- Vi visar inte id för den skämtet vi vill redigera -->    
<td><input type="hidden" name="idfilm" value=<?php echo $_GET['idfilm'];?></td> 
<td><input type="submit" name="update" value="Update"></td> 
</tr> 
</table> 
</form>
    </body>
</html>
