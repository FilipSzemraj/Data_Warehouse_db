-- Roczna liczba zawarcia umów w miastach.
SELECT DISTINCT w_miasta.nazwa AS MIASTO,w_rok.rok AS ROK,
COUNT(w_umowa.id_umowa) OVER (PARTITION BY w_miasta.id_miasta, w_rok.rok
ORDER BY w_rok.rok RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ilosc_umow
FROM w_umowa, w_miasta, w_rok
WHERE w_miasta.id_miasta = w_umowa.w_miasta_id_miasta
AND w_rok.id_rok = w_umowa.w_rok_id_rok
ORDER BY MIASTO, ROK DESC;

-- Iloœæ zawartych umów w danym salonie w ka¿dym roku.
SELECT DISTINCT w_salon.nazwa AS NAZWA_SALONU, w_salon.id_salon, w_rok.rok AS ROK,
COUNT(w_umowa.id_umowa) OVER (PARTITION BY w_salon.id_salon, w_rok.rok
ORDER BY w_rok.rok RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ilosc_umow
FROM w_pracownicy, w_salon, w_umowa, w_rok
WHERE w_salon.id_salon = w_umowa.w_salon_id_salon
AND w_rok.id_rok = w_umowa.w_rok_id_rok
AND w_pracownicy.id_pracownik = w_umowa.w_pracownicy_id_pracownik
ORDER BY ROK, ilosc_umow DESC;

--Miesiêczna ró¿nica œredniej wartoœci umowy w danych miastach.
SELECT DISTINCT w_miasta.nazwa AS MIASTO,miesiac AS MIESIAC,
srednia AS SREDNIA_CENA,
ROUND(NVL(srednia - LAG(srednia,1) OVER (PARTITION BY w_miasta.id_miasta ORDER BY miesiac DESC),0),2) AS roznica_sredniej
FROM(
SELECT w_miasta.id_miasta id_miasto, ROUND(AVG(w_umowa.cena),2) AS srednia,
w_miesiac.miesiac AS miesiac
FROM w_miasta, w_miesiac, w_umowa
WHERE w_miasta.id_miasta = w_umowa.w_miasta_id_miasta
AND w_miesiac.id_miesiac = w_umowa.w_miesiac_id_miesiac
GROUP BY (w_miasta.id_miasta, w_miesiac.miesiac)),w_miasta
WHERE w_miasta.id_miasta = id_miasto;