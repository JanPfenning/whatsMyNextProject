<?php

    /*$id = $_REQUEST['id'];
    $queryStr = "select * from topic as t";*/
$xslt = new xsltProcessor;
$dom = new DOMDocument();
$dom->load("../../../fe/xslt/topicview.xsl");
$xslt->importStylesheet($dom);
$xmlData ='<dataset>
<topics>
        <topic id="1">
            <name>Audio und Hifi</name>
            <color>red</color>
            <groups>
                <group id="1">
                    <name>Einstieg</name>
                </group>
                <group id="2">
                    <name>Nutzvoll</name>
                </group>
                <group id="3">
                    <name>Spielerisch</name>
                </group>
            </groups>
        </topic>
        <topic id="2">
            <name>Microcontroller</name>
            <color>blue</color>
            <groups>
                <group id="1">
                    <name>Einstieg</name>
                </group>
                <group id="2">
                    <name>Nutzvoll</name>
                </group>
                <group id="3">
                    <name>Spielerisch</name>
                </group>
            </groups>
        </topic>
        <topic id="3">
            <name>Schaltungen</name>
            <color>yellow</color>
            <groups>
                <group id="1">
                    <name>Einstieg</name>
                </group>
                <group id="2">
                    <name>Nutzvoll</name>
                </group>
                <group id="3">
                    <name>Spielerisch</name>
                </group>
            </groups>
        </topic>
        <topic id="4">
            <name>Holzarbeiten</name>
            <color>green</color>
            <groups>
                <group id="1">
                    <name>Einstieg</name>
                </group>
                <group id="2">
                    <name>Nutzvoll</name>
                </group>
                <group id="3">
                    <name>Spielerisch</name>
                </group>
            </groups>
        </topic>
        <topic id="5">
            <name>Metallarbeiten</name>
            <color>grey</color>
            <groups>
                <group id="1">
                    <name>Einstieg</name>
                </group>
                <group id="2">
                    <name>Nutzvoll</name>
                </group>
                <group id="3">
                    <name>Spielerisch</name>
                </group>
            </groups>
        </topic>
    </topics>
    </dataset>';
$dom->loadXML($xmlData);
print $xslt->transformToXml($dom);
