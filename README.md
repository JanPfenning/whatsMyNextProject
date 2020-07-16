# whatsMyNextProject
DHBW (University) exercise using XSLT and XML for building a Website.
This is for educative purpose only!!!

Der aktuelle Stand des Projekts ist auf https://expensive.click zu begutachten.

Besonders schön ist der Slider bei der "Projekterstellungs-Seite", unser Favicon und das Diagramm auf der Detailseite.

Alle Funktionen wurden **_komplett_** ohne jegliche APIs oder Frameworks implementiert. So wurde,
um alles möglichst Plain zu halten, nur HTML, CSS, JS, XSL (DTD, XML) und PHP genutzt.

Jede aufzufindende Zeile Code wurde händisch geschrieben!

Der Server verwendet eine MariaDB und stellt uns lediglich die SQL-Funktionalität zur verfügung.

 Der Client schickt eine Anfrage an unser PHP-Script, welches mittels Datenbankabfrage die Daten
 aus der Datenbank ausließt, sie mit einem Script in ein valides XML-Format bringt und es an den Client zurück gibt.
 Das verlinkte XSLT wird vom Client interpretiert und dieser baut daraus eine HTML-Seite. Die dann fehlenden
 JS-, CSS- und Bilddateien werden dann vom Client angefragt und geladen.