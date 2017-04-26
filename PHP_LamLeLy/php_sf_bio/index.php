<?php
echo 'Current PHP version: ' . phpversion();
/*
 * Denna version som körs på servern är en för gammal version för att köra det
 * mycket säkrare password_hash()
 * Använd aldrig md5() som vi använder i detta exempel i produktknsmilö då det
 * anses för osäkert. 
 */
include_once("config.php");
//include_once("config_local.php");

/*
 * Vi använder sessions för att spåra våra använder på websidan
*/
session_start();

/*
 * Vi kontrollerar om nedan värden är fyllda i formuläret, om signup knappen
 * användes. 
*/
if(isset($_POST['signup'])){
 $name = $_POST['name'];
 $email = $_POST['email'];
 /*
  * OBS! Här använder vi md5 för att skicka in värden till lösenordet krypterat
  * till databasen, oavsett sträng så kommer detta omvandlas till en 35 tecken
  * lång krypterad sträng i databasen, denna krypterade sträng passar enbart till
  * den strängen ni valde att ha som lösenord.
 */
 $pass = md5($_POST['pass']);
 
$insert = $pdo->prepare("INSERT INTO users (name,email,pass)
values(:name,:email,:pass) ");
$insert->bindParam(':name',$name);
$insert->bindParam(':email',$email);
$insert->bindParam(':pass',$pass);
$insert->execute();
}elseif(isset($_POST['signin'])){
 $email = $_POST['email'];
 /*
  * Vid login så passerar vi den krypterade lösenordet tillbaks till databasen
 */
 $pass = md5($_POST['pass']);
 
 $select = $pdo->prepare("SELECT * FROM users WHERE email='$email' and pass='$pass'");
 $select->setFetchMode();
 $select->execute();
 $data=$select->fetch();
 /*
  * Om inloggningen inte fungerar
 */
 if($data['email']!=$email and $data['pass']!=$pass)
 {
  echo "invalid email or pass";
 }
 /*
  * Om inloggningen fungerade så sparar vi bla användarnamnet och skickar vidare
  * användare till den sidan vi vill att den härnäst ska gå till, i detta fall
  * welcome.php.
  * Där kommer vi hälsa användare med dennes användarnamn
 */
 elseif($data['email']==$email and $data['pass']==$pass)
 {
 $_SESSION['email']=$data['email'];
    $_SESSION['name']=$data['name'];
header("location:movie.php"); 
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
        <title>Credentials</title>
        <style>
		body {
    background-color: lightblue;
}
h1 {
    color: white;
    text-align: center;
}

p {
    font-family: verdana;
    font-size: 20px;
}
            .formContainer{
  display: flex;
  
}

.rightForm{
 padding:85px;
}

.leftForm{
 margin-left: auto;
 padding:85px;
}

        </style>
    </head>
    <body>
        <div class="formContainer">
  <div class="rightForm">
    <h1>Create Account Here</h1>
  <form method="post">
<input type="text" name="name" placeholder="User Name"><br><br>
<input type="text" name="email" placeholder="example@example.com"><br><br>
<input type="password" name="pass" placeholder="password"><br><br>

<input type="submit" name="signup" value="SIGN UP">
</form>
  </div>
  <div class="leftForm">
  <h1>Log In Here</h1>
<form method="post">
<input type="text" name="email" placeholder="example@example.com"><br><br>
<input type="password" name="pass" placeholder="password"><br><br>
<input type="submit" name="signin" value="SIGN IN">
</form>
  </div>
</div>
    </body>
</html>
