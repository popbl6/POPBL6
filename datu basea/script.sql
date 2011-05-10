create database cmdb;

CREATE  TABLE Motak (
  idMota serial ,
  mota VARCHAR(45) ,
  PRIMARY KEY (idMota) );

CREATE  TABLE CI (
  idCI serial ,
  Deskribapena VARCHAR(300),
  idMota  integeregereger,
  Jabea VARCHAR(60),
  AEKapa VARCHAR(45),
  Marka VARCHAR(200),
  Bertsioa VARCHAR(10) ,
  Prozesagailua VARCHAR(100) ,
  RAM VARCHAR(45),
  DiskoGogorra VARCHAR(45),
  Modeloa VARCHAR(200),
  serieZenbakia VARCHAR(45),
  oharrak VARCHAR(500),
  Extensioa VARCHAR(15),
  Abiadura VARCHAR(45),
  TelefonoZKi VARCHAR(25),
  KontratuAmaiera DATE ,
  ISP VARCHAR(45),
  HasierakoPuntua VARCHAR(45),
  BukaeraPuntua VARCHAR(45),
  Kontaktua VARCHAR(45),
  Sinatzailea VARCHAR(45),
  PRIMARY KEY (idCI) ,
  CONSTRA integereger CIMotaFk
    FOREIGN KEY (idMota )
    REFERENCES Motak (idMota)
);

CREATE  TABLE Langileak(
  idLangileak serial,
  Izena VARCHAR(45)  ,
  Abizena VARCHAR(45) ,
  Helbidea VARCHAR(90) ,
  Telefonoa VARCHAR(45) ,
  Salarioa DECIMAL(10,0) ,
  Postua VARCHAR(45),
  PRIMARY KEY (idLangileak) );

CREATE  TABLE CILangileak (
  idCILangile serial,
  idLangile integer ,
  idCI integer ,
  deskribapena VARCHAR(500) ,
  PRIMARY KEY (idCILangile) ,
   CONSTRAINT CILangileLFK
    FOREIGN KEY (idLangile )
    REFERENCES Langileak (idLangileak ),
  CONSTRAINT CILangileC
    FOREIGN KEY (idCI )
    REFERENCES CI (idCI )
);

CREATE  TABLE InzidentziaMotak (
  idInzidentziaMotak serial,
  mota VARCHAR(200) ,
  PRIMARY KEY (idInzidentziaMotak) );

CREATE  TABLE Inzidentziak (
  idInzidentziak serial,
  InzidentziaHasi integer ,
  InzidentziaItxi integer ,
  timestamp TIMESTAMP ,
  DeskribapenaArazo VARCHAR(500) ,
  DeskribapenaKonpon VARCHAR(500) ,
  idCI integer ,
  konponduta boolean,
  inzidentziaMota integer ,
  PRIMARY KEY (idInzidentziak) ,
  CONSTRAINT inziHasiFK
    FOREIGN KEY (InzidentziaHasi )
    REFERENCES Langileak (idLangileak ),
  CONSTRAINT inziBukaFk
    FOREIGN KEY (InzidentziaItxi )
    REFERENCES Langileak (idLangileak ),
  CONSTRAINT inziCIFK
    FOREIGN KEY (idCI )
    REFERENCES CI (idCI ),
  CONSTRAINT inziMotaFK
    FOREIGN KEY (inzidentziaMota )
    REFERENCES InzidentziaMotak (idInzidentziaMotak ));

CREATE  TABLE Erlazioak (
  idErlazioak serial,
  CI1 integer ,
  CI2 integer ,
  deskribapena VARCHAR(500) ,
  PRIMARY KEY (idErlazioak) ,
  CONSTRAINT erlaCIFK
    FOREIGN KEY (CI1 )
    REFERENCES CI (idCI ),
  CONSTRAINT erlaCI2FK
    FOREIGN KEY (CI2 )
    REFERENCES CI (idCI ));

CREATE  TABLE Hornitzaileak (
  idHornitzaileak serial,
  Izena VARCHAR(45) ,
  Abizena VARCHAR(45) ,
  Helbidea VARCHAR(90) ,
  Telefonoa VARCHAR(45) ,
  PRIMARY KEY (idHornitzaileak) );

CREATE  TABLE CIHornitzaileak (
  idCIHornitzailea serial,
  idHornitzaileak integer ,
  IdCI integer ,
  deskribapena VARCHAR(45) ,
  PRIMARY KEY (idCIHornitzailea) ,
  CONSTRAINT CIHorniHFK
    FOREIGN KEY (idHornitzaileak )
    REFERENCES Hornitzaileak (idHornitzaileak ),
  CONSTRAINT CIHorniCFk
    FOREIGN KEY (IdCI )
    REFERENCES CI (idCI ));
