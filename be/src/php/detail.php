<?php

    $path = getcwd();
    require_once $path.'/../../../vault/dbConnection.php';

    include $path.'/craftXML.php';
    /*Simulated Request*/
    $IDvalue = 1;
    $result = mysqli_query($conn, "select * from Projekt where ProjektID = $IDvalue");
    /*if no 'action' default is get*/
    // if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    //     if(isset($_GET["projektID"])){
    //         $IDvalue = $_GET["projektID"];
    //         $result = mysqli_query($conn, "select * from Projekt where ProjektID = $IDvalue");
            printXML("Projekt", $result, $conn, $IDvalue);
    //     }else{
    //         echo 'No ID given for which Details where requested';
    //         /*TODO Link errorpage*/
    //     }
    // }
    // else{
    //     /*TODO Link errorpage*/
    // }



?>
