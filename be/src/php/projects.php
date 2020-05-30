<?php

$path = getcwd();
require_once $path.'/vault/dbConnection.php';

include $path.'/craftXML.php';
/*Simulated Request*/
//$IDvalue = 1;
//$result = mysqli_query($conn, "select 'ProjektID','Name','Kurzbeschreibung' from Projekt where GruppeID = $IDvalue");
/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    if(isset($_GET["gruppenID"])){
        $IDvalue = $_GET["gruppenID"];
        $result = mysqli_query($conn, "select 'ProjektID','Name','Kurzbeschreibung' from Projekt where GruppeID = $IDvalue");
        printXML("Projekt", $result, $conn, $IDvalue);
    }else{
        echo 'No ID given for which Projects where requested';
        /*TODO Link errorpage*/
    }
}
else{
    /*TODO Link errorpage*/
}



?>
