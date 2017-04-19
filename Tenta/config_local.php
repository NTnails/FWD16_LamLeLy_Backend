<?php
/*
 * Vi vill i en prodtionsmiljö dölja error meddelande för användarna, men vi
 * själva ska kunna logga alla fel.
 * I utvecklnings miljön kan vi däremot sätta ini_set('display_errors', 1); 
*/
error_reporting(E_ALL);
ini_set('display_errors', 0);
ini_set('log_errors', 1);

/*
 * Vi sätter vår db koppling i en try catch för att fånga upp om nåt går fel,
 * $pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
 * 
 * den andra attributet låter oss slipa skriva vilket inhämtnings metod vi vill
 * använda oss av överallt i vår kod, i exemplet nedan har vi satt default till
 * FETCH_ASSOC så om vi normalt hade behövt skriva detta:
 * $author = $authorQuery->fetch(FETCH_ASSOC) så behöver vi bara skriva:
 * $author = $authorQuery->fetch()
 * 
 * ATTR_EMULATE_PREPARES, prepared statments inom PDO stöds inte av all databas
 * drivruntiner, sätter vi detta false så använder vi den inyggda funktionen för
 * detta.
*/
try {
    
        
    $pdo = new PDO('mysql:host=localhost; dbname=ijdb', 'root', 'root');
    $pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE,PDO::FETCH_ASSOC);
    $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES,false);
    
} catch (PDOException $e) {
    
    echo 'Connection failed: ' . $e->getMessage();
    
    die();
    
}

?>


