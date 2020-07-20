<?php
header("Content-Type: text/xml");
print('<?xml version="1.0" encoding="UTF-8"?>');
print('<?xml-stylesheet type="application/xml" href="/../../../fe/xslt/create.xsl"?>');
print('<!DOCTYPE dataset SYSTEM "https://expensive.click/be/src/dtd/create.dtd">');
print('<dataset xmlns="http://expensive.click/be/src/dtd/create.dtd">');
print('<GruppeID>'.$_GET["GruppeID"].'</GruppeID>');
print('</dataset>');
?>
