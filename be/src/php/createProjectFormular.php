<?php
$htmlContent= '
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Project</title>
    <link rel="stylesheet" type="text/css" href="../../../fe/css/create.css" />
    <script src="../../../fe/js/createProject.js"></script>
</head>
<body onload="init()">
<div class="container">
    <form id="createProject" action="createProjectScript.php" method="post" enctype="multipart/form-data">
    <!--<form id="createProject" action="createProjectNoWriteJustEcho.php" method="post" enctype="multipart/form-data">-->
        <input type="hidden" id="group" autocomplete="off" name="GruppeID" value="'.$_GET["GruppeID"].'" required>
        <div class="row"> <!-- Projektname -->
            <div class="col-25">
                <label for="pname">Projektname</label>
            </div>
            <div class="col-75">
                <span class="col-90">
                    <input type="text" id="pname" autocomplete="off" name="ProjektName" placeholder="Projektname.." required>
                </span>
                <span class="col-10">
                    <select id="languageSelect" name="lang">
                        <option id="de" value="de">de</option>
                        <option id="en" value="en">en</option>
                    </select>
                </span>
            </div>
        </div>
        <div class="row"> <!-- Dein Name-->
            <div class="col-25">
                <label for="nname">Dein Name</label>
            </div>
            <div class="col-75">
                <input type="text" id="nname" autocomplete="off" name="UserName" placeholder="Dein Name.." required>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="sdescription">Kurzbeschreibung</label>
            </div>
            <div class="col-75">
                <input type="text" id="sdescription" autocomplete="off" name="Kurzbeschreibung" placeholder="Kurze Beschreibung.." required>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="ldescription">Beschreibung</label>
            </div>
            <div class="col-75">
                <textarea id="ldescription" autocomplete="off" name="Beschreibung" placeholder="Projektbeschreibung.." style="height: 200px;" required></textarea>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="pictureUpload">Bild</label>
            </div>
            <div class="col-75">
                    <span class="col-50" id="pictureUpload">
                        <input type="file" id="pictureButton" name="picture">
                    </span>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="Values">Values</label>
            </div>
            <div class="col-75 values" id="Values">
                <div class="col-33">
                    <label for="M1">Unterhaltsam</label>
                    <input type="range" oninput="changePic(this)" min="1" max="10" value="2" id="M1" name="Matrix[]">
                </div>
                <div class="col-33">
                    <label for="M2">Wissenschaftlich</label>
                    <input type="range" oninput="changePic(this)" min="1" max="10" value="2" id="M2" name="Matrix[]">
                </div>
                <div class="col-33">
                    <label for="M3">Kosten</label>
                    <input type="range" oninput="changePic(this)" min="1" max="10" value="2" id="M3" name="Matrix[]">
                </div>
                <div class="col-33">
                    <label for="M4">Komplexität</label>
                    <input type="range" oninput="changePic(this)" min="1" max="10" value="2" id="M4" name="Matrix[]">
                </div>
                <div class="col-33">
                    <label for="M5">Vorraussetzungen</label>
                    <input type="range" oninput="changePic(this)" min="1" max="10" value="2" id="M5" name="Matrix[]">
                </div>
                <div class="col-33">
                    <label for="M6">Einstiegshürde</label>
                    <input type="range" oninput="changePic(this)" min="1" max="10" value="2" id="M6" name="Matrix[]">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="materials">Materialien</label>
            </div>
            <div class="col-75">
                <div>
                    <span class="col-30">
                        <input type="text" id="materials" autocomplete="off" oninput="changeList(this,2)" onchange="remove(this,2)" name="materials[]" placeholder="Material...">
                    </span>
                    <span class="col-20">
                        <input type="text" id="matDesc" autocomplete="off" name="matDesc[]" placeholder="Kurzbeschreibung...">
                    </span>
                    <span class="col-20">
                        <input type="text" id="amount" autocomplete="off" name="amount[]" placeholder="Menge...">
                    </span>
                    <span class="col-20">
                        <input type="text" id="unit" autocomplete="off" name="unit[]" placeholder="Einheit...">
                    </span>
                    <span class="col-10">
                        <button onclick="removeLine(this,4)">-</button>
                    </span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="tools">Werkzeuge</label>
            </div>
            <div class="col-75">
                <div>
                    <span class="col-40">
                        <input type="text" id="tools" autocomplete="off" oninput="changeList(this,2)" onchange="remove(this,2)" name="tools[]" placeholder="Werkzeug...">
                    </span>
                    <span class="col-50">
                        <input type="text" id="tools" autocomplete="off" name="toolDesc[]" placeholder="Kurzbeschreibung...">
                    </span>
                    <span class="col-10">
                        <button onclick="removeLine(this,2)">-</button>
                    </span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="taglist">Tags</label>
            </div>
            <div class="col-75">
                <textarea id="taglist" autocomplete="off" name="Taglist" placeholder="Holz, Heimwerken, Zuhause, ..."></textarea>
            </div>
        </div>
        <div class="row">
            <input type="submit" value="Erstelle dein Projekt">
        </div>
    </form>
</div>
<footer>
Diese Seite ist nicht kommerziell genutzt und dient nur als Aufgabe der Universität im Rahmen einer Vorlesung.
Der Inhalt ist verfügbar unter der Lizenz <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/de/">CC BY-NC-SA 3.0</a>, sofern nicht anders angegeben.
Game content and materials are trademarks and copyrights of their respective publisher and its licensors. All rights reserved.
This site is not affiliated with the game publisher.
</footer>
</body>
</html>
';
print($htmlContent);
?>
