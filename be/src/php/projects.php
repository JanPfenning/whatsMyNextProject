<!--https://www.w3schools.com/xml/xsl_server.asp-->
<?php

if(isset($_REQUEST['id'])){
    $id = $_REQUEST['id'];
    $queryStr = "select * from porject as p 
            inner join groupe as g
            on g.id = p.group_id
            where g.id = $id";
}

?>