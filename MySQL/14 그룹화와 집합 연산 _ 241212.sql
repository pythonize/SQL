# GROUP BY
# 지정한 열의 데이터 값을 기준으로 그룹화하여 집계 함수 적용
# GROUP BY 동작 순서
# 테이블에서 WHERE 조건식에 맞는 데이터 값만 구분
# 지정한 열 기준으로 같은 데이터 값으로 그룹화
# 지정한 열들의 그룹화된 집계 결과 출력

# GROUP BY 절 특징
# WHERE 절은 그룹화 되기 전에 조건식 적용
# GROUP BY 절 사용시 SELECT 절에 지정된 기준열을 지정
# SELECT 절에 그룹 함수 없이도 GROUP BY 절 사용가능

USE sakila;

SELECT first_name, COUNT(*)
FROM customer
GROUP BY first_name;

SELECT district, COUNT(*)
FROM address
GROUP BY district;

SELECT rating, COUNT(*)
FROM film
GROUP BY rating;

SELECT special_features, COUNT(*)
FROM film
GROUP BY special_features;

# 다중 GROUP BY
SELECT rating, special_features, COUNT(*)
FROM film
GROUP BY rating, special_features;

SELECT rating, special_features, 
		rental_duration, COUNT(*)
FROM film
GROUP BY rating, special_features, rental_duration;

# with rollup 예제
SELECT rating, special_features, 
		rental_duration, COUNT(*)
FROM film
GROUP BY rating, special_features, 
		rental_duration WITH ROLLUP;
        # rental_duration이 없이 위의 두개의 칼럼만 계산한 값도 볼수 있게 해줌
        
SELECT staff_id, customer_id, COUNT(*)
FROM rental
GROUP BY staff_id, customer_id WITH ROLLUP;

SELECT staff_id, customer_id,
		MIN(amount), MAX(amount),
        SUM(amount), AVG(amount)
FROM payment
GROUP BY staff_id, customer_id WITH ROLLUP;

# GROUP BY ~ WHERE
SELECT store_id, COUNT(*)
FROM customer
WHERE active = 0
GROUP BY store_id;

SELECT rating, special_features, COUNT(*)
FROM film
WHERE length < 100
GROUP BY rating, special_features;

SELECT staff_id, customer_id, SUM(amount)
FROM payment
GROUP BY staff_id, customer_id;

SELECT * FROM payment;

SELECT staff_id, customer_id, SUM(amount)
FROM payment
WHERE payment_date < '2005-06-01'
GROUP BY staff_id, customer_id;

# HAVING
# WHERE 절에서는 그룹 함수를 사용할 수 없음
# 그룹화된 집계 결과에 조건식을 적용할 때 HAVIMNG절 사용
# HAVING 절 SQL 질의 예제
SELECT rating, special_features,
		SUM(replacement_cost)
FROM film
GROUP BY rating, special_features
HAVING SUM(replacement_cost) < 300;

SELECT staff_id, customer_id, COUNT(*)
FROM rental
GROUP BY staff_id, customer_id
HAVING COUNT(*) > 20;

SELECT staff_id, customer_id, SUM(amount)
FROM payment
GROUP BY staff_id, customer_id
HAVING SUM(amount) > 100;

# 집합 연산자
# 연산자 앞뒤의 값을 비교하여 데이터 조회
# 집합 연산자

# 합집합
# UNION
SELECT rating, special_features, title
FROM film
WHERE special_features = 'Trailers'
UNION
SELECT rating, special_features, title
FROM film
WHERE rating = 'G';

SELECT store_id, active, first_name
FROM customer
WHERE store_id = 2
UNION
SELECT store_id, active, first_name
FROM customer
WHERE active = 0;

# UNION ALL 합집합(중복 포함)
SELECT store_id, active, first_name
FROM customer
WHERE store_id = 2
UNION ALL
SELECT store_id, active, first_name
FROM customer
WHERE active = 0;


# 교집합
# INTERSECT
SELECT store_id, active, first_name
FROM customer
WHERE store_id = 2
INTERSECT
SELECT store_id, active, first_name
FROM customer
WHERE active = 0;

# 차집합
# EXCEPT
# 위에서 아래를 빼줌
SELECT store_id, active, first_name
FROM customer
WHERE store_id = 2
EXCEPT
SELECT store_id, active, first_name
FROM customer
WHERE active = 0;