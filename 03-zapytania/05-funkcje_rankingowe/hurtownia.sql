--Ranking iloœci zawartych umów przez pracowników.
SELECT w_pracownicy.imie AS IMIE, w_pracownicy.nazwisko AS NAZWISKO,
w_salon.nazwa AS SALON,ILOSC_UMOW, RANKING
FROM
(SELECT w_pracownicy.id_pracownik id_prac, w_salon.id_salon id_sal,
COUNT(w_umowa.id_umowa) as ILOSC_UMOW, DENSE_RANK() OVER (ORDER BY COUNT(w_umowa.id_umowa) DESC) AS RANKING
FROM w_umowa, w_pracownicy, w_salon
WHERE w_pracownicy.id_pracownik = w_umowa.w_pracownicy_id_pracownik
AND w_salon.id_salon = w_umowa.w_salon_id_salon
GROUP BY (w_pracownicy.id_pracownik, w_salon.id_salon)), w_pracownicy, w_salon
WHERE w_salon.id_salon = id_sal
AND w_pracownicy.id_pracownik = id_prac;

--Ranking iloœci umów w danych salonach.
SELECT w_salon.nazwa AS NAZWA_SALONU, w_miasta.nazwa AS MIASTO, w_ulica.nazwa, ILOSC, RANKING
FROM(
SELECT w_salon.id_salon id_sal,w_miasta.id_miasta id_miasto,w_ulica.id_ulica id_ul, COUNT(w_umowa.id_umowa) AS ILOSC,
DENSE_RANK() OVER(ORDER BY COUNT(w_umowa.id_umowa)DESC) AS RANKING
FROM w_salon, w_umowa, w_miasta, w_ulica
WHERE w_salon.id_salon  = w_umowa.w_salon_id_salon
AND w_miasta.id_miasta = w_umowa.w_miasta_id_miasta
AND w_ulica.id_ulica = w_umowa.w_ulica_id_ulica
GROUP BY (w_salon.id_salon, w_miasta.id_miasta, w_ulica.id_ulica)),w_salon,w_miasta,w_ulica
WHERE w_salon.id_salon = id_sal
AND w_miasta.id_miasta = id_miasto
AND w_ulica.id_ulica = id_ul;

--Ranking zawartych umów przez klientów.
SELECT w_klient.imie AS IMIE, w_klient.nazwisko as NAZWISKO,ILOSC_UMOW, RANKING
FROM(
SELECT w_klient.id_klient id_kl,
COUNT(w_umowa.id_umowa) AS ILOSC_UMOW, DENSE_RANK() OVER(ORDER BY COUNT(w_umowa.id_umowa)DESC) AS RANKING
FROM w_umowa, w_klient
WHERE w_umowa.w_klient_id_klient = w_klient.id_klient
GROUP BY w_klient.id_klient), w_klient
WHERE w_klient.id_klient = id_kl;