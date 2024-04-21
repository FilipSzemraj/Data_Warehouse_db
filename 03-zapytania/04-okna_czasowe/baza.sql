-- Roczna liczba zawarcia umów w miastach.
SELECT DISTINCT miasta.nazwa AS MIASTO,
EXTRACT (YEAR FROM umowa.data) AS ROK,
COUNT(umowa.id_umowa) over (PARTITION BY miasta.id_miasta, EXTRACT(YEAR FROM umowa.data)
ORDER BY EXTRACT(YEAR FROM umowa.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ilosc_umow
FROM umowa, miasta, ulica, salon, pracownicy
WHERE miasta.id_miasta = ulica.miasta_id_miasta
AND ulica.id_ulica = salon.ulica_id_ulica
AND salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
ORDER BY MIASTO, ROK DESC;

-- Iloœæ zawartych umów w danym salonie w ka¿dym roku.
SELECT DISTINCT salon.nazwa AS NAZWA_SALONU, salon.id_salon,
EXTRACT(YEAR FROM umowa.data) AS ROK,
COUNT(umowa.id_umowa) OVER (PARTITION BY salon.id_salon, EXTRACT (YEAR FROM umowa.data)
ORDER BY EXTRACT(YEAR FROM umowa.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ilosc_umow
FROM pracownicy, salon, umowa
WHERE salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
ORDER BY ROK, ilosc_umow DESC;

--Miesiêczna ró¿nica œredniej wartoœci umowy w danych miastach.
SELECT DISTINCT miasta.nazwa AS MIASTO, miesiac, srednia AS SREDNIA_CENA,
ROUND(NVL(srednia-LAG(srednia,1)OVER(PARTITION BY miasta.id_miasta ORDER BY miesiac DESC),0),2) AS roznica_sredniej
FROM(
SELECT miasta.id_miasta id_miasto, ROUND(AVG(umowa.cena),2) as srednia,
CASE EXTRACT(MONTH FROM umowa.data)
WHEN 1 THEN 'Styczeñ'
WHEN 2 THEN 'Luty'
WHEN 3 THEN 'Marzec'
WHEN 4 THEN 'Kwiecieñ'
WHEN 5 THEN 'Maj'
WHEN 6 THEN 'Czerwiec'
WHEN 7 THEN 'Lipiec'
WHEN 8 THEN 'Sierpieñ'
WHEN 9 THEN 'Wrzesieñ'
WHEN 10 THEN 'PaŸdziernik'
WHEN 11 THEN 'Listopad'
WHEN 12 THEN 'Grudzieñ'
END AS miesiac
FROM miasta, umowa, ulica, salon, pracownicy
WHERE miasta.id_miasta = ulica.miasta_id_miasta
AND ulica.id_ulica = salon.ulica_id_ulica
AND salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
GROUP BY (miasta.id_miasta,EXTRACT(MONTH FROM umowa.data))), miasta
WHERE miasta.id_miasta = id_miasto;