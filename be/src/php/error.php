<?php
$xml= '
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="application/xml" href="../../../fe/xslt/error.xsl"?>
<!DOCTYPE dataset SYSTEM "http://expensive.click/be/src/dtd/error.dtd">
<dataset xmlns="http:/expensive.click/be/src/dtd/error.dtd">
    <Errormessage>'.$err.'</Errormessage>
</dataset>
';
print($xml);
?>