<?php

$path = getcwd();
require_once $path.'/../../../vault/dbConnection.php';

include $path.'/craftXML.php';
include $path.'/linkErrorpage.php';

/*Simulated Request*/
$IDvalue = 1;
// $result = mysqli_query($conn, "select ProjektViewLINK from ProjektlistView where GruppeID = $IDvalue");
// printXML("Projekte", $result, $conn, $IDvalue);
/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    if(isset($_GET["GruppeID"])){
        $IDvalue = $_GET["GruppeID"];
        $result = mysqli_query($conn, "select ProjektViewLINK from ProjektlistView where GruppeID = $IDvalue");
        $BackgroundURL = mysqli_query($conn, "select BackgroundURL from Bereich as b join Gruppe as g on b.BereichID = g.BereichID where g.GruppeID = $IDvalue"); 
        $BackgroundURLtext = mysqli_fetch_array($BackgroundURL);
        printXML("Projekte", $result, $conn, $IDvalue, "/../../../fe/xslt/overview.xsl", $BackgroundURLtext["BackgroundURL"]);
    }else{
        error('No ID given for which Projects where requested');
    }
}
else{
    error('only GET allowed');
}



?>
