 /*
 1. 서브 쿼리(Sub Query)
 - select 문 안에 다시 select문이 기술된 쿼리
 - 상위 select문 안에 하위 select문이 포함된 형태라 중첩된 쿼리라고도 부름
 - 단일 select문 사용만으로는 복잡한 조건식을 만들 때 사용
 - 다른 테이블에서 데이터 값을 조회한 후 조건으로 사용할 때 사용
 2. 서브 쿼리 종류
  - 중첩 서브 쿼리 : where문에 나타나는 서브 쿼리
   - 단일 행 서브 쿼리 : 하나의 행을 검색하는 서브 질의
   - 다중 행 서브 쿼리 : 하나 이상의 행을 검색하는 서브 질의
   - 다중 열 서브 쿼리 : 하나 이상의 열을 검색하는 서브 질의
  - 인라인 뷰 : from 문에 나타나는 서브 쿼리
  - 스칼라 서브 쿼리 : select문에 나타나는 서브 쿼리
  3. 서브 쿼리 규칙
  - 서브쿼리는 괄호를 묶어서 사용
  - 단일 행 연산자 또는 다중 행 연산자로 서브쿼리 연결
  - 서브 쿼리 실행 후 메인 쿼리 실행
  - 여러 서브 쿼리를 중첩해서 사용가능
  단일행 연산자 =, >, <, <=, >=, <>, != 단일행 서브쿼리, 다중 열 서브 쿼리
  다중행 연산자 in, not in, exists, any, all 다중행서브쿼리, 다중열 서브쿼리
 */
 
 /*
 1) 단일 행 서브쿼리
 - 서부쿼리 select 문에서 단일 행 결과를 메인 쿼리에 전달
 - where 에 사용되는 열의 개수와 데이터 타입 일치 필요
 - 단일 행 연산자 사용 : =, >, <, <=, >=, <>, !=
 */
 
 use sakila;
 
 select first_name, last_name
 from customer
 where email = (select email
				from customer
				where customer_id = 1);
 
select email
from customer
where customer_id = 1;

select first_name, last_name
 from customer
 where email = 'MARY.SMITH@sakilacustomer.org';
 
 select rating, title, description
 from film
 where title = 'ACADEMY DINOSAUR';
 
 select title
 from film
 where film_id = 1;
 
  select rating, title, description
 from film
 where title =  (select title
				from film
				where film_id = 1);
                
/* 2) 다중행 서브 쿼리
- 서브 쿼리 select 문에서 다중행 결과를 메인 쿼리에 전달
- 단일행 연산자는 사용할수없고, 다중행연산자만 사용가능
in 서브 쿼리 결과 중 같은 값이 포함되어 있으면 true
not in 서브 쿼리 결과 중 같은 값이 포함되지 않았으면 true
exists 서브 쿼리 결과가 존재하면 true
any(some) 조건식을 하나라도 만족하면 true
all 조건식을 모두 만족하면 true
*/

# IN/ Not IN 연산자

select first_name, last_name, email
from customer
where customer_id in (select customer_id
					  from customer
                      where active = 0);

select customer_id
from customer
where active = 0;

select first_name, last_name, email
from customer
where customer_id in (16, 64, 124, 169);

select email
from customer
where address_id < 600;

select first_name, last_name, email, address_id
from customer
where email not in (select email
					from customer
					where address_id < 600);
                    
# Exists 연산자
select first_name, last_name, email
from customer
where exists (select customer_id
				from customer
				where active = 0);

select customer_id
from customer
where active = 3;

select rating, title, description
from film
where exists (select title
			  from film
			  where film_id = 1);

# ANY 연산자
select customer_id, first_name, last_name, email
from customer
where email = ANY (select email
					from customer
					where customer_id < 10);

select email
from customer
where customer_id < 10;

select customer_id, first_name, last_name, email
from customer
where email < ANY (select email
					from customer
					where customer_id < 10);

select customer_id, first_name, last_name, email
from customer
where email > ANY (select email
					from customer
					where customer_id = 10);
                    
# All 연산자

select film_id
from film
where length > 180 ;


select film_id, title, description, length
from film
where film_id > all ( select film_id
					  from film
                      where length > 180 );
# 다 만족을 해야해서 아무것도 안뜸

select film_id, title, description, length
from film
where film_id < any ( select film_id
					  from film
                      where length > 180 );
# 결과중에 뭐라도 하나 만족하면 출력이 됨

# 인라인 뷰
/* from 절에 있는 서브쿼리가 인라인 뷰를 생성
from 절에 직접 기술하여 효율적인 검색 가능
from 절에 있는 서브 쿼리에는 자주 별칭을 사용
*/

select address_id, address
from address
where district = 'Texas';

select first_name, last_name, address
from customer c, ( select address_id, address
					from address
					where district = 'Texas') a
where c.address_id = a.address_id;

select first_name, last_name, address
from customer c,  address a
where c.address_id = a.address_id
and district = 'Texas';

select c.name, f.title
from film f, film_category fc,
(select category_id, name
from category
where name = 'Action') c
where f.film_id = fc.film_id
and fc.category_id = c.category_id; 

# 스칼라 서브쿼리
select first_name, last_name,
		( select count(*) from actor )
from staff;

select concat(first_name, ' ', last_name)
from customer;

select category_id, name
from category;

select title, description,
		( select concat(first_name, ' ', last_name)
          from customer limit 1 )
from film;