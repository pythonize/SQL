SELECT CEIL(1.0), CEIL(1.4), CEIL(1.8), CEIL(2.0);
# 소수점 이하를 올림하는 CEIL() 함수

SELECT FLOOR(1.0), FLOOR(1.4), FLOOR(1.8), FLOOR(2.0);
# 소수점 이하 내림

SELECT ROUND(1.0), ROUND(1.4), ROUND(1.8), ROUND(2.0);
# 자릿수를 기준으로 반올림

SELECT ROUND (1.23456789, 1),
		ROUND (1.23456789, 4),
        ROUND (1.23456789, 7);
        
SELECT TRUNCATE (1.23456789, 1),
		truncate (1.23456789, 4),
        truncate (1.23456789, 7);
        
SELECT ABS(123), ABS(-123);
# 절대값

SELECT POW(10, 3), POWER(2, 3), SQRT(4);
# 지수 계산 제곱함수와 제곱근 함수

SELECT MOD(10, 3), MOD(20, 7);
# 나머지를 구하는 함수

SELECT GREATEST(12, 4, 18, 2, 8);
# 가장 큰 값을 반환        

SELECT LEAST(12, 4, 18, 2, 8);
# 가장 작은 값을 반환

USE sakila;

SELECT CEIL(amount * 1.2),
		FLOOR(amount * 1.2),
        ROUND(amount * 1.2, 2),
        TRUNCATE(amount * 1.2, 1)
FROM payment;

SELECT CEIL(replacement_cost * 1.1),
		FLOOR(replacement_cost * 1.1),
        ROUND(replacement_cost * 1.1, 2),
        TRUNCATE(replacement_cost * 1.1, 1)
FROM film;


SELECT first_name, 
		LOWER(first_name), 
		LCASE(first_name)
FROM customer;

SELECT city,
	   UPPER(city),
       UCASE(city)
FROM city;

SELECT first_name, last_name,
		LENGTH(first_name), LENGTH(last_name)
FROM actor;

SELECT first_name,
		LEFT(first_name, 4),
        RIGHT(first_name, 4),
        MID(first_name, 2, 6)
FROM customer;


SELECT city,
		LEFT(city, 3),
        RIGHT(city, 3),
        MID(city, 3, 6)
FROM city;

SELECT first_name,
		LPAD(first_name, 10, '*'),
        RPAD(first_name, 10, '*')
FROM customer;

SELECT city,
		LPAD(city, 10, '*'),
        RPAD(city, 10, '*')
FROM city;

SELECT first_name, last_name,
		REPEAT(first_name, 3),
        REPEAT(last_name, 2)
FROM customer;

SELECT '   MySQL   ',
		LTRIM('   MySQL   '),
        RTRIM('   MySQL   '),
        TRIM('   MySQL   ')
FROM customer;

SELECT CONCAT(first_name, ' ', last_name)
FROM customer;

SELECT CONCAT(address, ' ', district)
FROM address;

SELECT first_name,
		INSERT(first_name, 3, 5, '*')
FROM customer;
# 3번쨰 위치부터 5개의 길이만큼 제거하고 '*' 대체해서 삽입 

SELECT title,
		INSERT(title, 4, 7, ' ')
FROM film;
# 4번째부터 7번쨰까지 공백으로 메꿔달라

SELECT first_name,
		REPLACE(first_name, 'CHRI', 'SQL')
FROM actor
WHERE first_name LIKE 'CHRI%';
# 특정 문자(CHRI)를 찾아서 새로운 문자(SQL)로 대체

SELECT REPLACE(rating,
				'NC-17', '17세 이상 관람가')
FROM film;

SELECT first_name
		INSTR(first_name, 'LY')
FROM actor
WHERE first_name LIKE '%LY%';
# 문자열에서 특정 문자열을 찾아 위치를 반환하는 INSTR()함수
# 위치는 1부터 시작하며, 특정 문자열을 찾지 못하면 0을 반환

SELECT address
FROM address
WHERE address LIKE '%LY%';

SELECT address, INSTR(address, 'SA')
FROM address
WHERE address LIKE '%SA%';
# SA가 들어간 문자의 위치값 반환

SELECT first_name,
		SUBSTRING(first_name, 1, 5)
FROM customer;
# 문자열 시작 위치에서 개수만큼 가져오는 SUBSTRING() 함수

SELECT title,
		SUBSTRING(title, 1, 8)
FROM film;

SELECT last_name, REVERSE(last_name)
FROM actor;

SELECT name, REVERSE(name)
FROM category;
# 문자열을 반대로 가져오는 REVERSE()함수