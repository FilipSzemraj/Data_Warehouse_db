--Œrednia wydanych pieniedzy w danym salonie.
SELECT DISTINCT w_salon.nazwa AS NAZWA_SALONU, w_ulica.nazwa AS ULICA, w_miasta.nazwa AS MIASTO,
ROUND(AVG(w_umowa.cena) over (PARTITION BY w_salon.id_salon),2) AS SREDNIA_WYDANYCH_PIENIEDZY
FROM w_salon, w_umowa, w_ulica, w_miasta
WHERE w_salon.id_salon = w_umowa.w_salon_id_salon
AND w_ulica.id_ulica = w_umowa.w_ulica_id_ulica
AND w_miasta.id_miasta = w_umowa.w_miasta_id_miasta
ORDER BY srednia_wydanych_pieniedzy DESC;

--Œrednia wartoœæ umowy w danych wojewodztwach
SELECT DISTINCT w_wojewodztwo.nazwa AS NAZWA_WOJEWODZTWA,
ROUND(AVG(w_umowa.cena) OVER (PARTITION BY w_wojewodztwo.id_wojewodztwa),2) AS SREDNIA_CENA_UMOWY
FROM w_umowa,w_wojewodztwo
WHERE w_wojewodztwo.id_wojewodztwa = w_umowa.w_wojewodztwo_id_wojewodztwa
ORDER BY SREDNIA_CENA_UMOWY DESC;

--Sprzeda¿ danego modelu.
SELECT DISTINCT w_marka.nazwa AS NAZWA_MARKI,w_model.nazwa AS NAZWA_MODELU, 
w_kolor.nazwa AS KOLOR,
COUNT(w_umowa.id_umowa) OVER (PARTITION BY w_telefony.id_telefon) AS SPRZEDAZ_MODELU
FROM w_model, w_telefony,w_umowa,w_marka, w_kolor
WHERE w_model.id_model = w_umowa.w_model_id_model
AND w_telefony.id_telefon = w_umowa.w_telefony_id_telefon
AND w_marka.id_marka = w_umowa.w_marka_id_marka
AND w_kolor.id_kolor = w_umowa.w_kolor_id_kolor
ORDER BY w_marka.nazwa, NAZWA_MODELU DESC;