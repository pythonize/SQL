USE sakila;

SELECT NOW(), SYSDATE(), CURRENT_TIMESTAMP();
# 현재 날짜와 시간을 반환하는 함수

SELECT CURDATE(), CURRENT_DATE();
# 현재 날짜를 반환하는 함수

SELECT CURTIME(), CURRENT_TIME();
# 현재 시간을 반환하는 함수

SELECT DATE_ADD(NOW(), INTERVAL 10 SECOND);

SELECT DATE_ADD(NOW(), INTERVAL 1 MONTH);
# 날짜에서 기준값 만큼 더하는 함수


SELECT DATE_SUB(NOW(), INTERVAL 10 MINUTE);

SELECT DATE_SUB(NOW(), INTERVAL 1 DAY);
# 날짜에서 기준값 만큼 빼는 함수

SELECT ADDTIME('2024-12-12 00:15:24', '01:30:30');

SELECT ADDTIME(CURTIME(), '02:20:30');
# 기준 시간에서 지정한 시간 만큼 더하는 함수

SELECT SUBTIME('2024-12-12 00:17:24', '01:23:02');

SELECT SUBTIME(CURTIME(), '02:20:30');
# 기준 시간에서 지정한 시간 만큼 빼는 함수

SELECT YEAR(NOW()), MONTH(NOW());

SELECT YEAR('2024-12-12'), MONTH('2024/12/12');
# 날짜의 연도를 가져오는 함수와 월을 가져오는 함수

SELECT MONTHNAME(NOW()), DAYNAME(NOW());

SELECT MONTHNAME('2024/12/12'), DAYNAME('2024-12-12');
# 날짜의 월을 영어로 가져오는 함수와 요일을 영어로 가져오는 함수


SELECT DAYOFMONTH(NOW()), DAYOFWEEK(NOW()),
		WEEKDAY(NOW());
        
SELECT DAYOFMONTH('2024/12/12'),
		DAYOFWEEK('2024/12/12'),
        WEEKDAY('2024/12/12');
# 날짜의 월별 일자를 반환하는 함수와 주별일자를 바환하는 함수, 주별일자를 반환하는 함수

SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');

SELECT DATE_FORMAT(NOW(), '%Y/%m/%d');

SELECT DATE_FORMAT(NOW(), '%D %M %y');

SELECT DATE_FORMAT(NOW(), '%e %b. %Y');
# 날짜를 형식에 맞게 만들어 반환하는 함수
# 연도 : %Y(4자리), %y(2자리)
# 월 : %M(긴 월 이름), %m(숫자의 월, 01, 02, 03 ---), %b(짧은 월 이름), %c(숫자의 월, 1, 2, 3, ---)
# 요일 : %W(긴 요일), %a(짧은 요일), %w(0 - 일요일, 1 - 월요일, --- )
# 일 : %D(1st, 2nd, 3th, --), %d(01, 02, 03, 04, --), %e(1, 2, 3, --), %J(일년 중 날짜, 001, 002, 003, 004, --)

SELECT DATE_FORMAT(NOW(), '%1:%i');

SELECT DATE_FORMAT(NOW(), '%k:%i');

SELECT DATE_FORMAT(NOW(), '%h:%i:%S');

SELECT DATE_FORMAT(NOW(), '%H:%i:%S');
# 날짜를 형식에 맞게 만들어 반환하는 함수
# 시 : %I(12시간제, 1, 2, 3, ---), %k(24시간제, 0, 1, 2, 3, ---), %h(12시간제, 01, 02, 03, ---), %H(24시간제, 00, 01, 02, 03, ---)
# 분 : %i(00, 01, ---)
# 초 : %S(00, 01, 02, ---), %s(0, 1, 2, --)

SELECT DATE_FORMAT(NOW(), '%r');

SELECT DATE_FORMAT(NOW(), '%T');

SELECT DATE_FORMAT(NOW(), '%U, %u');

SELECT DATE_FORMAT(NOW(), '%p %H:%i');
# 날짜를 형식에 맞게 만들어 반환하는 함수
# 시간 : %r(12시간제 시간), %T(24시간제 시간)
# 주 : %U(일요일을 기준으로 계산한 주), %u(월요일을 기준으로 계산한 주)
# 오전/오후: %p(AM/PM)


# 집계 함수 종류
# COUNT
SELECT COUNT(actor_id) FROM actor;

SELECT COUNT(address), COUNT(address2)
FROM address;

SELECT COUNT(*) FROM CATEGORY;

SELECT COUNT(customer_id) FROM customer;

SELECT COUNT(*), COUNT(title) FROM film;

SELECT COUNT(payment_date) FROM payment;

SELECT COUNT(rental_id) FROM rental;

SELECT COUNT(*), SUM(active) FROM customer;

SELECT SUM(rental_duration), SUM(length) FROM film;

SELECT SUM(amount) / COUNT(amount)  FROM payment;

SELECT AVG(LENGTH(first_name)) FROM actor;

SELECT AVG(length), AVG(replacement_cost)
FROM film;

SELECT SUM(amount) / COUNT(amount) FROM payment;

SELECT AVG(amount) FROM payment;
# 집계함수
# 여러 행에 대해 하나의 결과를 출력하는 그룹 함수를 이용해 여러가지 집계 연산을 수행

SELECT MIN(rental_duration), MIN(length),
		MAX(replacement_cost), MAX(rental_rate)
FROM film;

SELECT MIN(amount), MAX(amount)
FROM payment;

SELECT MIN(LENGTH(first_name)),
		MAX(LENGTH(first_name))
FROM customer;
# 열의 최솟값을 구한믄 함수, 열의 최댓값을 구하는 함수

SELECT STDDEV(rental_duration),
STDDEV(length),
STDDEV(replacement_cost),
STDDEV(rental_rate)
FROM film;

SELECT VARIANCE(rental_duration),
VARIANCE(length),
VARIANCE(replacement_cost),
VARIANCE(rental_rate)
FROM film;

SELECT STDDEV(amount), VARIANCE(amount)
FROM payment;

SELECT STDDEV(LENGTH(first_name)),
		VARIANCE(LENGTH(first_name))
FROM customer;
# 표준편차를 구하는 함수, 분산을 구하는 함수