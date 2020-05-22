<!--https://www.w3schools.com/xml/xsl_server.asp-->
<?php

if(isset($_REQUEST['id'])){
    $id = $_REQUEST['id'];
    $queryStr = "select * from project as p 
            inner join material as m
            on p.id = m.project_id
            where p.id = $id";
}

?>