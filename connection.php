<?php
class Database{
    static $pdo=null;
    static function Connection(){
        if(self::$pdo==null){
            try{
                self::$pdo = new PDO("mysql:host=localhost;dbname=bms_ussd","root","");
                self::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
               // echo "Connected successfully";

            }
            catch(PDOException $e){
                echo "Connection failed: ". $e->getMessage();
            }
        }
        return self::$pdo;

    }
    
}
?>