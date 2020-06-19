<?php

$path = getcwd();

include $path.'/linkErrorpage.php';
$connfile = $path.'/../../../vault/dbConnection.php';
if(file_exists($connfile)&&is_readable($connfile)){
    require_once $path . '/../../../vault/dbConnection.php';
}else{
    toErrorPage("Failed to load requiered File");
    die();
}
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
        $BackgroundURL = mysqli_query($conn, "select BackgroundURL from Bereich as b where b.BereichID = $IDvalue"); 
        $BackgroundURLtext = mysqli_fetch_array($BackgroundURL);
        printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupview.xsl",  $BackgroundURLtext["BackgroundURL"]);
    }else{
        toErrorPage('No ID given for which Projects where requested');
    }
}
else{
    toErrorPage('only GET allowed');
}



?>
