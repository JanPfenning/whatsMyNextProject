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
    $IDvalue = 1;
    // $result = mysqli_query($conn, "select * from Projekt where ProjektID = $IDvalue");
    /*if no 'action' default is get*/
    if(!isset($_GET["action"]) || $_GET["action"] == "get"){
        if(isset($_GET["ProjektID"])){
            $IDvalue = $_GET["ProjektID"];
            $result = mysqli_query($conn, "select * from Projekt where ProjektID = $IDvalue");
            $BackgroundURL = mysqli_query($conn, "select BackgroundURL from Bereich as b join Gruppe as g on b.BereichID = g.BereichID join Projekt as p on p.GruppeID = g.GruppeID where p.ProjektID = $IDvalue"); 
            $BackgroundURLtext = mysqli_fetch_array($BackgroundURL);
            printXML("Projekt", $result, $conn, $IDvalue, "/../../../fe/xslt/detailview.xsl", $BackgroundURLtext["BackgroundURL"]);
        }else{
            toErrorPage('No ID given for which Details where requested');
        }
    }
    else{
        toErrorPage('only GET allowed');
    }



?>
