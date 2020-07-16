<?php
$htmlContent= '
<html>
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <script lang="javascript" src="../../../fe/js/error.js"></script>
                <link rel="shortcut icon" href="../../../fe/img/favicon.ico"/>
        <link rel="stylesheet" type="text/css" href="../../../fe/css/error.css" />
    </head>
    <body>
        <div id="buttons">
            <div id="errorText">'.$err.'</div>
            <form method="POST" name="toMainMenu" id="toMainMenuForm" action="./index.php">
                <button class="button" type="submit" id="toMainMenu">Zum Hauptmenu</button>
            </form>
            <form method="POST" name="quitTab" action="./index.php">
                <button class="button" type="submit" id="quit">Verlassen</button>
            </form>
        </div>
    </body>
</html>
';
print($htmlContent);
?>