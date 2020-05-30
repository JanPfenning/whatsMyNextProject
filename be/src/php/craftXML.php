<?php
    function resolveLink($columnName,$IDvalue, $conn, $parentCon){
	$table = str_replace("LINK","",$columnName);
    $linkPartner = str_replace("LINK", 'ID',$columnName);;
    if($parentCon == ""){
        $queryString = "SELECT * FROM $table as t where $IDvalue = t.$linkPartner";
    }
    else{
        $queryString = "SELECT * FROM $table as t where $parentCon = t.$linkPartner";
    }
    //echo $queryString;
	$result = mysqli_query($conn, $queryString);
	if(mysqli_num_rows($result)>0){
        printData($table,$result,$conn,$IDvalue); //4. param could also be $parentCon dunno
    }
}

    function printData($parentTag, $data, $conn, $IDvalue){
        print("<".$parentTag.">");
        while($row = mysqli_fetch_array($data)){
            $keys = array_keys($row);
            /*Für jede Spalte Tags mit Daten anlegen*/
            foreach($keys as $key){
                if(!is_numeric($key)){
                    $link = strpos($key, "LINK");
                    $id = strpos($key, "ID");
                    //if needle doesnt exisit in substr comp with ==0 -> true -> no recursion
                    if($link == 0 && ($key == "GruppeID" || $key == "BereichID" || $key == "ProjektID" || $id == 0)){
			            print("<".$key.">");
                        print($row[$key]);
                        print("</".$key.">");
                    //if needle Exists and is not at index 0 -> rekursion
                    }else{
                        //print($key."-> ".$row[$key]);
                        resolveLink($key, $IDvalue, $conn, $row[$key]);
                    }
                }
            }
        }
        print("</".$parentTag.">");
    }
    /*base strucutre of the needed XML document*/
    function printXML($parentTag, $data, $conn, $IDvalue){
        header("Content-Type: text/xml");
        print('<?xml version="1.0" encoding="UTF-8"?>');
        /*TODO link correct xsl sheet*/
        /*print('<?xml-stylesheet type="text/xsl" href="../../../fe/xslt/topicview.xsl"?>');*/
        print("<dataset>");
        printData($parentTag, $data, $conn, $IDvalue);
        print("</dataset>");
    }
?>
