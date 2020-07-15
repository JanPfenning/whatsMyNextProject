<?php
    $path = getcwd();
    include "./linkErrorpage.php";
    $connfile = $path . '/../../../vault/dbConnection.php';
    if(file_exists($connfile)&&is_readable($connfile)){
        require_once $path . '/../../../vault/dbConnection.php';
    }else{
        //echo(implode(",",$_GET["materials"])."</br>");
        //echo(implode(",",$_GET["amount"]));
        toErrorPage("Failed to load required File");
        die();
    }
    $start = 0;
    $until = 10;
    for ($projectID = $start; $projectID <= $until; $projectID++) {
        $conn->query("DELETE FROM Materialliste WHERE MateriallisteID = $projectID;");
        $conn->query("DELETE FROM Werkzeugliste WHERE WerkzeuglisteID = $projectID;");
        $conn->query("DELETE FROM Tagliste WHERE TaglisteID = $projectID;");
        $conn->query("DELETE FROM Wertliste WHERE WertlisteID = $projectID;");
        $conn->query("DELETE FROM Bewertungliste WHERE BewertunglisteID = $projectID;");
        $conn->query("DELETE FROM Projekt WHERE ProjektID = $projectID;");
    }
    $conn->query("ALTER TABLE Projekt AUTO_INCREMENT = $start;");
?>