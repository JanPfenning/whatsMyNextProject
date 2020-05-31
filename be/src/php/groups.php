<?php

$path = getcwd();
require_once $path.'/../../../vault/dbConnection.php';

include $path.'/craftXML.php';
include $path.'linkErrorpage.php';

/*Simulated Request*/
// $IDvalue = 1;
// $result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");
// printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupview.xsl");

/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    if(isset($_GET["BereichID"])){
        $IDvalue = $_GET["BereichID"];
        $result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");
        $BackgroundURL = mysqli_query($conn, "select BackgroundURL from Bereich as b where b.BereichID = $IDvalue"); 
        $BackgroundURLtext = mysqli_fetch_array($BackgroundURL);
        printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupview.xsl",  $BackgroundURLtext["BackgroundURL"]);
    }else{
        error('No ID given for which Projects where requested');
    }
}
else{
    error('only GET allowed');
}



?>
