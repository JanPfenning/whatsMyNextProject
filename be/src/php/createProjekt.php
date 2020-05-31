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
                            ."VALUES ($Gruppe,$NutzerID,$ProjektName,$Kurzbeschreibung,$Beschreibung)"
                            ."OUTPUT inserted.* SELECT 1;";
            if ($conn->query($sqliCreate) === TRUE) {
                //echo "New record created successfully";
                $last_insert_id = $conn->insert_id;
                /*TODO Bilder beim erstellen einfügen
                if(isset($_GET["ImageURL"])){
                    $BildURL = $_GET["ImageURL"];
                    $sqliUpdate = "UPDATE Projekt SET 'BildURL'=$BildURL";
                }
                */

                /*At the end*/
                $result = mysqli_query($conn, "select * from Projekt where ProjektID = $last_insert_id");
                printXML("Projekt", $result, $conn, $IDvalue);

                $validator = new DomValidator;
                $validated = $validator->validateFeeds('sample.xml');
                if ($validated) {
                    echo "Feed successfully validated";
                } else {
                    print_r($validator->displayErrors());
                }
            } else {
                //echo "Error: " . $sql . "<br>" . $conn->error;
            }

            $newID = "SELECT IDENT_CURRENT('Projekt').ProjektID";
        }else{
            /*TODO to Errorpage*/
            echo 'Some Values are Missing';
            die();
        }
    }else{
        echo 'Failed for reasons';
    }

    /*TODO check new input with select against xsd*/

    ?>