create or replace procedure Load_Magazyn as
begin insert into W_Magazyn select Id_magazyn from Magazyn; end;
/
create or replace procedure Load_Kolor as
begin insert into W_Kolor select Id_kolor, Nazwa from Kolor; end;
/
create or replace procedure Load_Ulica as
begin insert into W_Ulica select Id_ulica, Nazwa from Ulica; end;
/
create or replace procedure Load_Miasta as
begin insert into W_Miasta select Id_miasta, Nazwa from Miasta; end;
/
create or replace procedure Load_Telefony as
begin insert into W_Telefony select Id_telefon from Telefony; end;
/
create or replace procedure Load_Wojewodztwo as
begin insert into W_Wojewodztwo select Id_wojewodztwa, Nazwa from Wojewodztwo; end;
/
create or replace procedure Load_Pracownicy as
begin insert into W_Pracownicy select Id_pracownik, Imie, Nazwisko from Pracownicy; end;
/
create or replace procedure Load_Stanowisko as
begin insert into W_Stanowisko select s.id_stanowiska, s.nazwa FROM stanowisko s; end;
/
create or replace procedure Load_Salon as
begin insert into W_Salon select Id_salon, Nazwa from Salon; end;
/
create or replace procedure Load_Klient as
begin insert into W_Klient select Id_klient, Imie, Nazwisko from Klient; end;
/
create or replace procedure Load_Model as
begin insert into W_Model select Id_model, Nazwa from Model; end;
/
create or replace procedure Load_Marka as
begin insert into W_Marka select Id_marka, Nazwa from Marka; end;
/
create or replace procedure Load_Rok as
begin insert into W_Rok select id_umowa, EXTRACT(YEAR FROM data) from umowa ; end;
/
create or replace procedure Load_Miesiac as
begin insert into W_Miesiac select id_umowa,
CASE EXTRACT(MONTH FROM data)
WHEN 1 THEN 'Styczen'
WHEN 2 THEN 'Luty'
WHEN 3 THEN 'Marzec'
WHEN 4 THEN 'Kwiecien'
WHEN 5 THEN 'Maj'
WHEN 6 THEN 'Czerwiec'
WHEN 7 THEN 'Lipiec'
WHEN 8 THEN 'Sierpien'
WHEN 9 THEN 'Wrzesien'
WHEN 10 THEN 'Pazdziernik'
WHEN 11 THEN 'Listopad'
WHEN 12 THEN 'Grudzien'
END
FROM umowa;
end;
/
create or replace procedure Load_Umowa as
begin insert into W_UMOWA 
select umowa.id_umowa,umowa.cena,salon.id_salon,umowa.pracownicy_id_pracownik,
wojewodztwo.id_wojewodztwa,telefony.id_telefon,miasta.id_miasta,ulica.id_ulica,
kolor.id_kolor,marka.id_marka, model.id_model,umowa.magazyn_id_magazyn,
umowa.klient_id_klient,umowa.id_umowa,umowa.id_umowa,stanowisko.id_stanowiska 
FROM 
umowa,salon,pracownicy,wojewodztwo,telefony,miasta,ulica,kolor,marka,model,magazyn,stanowisko
WHERE wojewodztwo.id_wojewodztwa = miasta.wojewodztwo_id_wojewodztwa
AND miasta.id_miasta = ulica.miasta_id_miasta
AND ulica.id_ulica = salon.ulica_id_ulica
AND salon.id_salon = pracownicy.salon_id_salon
AND stanowisko.id_stanowiska = pracownicy.stanowisko_id_stanowiska
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
AND magazyn.id_magazyn = umowa.magazyn_id_magazyn
AND marka.id_marka = model.marka_id_marka
AND model.id_model = telefony.model_id_model
AND kolor.id_kolor = telefony.kolor_id_kolor
AND telefony.id_telefon = magazyn.telefony_id_telefon;
end;
/
execute Load_Magazyn;
execute Load_Kolor;
execute Load_Ulica;
execute Load_Miasta;
execute Load_Telefony;
execute Load_Wojewodztwo;
execute Load_Pracownicy;
execute Load_Stanowisko;
execute Load_Salon;
execute Load_Klient;
execute Load_Model;
execute Load_Marka;
execute Load_Rok;
execute Load_Miesiac;
execute Load_UMOWA;
