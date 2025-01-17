-- ex20_join.sql

/*
    관계형 데이터베이스 시스템이 지양하는 것들
     - 테이블을 수정해야지만 고쳐지는것들 > 구조적 문제
     
    1. 테이블에 기본키가 없는 상태
    2. null이 많은 상태의 테이블 > 공간낭비 +SQL 작업 불편함
    3. 데이터가 중복되는 상태 > 공간 낭비 + 데이터 조작시 문제 발생(동기화)
    4. 하나의 속성값은 원자값이 아닌 경우를 싫어한다. > 더이상 쪼개지지 않는 값을 넣어야한다.
    
    
    취미가 운동인 사람
    where 취미 = '운동'
    
    취미가 요리인 사람
    where 취미 = '요리'
    where 취미 like = '%요리%'
    



*/

-- 직원 정보를 담는 테이블
-- 직원(번호(PK), 직원이름, 급여, 거주지,  담당프로젝트)
create table tblStaff
(
    seq number primary key,             --직원 번호(PK)
    name varchar2(30) not null,          -- 직원명
    salary number not null,             --급여
    address varchar2(300) not null,      --거주지
    project varchar2(300) null         --담당프로젝트
    
);

insert into tblStaff(seq,name, salary, address, project)
    values(1,'홍길동',300,'서울시','홍콩수출');

insert into tblStaff(seq,name, salary, address, project)
    values(2,'아무개',350,'인천시','TV광고');
    
insert into tblStaff(seq,name, salary, address, project)
    values(3,'하하하',200,'의정부시','매출분석');

select * from tblStaff;

--홍길동에게 담당프로젝트가 1건 추가> '고객관리'
--1.원자값이 아니므로 별로인 방법
update tblStaff set
    project =  project ||'고객관리'
        where seq =1;

--'아무개'에게 담당 프로젝트 1건 추가>'게시판 관리'
--2. 데이터가 중복되므로 별로인 방법 
insert into tblStaff(seq,name, salary, address, project)
    values(4,'아무개',350,'인천시','게시판관리');


-- 원인 : 테이블 스키마(구조)가 잘못된 상태
-- 해결 : 테이블 재구성, 하나의 테이블 두개로 쪼개야한다.
drop table tblStaff;
drop table tblProject;
-- 관계(Relationship)
-- 뷰모테이블의 PK = 자식테이블의 FK

-- 테이블 생성 순서
-- 부모테이블 > 자식테이블



-- 부모테이블    
create table tblStaff
(
    seq number primary key,             --직원 번호(PK)
    name varchar2(30) not null,          -- 직원명
    salary number not null,             --급여
    address varchar2(300) not null      --거주지
    
);    

insert into tblStaff(seq,name, salary, address)
    values(1,'홍길동',300,'서울시');

insert into tblStaff(seq,name, salary, address )
    values(2,'아무개',350,'인천시');
    
insert into tblStaff(seq,name, salary, address)
    values(3,'하하하',200,'의정부시');



-- 자식테이블
create table tblProject
(
    seq number primary key,         --프로젝트 번호
    project varchar2(300) not null,  --직원명
    staff_seq number not null references tblStaff(seq)     -- e담당 직원 번호

    
);


insert into tblProject(seq,project,staff_seq)
    values(1,'홍콩수출',1);

insert into tblProject(seq,project,staff_seq)
    values(2,'TV광고',2);
    
insert into tblProject(seq,project,staff_seq)
    values(3,'매출분석',3);


insert into tblProject(seq,project,staff_seq)
    values(4,'침대가기',3);
    
    
insert into tblProject(seq,project,staff_seq)
    values(5,'게시판 분석',2);

select * from tblStaff;
select * from tblProject;

--TV광고(tblProject) 담당자!! > 담당직원 이름 찾기(tblStaff)
-- 1. 서브쿼리 짜기
select name from tblStaff 
    where seq=(select staff_seq from tblProject where project = 'TV광고');

-- Case A. 신입사원 입사 > 신입프로젝트 배정
-- A.1 신입 사원을 추가한다.
insert into tblStaff(seq,name, salary, address)
    values(4,'호호호',300,'서울시'); 
    
    
-- A.2 신규프로젝트 배정    
insert into tblProject(seq,project,staff_seq)
    values(6,'자재 매입',4); --호호호가 배정됨

-- A.3 신규플젝 추가
insert into tblProject(seq,project,staff_seq)
    values(7,'고객 유치',5);

--A.4고객유치(tblProject) 담당자!! > 담당직원 이름 찾기(tblStaff) > 없음!!!??
select name from tblStaff 
    where seq=(select staff_seq from tblProject where project = '고객유치');



-- Case B. 홍길동 퇴사
-- B1. '홍길동'삭제
delete from tblStaff where seq=1;

select * from tblStaff;
select * from tblProject;

--홍콩수출(tblProject) 담당자!! > 담당직원 이름 찾기(tblStaff) > 없음!!!?? >논리에러
select name from tblStaff 
    where seq=(select staff_seq from tblProject where project = '홍콩수출');

insert into tblStaff(seq,name, salary, address)
    values(1,'홍길동',300,'서울시');


-- B2. 홍길동 삭제전에 업무 인수인계(위임)해야한당~
update tblProject set staff_seq = 2 where staff_seq=1;


--B.3비로소 퇴사
delete from tblStaff where seq=1;



-- 사원 추가
insert into tblStaff(seq,name, salary, address)
    values(1,'홍길동',300,'서울시');

insert into tblStaff(seq,name, salary, address )
    values(2,'아무개',350,'인천시');
    
insert into tblStaff(seq,name, salary, address)
    values(3,'하하하',200,'의정부시');

-- 플젝 추가
insert into tblProject(seq,project,staff_seq)
    values(1,'홍콩수출',1);

insert into tblProject(seq,project,staff_seq)
    values(2,'TV광고',2);
    
insert into tblProject(seq,project,staff_seq)
    values(3,'매출분석',3);


insert into tblProject(seq,project,staff_seq)
    values(4,'침대가기',3);
    
    
insert into tblProject(seq,project,staff_seq)
    values(5,'게시판 분석',2);



--테이블 삭제 순서
drop table tblProject; --먼저
drop table tblStaff;-- 참조되기때문이다.


-- 부모테이블    
create table tblStaff
(
    seq number primary key,             --직원 번호(PK)
    name varchar2(30) not null,          -- 직원명
    salary number not null,             --급여
    address varchar2(300) not null      --거주지
    
);    

insert into tblStaff(seq,name, salary, address)
    values(1,'홍길동',300,'서울시');

insert into tblStaff(seq,name, salary, address )
    values(2,'아무개',350,'인천시');
    
insert into tblStaff(seq,name, salary, address)
    values(3,'하하하',200,'의정부시');



-- 자식테이블
create table tblProject
(
    seq number primary key,         --프로젝트 번호
    project varchar2(300) not null,  --직원명
    staff_seq number not null references tblStaff(seq)     -- e담당 직원 번호

    
);


insert into tblProject(seq,project,staff_seq)
    values(1,'홍콩수출',1);

insert into tblProject(seq,project,staff_seq)
    values(2,'TV광고',2);
    
insert into tblProject(seq,project,staff_seq)
    values(3,'매출분석',3);


insert into tblProject(seq,project,staff_seq)
    values(4,'침대가기',3);
    
    
insert into tblProject(seq,project,staff_seq)
    values(5,'게시판 분석',2);

select * from tblStaff;
select * from tblProject;










































