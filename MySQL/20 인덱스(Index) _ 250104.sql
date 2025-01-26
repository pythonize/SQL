use sakila;

/* 인덱스(Index)
1. 데이터 베이스에서 테이블 검색 속도를 향상시키기 위한 자료구조
2. 별도의 추가 저장 공간을 활용하여 인덱스 생성
3. 데이터와 데이터 위치를 포함한 자료구조 생성
4. 데이터를 빠르게 찾을수 있기 때문에 디스크 액세스 횟수 감소
5. 인덱스는 MYI(MySQL Index) 파일에 저장
6. DBMS에서 인덱스를 자동으로 사용하며 유지 보수 수행
7. 언제든지 생성 및 삭제가 가능하며, 다른 테이블이나 인덱스에 영향을 주지 않음
8. 데이터 조회를 위한 SELECT 뿐만 아니라 UPDATE와 DELETE의 성능도 인덱스를 통해 향상
9. 인덱스가 설정되지 않았다면 Table Full Scan이 일어나 성능이 저하되거나 치명적인 장애가 발생

인덱스 관리
1. 데이터에 변경이 발생하면 최신 상태를 유지를 위해 인덱스 관리 필요
2. 인덱스가 적용된 컬럼은 최신 데이터를 정렬된 상태로 유지
3. INSERT, UPDATE, DELETE 발생 시 인덱스 관리 수행
4. INSERT : 새로운 데이터에 대한 인덱스 추가
5. UPDATE : 기존의 인덱스는 사용하지 않도록 처리하고, 갱신된 데이터에 대한 인덱스 추가
6. DELETE : 삭제하는 데이터의 인덱스는 사용하지 않도록 처리
- 장점
1) 테이블 조회 속도 향상
2) 전반적인 시스템 부하 감소
- 단점
1) 인덱스 색인 정보를 갱신 관리하는 추가 비용 소요
2) 데이터 베이스의 약 10%정도의 추가 저장 공간 필요
3) UPDATE, INSERT, DELETE의 속도는 저하
4) 잘못된 인덱스 사용으로 성능이 저하될 수도 있음

효율적인 인덱스 설계
- 규모가 큰 테이블에 인덱스 사용시 효율적
- 중복되는 데이터가 최소인 컬럼
- SELECT절에 자주 등장하는 컬럼들을 잘 조합해서 인덱스를 만들면 인덱스 조회 후 다시 데이터에서 조회할 필요가 없으므로 빠르게 검색 가능
- INSERT, UPDATE, DELETE가 자주 발생하지 않는 컬럼
- WHERE절에서 자주 사용되는 열
- JOIN절에 자주 사용되는 열에는 인덱스의 효율이 좋음
- ORDER BY 절에 사용되는 열은 데이터 페이지가 자동 정렬됐기 때문에 클러스터형 인덱스가 유리

잘못된 인덱스 설계
1. 대용량 데이터가 자주 입력되는 경우
클러스터형 인덱스의 경우 빈번한 페이징이 일어나기 때문에 부하가 발생하므로 인덱스가필요한 경우 primary(클러스터)대신 unique만 설정하는게 좋을수 있음
2. 데이터의 중복도가 높은열은 인덱스 효과가 없음(예를 들어 성별열에 M, F만 있다고 하면 인덱스를 안 쓰는게 좋음), 따라서 일반 보조 인덱스보다 unique 보조 인덱스가 빠름
3. 자주 사용되지 않으면 성능 저하를 초래할 수 있음(INSERT만 주로 하는 시스템이라면, 사용해보지도 못하고 데이터 입력에 걸리는 작업량만 많아짐)

인덱스 타입 종류
클러스터 인덱스
1. 속도 : 빠르다
2. 사용 메모리 : 적다
3. 인덱스 : 인덱스가 주요 데이터
4. 개수 : 한 테이블에 한개
5. 리프노드 : 리프 노드 자체가 데이터
6. 저장값 : 데이터를 저장한 블록의 포인터
7. 인덱스 순서와 물리적 순서가 일치

보조 인덱스
1. 느리다
2. 많다
3. 인덱스가 데이터의 사본
4. 한 테이블에 여러개
5. 리프 노드는 데이터가 저장되는 위치
6. 값과 데이터의 위치를 가리키는 포인터
7. 인덱스 순서와 물리적 순서가 불일치

클러스터 인덱스
1. 특정 나열된 데이터들을 일정 기준으로 정렬해주는 인덱스(ex. 영어사전)
2. 클러스터형 인덱스 생성 시에는 데이터 페이지 전체가 다시 정렬
3. 이미 대용량의 데이터가 입력된 상태라면 클러스터형 인덱스 생성은 정렬로 인하여 심각한 시스템 부하를 줄 수 있음
4. 한 개의 테이블에 한 개씩만 만들 수 있음
5. 인덱스는 생성 시 데이터들의 배열 정보를 따로 저장하는 공간을 사용하나, 클러스터 인덱스는 따로 저장하는 정보 공간을 적게 사용하면서 테이블 공간 자체를 활용
6. 인덱스 자체의 리프 페이지가 곧 데이터이기 때문에 인덱스 자체에 데이터가 포함되어 있다고 볼수 있음
7. 보조 인덱스보다 검색 속도는 더 빠르지만, 입력/수정/삭제는 더 느림
8. MySQL에서는 Primary Key가 있다면 Clustered 인덱스로, 없다면 UNIQUE 하면서 NOT NULL 인 컬럼을, 그것도 없으면 임의로 보이지 않는 컬럼을 만들어 Clustered 인덱스로 지정

보조 인덱스
1. 논 클러스터 인덱스라고도 불리고, 개념적으로는 후보키에만 부여가능
2. 보조 인덱스의 생성시에는 데이터 페이지는 그냥 둔 상태에서 별도의 페이지에 인덱스를 구성하고, 클러스터와는 달리 자동 정렬을 하지 않음
3. 클러스터 인덱스의 리프 페이지는 보조 인덱스의 인덱스 자체의 리프 페이지는 데이터가 아니라 데이터가 위치하는 주소값(RID)
4. 클러스터형 인덱스보다 검색 속도는 더 느리지만 데이터의 입력/수정/삭제는 덜 느림
5. 보조 인덱스는 여러 개 생성할 수 있지만, 과도하게 사용할 경우에는 오히려 성능 저하 원인
6. 각 데이터에 대해서 고유값(unique) 들이 있는 목록에 생성할수있는 인덱스

복합 인덱스
1. 인덱스는 하나 혹은 여러 개의 컬럼에 대해 설정 가능(단일 여러 개 또는 여러 컬럼을 묶어 복합 인덱스)
2. 두 개 이상의 컬럼을 조합해서 생성한 인덱스
3. 첫번째 조건과 이를 만족하는 두번째 조건들 함께 인덱스로 사용
4. MySQL/MariaDB는 인덱스에 최대 15개 컬럼으로 구성 가능
5. 복합 인덱스(다중 컬럼 인덱스)는 단일 컬럼 인덱스보다 더 비효율적으로 인덱스를 UPDATE/DELETE를 수행하기 때문에 신중 필요
6. 가급적 UPDATE 가 자주 안되는 값으로 선정 필요

order by와 group by에 대한 인덱스
1. 인덱스는 order by와 group by 에도 영향을 줌
2. 다음과 같은 경우 인덱스 사용 X
1) order by 인덱스 컬럼1, 컬럼2 복수의 키에 대해서 order by 를 사용한 경우
2) where 컬럼 1 = '값' order by 인덱스 컬럼
연속하지 않은 컬럼에 대해 order by를 실행한 경우
3) order by 인덱스 컬럼 1 desc, 인덱스 컬럼2, asc
desc 와 asc를 혼합해서 사용한 경우
4) group by 컬럼 1, order by 컬럼 2
group by와 order by의 컬럼이 다른 경우
5) order by abs(컬럼)
order by 절에 다른 표현을 사용한 경우
*/

# 인덱스 예제
show index from actor;

show index from film;

show index from customer;

show index from payment;

show index from rental;

explain
select * from film
where language_id = 1;

explain
select * from film
where title = 'DAVIS';

create table vip
(
	vip_id			int not null auto_increment,
    first_name		varchar(10) not null,
    last_name		varchar(10) not null,
    email			varchar(20) unique,
    phone			varchar(20) unique,
    regist_date		timestamp default now(),
    primary key(vip_id)
);

show index from vip;

drop table vip;

# 테이블 생성시 인덱스 추가
create table vip
(
	vip_id			int not null auto_increment,
    first_name		varchar(10) not null,
    last_name		varchar(10) not null,
    email			varchar(20),
    phone			varchar(20),
    regist_date		timestamp default now(),
    primary key(vip_id),
    constraint idx_email unique(email),
    constraint idx_phone unique(phone),
    index idx_regist_date(regist_date asc)
);

show index from vip;

drop table vip;

/* 클러스터 인덱스와 보조 인덱스 차이
1. unique와 primary key는 둘 다 중복 비 허용
2. unique은 null을 허용하지만, primary key는 null 허용 안함
3. unique은 하나의 테이블에 여러 개 올 수 있지만, primary key는 하나만 존재
4. 특정 테이블에 primary key가 존재하면서 unique key가 존재할 경우
1) primary key 로 지정된 컬럼은 clustered 인덱스가 됨
2) unique key로 지정된 컬럼들은 보조 인덱스가 됨
3) unique key로 지정된 컬럼이 null을 허용하든 허용하지 않든 상관없이 모두 보조 인덱스가 됨
5. 특정 테이블에 primary key가 존재하지 않으며, 특정 컬럼에 unique not null 제약이 지정될 경우
1) 해당 컬럼은 clustered 인덱스가 됨
2) not null 조건이 없다면 보조 인덱스가 됨

인덱스 성능 주의점
- 보통 제약 조건의 설정은 대개 테이블의 생성구문(create)에서 하거나, 테이블 생성하고 뒤에 alter문으로 따로 진행
- 아직 테이블에 데이터가 입력되기 전에 primary key 및 unique key의 열에는 인덱스가 생성되어져 있기 때문에, 인덱스 자체를 구성하는 시간이 걸리지 않음
- 많은 데이터가 입력된 후에 alter 문으로 unique 나 primary를 지정하면 인덱스를 구성하는데 많은 시간이 걸릴 수도 있음(페이지 분할 및 재정렬 필요)
- 운영시간에 함부로 기존에 운영되는 대량의 테이블의 인덱스를 생성하면 시스템이 엄청나게 느려져 심각한 상황이 발생될 수도 있으니 주의(데이터의 양에 따라서 몇 시간이나 그 이상의 시간이 걸릴수도 있음)

create index 문
- 인덱스를 생성하는 대표 문법
- unique는 고유한 인덱스를 만들것인지 결정(동일한 데이터 값이 입력될 수 없음)
- 기본적으로 unique가 생략된 중복이 허용되는 인덱스로 생성
- fulltext : 전체 텍스트 인덱스
- spatial : 점, 선, 면, 등 공간 데이터와 관련된 인덱스 생성에 쓰임
- create index로 생성하는 건 보조 인덱스로 생성됨
- 생성된 인덱스를 실제 적용시키려면 analyze table tbl_name으로 테이블을 분석/처리 필요
*/

# 인덱스 없이 테이블 생성
create table vip
(
	vip_id			int primary key,
    first_name		varchar(10) not null,
    last_name		varchar(10) not null,
    email			varchar(10),
    phone			varchar(20),
    regist_date		timestamp default now()
);

show index from vip;

# 인덱스 생성
create index idx_regist_date
on vip(regist_date);

create unique index idx_email
on vip(email);

create unique index idx_phone
on vip(phone);

create index idx_name
on vip(first_name, last_name);

show index from vip;

drop table vip;

# 인덱스 없이 테이블 생성
create table vip
(
	vip_id			int,
    first_name		varchar(10) not null,
    last_name		varchar(10) not null,
    email			varchar(10),
    phone			varchar(20),
    regist_date		timestamp default now()
);

show index from vip;

alter table vip
add primary key(vip_id);

alter table vip
add unique index idx_email(email),
add unique index idx_phone(phone);

alter table vip
add index idx_regist_date(regist_date),
add index idx_name(first_name, last_name);

# 인덱스 삭제 문법
drop index idx_name
on vip;

drop index idx_regist_date
on vip;

alter table vip
drop index idx_email,
drop index idx_phone;

alter table vip
drop primary key;

show index from vip;