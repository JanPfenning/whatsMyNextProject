<?php

    $path = getcwd();

    include $path.'/linkErrorpage.php';
    $connfile = $path.'/../../../vault/dbConnection.php';
    if(file_exists($connfile)&&is_readable($connfile)){
        require_once $path . '/../../../vault/dbConnection.php';
    }else{
        toErrorPage("Failed to load required File");
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

            // $result = mysqli_query($conn, "select * from Projekt where ProjektID = $IDvalue");
            
            $query = $conn->prepare("select * from Projekt where ProjektID = ?");
            $query->bind_param("i", $IDvalue);
            $query->execute();
            $result = mysqli_stmt_get_result ($query);
            $query->close();

            // $BackgroundURL = mysqli_query($conn, "select BackgroundURL from Bereich as b join Gruppe as g on b.BereichID = g.BereichID join Projekt as p on p.GruppeID = g.GruppeID where p.ProjektID = $IDvalue"); 

            $BackgroundURL = $conn->prepare("select BackgroundURL from Bereich as b join Gruppe as g on b.BereichID = g.BereichID join Projekt as p on p.GruppeID = g.GruppeID where p.ProjektID = ?");
            $BackgroundURL->bind_param("i", $IDvalue);
            $BackgroundURL->execute();
            $BackgroundURLtext = mysqli_stmt_get_result($BackgroundURL);
            $BackgroundURL->close();
            
            // $BackgroundURLtext = mysqli_fetch_array($BackgroundURL);
            
            // printXML("Projekt", $result, $conn, $IDvalue, "/../../../fe/xslt/detail.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"]);
            // printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupSelection.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"], "details");
            printXML("Projekt", $result, $conn, $IDvalue, "/../../../fe/xslt/detail.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"],"details");
            $conn->close();
        }else{
            toErrorPage('No ID given for which Details where requested');
        }
    }
    else{
        toErrorPage('only GET allowed');
    }



?>
