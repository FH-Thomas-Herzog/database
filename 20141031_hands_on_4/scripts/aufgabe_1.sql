-- 1. actors not living int eh US
SELECT SCHAUSPIELER_ID, CONCAT(NACHNAME, CONCAT(', ', VORNAME)) AS VOLLER_NAME, STAAT, ORT
FROM SCHAUSPIELER
WHERE STAAT != 'US'
AND GESCHLECHT = 'W';

-- 2. actors with no awards
SELECT SCHAUSPIELER_ID, CONCAT(NACHNAME, CONCAT(', ', VORNAME)) AS VOLLER_NAME, STAAT, ORT
FROM SCHAUSPIELER
WHERE AUSZEICHNUNG IS NULL;

-- 3. movies shown in cinemas which name contains 'Mega'
SELECT DISTINCT f.TITEL, v.KINO
FROM VORFUEHRUNGEN v
INNER JOIN FILM f ON v.FILM_ID =  f.FILM_ID
WHERE v.KINO LIKE '%Mega%';

-- 4. actors part of movie 'Terminator 3'
SELECT f.TITEL, CONCAT(s.NACHNAME, CONCAT(', ', s.VORNAME)) AS VOLLER_NAME
FROM FILM f
INNER JOIN ROLLE r ON r.FILM_ID = f.FILM_ID
INNER JOIN SCHAUSPIELER s ON s.SCHAUSPIELER_ID = r.SCHAUSPIELER_ID
WHERE f.TITEL = 'Terminator 3';

-- 5. actors part of movie 'Terminator 3' and what was their first movie
-- Will select all actors event if they do not have a first movie
SELECT f.TITEL, CONCAT(s.NACHNAME, CONCAT(', ', s.VORNAME)) AS VOLLER_NAME, COALESCE(fe.TITEL, 'nicht verf�gbar') AS ERSTER_FILM
FROM FILM f
INNER JOIN ROLLE r ON r.FILM_ID = f.FILM_ID
INNER JOIN SCHAUSPIELER s ON s.SCHAUSPIELER_ID = r.SCHAUSPIELER_ID
LEFT OUTER JOIN FILM fe ON fe.FILM_ID = s.ERSTER_FILM
WHERE f.TITEL = 'Terminator 3';

-- 6. all movies with their playing cinemas if present
SELECT f.TITEL, CONCAT(COALESCE(v.STAAT, 'none'), CONCAT(', ', COALESCE(v.ORT, 'none'))) AS LOCATION
FROM FILM f
LEFT OUTER JOIN VORFUEHRUNGEN v ON v.FILM_ID = f.FILM_ID
ORDER BY f.TITEL, f.JAHR DESC;

-- 7. actors which market value fell undee the first payment
SELECT CONCAT(s.NACHNAME, CONCAT(', ', s.VORNAME)) AS VOLLER_NAME, s.MARKT_WERT, f.TITEL, r.GAGE, (s.MARKT_WERT - r.GAGE) AS DIFFERENZ
FROM SCHAUSPIELER s
INNER JOIN ROLLE r ON (r.SCHAUSPIELER_ID = s.SCHAUSPIELER_ID) AND (r.FILM_ID = s.ERSTER_FILM)
INNER JOIN FILM f ON f.FILM_ID = r.FILM_ID
GROUP BY s.NACHNAME, s.VORNAME, s.MARKT_WERT, f.TITEL, r.GAGE, s.MARKT_WERT
HAVING s.MARKT_WERT < SUM(r.GAGE);

-- 8. how many presentations of movie 'Terminator 3'
SELECT SUM(v.ANZAHL_VORFUEHRUNGEN) AS ANZAHL
FROM VORFUEHRUNGEN v
INNER JOIN FILM f ON f.FILM_ID = v.FILM_ID
WHERE f.TITEL = 'Terminator 3';

-- 9. count of movies which were released per year. 
SELECT JAHR, COUNT(FILM_ID) AS ANZAHL
FROM FILM
GROUP BY JAHR
ORDER BY JAHR DESC;

-- 10. summary of turn over of the moviews
SELECT f.TITEL, COALESCE(SUM(v.UMSATZ), 0) AS GESAMTUMSATZ
FROM FILM f
LEFT OUTER JOIN VORFUEHRUNGEN v ON v.FILM_ID = f.FILM_ID
GROUP BY f.TITEL
ORDER BY GESAMTUMSATZ DESC;

-- 11. which movie had more than 1000 presentations
SELECT f.TITEL, SUM(v.ANZAHL_VORFUEHRUNGEN) AS ANZAHL
FROM FILM f
INNER JOIN VORFUEHRUNGEN v ON v.FILM_ID = f.FILM_ID
GROUP BY f.TITEL
HAVING SUM(v.ANZAHL_VORFUEHRUNGEN) > 1000
ORDER BY ANZAHL DESC;

-- 12. which movies have less turn over than production costs
SELECT f.TITEL, SUM(v.UMSATZ) AS UMSATZ
FROM FILM f
INNER JOIN VORFUEHRUNGEN v ON v.FILM_ID = f.FILM_ID
GROUP BY f.TITEL, f.KOSTEN
HAVING SUM(v.UMSATZ) < f.KOSTEN
ORDER BY UMSATZ DESC;
 
 -- 13. Which movies haven't been presented yet
SELECT f.TITEL
FROM FILM f
WHERE f.FILM_ID NOT IN (
   SELECT DISTINCT FILM_ID
   FROM VORFUEHRUNGEN
);
 
-- 14. which actor has the highest market value
SELECT CONCAT(s.NACHNAME, CONCAT(', ', s.VORNAME)) AS VOLLER_NAME, s.MARKT_WERT
FROM (
    SELECT MAX(MARKT_WERT) AS MAX_VALUE
    FROM SCHAUSPIELER
) maxMarketValue
INNER JOIN SCHAUSPIELER s ON s.MARKT_WERT = maxMarketValue.MAX_VALUE
ORDER BY VOLLER_NAME;

-- 15. Which actors have a higher market value the the actor with the lowest.
-- If two of the actors have the same lowest marktet value, then these actor will
-- not be part fo the result set
SELECT CONCAT(NACHNAME, CONCAT(', ', VORNAME)) AS VOLLER_NAME, MARKT_WERT
FROM (
    SELECT MIN(MARKT_WERT) AS MIN_VALUE
    FROM SCHAUSPIELER
) minMarketValue
INNER JOIN SCHAUSPIELER s ON s.MARKT_WERT > minMarketValue.MIN_VALUE;

-- 16. Which actor earned the most money with salaries 
-- If two actor have the same highest value then both are selected
SELECT sumGage.VOLLER_NAME, sumGage.GAGE
FROM (
    SELECT CONCAT(s.NACHNAME, CONCAT(', ', s.VORNAME)) AS VOLLER_NAME, SUM(r.GAGE) AS GAGE
    FROM ROLLE r
    INNER JOIN SCHAUSPIELER s ON s.SCHAUSPIELER_ID = r.SCHAUSPIELER_ID
    GROUP BY s.VORNAME, s.NACHNAME
) sumGage
INNER JOIN (
    SELECT MAX(joinGage.GAGE) AS GAGE
    FROM (
        SELECT r.SCHAUSPIELER_ID AS S_ID, SUM(r.GAGE) AS GAGE
        FROM ROLLE r
        GROUP BY r.SCHAUSPIELER_ID
    ) joinGage
) maxGage ON sumGage.GAGE = maxGage.GAGE;

-- 17. which actor earned more than the average earned
SELECT sumGage.VOLLER_NAME, sumGage.GAGE
FROM (
    SELECT CONCAT(s.NACHNAME, CONCAT(', ', s.VORNAME)) AS VOLLER_NAME, SUM(r.GAGE) AS GAGE
    FROM ROLLE r
    INNER JOIN SCHAUSPIELER s ON s.SCHAUSPIELER_ID = r.SCHAUSPIELER_ID
    GROUP BY s.VORNAME, s.NACHNAME
) sumGage
INNER JOIN (
    SELECT AVG(joinGage.GAGE) AS GAGE
    FROM (
        SELECT r.SCHAUSPIELER_ID AS S_ID, SUM(r.GAGE) AS GAGE
        FROM ROLLE r
        GROUP BY r.SCHAUSPIELER_ID
    ) joinGage
) avgGage ON sumGage.GAGE > avgGage.GAGE;


