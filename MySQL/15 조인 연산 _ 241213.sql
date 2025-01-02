use sakila;

# 조인 연산
# 두개 이상의 테이블을 서로 연결하는데 사용되는 기법
# 테이블들은 서로 상호관계를 가짐

# 카티션 곱
# 공통되는 컬럼 없이 조인 조건이 없어서 모든 데이터가 조회
select address, city
from address, city;

select address, city
from address cross join city;

select first_name, last_name, address
from customer, address;

select first_name, last_name, address
from customer cross join address;


# 동등 조인(equi join)
# 조인하는 테이블에서 조인 조건이 일치하는 것만 조회(내부 조인이라고도 부름)
select address, district, city
from address, city
where address.city_id = city.city_id;

select address, district, city
from address a join city c
   on a.city_id = c.city_id;

select address, district, city
from address as a inner join city as c
   on a.city_id = c.city_id
   where district = 'Texas';
   
select first_name, last_name, 
address, district, city, country
from customer cu join address a
on cu.address_id = a.address_id
join city c
on a.city_id = c.city_id
join country co
on c.country_id = co.country_id;
   

select c.name, f.rating, f.title
from film f join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id;


select f.rating, f.title,
a.first_name, a.last_name
from film f join film_actor fa
on f.film_id = fa.film_id
join actor a
on fa.actor_id = a.actor_id;

select c.name, f.rating, f.title,
a.first_name, a.last_name
from film f join film_actor fa
on f.film_id = fa.film_id
join actor a
on fa.actor_id = a.actor_id
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id;


# 비동등조인(Non Equi Join)
# 테이블의 동일한 컬럼 없이 다른 조건으로 조인하는 방법

select address, district, city
from address a join city c
on a.city_id > c.city_id;

select title, rental_date
from film f join rental r
on f.length > r.customer_id;

select rental_id, first_name, last_name
from customer join rental
on return_date between rental_date and create_date;

# 외부조인(Outer Join)
# 조인하는 테이블에서 조인 조건을 만족하지 않는 행도 출력
# 동등 조인 조건을 만족하지 못하고 누락된 행을 출력할때 사용
# left join : 왼쪽 테이블에서 값을 가져오고 오른쪽 테이블에서 공통 열을 가져옴
# right join : 오른쪽 테이블에서 값을 가져오고 왼쪽 테이블에서 공통 열을 가져옴
# outer는 입력해도 되고 안해도 됨
select address, first_name, last_name
from customer c left outer join address a
on a.address_id = c.address_id;

select first_name, last_name, address
from customer c right outer join address a
on a.address_id = c.address_id;

# 자체 조인(Self Join)
# 자기 자신과 테이블을 조인하는 방법
select c1.first_name, c2.last_name
from customer c1 join customer c2
on c1.first_name = c2.last_name;
# 자체조인에서는 별칭을 반드시 붙여줘야함 (c1, c2)

select a1.address, a1.address_id, a2.city_id
from address a1 join address a2
on a1.address_id = a2.city_id;

select f1.title, f1.film_id, f2.length
from film f1 join film f2
on f1.film_id = f2.length;