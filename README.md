# meinCraft
DHBW (University) exercise using XSLT and XML for building a Website.
This is for educative purpose only!!!

Der aktuelle Stand des Projekts ist auf https://expensive.click zu begutachten.

Das Konzept der Seite basiert auf einem Wortspiel im bezug auf das Videospiel Minecraft, welches
auch maßgeblich für unsere Designideen verantwortlich war. Ansonsten sind einige Easter-Eggs auf der Seite versteckt :) .
"mein Craft" meint also "mein Handwerk" bzw. frei übersetzt "mein Bastelprojekt"

Die Landingpage verweist ausschließlich auf ein Impressum und einen "Über" Bereich, deren Inhalt nur als Platzhalter gedacht sind,
sowie auf die Seite in der die eigentliche Auswahl beginnt. 
Mit einem click auf "Los geht's" findet man sich selbst auf einer Seite auf der man einen Bereich für
sein Projekt auswählen kann. Mit einem click auf den unteren zentrierten Kreis kommt man eine Ebene nach oben.
Wählt man einen Bereich mit einem Click aus so wird man auf die verschiedenen Untergruppen des Bereichs geleitet.
Selbiges gilt für diese Seite. Nach der Auswahl einer Gruppe werden alle Projekte aufgelistet, welche in dieser Gruppe existieren.
Von hier aus hat man auch die Möglichkeit neue Projekte in dieser Gruppe einzureichen.
Durch hovern über ein Projekt wird die Kurzbeschreibung des Projekts angezeigt. Nach wahl eines
Interessanten Projekt kommt man auf die Detailseite mit zusätzlichen Informationen. Dort kann man das Projekt bewerten und kommentieren.
Die Toolbar ist auf jeder Seite und von dort aus kann jede hierarchisch übergeordnete Seite navigiert werden.
 
Besonders schön ist der Slider bei der "Projekterstellungs-Seite", unser Favicon und das Diagramm auf der Detailseite.

Alle Funktionen wurden **_komplett_** ohne jegliche APIs oder Frameworks implementiert. So wurde,
um alles möglichst Plain zu halten, nur HTML, CSS, JS, XSL (DTD, XML) und PHP genutzt.

Jede aufzufindende Zeile Code wurde händisch geschrieben!

Der Server verwendet eine MariaDB welche uns lediglich die SQL-Funktionalitäten zur verfügung stellt.

 Der Client schickt eine Anfrage an unser PHP-Script, welches mittels Datenbankabfrage die Daten
 aus der Datenbank ausließt, sie mit einem Script in ein valides XML-Format bringt und es an den Client zurück gibt.
 Das verlinkte XSLT wird vom Client interpretiert und dieser baut daraus eine HTML-Seite. Die dann fehlenden
 JS-, CSS- und Bilddateien werden dann vom Client angefragt und geladen.
 
 Die Dateien in be/src/xml sind nur zum lokalen de-bugging gedacht. Die XML-Dokumente welche am Client ankommen werden
 mit den Daten aus der Datenbank mittels des PHP-Scripts zusammengebaut.