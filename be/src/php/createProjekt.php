<?php
    $path = getcwd();
    require_once $path.'/vault/dbConnection.php';
    $sqliCreate = "INSERT INTO Projekt ('GruppeID','NutzerID','Name','Kurzbeschreibung','Beschreibung') VALUES (1,1,'Rasen mähen','Man mäht den Rasen','Kürzen des GRAS im Gaten')";
    $sqliUpdate = "UPDATE Projekt SET() WHERE ProjektID = IDENT_CURRENT('Projekt').ProjektID";
?>