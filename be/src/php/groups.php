<?php

$path = getcwd();
require_once $path.'/../../../vault/dbConnection.php';

include $path.'/craftXML.php';
/*Simulated Request*/
$IDvalue = 1;
$result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");
printXML("Gruppen", $result, $conn, $IDvalue);

// /*if no 'action' default is get*/
// if(!isset($_GET["action"]) || $_GET["action"] == "get"){
//     if(isset($_GET["bereichID"])){
//         $IDvalue = $_GET["bereichID"];
//         $result = mysqli_query($conn, "select * from Gruppe where BereichID = $IDvalue");
//         printXML("Gruppen", $result, $conn, $IDvalue);
//     }else{
//         echo 'No ID given for which groups where requested';
//         /*TODO Link errorpage*/
//     }
// }
// else{
//     /*TODO Link errorpage*/
// }



?>
