<?php 
error_reporting(-1);

/*
 * HUR MAN KOMMER ÅT VARIABLER OCH METODER
 * Är man inne i en klass och ska komma åt variabler och metoder som ska bli
 * insanser av klassen, så använder man $this-> följd av namnet eller metoden.
 * 
 * Är man utanför klassen och arbetar med själva instansen, så kommer man åt
 * variabler och metoder genom instansnamnet-> följd av variabeln eller metoden.
 * 
 * Är det däremot så att man är inne i klassen och arbetar med enbart klass
 * objekten, saker som inte kommer bli instanser av själva klassen eller 
 * kontstanter eller statiska variabler eller metoder, så använder
 * self:: följ av det man vill nå i klassen.
 * 
 * Vill nå dessa utanför klassen så skriver man klassnamnet:: följd av den
 * statiska metoden tex. 
*/


	abstract class aircraft {
		
            /*Konstanter och statiska egenskaper, Konstanter måste sättas ett värde,
             som sen inte går att ändra på. 
             Statiska egenskaper går att ända men delas av alla instanser medans
             en variabel är unik för alla instanser av klassen*/
                const INFO = "Refueling charter<br><br>";
                static public $stat = "WARNINIG!!! Boggie 9 oclock, Angels 5<br><br>";


                /* Properties */
                
                //protected: enbart dem ärvda klasserna kan ärva den variabel och komma åt den
                protected $aircraftDesigntion;
        	protected $speed;
                protected $rang;
                protected $payload;


                
/*
 * Construct
 * En konstuktor använder för att objeket vi instanserar av en klass ska
 * ha en viss struktur och data. Den kan ta emot paramterar
 * OBS!!! Det viktiga är att dem arguemnt där vi sätter ett default värde,
 * i detta fall bal och lock, dem måste alltid sättas sist i argument strängen.
 * Man får betänka följande när det en konstruktor i abstraktklass. En
 * abstraktklass kan aldrig instanseras, därför kommer inte heller denna
 * konstruktor kunna användas rakt av.
 * Den måste kickas igång i barnklassen som ärver denna absraktaklass 
*/
                
    public function __construct( $aircraftDesigntion, $speed, $rang, $payload ) 
            {
	$this->aircraftDesigntion = $aircraftDesigntion;
        $this->speed = $speed;
        $this->rang = $rang;
	$this->payload = $payload;
            }


                /* Methods */
                
/* Class Level Methods (Static Method)*/
    static public function stat() {

/* $this-> används enbart för instans variabler eller metoder, 
för ej användas för att komma åt statiska klass metoder eller variabler,
för att komma åt konstanter eller statiska egenskaper eller 
statiska metoder använde man sig av self:: om du redan befinner
dig inom klassen som här */
        echo self::INFO;
        echo self::$stat;
                    
                }

	}