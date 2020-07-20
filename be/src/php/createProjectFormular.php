<?php
$xml= '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="application/xml" href="/../../../fe/xslt/create.xsl"?>
<!DOCTYPE dataset SYSTEM "https://expensive.click/be/src/dtd/create.dtd">
<dataset xmlns="http://expensive.click/be/src/dtd/create.dtd">
    <GruppeID>'.$_GET["GruppeID"].'</GruppeID>
</dataset>';
print($xml);
?>
