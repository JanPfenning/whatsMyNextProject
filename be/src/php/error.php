<?php
header("Content-Type: text/xml");
print('<?xml version="1.0" encoding="UTF-8"?>');
print('<?xml-stylesheet type="application/xml" href="/../../../fe/xslt/error.xsl"?>');
print('<!DOCTYPE dataset SYSTEM "https://expensive.click/be/src/dtd/error.dtd">');
print('<dataset xmlns="http://expensive.click/be/src/dtd/error.dtd">');
print('<Errormessage>'.$err.'</Errormessage>');
print('</dataset>');
?>