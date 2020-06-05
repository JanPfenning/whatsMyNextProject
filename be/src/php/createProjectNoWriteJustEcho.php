<?php
/*Basic requirements*/
$path = getcwd();
include "./toString.php";
include "./DOMValidator.php";
include "./linkErrorpage.php";
$connfile = $path . '/../../../vault/dbConnection.php';
/*if(file_exists($connfile)&&is_readable($connfile)){
    require_once $path . '/../../../vault/dbConnection.php';
}else{
    toErrorPage("required File doesnt exist or is not accessible");
    die();
}*/
$conn = null;
if(!isset($_POST["action"]) || $_POST["action"] == "post"){
    $attributes = $_POST;
    //echo implode(",",$attributes);
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
        //$NutzerID = getUserID($Nickname, $conn);
        $NutzerID = 3;

        /*Create project with basic information*/
        $sqliCreate = "INSERT INTO Projekt (GruppeID,NutzerID,ProjektName,Kurzbeschreibung,Beschreibung) VALUES ($GruppeID,$NutzerID,'$ProjektName','$Kurzbeschreibung','$Beschreibung');";
        $created = true;
        //$conn->query($sqliCreate);

        if ($created === true){
            //$projektID = $conn->insert_id;
            $projektID = 1;
            if($projektID == 0){
                cleanUp($conn,$projektID,"something went wrong while creating the project");
            }

            if(count($_FILES)>0){
                addPicture($GruppeID, $projektID, $conn);
            }

            $materials = $attributes['materials'];
            $matDescs = $attributes["matDesc"];
            $amounts = $attributes["amount"];
            $units = $attributes["unit"];
            if(implode(',',$materials)!=''){
                $index = 0;
                foreach ($materials as $matKey){
                    if ($matKey != ""){
                        $matID = getMat($matKey,$matDescs[$index],$amounts[$index],$units[$index], $conn, $projectID);
                        $query = "INSERT INTO Materialliste (MateriallisteID,MaterialLINK) values($projektID,$matID);";
                        $created = true;
                        //$conn->query($query);
                        if(!$created){
                            cleanUp($conn,$projektID,"Error at linking Material to Project");
                        }
                    }
                    $index = $index+1;
                }
            }
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
                        $created = true; //$conn-query($query);
                        if(!$created){
                            cleanUp($conn,$projektID,"Error at linking Tools to project");
                        }
                    }
                    $index = $index+1;
                }
            }
            //*TODO* DB default beschreibung: Keine detaillierte beschreibung vorhanden

            if($attributes["Taglist"]!=''){
                $tagArray = explode(',',$attributes['Taglist']);
                foreach ($tagArray as $tagKey){
                    $tag = str_replace(" ", "", $tagKey);
                    $tagID = getTag($tag, $conn,$projektID);
                    $query = "INSERT INTO Tagliste (TaglisteID,TagLINK) values($projektID,$tagID);";
                    $created = true; //$conn-query($query);
                    if(!$created){
                        cleanUp($conn,$projektID,"Error at linktin Tags to Project");
                    }
                }
            }

            $matrix = $attributes['Matrix'];
            $query="INSERT INTO Wertliste (WertlisteID,Wert1,Wert2,Wert3,Wert4,Wert5,Wert6) ".
                "values($projektID,$matrix[0],$matrix[1],$matrix[2],$matrix[3],$matrix[4],$matrix[5]);";
            $created = true; //$conn-query($query);
            if(!$created){
                cleanUp($conn,$projektID, "Error at initializing Wertliste");
            }

            $query="INSERT INTO Bewertungliste(BewertunglisteID,Stern1,Stern2,Stern3,Stern4,Stern5) ".
                "values($projektID,0,0,0,0,0);".
                $created = true; //$conn-query($query);
            if(!$created){
                cleanUp($conn,$projektID,"Error at initializing Bewertungliste");
            }

            /*TODO Validate generated resource*/
            // $result = mysqli_query($conn, "select * from Projekt where ProjektID = $projektID");
            // $schemaPath = "../xml/xmlschemaDetail.xml";
            // $validator = new DOMValidator($schemaPath);
            // try {
            //     $validated = $validator->validateFeeds(strXML("Projekt", $result, $conn, $IDvalue, "../../../fe/xslt/detailview.xsl", ""));
            // } catch (DOMException $e) {
            //     cleanUp($conn,$projektID,"failed to validate resource");
            // } catch (Exception $e) {
            //     cleanUp($conn,$projektID,"failed to validate resource for custom reasons");
            // }
            // if (!$validated) {
            //     print_r($validator->displayErrors());
            //     cleanUp($conn,$projektID,"Created resource is not valid against the xsd");
            // }

            include("../../../fe/html/index.html");

        } else {
            toErrorPage("Error: " . $sqliCreate . "</br>" . $conn->error);
            //no cleanup because no project has been created yet
            die();
        }
    }else{
        $errString ="Some Obligatory Values are Missing:";
        if($attributes["UserName"]!=""){
            $errString=$errString.("</br> Username");
        }if($attributes["ProjektName"]!=''){
            $errString=$errString.("</br> Projektname");
        }if($attributes["Kurzbeschreibung"]!=''){
            $errString=$errString.("</br> Kurzbeschreibung");
        }if($attributes["Beschreibung"]!=''){
            $errString=$errString.("</br> Beschreibung");
        }if($attributes["GruppeID"]!=0&&$attributes["GruppeID"]!=""){
            $errString=$errString.("</br> GruppeID");
        }
        toErrorPage($errString);
        //no cleanup because no project has been created yet
        die();
    }
}else{
    toErrorPage('Failed for reasons');
    //no cleanup because no project has been created yet
    die();
}

function getUserID($Nickname, $conn){
    $query = "Select NutzerID From Nutzer where Nick = '$Nickname';";
    $sqliGetNutzer = $conn->query($query);
    if(mysqli_num_rows($sqliGetNutzer)==1){
        $row = mysqli_fetch_array($sqliGetNutzer);
        return($row["NutzerID"]);
    }else if(mysqli_num_rows($sqliGetNutzer)==0){
        $query="INSERT INTO Nutzer (Nick) VALUES ('$Nickname');";
        $newUser = true; //$conn-query($query);
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
    $query="Select TagName From Tag where TagName = '$tag';";
    $sqliGetTag = $conn->query($query);
    if(mysqli_num_rows($sqliGetTag)==1){
        $row = mysqli_fetch_array($sqliGetTag);
        return($row["TagID"]);
    }else if(mysqli_num_rows($sqliGetTag)==0){
        $query="INSERT INTO Tag (TagName) VALUES ('$tag');";
        $newTag = true; //$conn-query($query);
        if(!$newTag){
            cleanUp($conn,$projectID,"Error: " . $conn->error."</br> cannot create new Tag, contact your administrator");
        }else{
            return($conn->insert_id);
        }
    }else{
        cleanUp($conn,$projectID,"there are different Tags with the same Title, contact your administrator");
    }
}

function getMat($mat,$desc,$amount,$unit, $conn,$projectID){
    $query="Select Name,Menge,Einheit From Material where Name = '$mat';";
    $sqliGetMat = $conn->query($query);
    if(mysqli_num_rows($sqliGetMat)==1){
        $row = mysqli_fetch_array($sqliGetMat);
        return($row["MaterialID"]);
    }else if(mysqli_num_rows($sqliGetMat)==0){
        $query="INSERT INTO Material (Name,Beschreibung,Menge,Einheit) VALUES ('$mat','$desc','$amount','$unit');";
        $newMat = true; //$conn-query($query);
        if(!$newMat){
            cleanUp($conn,$projectID,"Error: " .$query."</br> -> ". $conn->error."</br> cannot create new Mat");
        }else{
            return($conn->insert_id);
        }
    }else{
        cleanUp($conn,$projectID,"there are different Mats with the same Title, Amount and Unit, contact your administrator");
    }
}

function getTool($tool, $desc,$conn,$projectID){
    $query="Select Name From Werkzeug where Name = '$tool';";
    $sqliGetTool = $conn->query($query);
    if(mysqli_num_rows($sqliGetTool)==1){
        $row = mysqli_fetch_array($sqliGetTool);
        return($row["WerkzeugID"]);
    }else if(mysqli_num_rows($sqliGetTool)==0){
        $query="INSERT INTO Werkzeug (Name,Beschreibung) VALUES ('$tool','$desc');";
        $newTool = true; //$conn-query($query);
        if(!$newTool){
            cleanUp($conn,$projectID,"Error: " . $conn->error."</br> cannot create new Tool");
        }else{
            return($conn->insert_id);
        }
    }else{
        cleanUp($conn,$projectID,"there are different Tools with the same Title, contact your administrator");
    }
}

function addPicture($GruppeID, $projectID, $conn){
    //$query="Select BereichID from Gruppe where GruppeID = $GruppeID;";
    //$row = mysqli_fetch_array($conn->query($query));
    $BereichID = 1;//$row["BereichID"];
    $target_dir = "../../../fe/img/$BereichID/$GruppeID/";
    $inputName = "picture";
    $target_file = $target_dir . basename($_FILES[$inputName]["name"]);
    echo $target_file;
    $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

    // Check if image file is a actual image or fake image
    $check = getimagesize($_FILES[$inputName]["tmp_name"]);
    if($check === false){
        cleanUp($conn,$projectID,"File is not an image.");
    }else if(file_exists($target_file)) {
        cleanUp($conn,$projectID,"Sorry, file already exists.");
    }else if ($_FILES[$inputName]["size"] > 50000000) {
        cleanUp($conn,$projectID,"Sorry, your file is too large.");
    }else if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg") {
        cleanUp($conn,$projectID,"Sorry, only JPG, JPEG and PNG files are allowed.");
    }else{
        //upload file
        if (move_uploaded_file($_FILES[$inputName]["tmp_name"], $target_file)) {
            $query = "UPDATE Projekt SET BildURL ='$target_file' where ProjektID = $projectID;";
            $sqliUpdate = true; //$conn-query($query);
            if(!$sqliUpdate){
                cleanUp($conn,$projectID,"Error: " . $conn->error."</br> failed to insert picture");
            }
        } else {
            cleanUp($conn,$projectID,"Error uploading File");
        }
    }
}

function cleanUp($conn,$projectID,$msg){
    /*$conn->query("DELETE FROM Materialliste WHERE MateriallisteID = $projectID;");
    $conn->query("DELETE FROM Werkzeugliste WHERE WerkzeuglisteID = $projectID;");
    $conn->query("DELETE FROM Tagliste WHERE TaglisteID = $projectID;");
    $conn->query("DELETE FROM Wertliste WHERE WertlisteID = $projectID;");
    $conn->query("DELETE FROM Bewertungliste WHERE BewertunglisteID = $projectID;");
    $conn->query("DELETE FROM Projekt WHERE ProjektID = $projectID;");
    $conn->query("ALTER TABLE Projekt AUTO_INCREMENT = $projectID;");*/
    toErrorPage($msg);
    die();
}

?>