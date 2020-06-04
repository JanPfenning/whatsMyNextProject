<?php

$path = getcwd();
require_once $path.'/../../../vault/dbConnection.php';

include $path.'/craftXML.php';

/*if no 'action' default is get*/
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    $result = mysqli_query($conn, "select BereichLINK from BereichView");
    printXML("Bereiche", $result, $conn, 0,"/../../../fe/xslt/topicview.xsl", "/../../../fe/img/landingPage.png");
}
else{
    /*TODO Link errorpage*/
}



?>
