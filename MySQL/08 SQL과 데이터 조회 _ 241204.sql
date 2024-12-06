USE sakila;

SHOW TABLES;

# 한 줄 주석

-- 한 줄 주석

/* 두 줄 이상
주석 처리 */

SELECT * FROM actor;

SELECT * FROM actor_info;

SELECT * FROM address;

SELECT * FROM category;

SELECT * FROM city;

SELECT * FROM country;
# 테이블 모든 데이터 가져오기

SELECT last_name, first_name
FROM actor;

SELECT first_name, last_name
FROM customer;

SELECT title, rating 
FROM film;

SELECT payment_date, last_update 
FROM payment;

SELECT rental_date, return_date
FROM rental;
# 테이블에서 칼럼 가져오기

SELECT last_name AS 성, first_name AS 이름
FROM actor;

SELECT title AS 제목, rating AS 등급
FROM film;
# 칼럼명 바꾸기

SELECT rental_date AS 대여일,
rental_date AS 반납일
FROM rental;

SELECT DISTINCT last_name
FROM actor;
# 중복을 피함

SELECT DISTINCT category
FROM film_list;

SELECT DISTINCT rating FROM film;
# 중복 분류를 다섯가지로 하고 있음