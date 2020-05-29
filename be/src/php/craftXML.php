<?php
    function resolveLink($columnName,$rootTable, $conn ){
        $table = str_replace("LINK","",$columnName);
        $linkPartner = str_replace("LINK", 'ID',$columnName);
        $linkValue = $rootTable.'ID';
        $queryString = "SELECT * FROM $table as t inner join $rootTable as r on r.$linkValue=t.$linkPartner";
        $result = mysqli_query($conn, $queryString);
        if(mysqli_num_rows($result)>0){
            printData($table,$result,$conn,$rootTable);
        }
    }

    function printData($parentTag, $data, $conn, $rootTable){
        while($row = mysqli_fetch_array($data)){
            $keys = array_keys($row);
            print("<".$parentTag.">");
            /*Für jede Spalte Tags mit Daten anlegen*/
            foreach($keys as $key){
                if(!is_numeric($key)){
                    $link = strpos($key, "Link");
                    //if needle doesnt exisit in substr comp with ==0 -> true -> no recursion
                    if($link == 0 || $key == $parentTag."ID"){
                        print("<".$key.">");
                        print($row[$key]);
                        print("</".$key.">");
                    //if needle Exists and is not at index 0 -> rekursion
                    }else{
                        if($key != $parentTag."ID"){
                            resolveLink($key, $rootTable, $conn);
                        }
                    }
                }
            }
            print("</".$parentTag.">");
        }
    }
    /*base strucutre of the needed XML document*/
    function printXML($parentTag, $data, $conn){
        header("Content-Type: text/xml");
        print('<?xml version="1.0" encoding="UTF-8"?>');
        /*TODO link correct xsl sheet*/
        /*print('<?xml-stylesheet type="text/xsl" href="../../../fe/xslt/topicview.xsl"?>');*/
        print("<dataset>");
        printData($parentTag, $data, $conn);
        print("</dataset>");
    }
?>
