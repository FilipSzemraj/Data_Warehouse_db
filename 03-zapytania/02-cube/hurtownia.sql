--Liczba klientów dla kombinacji marek telefonów, modeli, kolorów.
SELECT CASE WHEN MARKA = 'Wszystkie marki' THEN 'Wszystkie marki' ELSE(SELECT nazwa FROM w_marka WHERE id_marka = MARKA) END AS NAZWA_MARKI,
CASE WHEN MODEL = 'Wszystkie modele' THEN 'Wszystkie modele' ELSE(SELECT nazwa FROM w_model WHERE id_model = MODEL) END AS NAZWA_MODELU,
CASE WHEN KOLOR = 'Wszystkie kolory' THEN 'Wszystkie kolory' ELSE(SELECT nazwa FROM w_kolor WHERE id_kolor = KOLOR) END AS NAZWA_KOLORU,
LICZBA_KLIENTOW FROM(
SELECT NVL(TO_CHAR(w_marka.id_marka), 'Wszystkie marki') AS MARKA, NVL(TO_CHAR(w_model.id_model), 'Wszystkie modele') AS MODEL,
NVL(TO_CHAR(w_kolor.id_kolor), 'Wszystkie kolory') AS KOLOR, COUNT(w_klient.id_klient) AS LICZBA_KLIENTOW
FROM w_marka, w_model,w_umowa, w_klient, w_kolor
WHERE w_marka.id_marka = w_umowa.w_marka_id_marka
AND w_model.id_model = w_umowa.w_model_id_model
AND w_kolor.id_kolor = w_umowa.w_kolor_id_kolor
AND w_klient.id_klient = w_umowa.w_klient_id_klient
GROUP BY CUBE(w_marka.id_marka, w_model.id_model, w_kolor.id_kolor));

--Œrednia cena umów dla kombinacji marek telefonów i stanowisk pracownikow.
SELECT CASE WHEN MARKA = 'Wszystkie marki' THEN 'Wszystkie marki' ELSE(SELECT nazwa FROM w_marka WHERE id_marka = MARKA) END AS NAZWA_MARKI,
CASE WHEN STANOWISKO = 'Œrednia_cena_umowy' THEN 'Œrednia_cena_umowy' ELSE(SELECT nazwa FROM w_stanowisko WHERE id_stanowiska = STANOWISKO) END AS NAZWA_STANOWISKA,
SREDNIA_CENA_UMOW FROM(
SELECT NVL(TO_CHAR(w_marka.id_marka), 'Wszystkie marki') AS MARKA, NVL(TO_CHAR(w_stanowisko.id_stanowiska), 'Œrednia_cena_umowy') AS STANOWISKO, 
ROUND(AVG(w_umowa.cena),2) AS SREDNIA_CENA_UMOW
FROM w_marka, w_umowa, w_pracownicy, w_stanowisko
WHERE w_marka.id_marka = w_umowa.w_marka_id_marka
AND w_pracownicy.id_pracownik = w_umowa.w_pracownicy_id_pracownik
AND w_stanowisko.id_stanowiska = w_umowa.w_stanowisko_id_stanowiska
GROUP BY CUBE(w_marka.id_marka, w_stanowisko.id_stanowiska));

--Œrednia wartoœæ umów w danym wojewodztwie.
SELECT CASE WHEN wojewodztwo = 'Wszystkie wojewodztwa' THEN 'Wszystkie wojewodztwa' 
ELSE(SELECT nazwa FROM wojewodztwo WHERE id_wojewodztwa = wojewodztwo) END AS NAZWA_WOJEWODZTWA,
rok,srednia_cena_umowy FROM(
SELECT NVL(TO_CHAR(w_wojewodztwo.id_wojewodztwa),'Wszystkie wojewodztwa') AS wojewodztwo, NVL(TO_CHAR(w_rok.rok),'Kazdy rok') AS rok,ROUND(AVG(w_umowa.cena),2) AS srednia_cena_umowy
FROM w_umowa,w_wojewodztwo,w_rok
WHERE w_umowa.w_wojewodztwo_id_wojewodztwa  = w_wojewodztwo.id_wojewodztwa
AND w_rok.id_rok = w_umowa.w_rok_id_rok
GROUP BY CUBE (w_wojewodztwo.id_wojewodztwa, w_rok.rok))
ORDER BY wojewodztwo, rok;