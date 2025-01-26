/* 뷰(view)
- 사용자에게 접근이 허용된 데이터만 제한적으로 제공
- 하나 이상의 테이블로부터 유도된 가상테이블
- 뷰에 대한 질의 실행 시 정의된 테이블로 대체되어 실행
- 임시 작업을 위한 용도도 활용되고 사용상의 편의성을 최대화함
1. 장점
- 논리적 데이터 독립성 제공
- 동일 데이터에 대해 동시에 여러 사용자 요구 지원
- 사용자의 데이터 관리 편의성 제공
- 접근 제어를 통한 보안 제공
2. 단점
- 독립적 인덱스 생성 불가
- 뷰의 정의 변경 불가
- 삽입, 수정, 삭제 연산에 제약

- 테이블에서 유도 되었기 떄문에 구조가 같음
- 가상 테이블이라 물리적으로 구현되지 않음
- 데이터의 논리적 독립성 제공
- 뷰로 필요한 데이터만 처리하므로 관리 용이
- 여러 테이블을 조인하여 뷰 생성 가능
- 뷰에 나타나지 않은 데이터를 안전하게 보호(사용자별로 접근 권한 설정)
- 테이블의 기본키를 포함하여 뷰를 구성하면 삽입, 삭제, 갱신 가능

1) 단순 뷰
- 하나의 테이블에서 뷰 생성
2) 복합 뷰
- 두개 이상의 테이블을 조인하여 뷰 생성
3) 인라인 뷰
- select문의 from절에 기술된 select문
*/

use sakila;

select * from actor;

select * from actor_info;

select * from customer;

select * from customer_list;

select * from film;

select * from film_list;

select * from nicer_but_slower_film_list;

select * from film_category;

select * from sales_by_film_category;

select * from sales_by_store;

select * from staff;

select * from staff_list;

# 뷰 생성
# 1. 뷰 생성 문법
create view film_view as
select film_id, title, release_year, length, rating
from film;

select * from film_view;
# 뷰 생성을 하면 하나의 가상 테이블 형태를 만들어서 보여줌

#2. 조건이 포함된 단순 뷰 생성 예제
select customer_id, store_id,
		first_name, last_name,
        email, address_id, active
from customer
where active = 0;

select * from inactive_customer_view;

insert into inactive_customer_view
values (606, 2, 'Ryan', 'Lee',
		'Ryan.lee@gmail.com',
        100, 0);
        
insert into inactive_customer_view
values (607, 2, 'Ryan', 'Lee',
		'Ryan.lee@gmail.com',
        200, 0);

# 복합 뷰 생성 예제
create view customer_view as        
select first_name, last_name,
		address, district, city, country
from customer cu join address a
  on cu.address_id = a.address_id
  join city c
  on a.city_id = c.city_id
  join country co
  on c.country_id = co.country_id;
  
select * from customer_view;

# 집계 함수가 포함된 복합뷰 생성
create view film_avg_view as
select rating, special_features,
		avg(rental_duration), avg(length)
from film
group by rating, special_features
order by rating, special_features;

select * from film_avg_view;

/* 뷰를 통한 데이터 입력 조건
1. 테이블의 not null 열이 뷰에 모두 포함
- 데이터 입력 가능
2. 테이블의 not null 열이 뷰에 포함 안됨
- 데이터 입력 불가
- 데이터가 입력되지 않아도 에러 없도록 수정 필요
- not null 열의 default 값 설정
- not null 조건을 null 조건으로 변경
3. with check option : 뷰를 통해 데이터 입력시, 조건에 맞는 데이터만 입력
*/

# 뷰 대체 예제
create view district_view as
select address, district, city, postal_code, country
from address a join city c
on a.city_id = c.city_id
join country co
on co.country_id = c.country_id
where district = 'California';

select * from district_view;

create or replace view district_view as
select address, district, city, postal_code, country
from address a join city c
on a.city_id = c.city_id
join country co
on co.country_id = c.country_id
where district = 'Texas';

# 뷰 수정
select * from film_view;

alter view film_view as
select film_id, title, release_year,
		length, rating, replacement_cost
from film;

select * from inactive_customer_view;

alter view inactive_customer_view as
select customer_id, store_id, first_name, last_name,
		email, address_id, active
from customer
where active = 0;
with check option;

insert into inactive_customer_view
values (609, 1, 'SEAH', 'LEE',
		'SEAH.LEE@sakilacustomer.org',
        400, 1);
# 위드체크 옵션이 있어서 1은 안됨

# 뷰 삭제
drop view film_view;
drop view inactive_customer_view;
drop view customer_view;
drop view film_actor_view;
drop view film_avg_view;
drop view category_film_avg_view;
drop view district_view;

show tables;