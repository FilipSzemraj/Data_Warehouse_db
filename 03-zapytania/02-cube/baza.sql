--Liczba klientów dla kombinacji marek telefonów, modeli, kolorów.
SELECT CASE WHEN MARKA = 'Wszystkie marki' THEN 'Wszystkie marki' ELSE(SELECT nazwa FROM marka WHERE id_marka = MARKA) END AS NAZWA_MARKI,
CASE WHEN MODEL = 'Wszystkie modele' THEN 'Wszystkie modele' ELSE(SELECT nazwa FROM model WHERE id_model = MODEL) END AS NAZWA_MODELU,
CASE WHEN KOLOR = 'Wszystkie kolory' THEN 'Wszystkie kolory' ELSE(SELECT nazwa FROM kolor WHERE id_kolor = KOLOR) END AS NAZWA_KOLORU,
LICZBA_KLIENTOW FROM(
SELECT NVL(TO_CHAR(marka.id_marka), 'Wszystkie marki') AS MARKA, NVL(TO_CHAR(model.id_model), 'Wszystkie modele') AS MODEL, NVL(TO_CHAR(kolor.id_kolor), 'Wszystkie kolory') AS KOLOR, COUNT(klient.id_klient) AS LICZBA_KLIENTOW
FROM marka, model, telefony, magazyn, umowa, klient, kolor
WHERE marka.id_marka = model.marka_id_marka
AND model.id_model = telefony.model_id_model
AND telefony.id_telefon = magazyn.telefony_id_telefon
AND magazyn.id_magazyn = umowa.magazyn_id_magazyn
AND umowa.klient_id_klient = klient.id_klient
AND telefony.kolor_id_kolor = kolor.id_kolor
GROUP BY CUBE(marka.id_marka, model.id_model, kolor.id_kolor));

--Œrednia cena umów dla kombinacji marek telefonów i stanowisk pracownikow.
SELECT CASE WHEN MARKA = 'Wszystkie marki' THEN 'Wszystkie marki' ELSE(SELECT nazwa FROM marka WHERE id_marka = MARKA) END AS NAZWA_MARKI,
CASE WHEN STANOWISKO = 'Œrednia_cena_umowy' THEN 'Œrednia_cena_umowy' ELSE(SELECT nazwa FROM stanowisko WHERE id_stanowiska = STANOWISKO) END AS NAZWA_STANOWISKA,
SREDNIA_CENA_UMOW FROM(
SELECT NVL(TO_CHAR(marka.id_marka), 'Wszystkie marki') AS MARKA, NVL(TO_CHAR(stanowisko.id_stanowiska), 'Œrednia_cena_umowy') AS STANOWISKO, ROUND(AVG(umowa.cena),2) AS SREDNIA_CENA_UMOW
FROM marka, stanowisko, umowa, magazyn, pracownicy, telefony, model
WHERE marka.id_marka = model.marka_id_marka
AND model.id_model = telefony.model_id_model
AND telefony.id_telefon = magazyn.Telefony_Id_telefon
AND magazyn.id_magazyn = umowa.magazyn_id_magazyn
AND umowa.pracownicy_id_pracownik = pracownicy.id_pracownik
AND pracownicy.stanowisko_id_stanowiska = stanowisko.id_stanowiska
GROUP BY CUBE(marka.id_marka, stanowisko.id_stanowiska));

--Œrednia wartoœæ umów w danym wojewodztwie.
SELECT CASE WHEN wojewodztwo = 'Wszystkie wojewodztwa' THEN 'Wszystkie wojewodztwa' 
ELSE(SELECT nazwa FROM wojewodztwo WHERE id_wojewodztwa = wojewodztwo) END AS NAZWA_WOJEWODZTWA,
rok,srednia_cena_umowy FROM(
SELECT NVL(TO_CHAR(wojewodztwo.id_wojewodztwa),'Wszystkie wojewodztwa') AS wojewodztwo, NVL(TO_CHAR(EXTRACT(YEAR FROM umowa.data)),'Kazdy rok') AS rok,
ROUND(AVG(umowa.cena),2) AS srednia_cena_umowy
FROM umowa, magazyn, salon, ulica, miasta, wojewodztwo, pracownicy
WHERE
  umowa.magazyn_id_magazyn = magazyn.id_magazyn
  AND salon.id_salon = pracownicy.salon_id_salon
  AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
  AND salon.ulica_id_ulica = ulica.id_ulica
  AND ulica.miasta_id_miasta = miasta.id_miasta
  AND miasta.wojewodztwo_id_wojewodztwa = wojewodztwo.id_wojewodztwa
GROUP BY CUBE (wojewodztwo.id_wojewodztwa, EXTRACT(YEAR FROM umowa.data)));

