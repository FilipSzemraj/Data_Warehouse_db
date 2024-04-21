--Ranking iloœci zawartych umów przez pracowników.
SELECT pracownicy.imie AS IMIE, pracownicy.nazwisko AS NAZWISKO,
salon.nazwa AS SALON,ILOSC_UMOW, RANKING
FROM
(SELECT pracownicy.id_pracownik id_prac, salon.id_salon id_sal,
COUNT(umowa.id_umowa) as ILOSC_UMOW, DENSE_RANK() OVER (ORDER BY COUNT(umowa.id_umowa) DESC) AS RANKING
FROM umowa, pracownicy, salon
WHERE salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
GROUP BY (pracownicy.id_pracownik, salon.id_salon)), pracownicy, salon
WHERE salon.id_salon = id_sal
AND pracownicy.id_pracownik = id_prac;

--Ranking iloœci umów w danych salonach.
SELECT salon.nazwa AS NAZWA_SALONU,
miasta.nazwa AS MIASTO,
ulica.nazwa AS ULICA,ILOSC_UMOW,RANKING
FROM
(SELECT salon.id_salon id_sal, miasta.id_miasta id_miasto, ulica.id_ulica id_ul,
COUNT(umowa.id_umowa) as ILOSC_UMOW, DENSE_RANK() OVER (ORDER BY COUNT(umowa.id_umowa) DESC) AS RANKING
FROM salon, miasta, umowa, ulica, magazyn, pracownicy
WHERE miasta.id_miasta = ulica.miasta_id_miasta
AND ulica.id_ulica = salon.ulica_id_ulica
AND salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
AND magazyn.id_magazyn = umowa.magazyn_id_magazyn
GROUP BY (salon.id_salon, miasta.id_miasta, ulica.id_ulica)),salon, miasta,ulica
WHERE salon.id_salon = id_sal
AND miasta.id_miasta = id_miasto
AND ulica.id_ulica = id_ul;

--Ranking zawartych umów przez klientów
SELECT klient.imie as IMIE,
klient.nazwisko as NAZWISKO, ILOSC_UMOW, RANKING
FROM
(SELECT klient.id_klient id_kl,
COUNT(umowa.id_umowa) AS ILOSC_UMOW, DENSE_RANK() OVER(ORDER BY COUNT(umowa.id_umowa)DESC) AS RANKING
FROM klient, umowa
WHERE umowa.klient_id_klient = klient.id_klient
GROUP BY (klient.id_klient)),klient
WHERE klient.id_klient = id_kl;
