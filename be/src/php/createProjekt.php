<?php
    /*Basic requirements*/
    $path = getcwd();
    require_once $path.'/vault/dbConnection.php';
    /**/
    if(!isset($_GET["action"]) || $_GET["action"] == "get"){
        /*Neccesary data for adding a Project*/
        if(isset($_GET["GruppeID"])
            &&isset($_GET["Nickname"])
            &&isset($_GET["Name"])
            &&isset($_GET["Kurzbeschreibung"])
            &&isset($_GET["Beschreibung"])
        ){
            $Gruppe = $_GET["GruppeID"];
            $NutzerID = $_GET["NutzerID"];
            $ProjektName = $_GET["Name"];
            $Kurzbeschreibung = $_GET["Kurzbeschreibung"];
            $Beschreibung = $_GET["Beschreibung"];
            $sqliCreate = "INSERT INTO Projekt ('GruppeID','NutzerID','Name','Kurzbeschreibung','Beschreibung')"
                            ."VALUES ($Gruppe,$NutzerID,$ProjektName,$Kurzbeschreibung,$Beschreibung)";
        }else{
            /*TODO to Errorpage*/
            echo 'Some Values are Missing';
            die();
        }
        /*TODO Bilder beim erstellen einfügen
        if(isset($_GET["ImageURL"])){
            $BildURL = $_GET["ImageURL"];
            $sqliUpdate = "UPDATE Projekt SET 'BildURL'=$BildURL";
        }
        */
        $sqliCreateMaterialliste = "INSERT INTO Materialliste('MateriallisteID','MaterialID') VALUES(IDENT_CURRENT('Projekt').ProjektID, ID)";
    }else{
        echo 'Failed for reasons';
    }

    /*TODO check new input with select against xsd*/

    $validator = new DomValidator;
    $validated = $validator->validateFeeds('sample.xml');
    if ($validated) {
        echo "Feed successfully validated";
    } else {
        print_r($validator->displayErrors());
    }

    ?>