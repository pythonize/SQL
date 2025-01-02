USE sakila;

SET @var1 = 2;
SET @var2 = 4;
SET @var3 = 2.4;
SET @var4 = 'SUAN';

SELECT @var1, @var2, @var3, @var4;

SELECT @var4, last_name
FROM customer;

SET @last_name = 'ADAM';

PREPARE name_query
FROM 'SELECT *
FROM customer
WHERE last_name = ?';

EXECUTE name_query USING @last_name;


SET @topk = 20;

PREPARE limit_query
FROM 'SELECT *
FROM customer
LIMIT ?';

EXECUTE limit_query USING @topk;


SET @rating = 'PG';
SET @title = '%AGENT%';

PREPARE film_query
FROM 'SELECT *
FROM film
WHERE rating = ? AND title LIKE ?';

EXECUTE film_query USING @rating, @title;


SELECT CAST(2.34 AS SIGNED INTEGER);
SELECT CAST(2.34 AS FLOAT);
SELECT CAST(2.34 AS DECIMAL(5, 3));
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);

SELECT CONVERT(2.34, SIGNED INTEGER);
SELECT CONVERT(2.34, FLOAT);
SELECT CONVERT(2.34, DECIMAL(5, 3));
SELECT CONVERT('2022/12/12', DATE);
SELECT CONVERT('2022.12.12', DATE);