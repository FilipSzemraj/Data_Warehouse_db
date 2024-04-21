DROP TABLE w_klient CASCADE CONSTRAINTS;
DROP TABLE w_magazyn CASCADE CONSTRAINTS;
DROP TABLE w_kolor CASCADE CONSTRAINTS;
DROP TABLE w_ulica CASCADE CONSTRAINTS;
DROP TABLE w_miasta CASCADE CONSTRAINTS;
DROP TABLE w_telefony CASCADE CONSTRAINTS;
DROP TABLE w_wojewodztwo CASCADE CONSTRAINTS;
DROP TABLE w_pracownicy CASCADE CONSTRAINTS;
DROP TABLE w_stanowisko CASCADE CONSTRAINTS;
DROP TABLE w_salon CASCADE CONSTRAINTS;
DROP TABLE w_model CASCADE CONSTRAINTS;
DROP TABLE w_marka CASCADE CONSTRAINTS;
DROP TABLE w_rok CASCADE CONSTRAINTS;
DROP TABLE w_miesiac CASCADE CONSTRAINTS;
DROP TABLE w_umowa CASCADE CONSTRAINTS;

CREATE TABLE w_klient (
    id_klient NUMBER(3) NOT NULL,
    imie      VARCHAR2(10),
    nazwisko  VARCHAR2(11)
);

ALTER TABLE w_klient ADD CONSTRAINT w_klient_pk PRIMARY KEY ( id_klient );

CREATE TABLE w_kolor (
    id_kolor NUMBER(1) NOT NULL,
    nazwa    VARCHAR2(13)
);

ALTER TABLE w_kolor ADD CONSTRAINT w_kolor_pk PRIMARY KEY ( id_kolor );

CREATE TABLE w_magazyn (
    id_magazyn NUMBER(3) NOT NULL
);

ALTER TABLE w_magazyn ADD CONSTRAINT w_magazyn_pk PRIMARY KEY ( id_magazyn );

CREATE TABLE w_marka (
    id_marka NUMBER(1) NOT NULL,
    nazwa    VARCHAR2(9)
);

ALTER TABLE w_marka ADD CONSTRAINT w_marka_pk PRIMARY KEY ( id_marka );

CREATE TABLE w_miasta (
    id_miasta NUMBER(2) NOT NULL,
    nazwa     VARCHAR2(25)
);

ALTER TABLE w_miasta ADD CONSTRAINT w_miasta_pk PRIMARY KEY ( id_miasta );

CREATE TABLE w_miesiac (
    id_miesiac NUMBER(5) NOT NULL,
    miesiac    VARCHAR2(11)
);

ALTER TABLE w_miesiac ADD CONSTRAINT w_miesiac_pk PRIMARY KEY ( id_miesiac );

CREATE TABLE w_model (
    id_model NUMBER(2) NOT NULL,
    nazwa    VARCHAR2(15)
);

ALTER TABLE w_model ADD CONSTRAINT w_model_pk PRIMARY KEY ( id_model );

CREATE TABLE w_pracownicy (
    id_pracownik NUMBER(3) NOT NULL,
    imie         VARCHAR2(10),
    nazwisko     VARCHAR2(11)
);

ALTER TABLE w_pracownicy ADD CONSTRAINT w_pracownicy_pk PRIMARY KEY ( id_pracownik );

CREATE TABLE w_stanowisko(
    id_stanowiska NUMBER(3) NOT NULL,
    nazwa VARCHAR2(24)
);

ALTER TABLE w_stanowisko ADD CONSTRAINT w_stanowisko_pk PRIMARY KEY ( id_stanowiska );

CREATE TABLE w_rok (
    id_rok NUMBER(5) NOT NULL,
    rok    NUMBER(4)
);

ALTER TABLE w_rok ADD CONSTRAINT w_rok_pk PRIMARY KEY ( id_rok );

CREATE TABLE w_salon (
    id_salon NUMBER(3) NOT NULL,
    nazwa    VARCHAR2(12)
);

ALTER TABLE w_salon ADD CONSTRAINT w_salon_pk PRIMARY KEY ( id_salon );

CREATE TABLE w_telefony (
    id_telefon NUMBER(3) NOT NULL
);

ALTER TABLE w_telefony ADD CONSTRAINT w_telefony_pk PRIMARY KEY ( id_telefon );

CREATE TABLE w_ulica (
    id_ulica NUMBER(3) NOT NULL,
    nazwa    VARCHAR2(17)
);

ALTER TABLE w_ulica ADD CONSTRAINT w_ulica_pk PRIMARY KEY ( id_ulica );

CREATE TABLE w_umowa (
    id_umowa                     NUMBER(5) NOT NULL,
    cena                         NUMBER(4),
    w_salon_id_salon             NUMBER(3) NOT NULL,
    w_pracownicy_id_pracownik    NUMBER(3) NOT NULL,
    w_wojewodztwo_id_wojewodztwa NUMBER(2) NOT NULL,
    w_telefony_id_telefon        NUMBER(3) NOT NULL,
    w_miasta_id_miasta           NUMBER(2) NOT NULL,
    w_ulica_id_ulica             NUMBER(3) NOT NULL,
    w_kolor_id_kolor             NUMBER(1) NOT NULL,
    w_marka_id_marka             NUMBER(1) NOT NULL,
    w_model_id_model             NUMBER(2) NOT NULL,
    w_magazyn_id_magazyn         NUMBER(3) NOT NULL,
    w_klient_id_klient           NUMBER(3) NOT NULL,
    w_rok_id_rok                 NUMBER(5) NOT NULL,
    w_miesiac_id_miesiac         NUMBER(5) NOT NULL,
    w_stanowisko_id_stanowiska   NUMBER(5) NOT NULL
);

ALTER TABLE w_umowa ADD CONSTRAINT w_umowa_pk PRIMARY KEY ( id_umowa);

CREATE TABLE w_wojewodztwo (
    id_wojewodztwa NUMBER(2) NOT NULL,
    nazwa          VARCHAR2(21)
);

ALTER TABLE w_wojewodztwo ADD CONSTRAINT w_wojewodztwo_pk PRIMARY KEY ( id_wojewodztwa );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_klient_fk FOREIGN KEY ( w_klient_id_klient )
        REFERENCES w_klient ( id_klient );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_kolor_fk FOREIGN KEY ( w_kolor_id_kolor )
        REFERENCES w_kolor ( id_kolor );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_magazyn_fk FOREIGN KEY ( w_magazyn_id_magazyn )
        REFERENCES w_magazyn ( id_magazyn );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_marka_fk FOREIGN KEY ( w_marka_id_marka )
        REFERENCES w_marka ( id_marka );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_miasta_fk FOREIGN KEY ( w_miasta_id_miasta )
        REFERENCES w_miasta ( id_miasta );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_miesiac_fk FOREIGN KEY ( w_miesiac_id_miesiac )
        REFERENCES w_miesiac ( id_miesiac );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_model_fk FOREIGN KEY ( w_model_id_model )
        REFERENCES w_model ( id_model );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_pracownicy_fk FOREIGN KEY ( w_pracownicy_id_pracownik )
        REFERENCES w_pracownicy ( id_pracownik );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_rok_fk FOREIGN KEY ( w_rok_id_rok )
        REFERENCES w_rok ( id_rok );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_salon_fk FOREIGN KEY ( w_salon_id_salon )
        REFERENCES w_salon ( id_salon );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_telefony_fk FOREIGN KEY ( w_telefony_id_telefon )
        REFERENCES w_telefony ( id_telefon );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_ulica_fk FOREIGN KEY ( w_ulica_id_ulica )
        REFERENCES w_ulica ( id_ulica );

ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_wojewodztwo_fk FOREIGN KEY ( w_wojewodztwo_id_wojewodztwa )
        REFERENCES w_wojewodztwo ( id_wojewodztwa );
        
ALTER TABLE w_umowa
    ADD CONSTRAINT w_umowa_w_stanowisko_fk FOREIGN KEY ( w_stanowisko_id_stanowiska )
        REFERENCES w_stanowisko ( id_stanowiska );