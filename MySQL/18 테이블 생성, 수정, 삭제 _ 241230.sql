/* 데이터 정의어
1. 데이터 정의어(DDL, Data Definition Language):데이터베이스 객체들을 정의하는데 사용
2. 데이터 베이스 객체 : 테이블, 뷰, 인덱스, 시퀀스, 시노님
3. DDL 명령어는 데이터베이스에 즉각 반영되며 데이터 사전(data dictionary)에 기록
4. 데이터 베이스 객체들을 생성, 수정, 삭제하는 명령어
- create:데이터베이스 객체 생성
- drop : 데이터베이스 객체 삭제
- alter : 데이터 베이스 객체 수정
- truncate : 테이블 내의 전체 데이터 삭제
*/

/* Create table
- 새로운 테이블 생성
1) 테이블 이름 중복 불가
2) 테이블 내 열 이름 중복 불가
3) 데이터베이스 예약어 사용 불가
4) 1~30 바이트 영어 이름을 권장
*/

use sakila;

create table vip
(
	vip_id			int not null auto_increment,
	first_name		varchar(10) not null,
	last_name		varchar(10) not null,
	email			varchar(20) unique,
	phone_number	varchar(20) unique,
    regist_date		timestamp default now(),
    primary key		(vip_id)
);

desc vip;

select * from vip;

insert into vip(first_name, last_name,
				email, phone_number)
values ('Sundar', 'Pichai', 
		'pichai@gmail.com', '010-5555-6666');
        
alter table vip
add column ( gender char(1) );

alter table vip
add column ( age int );

alter table vip
add column ( dob date );

desc vip;

select * from vip;

update vip
set gender = 'M', age = 51,
	dob = '1972-07-12'
where vip_id = 4;

# 테이블에 자료형 변경
alter table vip
modify column gender varchar(10) not null,
alter table vip
modify column age int default 0,
alter table vip
modify column dob date not null;

update vip
set gender = 'Male'
where vip_id in (1, 2, 3, 4);

select * from vip;

insert into vip(first_name, last_name,
				email, phone_number,
                gender, dob)
values ('Larry', 'Page',
		'larry@gmail.com', '010-8888-9999',
        'Male', '1973-03-26');

# 테이블 열 이름 변경
alter table vip
change column phone_number phone varchar(20) unique;

alter table vip
change column dob date_of_birth date not null;

desc vip;

# 테이블 열 삭제
alter table vip
drop column age;

alter table vip
change column date_of_birth;

테이블 이름 변경
alter table vip rename vvip;

show tables;

alter table vvip rename vip;

# 테이블의 모든 데이터 삭제(테이블 구조 유지)
truncate table vip;

select * from vip;

# 테이블 완전 삭제
drop table vip;

show tables;

/* 테이블 데이터 삭제 명령어 비교
1. Delete Table
- DML 명령
- 데이터만 삭제
2. Truncate Table
- DDL 명령
- 테이블 구조 유지
- 데이터 삭제
- 데이터, 인덱스, 테이블 공간 삭제
3. Drop Table
- DDL 명령
- 테이블 완전 삭제
- 데이터, 인덱스, 테이블 공간 삭제
*/

