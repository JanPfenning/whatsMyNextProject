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

/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    $result = mysqli_query($conn, "select BereichLINK from BereichView");
    printXML("Bereiche", $result, $conn, 0,"/../../../fe/xslt/topicview.xsl", "/../../../fe/img/landingPage.png");
}
else{
    toErrorPage("only GET allowed");
}



?>
