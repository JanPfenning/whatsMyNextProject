<!--https://www.w3schools.com/xml/xsl_server.asp-->
<?php

// Load XML file
$xml = new DOMDocument;
$xml->load('../xml/data.xml');

// Load XSL file
$xsl = new DOMDocument;
$xsl->load('../../../fe/xslt/overview.xsl');

// Configure the transformer
$proc = new XSLTProcessor;

// Attach the xsl rules
$proc->importStyleSheet($xsl);

echo $proc->transformToXML($xml);

?>