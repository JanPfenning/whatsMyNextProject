<?php

$path = getcwd();
require_once $path.'/../../../vault/dbConnection.php';

include $path.'/craftXML.php';
/*Simulated Request*/
$IDvalue = 1;
// $result = mysqli_query($conn, "select ProjektViewLINK from ProjektlistView where GruppeID = $IDvalue");
// printXML("Projekte", $result, $conn, $IDvalue);
/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    if(isset($_GET["GruppeID"])){
        $IDvalue = $_GET["GruppeID"];
        $result = mysqli_query($conn, "select ProjektViewLINK from ProjektlistView where GruppeID = $IDvalue");
        printXML("Projekte", $result, $conn, $IDvalue, "/../../../fe/xslt/overview.xsl");
    }else{
        echo 'No ID given for which Projects where requested';
        /*TODO Link errorpage*/
    }
}
else{
    /*TODO Link errorpage*/
}



?>
