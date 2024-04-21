--Œrednia wydanych pieniedzy w danym salonie.
SELECT DISTINCT salon.nazwa AS NAZWA_SALONU, ulica.nazwa AS ULICA, miasta.nazwa AS MIASTO,
ROUND(AVG(umowa.cena) over (PARTITION BY salon.id_salon),2) AS SREDNIA_WYDANYCH_PIENIEDZY
FROM salon, umowa,magazyn, ulica, miasta, pracownicy
WHERE salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
AND magazyn.id_magazyn = umowa.magazyn_id_magazyn
AND ulica.id_ulica = salon.ulica_id_ulica
AND ulica.miasta_id_miasta = miasta.id_miasta
ORDER BY srednia_wydanych_pieniedzy DESC;

--Œrednia wartoœæ umowy w danych wojewodztwach
SELECT DISTINCT wojewodztwo.nazwa AS NAZWA_WOJEWODZTWA,
ROUND(AVG(umowa.cena) OVER (PARTITION BY wojewodztwo.id_wojewodztwa),2) AS SREDNIA_CENA_UMOWY
FROM miasta, ulica, pracownicy, salon, umowa,wojewodztwo
WHERE wojewodztwo.id_wojewodztwa = miasta.wojewodztwo_id_wojewodztwa
AND miasta.id_miasta = ulica.miasta_id_miasta
AND ulica.id_ulica = salon.ulica_id_ulica
AND salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
ORDER BY SREDNIA_CENA_UMOWY DESC;

--Sprzeda¿ danego modelu.
SELECT DISTINCT marka.nazwa AS NAZWA_MARKI,model.nazwa AS NAZWA_MODELU, 
kolor.nazwa AS KOLOR,
COUNT(umowa.id_umowa) OVER (PARTITION BY telefony.id_telefon) AS SPRZEDAZ_MODELU
FROM model, telefony,magazyn,umowa,marka, kolor
WHERE marka.id_marka = model.marka_id_marka
AND kolor.id_kolor = telefony.kolor_id_kolor
AND model.id_model = telefony.model_id_model
AND magazyn.telefony_id_telefon = telefony.id_telefon
AND umowa.magazyn_id_magazyn = magazyn.id_magazyn
ORDER BY marka.nazwa, NAZWA_MODELU DESC;
