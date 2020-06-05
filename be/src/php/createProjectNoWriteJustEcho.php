<?php
/*Basic requirements*/
$path = getcwd();
include "./toString.php";
include "./DOMValidator.php";
include "./linkErrorpage.php";
$connfile = $path . '/../../../vault/dbConnection.php';
if(file_exists($connfile)&&is_readable($connfile)){
    require_once $path . '/../../../vault/dbConnection.php';
}else{
    //echo(implode(",",$_GET["materials"])."</br>");
    //echo(implode(",",$_GET["amount"]));
    toErrorPage("Failed to load required File");
    die();
}
if(!isset($_GET["action"]) || $_GET["action"] == "get"){
    /*Neccesary data for adding a Project*/
    $attributes = $_GET;
    echo implode(",",$attributes);
    if($attributes["UserName"]!=""
        ||$attributes["ProjektName"]!=''
        ||$attributes["Kurzbeschreibung"]!=''
        ||$attributes["Beschreibung"]!=''
        ||$attributes["GruppeID"]!=0&&$attributes["GruppeID"]!=""
    )
    {
        $GruppeID = $attributes["GruppeID"];
        $Nickname = $attributes["UserName"];
        $ProjektName = $attributes["ProjektName"];
        $Kurzbeschreibung = $attributes["Kurzbeschreibung"];
        $Beschreibung = $attributes["Beschreibung"];

        /*Get User if existing, else create user*/
        $NutzerID = getUserID($Nickname, $conn);

        /*Create project with basic information*/
        $sqliCreate = "INSERT INTO Projekt (GruppeID,NutzerID,ProjektName,Kurzbeschreibung,Beschreibung) VALUES ($GruppeID,$NutzerID,'$ProjektName','$Kurzbeschreibung','$Beschreibung');";
        echo($sqliCreate);
        $created = true;//$conn->query($sqliCreate);

        //if ($conn->query($sqliCreate) === TRUE) {
        if ($created === true){
            /*Insert additional data into the created resource*/
            $projektID = $conn->insert_id;
            // if($projektID == 0){
            //     toErrorPage("something went wrong while creating the project");
            //     cleanUp($conn,$projektID);
            // }

            /*TODO how does uploading pictures work?*/
            // $picture = $attributes["Bild"];
            // if($picture!=''){
            //     addPicture($picture,$GruppeID,$projektID, $conn);
            // }

            $materials = $attributes['materials'];
            $matDescs = $attributes["matDesc"];
            $amounts = $attributes["amount"];
            $units = $attributes["unit"];
            $materialcheck = implode(',',$materials);
            echo $materialcheck;
            if($materialcheck!=''){
                $index = 0;
                foreach ($materials as $matKey){
                    echo $matKey;
                    if ($matKey != ""){
                        echo "</br> MatKey: " . $matKey . "</br> MatDescs: " . $matDescs[$index] . "</br> amounts: " . $amounts[$index] . "</br> units: " . $units[$index];
                        $matID = getMat($matKey,$matDescs[$index],$amounts[$index],$units[$index], $conn, $projectID);
                        echo $matID . " das ist matID";
                        $query = "INSERT INTO Materialliste (MateriallisteID,MaterialLINK) values($projektID,$matID);";
                        echo($query);
                        $created = true;//$conn->query($query);
                        if(!$created){
                            cleanUp($conn,$projektID);
                        }
                    }
                    $index = $index+1;
                }
            }
            //*TODO* Check whether Beschreibung, Amount and Einheit are correct
            //*TODO* make Amound and Einheit required if a name is given
            //*TODO* DB default beschreibung: Keine detaillierte beschreibung vorhanden

            $tools = $attributes['tools'];
            $toolDescs = $attributes["toolDesc"];
            if(implode(',',$tools)!=''){
                $index = 0;
                foreach ($tools as $toolKey){
                    if ($toolKey != "") {
                        $toolID = getTool($toolKey,$toolDescs[$index], $conn,$projektID);
                        $query = "INSERT INTO Werkzeugliste (WerkzeuglisteID,WerkzeugLINK) values($projektID,$toolID);";
                        echo($query);
                        $created = true;//$conn->query($query);
                        if(!$created){
                            cleanUp($conn,$projektID);
                        }
                    }
                    $index = $index+1;
                }
            }
            //*TODO* Check whether Beschreibung is correct in db
            //*TODO* DB default beschreibung: Keine detaillierte beschreibung vorhanden

            if($attributes["Taglist"]!=''){
                $tagArray = explode(',',$attributes['Taglist']);
                foreach ($tagArray as $tagKey){
                    $tag = str_replace(" ", "", $tagKey);
                    $tagID = getTag($tag, $conn,$projektID);
                    $query = "INSERT INTO Tagliste (TaglisteID,TagLINK) values($projektID,$tagID);";
                    echo($query);
                    $created = true;//$conn->query($query);
                    if(!$created){
                        cleanUp($conn,$projektID);
                    }
                }
            }

            $matrix = $attributes['Matrix'];
            $created = true;//$conn->query
            echo("INSERT INTO Wertliste (WertlisteID,Wert1,Wert2,Wert3,Wert4,Wert5,Wert6) values($projektID,$matrix[0],$matrix[1],$matrix[2],$matrix[3],$matrix[4],$matrix[5]);");
            if(!$created){
                cleanUp($conn,$projektID);
            }

            $created = true;//$conn->query
            echo("INSERT INTO Bewertungliste(BewertunglisteID,Stern1,Stern2,Stern3,Stern4,Stern5) values($projektID,0,0,0,0,0);");
            if(!$created){
                cleanUp($conn,$projektID);
            }

            /*TODO Kommentarbereich anlegen (muss vlt gar nicht beim erstellen passieren)*/
            //$commentArea = mysqli_query($conn, "INSERT INTO Kommentarliste (KommenntarlisteID) values ($projektID)");

            echo("successfully created source. To be validated");

            /*TODO Validate generated resource*/
            // $result = mysqli_query($conn, "select * from Projekt where ProjektID = $projektID");
            // $schemaPath = "../xml/xmlschemaDetail.xml";
            // $validator = new DOMValidator($schemaPath);
            // try {
            //     $validated = $validator->validateFeeds(strXML("Projekt", $result, $conn, $IDvalue, "../../../fe/xslt/detailview.xsl", ""));
            // } catch (DOMException $e) {
            //     toErrorPage("failed to validate resource");
            //     cleanUp($conn,$projektID);
            // } catch (Exception $e) {
            //     toErrorPage("failed to validate resource for custom reasons");
            //     cleanUp($conn,$projektID);
            // }

            // if (!$validated) {
            //     print_r($validator->displayErrors());
            //     toErrorPage("Created resource is not valid against the xsd");
            //     cleanUp($conn,$projektID);
            // }
        } else {
            toErrorPage("Error: " . $sqliCreate . "</br>" . $conn->error);
            //no cleanup because no project has been created yet
            die();
        }
    }else{
        toErrorPage('Some Obligatory Values are Missing:');
        //no cleanup because no project has been created yet
        die();
    }
}else{
    toErrorPage('Failed for reasons');
    //no cleanup because no project has been created yet
    die();
}

function getUserID($Nickname, $conn){
    $sqliGetNutzer = $conn->query("Select NutzerID From Nutzer where Nick = '$Nickname'");
    if(mysqli_num_rows($sqliGetNutzer)==1){
        $row = mysqli_fetch_array($sqliGetNutzer);
        return($row["NutzerID"]);
    }else if(mysqli_num_rows($sqliGetNutzer)==0){
        $newUser = true;//$conn->query
        echo("INSERT INTO Nutzer (Nick) VALUES ('$Nickname');");
        if(!$newUser){
            toErrorPage("Error: " . $conn->error."</br> Can not create new User, Contact your administrator");
            die();
        }else{
            return($conn->insert_id);
        }
    }else{
        toErrorPage("There are two people with the same nickname, contact the administrator");
        die();
    }
}

function getTag($tag, $conn, $projectID){
    $sqliGetTag = $conn->query("Select TagName From Tag where TagName = '$tag';");
    if(mysqli_num_rows($sqliGetTag)==1){
        $row = mysqli_fetch_array($sqliGetTag);
        return($row["TagID"]);
    }else if(mysqli_num_rows($sqliGetTag)==0){
        $newTag = true;//$conn->query
        echo("INSERT INTO Tag (TagName) VALUES ('$tag');");
        if(!$newTag){
            toErrorPage("Error: " . $conn->error."</br> cannot create new Tag, contact your administrator");
            cleanUp($conn,$projectID);
        }else{
            return($conn->insert_id);
        }
    }else{
        toErrorPage("there are different Tags with the same Title, contact your administrator");
        cleanUp($conn,$projectID);
    }
}

function getMat($mat,$desc,$amount,$unit, $conn,$projectID){
    echo "</br> START getMat";
    echo ("Select Name,Menge,Einheit From Material where Name = '$mat';");
    $sqliGetMat = $conn->query("Select Name,Menge,Einheit From Material where Name = '$mat';");
    echo "</br> vor SQLI";
    if(mysqli_num_rows($sqliGetMat)==1){
        $row = mysqli_fetch_array($sqliGetMat);
        return($row["MaterialID"]);
    }else if(mysqli_num_rows($sqliGetMat)==0){
        $query="INSERT INTO Material (Name,Beschreibung,Menge,Einheit) VALUES ('$mat','$desc','$amount','$unit');";
        echo($query);
        $newMat = true;//$conn->query($query);
        if(!$newMat){
            toErrorPage("Error: " .$query."</br> -> ". $conn->error."</br> cannot create new Mat");
            cleanUp($conn,$projectID);
        }else{
            return($conn->insert_id);
        }
    }else{
        toErrorPage("there are different Mats with the same Title, Amount and Unit, contact your administrator");
        cleanUp($conn,$projectID);
    }
}

function getTool($tool, $desc,$conn,$projectID){
    $sqliGetTool = $conn->query("Select Name From Werkzeug where Name = '$tool';");
    if(mysqli_num_rows($sqliGetTool)==1){
        $row = mysqli_fetch_array($sqliGetTool);
        return($row["WerkzeugID"]);
    }else if(mysqli_num_rows($sqliGetTool)==0){
        $newTool = true;//$conn->query
        echo("INSERT INTO Werkzeug (Name,Beschreibung) VALUES ('$tool','$desc');");
        if(!$newTool){
            toErrorPage("Error: " . $conn->error."</br> cannot create new Tool");
            cleanUp($conn,$projectID);
        }else{
            return($conn->insert_id);
        }
    }else{
        toErrorPage("there are different Tools with the same Title, contact your administrator");
        cleanUp($conn,$projectID);
    }
}

function addPicture($Files,$GruppeID,$projectID, $conn){
    /*TODO correct path*/
    $uploads_dir = "../../../fe/img/$GruppeID/$projectID/";
    foreach ($Files["pictures"]["error"] as $key => $error) {
        if ($error == UPLOAD_ERR_OK) {
            $tmp_name = $Files["pictures"]["tmp_name"][$key];
            $name = $Files["pictures"]["titlePicture"][$key];
            move_uploaded_file($tmp_name, "$uploads_dir/$name");
            $sqliUpdate = $conn->query("UPDATE Projekt SET BildURL ='$uploads_dir/$name' where ProjektID = $projectID;");
            if(!$sqliUpdate){
                toErrorPage("Error: " . $conn->error."</br> failed to insert picture");
                cleanUp($conn,$projectID);
            }
        }
    }
}

function cleanUp($conn,$projectID){
    /*
    $conn->query("DELETE FROM Materialliste WHERE MateriallisteID = $projectID;");
    $conn->query("DELETE FROM Werkzeugliste WHERE WerkzeuglisteID = $projectID;");
    $conn->query("DELETE FROM Tagliste WHERE TaglisteID = $projectID;");
    $conn->query("DELETE FROM Wertliste WHERE WertlisteID = $projectID;");
    $conn->query("DELETE FROM Bewertungliste WHERE BewertunglisteID = $projectID;");
    $conn->query("DELETE FROM Projekt WHERE ProjektID = $projectID;");*/
    die();
}

?>