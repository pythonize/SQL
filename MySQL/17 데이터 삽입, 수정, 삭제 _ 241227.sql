/* 데이터 조작
- 사용자가 응용 프로그램이나 질의어를 통해 저장된 데이터를 실질적으로 처리하는데 사용하는 DML(Data Manipulation Language)
- 사용자(응용 프로그램)와 DBMS간의 인터페이스 제공
1) select : 테이블에서 조건에 맞는 튜플을 검색
2) insert : 테이블에 새로윤 튜플을 삽입
3) update : 테이블에서 조건에 맞는 튜플의 내용을 변경
4) delete : 테이블에서 조건에 맞는 튜플을 삭제
- 데이터 삽입(Insert), 수정(Update), 삭제(Delete)는 트랜잭션(Transaction) 과정으로 동작
*/

/* 데이터 무결성
- 데이터의 정확성, 유효성, 일관성을 유지하고 보증
- 데이터베이스나 RDBMS 시스템의 중요한 기능
- 데이터의 잘못된 입력, 수정, 삭제로부터 보호
- 입력한 데이터와 데이터베이스에 저장된 데이터 일치
1. 개체 무결성(Entity Integrity)
1) 기본키 열은 고유
2) Null 값을 가질 수 없음
2. 참조 무결성(Reference Integrity)
1) 외래키가 있는 테이블은 기본키와의 관계 유지
2) 참조하는 외래키가 존재하면 기본키 변경이나 행 삭제 불가
3. 영역 무결성(Domain Integrity)
1) 데이터 형태, 범위, 기본값, 유일성에 대한 제한
2) 주어진 속성 값은 정의된 도메인에 속한 값
4. 비즈니스 무결성(Business Integrity)
1) 사용자의 업무의 특성과 규칙에 따른 제약 조건
2) 제약 조건, DEFAULT, TRIGGER 등의 사용자 정의
*/

/*  제약조건
- 정해진 규칙에 적합한 데이터만 입력가능하고, 그 외에는 거부하여 무결성 유지
- 제약 조건의 종류
1) 기본키 제약 조건
- unique와 not null 조건 만족
- 테이블에서 각 행을 유일하게 식별하는 값
2) 외래 키 제약 조건
- 외래 키가 참조 열의 갑을 반드시 참조해야함
- 참조되는 열은 unique 하거나 기본키
3) 유일 키 제약 조건
- 중복된 값을 허용하지 않음
- 유일한 값으로 존재(Null값 허용가능)
4) Not Null 제약 조건
- Null 값을 허용하지 않음
- 값을 반드시 입력해야 함
*/

/* Insert
- 관계형 데이터 베이스의 테이블에 새로운 데이터롤 추가(저장)할 때 사용하는 명령어
- Crud의 create 부분에 해당하는 역할을 수행
- 필드의 이름은 생략 가능하며, 스키마와 같은 순서대로 필드의 값이 자동 대입
- 생략 가능한 필드
1) Null 을 저장할 수 있도록 설정된 필드
2) Default 제약 조건이 설정된 필드
3) auto_increment 키워드가 설정된필드
*/

use sakila;

select * from actor
where actor_id >200;

insert into actor
values (201, 'Ryan', 'LEE', NOW());

insert into actor(actor_id, first_name,
				  last_name, last_update)
values (202, 'Annie', 'KANG', NOW());

insert into actor(first_name, last_name, last_update)
values ('Annie', 'KANG', NOW());

insert into actor(first_name, last_name)
values ('Joo', 'LEE');

select * from language;

insert into language(name)
values ('Korean');

select * from country;

insert into country(country)
values ('South Korea')

select * from city;

insert into city(city, country_id)
values ('Seoul', 110);

select * from address;

insert into address(address, district,
					city_id, postal_code,
                    phone, location)
values('110 Sejong-daero', 'Seoul',
		607, 04524, 0212345678,
        ST_GeomFromText('POINT(1 1)'));
        
select * from film;

insert into film(title, description, release_year,
				language_id, rental_duration,
                rental_rate, length, replacement_cost,
                rating, special_features)
values ('Parasite', 
		'Parasite is a dark comedy/drama with some horror elements sprinkled in that revolves around the Kim family',
		2019, 7, 5, 4.99, 131, 28.99, 
        'PG-13', 'Deleted Scenes');

select * from inventory
where film_id in (1001, 1002);

insert into inventory(film_id, store_id)
values (1001, 1);

insert into inventory(film_id, store_id)
values (1002, 1);

select * from customer
where first_name = 'Ryan';

insert into customer(store_id, first_name, last_name,
					 email, address_id, active)
values (1, 'Ryan', 'LEE',
		'different0423@gmail.com', 606, 1);
        
select * from rental
order by rental_date desc;

insert into rental(rental_date,
				   inventory_id, customer_id, staff_id)
values (NOW(), 4582, 600, 1);

select * from payment
where customer_id = 600;

insert into payment(customer_id, staff_id,
					rental_id, amount)
values (600, 1, 16050, 4.99);


use sakila;

/* UPDATE
1. 관계형 데이터베이스의 테이블에서 이미 저장된 값을 수정하는 명령
2. Crud의 update 부분에 해당하는 역할을 수행
3. update는 삽입되어 있는 갑을 수정해주는 만큼 조건문이 필요
4. 수정하고자 하는 값을 특정해주고 변경을 해줘야 원하는 결과를 얻을수 있음
5. 만약 where문이 없이 update를 수행한다면 모든 값이 업데이트 한 값으로 바뀜
*/

select * from actor
where actor_id = 203;

update actor
set first_name = 'SUSAN'
where actor_id = '202';
                    
update actor
set first_name = 'SUWAN'
where actor_id = '203';

update actor
set last_name = 'GO'
where last_name = 'LEE';

select * from actor;

select * from address
where address_id = 606;

update address
set address = '392 Hangang-daero',
	postal_code = 04323,
    phone = 111222333,
    location = ST_GeoFromText('POINT(0 0)')
where address_id = 606;

select * from film
where title in ('Parasite', 'Train to Busan');

update film
set rental_duration = 6,
	rental_rate = 6.99
where title = 'Parasite';

update film
set rental_duration = 6,
	rental_rate = 6.99
    replacement_cost = 26.99
where title = 'Train to Busan';

/* DELETE
1. 관계형 데이터베이스의 테이블에서 이미 저장된 값을 삭제하는 명령
2. crud의 delete 부분에 해당하는 역할을 수행
3. delete 명령어도 값을 특정해주지 않으면 전체 값일 delete 됨
4. 원하는 곳을 적절히 삭제하기 위해서는 where 문으로 조건을 달아주어야 함
*/

select * from payment;

delete from payment
where customer_id = 600;

delete from rental
where customer_id = 600;

delete from customer
where customer_id = 600;

delete from inventory
where film_id = 1001 or film_id = 1002;

delete from film
where film_id in (1001, 1002);

delete from actor
where actor_id between 201 and 204;

delete from language
where language_id = 7;

delete from address
where address_id = 606;

delete from city
where city = 'Seoul';

delete from country
where country_id = 110;