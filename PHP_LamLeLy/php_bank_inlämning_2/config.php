<!-- config.php -->
<?php
$dbname = 'db1164707_LaHoal';
$hostname = '83.168.227.23';
$username = 'u1164707_LaHoal';
$password = 'f WY6n}:aP';
$options  = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'UTF8'");

try {
    $conn = new PDO("mysql:host=$hostname;dbname=$dbname;", $username, 
    $password, $options);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    /*** echo a message saying we have connected ***/
    //echo 'Connected to database.<br />';
}
catch(PDOException $e){
    // For debug purpose, shows all connection details
    echo 'Connection failed: '.$e->getMessage()."<br />";
      // Hide connection details.
    //echo 'Could not connect to database.<br />'); 
}
class bank {
    //Class variables
    public $accountFname;
    public $accountLname;
    public $accountName;
    private $accountBalance;
    public $Fname;
    
    // Constructor who manages instances using data retrieved from DB
    public function __construct() {
        // Convert Float Value to an Integer
        $this->accountBalance = round($this->accountBalance);
        // Fname gathers all necessary data from db and puts in a common variable
        $this->Fname = "{$this->accountFname} {$this->accountLname} has: {$this->accountName} with {$this->accountBalance} balance";
    }
}
?>
