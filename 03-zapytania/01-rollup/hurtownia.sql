-- Zestawienie iloœci umów w danym mieœcie i salonach.
SELECT CASE WHEN SALON = 'Wszystkie salony' THEN 'Wszystkie salony' ELSE (SELECT w_salon.nazwa FROM w_salon WHERE id_salon = SALON) END AS NAZWA_SALONU,
CASE WHEN MIASTO = 'Wszystkie miasta' THEN 'Wszystkie miasta' ELSE (SELECT w_miasta.nazwa FROM w_miasta WHERE id_miasta = MIASTO) END AS NAZWA_MIASTA,
ILOSC 
FROM(
SELECT NVL(TO_CHAR(w_miasta.id_miasta),'Wszystkie miasta') AS MIASTO, NVL(TO_CHAR(w_salon.id_salon),'Wszystkie salony') AS SALON, COUNT(w_umowa.id_umowa) ILOSC
FROM w_miasta, w_ulica, w_umowa, w_salon
WHERE w_miasta.id_miasta = w_umowa.w_miasta_id_miasta
AND w_ulica.id_ulica = w_umowa.w_ulica_id_ulica
AND w_salon.id_salon = w_umowa.w_salon_id_salon
GROUP BY ROLLUP(w_miasta.id_miasta,w_salon.id_salon))
ORDER BY ILOSC ASC;

--Zestawienie ilosci umow w danych salonach dla pracowników.
SELECT CASE WHEN ID_SAL IS NULL THEN 'Wszystkie_salony'
ELSE (SELECT nazwa FROM w_salon WHERE id_salon = ID_SAL) END AS NAZWA_SALONU,
CASE WHEN ID_SAL IS NULL THEN 0
ELSE (SELECT id_salon FROM w_salon WHERE id_salon = ID_SAL) END AS ID_SALONU,
(SELECT w_pracownicy.imie FROM w_pracownicy WHERE w_pracownicy.id_pracownik = ID_PRAC) as IMIE, (SELECT w_pracownicy.nazwisko FROM w_pracownicy WHERE w_pracownicy.id_pracownik = ID_PRAC) as NAZWISKO, ILOSC
FROM (
SELECT w_salon.id_salon AS ID_SAL, w_pracownicy.id_pracownik AS ID_PRAC, COUNT(w_umowa.id_umowa) AS ILOSC
FROM w_pracownicy, w_umowa, w_salon
WHERE w_salon.id_salon = w_umowa.w_salon_id_salon
AND w_pracownicy.id_pracownik = w_umowa.w_pracownicy_id_pracownik
GROUP BY ROLLUP(w_salon.id_salon, w_pracownicy.id_pracownik)
)
ORDER BY ILOSC ASC;

--Ilosc zawartych umow dla danych modeli telefonow.
SELECT CASE WHEN MARKA = 'Wszystkie marki' THEN 'Wszystkie marki' 
ELSE (SELECT w_marka.nazwa FROM w_marka WHERE id_marka = MARKA) END AS NAZWA_MARKI,
CASE WHEN MODEL = 'Wszystkie modele' THEN 'Wszystkie modele' 
ELSE (SELECT w_model.nazwa FROM w_model WHERE id_model = MODEL) END AS NAZWA_MODELU,
CASE WHEN KOLOR = 'Wszystkie kolory' THEN 'Wszystkie kolory' 
ELSE (SELECT w_kolor.nazwa FROM w_kolor WHERE id_kolor = KOLOR) END AS NAZWA_KOLORU,
ILOSC FROM(
	SELECT NVL(TO_CHAR(w_marka.id_marka),'Wszystkie marki') as MARKA,
	NVL(TO_CHAR(w_model.id_model),'Wszystkie modele') AS MODEL,
	NVL(TO_CHAR(w_kolor.id_kolor),'Wszystkie kolory') AS KOLOR, 
	COUNT(w_umowa.id_umowa) AS ILOSC
	FROM 
	w_model, w_umowa, w_marka, w_kolor
	WHERE w_marka.id_marka = w_umowa.w_marka_id_marka
	AND w_model.id_model = w_umowa.w_model_id_model
	AND w_kolor.id_kolor = w_umowa.w_kolor_id_kolor
	GROUP BY ROLLUP(w_marka.id_marka,w_model.id_model,w_kolor.id_kolor)
);