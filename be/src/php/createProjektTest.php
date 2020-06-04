<?php
    /*Basic requirements*/
    //$path = getcwd();
    //require_once $path.'/vault/dbConnection.php';
    include "./toString.php";
    if(!isset($_GET["action"]) || $_GET["action"] == "get"){
        /*Neccesary data for adding a Project*/
        $attributes = $_GET;
        if(true/*$attributes["UserName"]!=""
            &&$attributes["ProjektName"]!=''
            &&$attributes["Kurzbeschreibung"]!=''
            &&$attributes["Beschreibung"]!=''
            &&$attributes["GruppeID"]!=0*/
        )
        {
            /*$Gruppe = $attributes["GruppeID"];
            $Nickname = $attributes["UserName"];
            $ProjektName = $attributes["ProjektName"];
            $Kurzbeschreibung = $attributes["Kurzbeschreibung"];
            $Beschreibung = $attributes["Beschreibung"];*/
            $Gruppe = 1;
            $Nickname = 'XizTenS';
            $ProjektName = 'JS lernen';
            $Kurzbeschreibung = 'man lernt JS';
            $Beschreibung = 'man lernt js aber mit mehr worten';

            /*Get User if existing, else create user*/
            $NutzerID = getUserID($Nickname);

            /*Create project with basic information*/
            $sqliCreate = "INSERT INTO Projekt ('GruppeID','NutzerID','Name','Kurzbeschreibung','Beschreibung')"
                            ."VALUES ($Gruppe,$NutzerID,$ProjektName,$Kurzbeschreibung,$Beschreibung);";

            if ($conn->query($sqliCreate) === TRUE) {
                /*Insert additional data into the created resource*/
                $projektID = $conn->insert_id;

                $picture = $attributes["Bild"];
                if($picture!=''){
                    addPicture($picture,$Gruppe,$projektID);
                }

                $materials = $attributes['materials'];
                if(implode(',',$materials)!=''){
                    /*TODO create materiallink entry*/
                    foreach ($materials as $matKey){
                        $mat = $materials[$matKey];
                        $matID = getMat($mat);
                        $query = "INSERT INTO Materialliste (MateriallisteID,MaterialID) values($projektID,$matID)";
                    }
                }

                $tools = $attributes['tools'];
                if(implode(',',$tools)!=''){
                    /*TODO create toollink entry*/
                    foreach ($tools as $toolKey){
                        $tool = $tools[$toolKey];
                        $toolID = getTool($tool);
                        $query = "INSERT INTO Werkzeugliste (WerkzeuglisteID,WerkzeugID) values($projektID,$toolID)";
                    }
                }

                $tagArray = explode(',',$attributes['Taglist']);
                foreach ($tagArray as $tagKey){
                    $tag = $tagArray[$tagKey];
                    $tagID = getTag($tag);
                    $query = "INSERT INTO Tagliste (TaglisteID,TagID) values($projektID,$tagID)";
                }

                $matrix = $attributes['values'];
                $query = "INSERT INTO Wertliste (WertlisteID,Wert1,Wert2,Wert3,Wert4,Wert5,Wert6) 
                            values($projektID,$matrix[0],$matrix[1],$matrix[2],$matrix[3],$matrix[4],$matrix[5])";

                $query = "INSERT INTO Bwertungliste(BewertunglisteID,Stern1,Stern2,Stern3,Stern4,Stern5)
                            values($projektID,0,0,0,0,0)";

                /*TODO Kommentarbereich anlegen (muss vlt gar nicht beim erstellen passieren)*/
                //$commentArea = mysqli_query($conn, "INSERT INTO Kommentarliste (KommenntarlisteID) values ($projektID)");

                /*TODO Validate generated resource*/
                $result = mysqli_query($conn, "select * from Projekt where ProjektID = $projektID");
                $checkFile = tmpfile();
                /*TODO make this work*/
                file_put_contents($checkFile, strXML("Projekt", $result, $conn, $IDvalue, "../../../fe/xslt/detailview.xsl", ""));
                $schemaPath = "../xml/xmlschemaDetail.xml";
                $validator = new DomValidator($schemaPath);
                try {
                    $validated = $validator->validateFeeds(file_get_contents($checkFile));
                } catch (DOMException $e) {
                    /*TODO to Errorpage*/
                    echo "failed to validate resource";
                    /*TODO delete data*/
                    die();
                }

                if ($validated) {
                    //echo "Feed successfully validated";
                } else {
                    print_r($validator->displayErrors());
                    /*TODO delete row*/
                    echo "Created resource is not valid against the xsd";
                    die();
                }
            } else {
                /*TODO to Errorpage*/
                echo "Failed to create Project ".$conn->error;
                die();
            }
        }else{
            /*TODO to Errorpage*/
            echo 'Some Obligatory Values are Missing';
            die();
        }
    }else{
        echo 'Failed for reasons';
        die();
    }

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

    function getTag($tag){
        $sqliGetTag = $conn->query("Select TagName From Tag where TagName = $tag");
        if(mysqli_num_rows($sqliGetTag)==1){
            $row = mysqli_fetch_array($sqliGetTag);
            return($row["TagID"]);
        }else if(mysqli_num_rows($sqliGetTag)==0){
            $newTag = $conn->query("INSERT INTO Tag (TagName) VALUES($tag);");
            if(!$newTag){
                echo "cannot create new Tag";
                die();
            }else{
                return($conn->insert_id);
            }
        }else{
            echo "there are different Tags with the same Title, contact your administrator";
            die();
        }
    }

    function getMat($mat){
        $sqliGetMat = $conn->query("Select MaterialName From Material where MaterialName = $mat");
        if(mysqli_num_rows($sqliGetMat)==1){
            $row = mysqli_fetch_array($sqliGetMat);
            return($row["MaterialID"]);
        }else if(mysqli_num_rows($sqliGetMat)==0){
            $newMat = $conn->query("INSERT INTO Mat (MatName) VALUES($mat);");
            if(!$newMat){
                echo "cannot create new Mat";
                die();
            }else{
                return($conn->insert_id);
            }
        }else{
            echo "there are different Mats with the same Title, contact your administrator";
            die();
        }
    }

    function getTool($tool){
        $sqliGetTool = $conn->query("Select WerkzeugName From Tool where WerkzeugName = $tool");
        if(mysqli_num_rows($sqliGetTool)==1){
            $row = mysqli_fetch_array($sqliGetTool);
            return($row["WerkzeugID"]);
        }else if(mysqli_num_rows($sqliGetTool)==0){
            $newTool = $conn->query("INSERT INTO Werkzeug (WerkzeugName) VALUES($tool);");
            if(!$newTool){
                echo "cannot create new Tool";
                die();
            }else{
                return($conn->insert_id);
            }
        }else{
            echo "there are different Tools with the same Title, contact your administrator";
            die();
        }
    }

    function addPicture($Files,$Gruppe,$projektID){
        /*TODO correct path*/
        $uploads_dir = "../../../fe/img/$Gruppe/$projektID/";
        foreach ($Files["pictures"]["error"] as $key => $error) {
            if ($error == UPLOAD_ERR_OK) {
                $tmp_name = $Files["pictures"]["tmp_name"][$key];
                $name = $Files["pictures"]["titlePicture"][$key];
                move_uploaded_file($tmp_name, "$uploads_dir/$name");
                $sqliUpdate = "UPDATE Projekt SET 'BildURL'=$uploads_dir/$name where ProjektID = $projektID";
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