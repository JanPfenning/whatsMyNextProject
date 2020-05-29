<?php

    $path = getcwd();
    require_once $path.'/vault/dbConnection.php';

    include $path.'/craftXML.php';
    /*Simulated Request*/
    $IDvalue = 1;
    $result = mysqli_query($conn, "select * from Projekt where ProjektID = $IDvalue");
    /*if no 'action' default is get*/
    //if(!isset($_GET["action"]) || $_GET["action"] == "get"){
        //if(isset($_GET["projektID"])){
        //}else{echo 'failed for reasons '; }

        printXML("Projekt", $result, $conn, $IDvalue);
    //}else if($_GET["action"] == "update"){
        /*TODO Update a project*/
    //}
?>
