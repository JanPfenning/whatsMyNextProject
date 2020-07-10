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
// $IDvalue = 1;
// $result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");
// printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupview.xsl");

/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    if(isset($_GET["BereichID"])){
        $IDvalue = $_GET["BereichID"];

        // $result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");

        $query = $conn->prepare("select GruppeLINK from GruppeView where BereichID = ?");
        $query->bind_param("i", $IDvalue);
        $query->execute();
        $result = mysqli_stmt_get_result ($query);
        $query->close();

        // $BackgroundURL = mysqli_query($conn, "select BackgroundURL from Bereich as b where b.BereichID = $IDvalue"); 
        // $BackgroundURLtext = mysqli_fetch_array($BackgroundURL);

        $BackgroundURL = $conn->prepare("select BackgroundURL from Bereich as b where b.BereichID = ?");
        $BackgroundURL->bind_param("i", $IDvalue);
        $BackgroundURL->execute();
        $BackgroundURLtext = mysqli_stmt_get_result($BackgroundURL);
        $BackgroundURL->close();

        printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupSelection.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"]);
        //printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupSelection.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"],"groups");
    }else if(isset($_GET["GruppeID"])){

        $Gruppe = $_GET["GruppeID"];
        $query = $conn->prepare("select BereichID from Gruppen where GruppeID = ?");
        $query->bind_param("i", $Gruppe);
        $query->execute();
        $IDvalue = mysqli_stmt_get_result ($query);
        $query->close();;

        // $result = mysqli_query($conn, "select GruppeLINK from GruppeView where BereichID = $IDvalue");

        $query = $conn->prepare("select GruppeLINK from GruppeView where BereichID = ?");
        $query->bind_param("i", $IDvalue);
        $query->execute();
        $result = mysqli_stmt_get_result ($query);
        $query->close();

        // $BackgroundURL = mysqli_query($conn, "select BackgroundURL from Bereich as b where b.BereichID = $IDvalue");
        // $BackgroundURLtext = mysqli_fetch_array($BackgroundURL);

        $BackgroundURL = $conn->prepare("select BackgroundURL from Bereich as b where b.BereichID = ?");
        $BackgroundURL->bind_param("i", $IDvalue);
        $BackgroundURL->execute();
        $BackgroundURLtext = mysqli_stmt_get_result($BackgroundURL);
        $BackgroundURL->close();

        printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupSelection.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"]);
        //printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupSelection.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"],"groups");
        $conn->close();
    }else{
        toErrorPage('No ID given for which Projects where requested');
    }
}
else{
    toErrorPage('only GET allowed');
}



?>
