<?php
    /*Basic requirements*/
    $path = getcwd();
    require_once $path.'/vault/dbConnection.php';
    /**/
    if(!isset($_GET["action"]) || $_GET["action"] == "get"){
        /*Neccesary data for adding a Project*/
        if(isset($_POST["GruppeID"])
            &&isset($_POST["Nickname"])
            &&isset($_POST["Name"])
            &&isset($_POST["Kurzbeschreibung"])
            &&isset($_POST["Beschreibung"])
        ){
            $Gruppe = $_POST["GruppeID"];
            $Nickname = $_POST["Nickname"];
            $ProjektName = $_POST["Name"];
            $Kurzbeschreibung = $_POST["Kurzbeschreibung"];
            $Beschreibung = $_POST["Beschreibung"];
            /*Get User if existing, else create user*/
            $NutzerID = getUserID($Nickname);

            /*Create project with basic information*/
            $sqliCreate = "INSERT INTO Projekt ('GruppeID','NutzerID','Name','Kurzbeschreibung','Beschreibung')"
                            ."VALUES ($Gruppe,$NutzerID,$ProjektName,$Kurzbeschreibung,$Beschreibung);";
                            //."OUTPUT inserted.* SELECT 1;";

            /*Insert additional data into the created resource*/
            if ($conn->query($sqliCreate) === TRUE) {
                //echo "New record created successfully";
                $last_insert_id = $conn->insert_id;
                /*TODO BildURL einfügen*/
                /*if(isset($_FILES)){
                    addPicture($_FILES,$Gruppe,$last_insert_id);
                }*/
                /*TODO Materialliste einfügen*/
                /*TODO Wertliste einfügen*/
                /*TODO Tagliste einfügen*/
                /*TODO Werkzeugliste einfügen*/
                /*TODO Bewertungliste einfügen*/
                /*TODO Kommentarbereich einfügen*/

                /*Validate generated resource*/
                $result = mysqli_query($conn, "select * from Projekt where ProjektID = $last_insert_id");
                printXML("Projekt", $result, $conn, $IDvalue);
                /*todo into file which will be validated*/

                $validator = new DomValidator;
                $validated = $validator->validateFeeds('sample.xml');
                if ($validated) {
                    //echo "Feed successfully validated";
                } else {
                    print_r($validator->displayErrors());
                    /*TODO delete row*/
                    echo "Created resource is not valid against the xsd";
                }
            } else {
                /*TODO to Errorpage*/
                echo "Failed to create Project ".$conn->error;
            }
        }else{
            /*TODO to Errorpage*/
            echo 'Some Obligatory Values are Missing';
            die();
        }
    }else{
        echo 'Failed for reasons';
    }

    /*TODO check new input with select against xsd*/

    function getUserID($Nickname){
        $sqliGetNutzer = $conn->query("Select NutzerID From Nutzer where Nick = $Nickname");
        if(mysqli_num_rows($sqliGetNutzer)==1){
            $row = mysqli_fetch_array($sqliGetNutzer);
            return($row["NutzerID"]);
        }else if(mysqli_num_rows($sqliGetNutzer)==0){
            $newUser = $conn->query("INSERT INTO Nutzer (Nick) VALUES($Nickname);");
            if(!$newUser){
                echo "cannot create new user";
                die();
            }else{
                return($conn->insert_id);
            }
        }else{
            echo "there are two people with the same nickname, contact the administrator";
            die();
        }
    }

    function addPicture($Files,$Gruppe,$last_insert_id){
        $uploads_dir = "../../../fe/img/$Gruppe/$last_insert_id/";
        foreach ($Files["pictures"]["error"] as $key => $error) {
            if ($error == UPLOAD_ERR_OK) {
                $tmp_name = $Files["pictures"]["tmp_name"][$key];
                $name = $Files["pictures"]["titlePicture"][$key];
                move_uploaded_file($tmp_name, "$uploads_dir/$name");
                $sqliUpdate = "UPDATE Projekt SET 'BildURL'=$uploads_dir/$name where ProjektID = $last_insert_id";
                if($sqliUpdate){
                    //Picture uploaded
                }else{
                    echo "failed to insert picture";
                    die();
                }
            }
        }
    }

    ?>