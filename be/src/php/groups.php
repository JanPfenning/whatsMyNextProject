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
 
/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get") {
    if (isset($_GET["GruppeID"])) {
        $Gruppe = $_GET["GruppeID"];
        $query = $conn->prepare("select BereichID from Gruppe where GruppeID = ?");
        $query->bind_param("i", $Gruppe);
        $query->execute();
        $IDvalueText = mysqli_stmt_get_result($query);
        $IDvalue = mysqli_fetch_array($IDvalueText)["BereichID"];
        $query->close();
    } else if (isset($_GET["BereichID"])) {
        $IDvalue = $_GET["BereichID"];
    } else {
        toErrorPage('No ID given for which Projects where requested');
        die();
    }
    $query = $conn->prepare("select GruppeLINK from GruppeView where BereichID = ?");
    $query->bind_param("i", $IDvalue);
    $query->execute();
    $result = mysqli_stmt_get_result($query);
    $query->close();
 
    $BackgroundURL = $conn->prepare("select BackgroundURL from Bereich as b where b.BereichID = ?");
    $BackgroundURL->bind_param("i", $IDvalue);
    $BackgroundURL->execute();
    $BackgroundURLtext = mysqli_stmt_get_result($BackgroundURL);
    $BackgroundURL->close();
 
    printXML("Gruppen", $result, $conn, $IDvalue, "/../../../fe/xslt/groupSelection.xsl", mysqli_fetch_array($BackgroundURLtext)["BackgroundURL"], "groups");
}
else{
    toErrorPage('only GET allowed');
}
 
?>