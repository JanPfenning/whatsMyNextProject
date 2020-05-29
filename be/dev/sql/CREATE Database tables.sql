CREATE TABLE Bereich (
  BereichID int PRIMARY KEY AUTO_INCREMENT,
  BereichsName varchar(50)
);

CREATE TABLE Gruppe (
  GruppeID int PRIMARY KEY AUTO_INCREMENT,
  BereichID int,
  GruppenName varchar(50)
);

CREATE TABLE `Projekt` (
`ProjektID` int PRIMARY KEY AUTO_INCREMENT,
`GruppeID` int,
`NutzerID` int,
`Name` VARCHAR(64),
`WerkzeuglisteLINK` varchar(1) default '',
`MateriallisteLINK` varchar(1) default '',
`WertlisteLINK` varchar(1) default '',
`TaglisteLINK` varchar(1) default '',
`KommentarlisteLINK` varchar(1) default '',
`Kurzbeschreibung` varchar(512),
`Beschreibung` varchar(32768),
`DatumErstellt` date DEFAULT (now()),
`DatumErneuert` date DEFAULT (now())
);

CREATE TABLE Kommentar (
  KommentarID int PRIMARY KEY AUTO_INCREMENT,
  NutzerID int,
  Inhalt varchar(1024),
  DatumErstellt date DEFAULT (now())
);

CREATE TABLE Nutzer (
  NutzerID int PRIMARY KEY AUTO_INCREMENT,
  Nick varchar(32)
);

CREATE TABLE Werkzeug (
  WerkzeugID int PRIMARY KEY AUTO_INCREMENT,
  Name varchar(64),
  Beschreibung varchar(512)
);

CREATE TABLE Material (
  MaterialID int PRIMARY KEY AUTO_INCREMENT,
  Name varchar(64),
  Beschreibung varchar(512),
  Menge int,
  Einheit varchar(16)
);

CREATE TABLE Tag (
  TagID int PRIMARY KEY AUTO_INCREMENT,
  TagName varchar(32)
);

CREATE TABLE Werkzeugliste (
  WerkzeuglisteID int,
  WerkzeugLINK int,
  PRIMARY KEY (WerkzeuglisteID, WerkzeugLINK)
);

CREATE TABLE Materialliste (
  MateriallisteID int,
  MaterialLINK int,
  PRIMARY KEY (MateriallisteID, MaterialLINK)
);

CREATE TABLE Tagliste (
  TaglisteID int,
  TagLINK int,
  PRIMARY KEY (TaglisteID, TagLINK)
);

CREATE TABLE Kommentarliste (
  KommentarlisteID int,
  KommentarLINK int,
  PRIMARY KEY (KommentarlisteID, KommentarLINK)
);

CREATE TABLE Wertliste (
  WertlisteID int PRIMARY KEY,
  Wert1 tinyint(2),
  Wert2 tinyint(2),
  Wert3 tinyint(2),
  Wert4 tinyint(2),
  Wert5 tinyint(2),
  Wert6 tinyint(2)
);

ALTER TABLE Gruppe ADD FOREIGN KEY (BereichID) REFERENCES Bereich (BereichID);

ALTER TABLE Projekt ADD FOREIGN KEY (GruppeID) REFERENCES Gruppe (GruppeID);

ALTER TABLE Projekt ADD FOREIGN KEY (NutzerID) REFERENCES Nutzer (NutzerID);

ALTER TABLE Kommentar ADD FOREIGN KEY (NutzerID) REFERENCES Nutzer (NutzerID);

ALTER TABLE Werkzeugliste ADD FOREIGN KEY (WerkzeuglisteID) REFERENCES Projekt (ProjektID);

ALTER TABLE Werkzeugliste ADD FOREIGN KEY (WerkzeugLINK) REFERENCES Werkzeug (WerkzeugID);

ALTER TABLE Materialliste ADD FOREIGN KEY (MateriallisteID) REFERENCES Projekt (ProjektID);

ALTER TABLE Materialliste ADD FOREIGN KEY (MaterialLINK) REFERENCES Material (MaterialID);

ALTER TABLE Tagliste ADD FOREIGN KEY (TaglisteID) REFERENCES Projekt (ProjektID);

ALTER TABLE Tagliste ADD FOREIGN KEY (TagLINK) REFERENCES Tag (TagID);

ALTER TABLE Kommentarliste ADD FOREIGN KEY (KommentarlisteID) REFERENCES Projekt (ProjektID);

ALTER TABLE Kommentarliste ADD FOREIGN KEY (KommentarLINK) REFERENCES Kommentar (KommentarID);

ALTER TABLE Wertliste ADD FOREIGN KEY (WertlisteID) REFERENCES Projekt (ProjektID);