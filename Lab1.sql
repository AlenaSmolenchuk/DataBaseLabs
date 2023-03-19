CREATE TABLE Countries ( 
 id_country INTEGER PRIMARY KEY,
 name_coutry VARCHAR(64) NOT NULL
);

CREATE TABLE Exhibits (
 id_exhibit VARCHAR(32) PRIMARY key,
 name_exhibit VARCHAR(2000) NOT NULL UNIQUE,
 collection VARCHAR(2000) NOT NULL,
 technique VARCHAR(2000) NOT NULL,
 year NUMERIC(4),
 insurance NUMERIC(10,2) NOT NULL DEFAULT 20000,
 country INTEGER NOT NULL REFERENCES Countries(id_country),
 CHECK (year > 1900)
);

 SELECT * FROM Countries;
 
 SELECT * FROM Exhibits;
