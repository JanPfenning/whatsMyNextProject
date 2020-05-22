<?php

if(isset($_REQUEST['id'])){
    $id = $_REQUEST['id'];
    $queryStr = "select * from groupe as g 
            inner join topic as t
            on t.id = g.topic_id
            where t.id = $id";
}

?>