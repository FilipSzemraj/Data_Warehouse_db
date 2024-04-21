-- Zestawienie iloœci umów w danym mieœcie i salonach
SELECT CASE WHEN SALON = 'RAZEM' THEN 'RAZEM' ELSE (SELECT salon.nazwa FROM salon WHERE id_salon = SALON) END AS NAZWA_SALONU,
CASE WHEN miasto = 'RAZEM' THEN 'RAZEM' ELSE(SELECT miasta.nazwa FROM miasta WHERE id_miasta=miasto) END AS NAZWA_MIASTA, SALON, ILOSC FROM(
SELECT NVL(TO_CHAR(miasta.id_miasta),'RAZEM') as miasto, NVL(TO_CHAR(salon.id_salon),'RAZEM') AS SALON, COUNT(umowa.id_umowa) AS ILOSC
FROM miasta, ulica, umowa, salon, pracownicy
WHERE miasta.id_miasta = ulica.miasta_id_miasta
AND ulica.id_ulica = salon.ulica_id_ulica
AND salon.id_salon = pracownicy.salon_id_salon
AND umowa.pracownicy_id_pracownik = pracownicy.id_pracownik
GROUP BY ROLLUP(miasta.id_miasta,salon.id_salon)
)ORDER BY ILOSC ASC;

--Zestawienie ilosci umow w danych salonach dla pracowników
SELECT CASE WHEN ID_SAL IS NULL THEN 'Wszystkie_salony'
ELSE (SELECT nazwa FROM salon WHERE id_salon = ID_SAL) END AS NAZWA_SALONU,
CASE WHEN ID_SAL IS NULL THEN 0
ELSE (SELECT id_salon FROM salon WHERE id_salon = ID_SAL) END AS ID_SALONU,
(SELECT pracownicy.imie FROM pracownicy WHERE pracownicy.id_pracownik = ID_PRAC) as IMIE, 
(SELECT pracownicy.nazwisko FROM pracownicy WHERE pracownicy.id_pracownik = ID_PRAC) as NAZWISKO, ILOSC
FROM (
SELECT salon.id_salon AS ID_SAL, pracownicy.id_pracownik AS ID_PRAC, 
COUNT(umowa.id_umowa) AS ILOSC
FROM pracownicy, umowa, salon
WHERE salon.id_salon = pracownicy.salon_id_salon
AND pracownicy.id_pracownik = umowa.pracownicy_id_pracownik
GROUP BY ROLLUP(salon.id_salon, pracownicy.id_pracownik)
)zagniezdzone
ORDER BY ILOSC ASC;

--Ilosc zawartych umow dla danych modeli telefonow
SELECT CASE WHEN MARKA = 'Wszystkie marki' THEN 'Wszystkie marki' 
ELSE (SELECT marka.nazwa FROM marka WHERE id_marka = MARKA)END AS NAZWA_MARKI,
CASE WHEN MODEL = 'Wszystkie modele' THEN 'Wszystkie modele' 
ELSE (SELECT model.nazwa FROM model WHERE id_model = MODEL)END AS NAZWA_MODELU,
CASE WHEN KOLOR = 'Wszystkie kolory' THEN 'Wszystkie kolory' 
ELSE (SELECT kolor.nazwa FROM kolor WHERE id_kolor = KOLOR)END AS NAZWA_KOLORU,ILOSC 
FROM (
SELECT NVL(TO_CHAR(marka.id_marka),'Wszystkie marki') as MARKA,
NVL(TO_CHAR(model.id_model),'Wszystkie modele') AS MODEL,
NVL(TO_CHAR(kolor.id_kolor),'Wszystkie kolory') AS KOLOR, 
COUNT(umowa.id_umowa) AS ILOSC
FROM model, telefony, magazyn, umowa, marka, kolor
WHERE kolor.id_kolor = telefony.kolor_id_kolor 
AND marka.id_marka = model.marka_id_marka 
AND model.id_model = telefony.model_id_model
AND telefony.id_telefon = magazyn.telefony_id_telefon
AND umowa.magazyn_id_magazyn = magazyn.id_magazyn
GROUP BY ROLLUP(marka.id_marka,model.id_model,kolor.id_kolor))
ORDER BY ILOSC ASC;