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

/*
    
    조인, Join
    - (서로 관계를 맺은) 2개(1개) 이상의 테이블을 1개의 결과셋으로 만드는 기술
    - 태이블 합치기
    
    조인 종류
    1. 단순 조인, cross join
    2. 내부 조인, inner join
    3. 외부 조인, outer join
    4. 셀프 조인, self join
    5. 전체 외부 조인, full outer join
    
    1. 단순 조인 cross join, 카티션 곱, 데카르트 곱
    - 사용 안함 > 가치가 있는 행과 가치가 없는 행이 뒤섞여 있다.
    - 모든 조인의 기본 동작
    - A 테이블 X B 테이블
    - 다량의 더미 생성용 or 테스트용
    
    
    SELECT * FROM A CROSS JOIN B;   --ANSI 문법(*추천)
    SELECT * FROM A,B;              --ORACLE 전용 문법
    
    
    2. 내부 조인, inner join
    - 단순 조인에서 유효한 레코드만 추출한 조인
    
    SELECT * FROM A INNER JOIN B ON A.PK = B.FK;
    
    
    3.외부조인,outer join
    - 내부조인의 반댓말(X)
    - 내부조인의 결과 셋 + a(내부 조인에는 포함되지 않는 부모 테이블의 나머지 레코드)
    - 자식테이블을 가르키는 경우 거의 내부조인과 같음
    - 주로 부모 테이블을 가리키도록 외부조인을 사용
    
    SELECT * FROM A INNER JOIN B ON A.PK = B.FK;
    
    SELECT * FROM A (LEFT|RIGHT) OUTER JOIN B ON A.PK = B.FK;


    4. 셀프 조인 , self join
    - 1개의 테이블을 사용하는 조인
    - 테이블이 자기 자신과 관계를 맺는 경우
    
    
    
    
*/

--<4.셀프조인>
--직원 테이블
create table tblself(
    seq number primary key,                 --직원 번호(PK)
    name varchar2(30) not null,             --직원명
    department varchar2(30) not null,       --부서명
    super number references tblself(seq) null    -- 상사번호(FK)
);

insert into tblSelf values (1,'홍사장','사장실',null);
insert into tblSelf values(2,'김부장','영업부',1);
insert into tblSelf values(3,'박과장','영업부',3);
insert into tblSelf values(4,'최대리','영업부',3);
insert into tblSelf values(5,'정사원','영업부',4);
insert into tblSelf values(6,'이부장','개발부',1);
insert into tblSelf values(7,'하과장','개발부',6);
insert into tblSelf values(8,'신과장','개발부',6);
insert into tblSelf values(9,'황대리','개발부',7);
insert into tblSelf values(10,'하사원','개발부',9);

select * from tblSelf;

-- 직원 명단을 가져오시오. 단, 상사명까지
-- 1. join
-- 2. subquery
-- 3. 계층형 쿼리(오라클 전용)

--1. join
select 
    e.name as 직원명,
    e.department as 부서명,
    s.name as 상사명
from tblSelf e --직원(자식)
    LEFT outer join tblSelf s --상사(부모)
       on s.seq = e.super;
-- 직원으로서의 홍사장이 누락되었으므로 left outer조인



-- 2. subquery
select
    department as 부서명,
    (select name from tblSelf s2 where seq = s1.super) as 상사명
from tblSelf s1; --직원(자식역할)


























--대여 기ㄴ록이 있는 회원의 이름과 연락처?
select
    distinct m.name, m.tel
from tblMember m
    inner join tblRent r
        on m.seq = r.member;


--대여 기ㄴ록이 있는 회원의 이름과 연락처? +대여 횟수?
-- 1. 서브쿼리 
    -- 누가 메인이 될지 ㅇ정해야한다.
    select 
        tblMember.*,
        (select count(*) from tblRent where member=tblMember.seq)
    from tblMember
       where (select count(*) from tblRent where member = tblMember.seq) > 0;

select * from tblMember;    
select * from tblRent;

-- 2. 그룹바이
select
    m.seq, count(*)
from tblMember m
    inner join tblRent r
        on m.seq = r.member
            group by m.seq;


--2-1 이름도 넣어야함, 서브쿼리
select
    m.seq,(select name from tblMember where seq = m.seq),
    (select tel from tblMember where seq = m.seq),count(*)
from tblMember m
    inner join tblRent r
        on m.seq = r.member
            group by m.seq;


--2-2 조건에 넣기, 아무때나 쓸수는 없지만 지금은 ok
select
    m.seq,m.name, m.tel, count(*)
from tblMember m
    inner join tblRent r
        on m.seq = r.member
            group by m.seq, m.name, m.tel;





-- <전체 외부 조인>
select 
    *
from tblMen m
    full outer join tblWomen w
        on m.couple = w.name
            order by m.couple, w.couple;




--<3. 외부조인>
select * from tblCustomer;-- 3명
select * from tblSales; --9건

insert into tblcustomer values(4, '호호호','010-1234-5568','서울시');
insert into tblcustomer values(5, '후후후','010-1234-5568','서울시');

select * from tblCustomer;-- 5명

select * from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;  --9 내부조인
        
select * from tblCustomer c
    left outer join tblSales s
        on c.seq=s.cseq;    --11 부모테이블을 가르키게 > 사용

select * from tblCustomer c
    right outer join tblSales s
        on c.seq=s.cseq;    --9 자식테이블을 가리키게 > 의미XX = 내부조인








select * from tblStaff;
select * from tblProject;

insert into tblStaff values(6, '호호호',250,'서울시');

-- 직원 명당 > 단, 프로젝트 담당자로 되어있는 직원만
select * from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq; ---호호호?
        
-- 직원 명단 > 프로젝트 담당 유무 무관 > 모든 명당 ~ + 담당프로젝트 정보까지
--outer join사용
select * from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;










select * from tblMen;
select * from tblWomen;

--ㅋㅓ플 목록을 가져오시오.
--inner join
select 
    *
from tblMen m
    inner join tblWomen w
        on m.couple = w.name;

--ㅋㅓ플 목록을 가져오시오. +  남자 솔로 목록도 같이
-- outer join
select 
    *
from tblMen m
    left outer join tblWomen w
        on m.couple = w.name;


--ㅋㅓ플 목록을 가져오시오. +  여자 솔로 목록도 같이
-- outer join
select 
    *
from tblMen m
    right outer join tblWomen w
        on m.couple = w.name;








-- <2.내부조인>
--employees > 7개
select
    e.first_name||e.last_name as 직원명,
    d.department_name as 부서명,
    l.city as 도시명,
    c.country_name as 국가명,
    r.region_name as 대륙명,
    j.job_title as 직업명
from  employees e
    inner join departments d
        on e.department_id = d.department_id
            inner join locations l
                on d.location_id = l.location_id
                    inner join countries c
                        on l.country_id = c.country_id
                            inner join regions r
                                on c.region_id = r.region_id
                                    inner join jobs j
                                        on e.job_id = j.job_id;

--비디오 + 장르 + 대여 + 회원
select
    m.name as 누가,
    v.name as 무엇을,
    r.rentdate as 언제,
    g.price as 얼마
from tblGenre g
 inner join tblVideo v
    on g.seq = v.genre
        inner join tblRent r
            on r.video = v.seq
                inner join tblMember m
                    on m.seq = r.member;





--비디오 + 장르 + 대여
select
*
from tblGenre g
 inner join tblVideo v
    on g.seq = v.genre
        inner join tblRent r
            on r.video = v.seq;



--비디오 + 장르
select
*
from tblGenre g
 inner join tblVideo v
    on g.seq = v.genre;

-- 두테이블을 같이 보고싶다! 할때 inner join 쓰기 
-- 직원 명단과 담당 프로젝트
select * from tblStaff inner join tblProject on tblStaff.seq = tblProject.staff_seq;


select * from tblCustomer 
    inner join tblSales 
        on tblcustomer.seq = tblSales.cseq;

select * from tblSales
    inner join tblCustomer
        on tblcustomer.seq = tblSales.cseq;

select 
    tblCustomer.seq as 고객번호,
    tblCustomer.name as 고객명,
    tblSales.seq as 판매번호,
    item as 상품명
from tblCustomer
    inner join tblSales
        on tblcustomer.seq = tblSales.cseq;

-- 테이블 별칭
select 
    c.seq as 고객번호,
    c.name as 고객명,
    s.seq as 판매번호,
    item as 상품명
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;
        
        
        
-- 고객+ 판매
-- 어떤 고객(c.name)이 어떤 물건(s.item)을 몇개(s.qty) 사갔습니까?
-- 1. 조인
select
    c.name as 고객명,
    s.item as 물품,
    s.qty as 수량
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq
            order by 고객명;


-- 2. 서브쿼리
-- 메인 쿼리를 어떤 테이블로?
-- 서브쿼리를 어떤 테이블로?
-- 메인쿼리(자식테이블) + 서브쿼리(부모테이블)
select 
    item,qty,
    (select name from tblCustomer where seq=cseq)
from tblSales;




--- <1.>
select * from tblCustomer;  -- 3명
select * from tblSales;     -- 9명

select * from tblcustomer cross join tblSales;
--27개 걍 곱하고 붙여서 나옴 > 쓰레기 데이터 너무 많음



































