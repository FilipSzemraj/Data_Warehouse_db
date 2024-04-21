DROP TABLE klient CASCADE CONSTRAINTS;
DROP TABLE kolor CASCADE CONSTRAINTS;
DROP TABLE magazyn CASCADE CONSTRAINTS;
DROP TABLE marka CASCADE CONSTRAINTS;
DROP TABLE miasta CASCADE CONSTRAINTS;
DROP TABLE model CASCADE CONSTRAINTS;
DROP TABLE pracownicy CASCADE CONSTRAINTS;
DROP TABLE salon CASCADE CONSTRAINTS;
DROP TABLE stanowisko CASCADE CONSTRAINTS;
DROP TABLE telefony CASCADE CONSTRAINTS;
DROP TABLE umowa CASCADE CONSTRAINTS;
DROP TABLE ulica CASCADE CONSTRAINTS;
DROP TABLE wojewodztwo CASCADE CONSTRAINTS;

CREATE TABLE klient (
    id_klient            NUMBER(3) NOT NULL,
    imie                 VARCHAR2(10) NOT NULL,
    nazwisko             VARCHAR2(11),
    nr_telefonu          NUMBER(9),
    nr_dowodu_osobistego VARCHAR2(9),
    ulica_id_ulica       NUMBER(3) NOT NULL
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id_klient );

CREATE TABLE kolor (
    id_kolor NUMBER(2) NOT NULL,
    nazwa    VARCHAR2(13)
);

ALTER TABLE kolor ADD CONSTRAINT kolor_pk PRIMARY KEY ( id_kolor );

CREATE TABLE magazyn (
    id_magazyn NUMBER(3) CONSTRAINT id_magazyn_pk PRIMARY KEY,
    ilosc               NUMBER(3),
    telefony_id_telefon NUMBER(3) NOT NULL,
    salon_id_salon      NUMBER(3) NOT NULL
);

CREATE TABLE marka (
    id_marka NUMBER(3) NOT NULL,
    nazwa    VARCHAR2(9)
);

ALTER TABLE marka ADD CONSTRAINT marka_pk PRIMARY KEY ( id_marka );

CREATE TABLE miasta (
    id_miasta                  NUMBER(3) NOT NULL,
    nazwa                      VARCHAR2(25),
    wojewodztwo_id_wojewodztwa NUMBER(2) NOT NULL
);

ALTER TABLE miasta ADD CONSTRAINT miasta_pk PRIMARY KEY ( id_miasta );

CREATE TABLE model (
    id_model       NUMBER(3) NOT NULL,
    nazwa          VARCHAR2(15),
    marka_id_marka NUMBER(3) NOT NULL
);

ALTER TABLE model ADD CONSTRAINT model_pk PRIMARY KEY ( id_model );

CREATE TABLE pracownicy (
    id_pracownik             NUMBER(3) NOT NULL,
    imie                     VARCHAR2(10),
    salon_id_salon           NUMBER(3) NOT NULL,
    stanowisko_id_stanowiska NUMBER(2) NOT NULL,
    nazwisko                 VARCHAR2(11)
);

ALTER TABLE pracownicy ADD CONSTRAINT pracownicy_pk PRIMARY KEY ( id_pracownik );

CREATE TABLE salon (
    id_salon       NUMBER(3) NOT NULL,
    nazwa          VARCHAR2(12),
    ulica_id_ulica NUMBER(3) NOT NULL
);

ALTER TABLE salon ADD CONSTRAINT salon_pk PRIMARY KEY ( id_salon );

CREATE TABLE stanowisko (
    id_stanowiska NUMBER(2) NOT NULL,
    nazwa         VARCHAR2(24),
    pensja        NUMBER(5)
);

ALTER TABLE stanowisko ADD CONSTRAINT stanowisko_pk PRIMARY KEY ( id_stanowiska );

CREATE TABLE telefony (
    id_telefon     NUMBER(3) NOT NULL,
    kolor_id_kolor NUMBER(2) NOT NULL,
    model_id_model NUMBER(3) NOT NULL
);

ALTER TABLE telefony ADD CONSTRAINT telefony_pk PRIMARY KEY ( id_telefon );

CREATE TABLE ulica (
    miasta_id_miasta NUMBER(3) NOT NULL,
    id_ulica         NUMBER(3) NOT NULL,
    nazwa            VARCHAR2(17)
);

ALTER TABLE ulica ADD CONSTRAINT ulica_pk PRIMARY KEY ( id_ulica );

CREATE TABLE umowa (
    id_umowa NUMBER(5) CONSTRAINT id_umowa_pk PRIMARY KEY,
    data                    DATE NOT NULL,
    pracownicy_id_pracownik NUMBER(3) NOT NULL,
    klient_id_klient        NUMBER(3) NOT NULL,
    cena                    NUMBER(4),
    ilosc                   NUMBER(3),
    magazyn_id_magazyn NUMBER(3) NOT NULL
);

CREATE TABLE wojewodztwo (
    id_wojewodztwa NUMBER(2) NOT NULL,
    nazwa          VARCHAR2(21)
);

ALTER TABLE umowa ADD CONSTRAINT umowa_magazyn_fk FOREIGN KEY (magazyn_id_magazyn) REFERENCES magazyn(id_magazyn);
ALTER TABLE umowa ADD CONSTRAINT umowa_pracownicy_fk FOREIGN KEY (pracownicy_id_pracownik) REFERENCES pracownicy(id_pracownik);
ALTER TABLE umowa ADD CONSTRAINT umowa_klient_fk FOREIGN KEY (klient_id_klient) REFERENCES klient(id_klient);
ALTER TABLE wojewodztwo ADD CONSTRAINT wojewodztwo_pk PRIMARY KEY ( id_wojewodztwa );
ALTER TABLE klient ADD CONSTRAINT klient_ulica_fk FOREIGN KEY ( ulica_id_ulica ) REFERENCES ulica ( id_ulica );
ALTER TABLE miasta ADD CONSTRAINT miasta_wojewodztwo_fk FOREIGN KEY ( wojewodztwo_id_wojewodztwa ) REFERENCES wojewodztwo ( id_wojewodztwa );
ALTER TABLE model ADD CONSTRAINT model_marka_fk FOREIGN KEY ( marka_id_marka ) REFERENCES marka ( id_marka );
ALTER TABLE pracownicy ADD CONSTRAINT pracownicy_salon_fk FOREIGN KEY ( salon_id_salon ) REFERENCES salon ( id_salon );
ALTER TABLE pracownicy ADD CONSTRAINT pracownicy_stanowisko_fk FOREIGN KEY ( stanowisko_id_stanowiska ) REFERENCES stanowisko ( id_stanowiska );
ALTER TABLE salon ADD CONSTRAINT salon_ulica_fk FOREIGN KEY ( ulica_id_ulica ) REFERENCES ulica ( id_ulica );
ALTER TABLE telefony ADD CONSTRAINT telefony_kolor_fk FOREIGN KEY ( kolor_id_kolor ) REFERENCES kolor ( id_kolor );
ALTER TABLE telefony ADD CONSTRAINT telefony_model_fk FOREIGN KEY ( model_id_model ) REFERENCES model ( id_model );
ALTER TABLE ulica ADD CONSTRAINT ulica_miasta_fk FOREIGN KEY ( miasta_id_miasta ) REFERENCES miasta ( id_miasta );
ALTER TABLE magazyn ADD CONSTRAINT magazyn_tel_fk FOREIGN KEY (telefony_id_telefon) REFERENCES telefony(id_telefon);
ALTER TABLE magazyn ADD CONSTRAINT magazyn_sal_fk FOREIGN KEY (salon_id_salon) REFERENCES salon(id_salon);