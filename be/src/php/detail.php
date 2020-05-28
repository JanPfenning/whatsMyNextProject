<?php

    $path = getcwd();
    require_once $path.'/vault/dbConnection.php';

    include $path.'/craftXML.php';
    $result = mysqli_query($conn, "select * from Projekt where PrID = 1");
    /*if no 'action' default is get*/
    if(!isset($_GET["action"]) || $_GET["action"] == "get"){
/*
        if(isset($_GET["projektID"])){
        }else{echo 'failed for reasons '; }
*/

        printXML("project", $result, $conn);
    }else if($_GET["action"] == "update"){
        /*TODO Update a project*/
    }
?>
