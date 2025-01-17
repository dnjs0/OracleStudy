-- ex23_alter.sql

/*

    DDL : 객체 조작하는 명령어
        - 객체 생성 : create
        - 객체 수정 : alter
        - 객체 삭제 : drop
    
    
    DML : 데이터를 조작하는 명령어
        - 데이터 생성 : insert
        - 데이터 수정 : update
        - 데이터 삭제 : delete



    테이블 수정하기
    - 테이블 수정 > 테이블 스키마 수정 > 컬럼 수정
        > 컬럼명 or 자료형(길이) or 제약 사항 > 수정
    - 되도록 테이블을 수정하는 상황을 발생시키면 안된다!!!!!!
    - 테이블 설계를 꼼꼼하게 + 검토
    
    
    테이블 수정해야하는 상황 발생!!!!
    1. 기존테이블 삭제(drop) > 테이블 DDL 수정 > 수정된 DDL로 다시 테이블 생성
        a. 기존 테이블에 데이터가 없을 경우 > 아무 문제 없음
        b. 기존 테이블에 데이터가 있을 경우 > 미리 데이터를 백업해야한다. > 테이블 삭제 > 수정된 테이블 생성 > 데이터 복구
            - 개발 중에 많이 사용
            - 학즙 중에도 많이 사용
            - 운영중에는 많이 부담
    
    2. alter 명령어 사용 > 기존 테이블의 구조 변경
        a. 기존 테이블에 데이터가 없을 경우 > 아무 문제 없음
        b. 기존 테이블에 데이터가 있을 경우 > 상황에 따라 다름
            - 개발 중에 많이 사용
            - 학즙 중에도 많이 사용
            - 운영중에는 덜 부담    
    
    

*/


create table tblEdit(
    seq number primary key,
    name varchar2(20) not null
);

insert into tblEdit values(1,'마우스');
insert into tblEdit values(2,'키보드');
insert into tblEdit values(3,'모니터');

select * from tblEdit;


-- Case 1.새로운 컬럼을 추가하기
alter table 테이블명 add (컬럼정의);

alter table tblEdit add (price number);

alter table tblEdit add (qty number not null); -- 에러 not null안댐,테이블 삭제하고 실행해야한다.

desc tblEdit; -- price 진짜 추가되어 있음
select * from tblEdit;

delete from tblEdit;

insert into tblEdit values (1, '마우스',1000,1);
insert into tblEdit values (2, '키보드',2000,1);
insert into tblEdit values (3, '모니터',10000,1);

select * from tblEdit;

alter table tblEdit add (color varchar2(30) default 'white' not null); -- not null이 아니므로 default값을 넣어준다.

--Case2. 컬럼을 삭제하기
alter table 테이블명 drop column 컬럼명;

alter table tblEdit drop column price; -- price컬럼 빼라
alter table tblEdit drop column color;
alter table tblEdit drop column seq; --주의!!! PK는 지우면 안된다.
rollback; -- 롤백도 안됨,.....
-- 중요한 컬럼은 조심조심 또 조심!!

select * from tblEdit;

drop  table tblEdit;


-- Case 3. 컬럼 수정하기
insert into tblEdit values (4,'맥북 M4 프로 2025 고급형');
-- "HR"."TBLEDIT"."NAME" 열에 대한 값이 너무 큼(실제: 31, 최대값: 20) 에러남
-- 컬럼을 수정해서 자료의 길이를 늘리자!

-- Case 3-1 컬럼 길이 수정하기(확장/ 축소)
alter table 테이블명
    modify (컬럼정의);
    
alter table tblEdit modify(name varchar(100));  --확장하기
insert into tblEdit values (4,'맥북 M4 프로 2025 고급형'); --확장 후 성공

select * from tblEdit; --확인
desc tblEdit;

-- 줄이기
alter table tblEdit modify(name varchar(20)); --에러남ㄴ!!
-- 일부 값이 너무 커서 열 길이를 줄일 수 없음


-- Case 3-2 NULL제약 수정하기
alter table tblEdit modify (name varchar2(31) null); --명시적으로 적어줘야 not null 에서 null로 고쳐짐

alter table tblEdit modify (name varchar2(31) not null); --다시 not null이 됨

select * from tblEdit; --확인
desc tblEdit;



alter table tblEdit modify (name varchar2(31) null); 

insert into tblEdit values (5,null); --null값이 있는것을 넣었으므로 not null로 바꿀수 없음
-- 지우던지 null 에 값을 넣든지 해야한다.

alter table tblEdit modify(name varchar2(31) unique);
alter table tblEdit modify(name varchar2(31) check(length(name)>=3));

-- 제약 확인하기
select * from user_constraints
    where table_name = 'TBLEDIT';

alter table rbledit drop constraint SYS_C008489;--??

select * from tblEdit; --확인
desc tblEdit;


-- Case3.3 컬럼의 자료형 수정하기
delete from tblEdit;

alter table tblEdit modify(name number);

desc tblEdit;


-- Case 3.4 PK추가하기
create table tblEdit(
    seq number,
    name varchar2(20) not null
);

insert into tblEdit values(1,'마우스');
insert into tblEdit values(2,'키보드');
insert into tblEdit values(3,'모니터');

select * from tblEdit;

-- pk설정
alter table tblEdit
    add constraint tbledit_seq_pk primary key(seq);

--pk삭제
alter table tblEdit
    drop constraint tbledit_seq_pk;

desc tblEdit;















































