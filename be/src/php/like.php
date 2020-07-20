<?php
    $path = getcwd();

    include "./linkErrorpage.php";
    $connfile = $path . '/../../../vault/dbConnection.php';
    if(file_exists($connfile)&&is_readable($connfile)){
        require_once $path . '/../../../vault/dbConnection.php';
    }else{
        toErrorPage("Failed to load requiered File");
        die();
    }
    $attributes = $_POST;

    $projectID = $attributes["projectID"];
    $like = $attributes["like"];

    switch($like){
        case(1):
            $query = $conn->prepare("UPDATE Projekt SET 1Stern = 1Stern + 1 WHERE ProjektID = ?");
            break;
        case(2):
            $query = $conn->prepare("UPDATE Projekt SET 2Stern = 2Stern + 1 WHERE ProjektID = ?");
            break;
        case(3):
            $query = $conn->prepare("UPDATE Projekt SET 3Stern = 3Stern + 1 WHERE ProjektID = ?");
            break;
        case(4):
            $query = $conn->prepare("UPDATE Projekt SET 4Stern = 4Stern + 1 WHERE ProjektID = ?");
            break;
        case(5):
            $query = $conn->prepare("UPDATE Projekt SET 5Stern = 5Stern + 1 WHERE ProjektID = ?");
            break;
    }
    $query->bind_param("i", $projectID);
    $worked = $query->execute();

    if(!$worked){
        toErrorPage("Error: " . $conn->error."</br> Cannot like the project. Please contact the administrator");
        die();
    }else{
        header("Location:./detail.php?ProjektID=".$projectID);
    }
?>