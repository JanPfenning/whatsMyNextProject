<?php

$path = getcwd();
require_once $path.'/../../../vault/dbConnection.php';

include $path.'/craftXML.php';
/*Simulated Request*/
// $IDvalue = 1;
// $result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");
// printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupview.xsl");

/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    if(isset($_GET["BereichID"])){
        $IDvalue = $_GET["BereichID"];
        $result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");
        printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupview.xsl");
    }else{
        echo 'No ID given for which groups where requested';
        /*TODO Link errorpage*/
    }
}
else{
    /*TODO Link errorpage*/
}



?>
