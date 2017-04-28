<?php

require_once ("aircraft.php");
require_once ("interface.php");
error_reporting(-1);

//skapa klass som implimentera interfacet
                                 /* interface */
class Interceptor extends aircraft implements i_Texaco{
    //use trait
    use tr_Texaco;
    
    public $missiles;
    
    public function __construct($missiles, $aircraftDesigntion, $speed, $rang, $payload ) {
        $this->missiles = $missiles;
        parent::__construct($aircraftDesigntion, $speed, $rang, $payload );
    }
}
          
		  /* interface */
class Bomber extends aircraft implements i_Texaco {
    /* trait */
    use tr_Texaco;
    
    public $bombs;
    
    public function __construct($bomber, $aircraftDesigntion, $speed, $rang, $payload ) {
        
        $this->bombs = $bomber;
        // :: är när klasser kommunicerar med varandra
        parent::__construct($aircraftDesigntion, $speed, $rang, $payload );  
} 
}

