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
            $query = $conn->prepare("UPDATE Bewertungliste SET Stern1 = Stern1 + 1 WHERE BewertunglisteID = ?");
            break;
        case(2):
            $query = $conn->prepare("UPDATE Bewertungliste SET Stern2 = Stern2 + 1 WHERE BewertunglisteID = ?");
            break;
        case(3):
            $query = $conn->prepare("UPDATE Bewertungliste SET Stern3 = Stern3 + 1 WHERE BewertunglisteID = ?");
            break;
        case(4):
            $query = $conn->prepare("UPDATE Bewertungliste SET Stern4 = Stern4 + 1 WHERE BewertunglisteID = ?");
            break;
        case(5):
            $query = $conn->prepare("UPDATE Bewertungliste SET Stern5 = Stern5 + 1 WHERE BewertunglisteID = ?");
            break;
        default:
            toErrorPage("no valid like value given");
            die();
    }
    $query->bind_param("i", $projectID);
    $worked = $query->execute();
    $query->close();

    if(!$worked){
        toErrorPage("Error: " . $conn->error."</br> Cannot like the project. Please contact the administrator");
        die();
    }else{
        header("Location:./detail.php?ProjektID=".$projectID);
    }
?>