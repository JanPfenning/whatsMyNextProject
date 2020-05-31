<?php

    $path = getcwd();
    require_once $path.'/../../../vault/dbConnection.php';

    include $path.'/craftXML.php';
    include $path.'linkErrorpage.php';
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
            error('No ID given for which Details where requested');
        }
    }
    else{
        error('only GET allowed');
    }



?>
