<?php
    function followID($id, $idValue, $conn){
        $table = str_replace("id","",$id);
        /*TODO ordanary Query*/
        $queryString = "SELECT * FROM Projekt where PrID = 1".$table;
        $result = mysqli_query($conn, $queryString);
    }

    function printData($parentTag, $data, $conn){
        while($row = mysqli_fetch_array($data)){
            $keys = array_keys($row);
            print("<".$parentTag.">");
            /*Für jede Spalte Tags mit Daten anlegen*/
            foreach($keys as $key){
                if(!is_numeric($key)){
                    $idPos = strpos($key, "id");
                    if($idPos == 0 || $key == $parentTag."id"){
                        print("<".$key.">");
                        print($row[$key]);
                        print("</".$key.">");
                    }else{
                        if($key != $parentTag."id"){
                            followId($key, $row[$key], $conn);
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
        //xslt preparation
 /*       $xslt = new xsltProcessor;
        $dom = new DOMDocument();
        $dom->load("../../../fe/xslt/detailview.xsl");
        $xslt->importStylesheet($dom);
        $xmlData="";
        $dom->loadXML($xmlData);
        print $xslt->transformToXml($dom);
*/      print("<dataset>");
        printData($parentTag, $data, $conn);
        print("</dataset>");
    }
?>
