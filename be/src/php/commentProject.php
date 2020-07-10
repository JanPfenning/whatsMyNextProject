<?php

    $path = getcwd();

    include "./linkErrorpage.php";
    $connfile = $path . '/../../../vault/dbConnection.php';
    if(file_exists($connfile)&&is_readable($connfile)){
        require_once $path . '/../../../vault/dbConnection.php';
    }else{
        toErrorPage("Failed to load requiered File");
        die();
    }
    $attributes = $_POST;
    $Nickname = $attributes["nick"];
    $projectID = $attributes["projectID"];
    $comment = $attributes["comment"];

    $NutzerID = getUserID($Nickname, $conn);

    $query = "INSERT INTO Kommentar (NutzerID,Kommentar) VALUES ('$NutzerID','$comment')";
    $worked = $conn->query($query);
    if(!$worked){
        toErrorPage("Error: " . $conn->error."</br> Cannot create comment. Please contact the administrator");
        die();
    }else{
        $commentID = $conn->insert_id;
        $query = "UPDATE Kommentarliste SET KommentarlisteID=$projectID, KommentarLINK=$commentID;";
        $worked = $conn->query($query);
        if(!$worked){
            $error = $conn->error;
            $query = "DELETE Kommentar WHERE KommentarID=$commentID;";
            $cleaned = $conn->query($query);
            if($cleaned){
                toErrorPage($error);
            }else{
                toErrorPage($error."</br> $conn->error </br> comment $commentID not cleaned");
            }
        }
    }


    function getUserID($Nickname, $conn){
        $query = "Select NutzerID From Nutzer where Nick = '$Nickname';";
        $sqliGetNutzer = $conn->query($query);
        if(mysqli_num_rows($sqliGetNutzer)==1){
            $row = mysqli_fetch_array($sqliGetNutzer);
            return($row["NutzerID"]);
        }else if(mysqli_num_rows($sqliGetNutzer)==0){
            $query="INSERT INTO Nutzer (Nick) VALUES ('$Nickname');";
            $newUser = $conn->query($query);
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

?>
