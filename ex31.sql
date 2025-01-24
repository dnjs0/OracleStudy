-- ex31.sql

-- 근태 관리(출결)
create table tblDate(
    seq number primary key,             --PK
    state varchar2(30) not null,        --정상, 지각,조회
    regdate date not null               --날짜
);


-- 2024년 8월
insert into tblDate (seq, state, regdate) values ( 1, '정상', '2024-08-01');
insert into tblDate (seq, state, regdate) values ( 2, '정상', '2024-08-02');
-- 08-03: 토요일
-- 08-04: 일요일

insert into tblDate (seq, state, regdate) values ( 3, '지각', '2024-08-05');
insert into tblDate (seq, state, regdate) values ( 4, '정상', '2024-08-06');
insert into tblDate (seq, state, regdate) values ( 5, '정상', '2024-08-07');
insert into tblDate (seq, state, regdate) values ( 6, '조퇴', '2024-08-08');
insert into tblDate (seq, state, regdate) values ( 7, '정상', '2024-08-09');
-- 08-10: 토요일
-- 08-11: 일요일


insert into tblDate (seq, state, regdate) values ( 8, '조퇴', '2024-08-12');
insert into tblDate (seq, state, regdate) values ( 9, '정상', '2024-08-13');
insert into tblDate (seq, state, regdate) values (10, '정상', '2024-08-14');
insert into tblDate (seq, state, regdate) values (11, '정상', '2024-08-16');
-- 08-15: 광복절
-- 08-17: 토
-- 08-18: 일

insert into tblDate (seq, state, regdate) values (12, '정상', '2024-08-19');
insert into tblDate (seq, state, regdate) values (13, '정상', '2024-08-20');
insert into tblDate (seq, state, regdate) values (14, '지각', '2024-08-21');
-- 08-22: 결석
insert into tblDate (seq, state, regdate) values (15, '정상', '2024-08-23');
-- 08-24: 토
-- 08-25: 일

insert into tblDate (seq, state, regdate) values (16, '정상', '2024-08-26');
insert into tblDate (seq, state, regdate) values (17, '지각', '2024-08-27');
insert into tblDate (seq, state, regdate) values (18, '정상', '2024-08-28');
insert into tblDate (seq, state, regdate) values (19, '정상', '2024-08-29');
insert into tblDate (seq, state, regdate) values (20, '정상', '2024-08-30');
-- 08-31: 토

commit;

select to_char(regdate, 'yyyy-mm-dd') from tblDate order by regdate asc;

-- 요구사항] 근태 조회 > 8월 전체의 근태 상황 열람
-- 근태 > 달력에 출력
-- 2024-08-01~2024-08-30 > 모든 날짜 열람 + 상태 확인
-- 빠진 날짜 메꾸기 !

-- 1. PL/SQL
-- 2. 표준 SQL(**********************)
-- 3. 자바 연동(지금은 안됨)

-- 공휴일 테이블
create table tblHoliday(
    seq number primary key,     --pk
    regdate date not null,      -- 날짜
    name varchar2(30) not null  -- 공휴일명
);
insert into tblHoliday values (1, '2024-08-15','광복절');


-- PL/SQL

set serveroutput on;

declare
    vdate date;
    vcnt number;
    vstate tblDate.state%type;
begin

    -- seed(2024-08-01)
    vdate := to_date('2024-08-01','yyyy-mm-dd');

    for i in 1..31 loop
    
        dbms_output.put_line(vdate);
        
        select count(*) into vcnt from tblDate
            where to_char(regdate,'yyyy-mm-dd') = to_char(vdate, 'yyyy-mm-dd');
        
        dbms_output.put_line(vcnt);
        if vcnt > 0 then
            -- 평일(나온날)
            select state into vstate from tblDate
                where to_char(regdate,'yyyy-mm-dd') = to_char(vdate, 'yyyy-mm-dd');
            dbms_output.put_line(vstate);
        else
            -- 토, 일, 공휴일, 결석
            if to_char(vdate, 'd') in ('1','7') then
                dbms_output.put_line('주말');
            else
                --dbms_output.put_line('공휴일 or결석');
                
                select count(*) into vcnt from tblHoliday
                    where to_char(regdate,'yyyy-mm-dd') = to_char(vdate, 'yyyy-mm-dd');
                    
                if vcnt > 0 then
                    dbms_output.put_line('공휴일');
                else
                    dbms_output.put_line('결석');
                end if;
                
            end if;
            
        end if;
        
        
        
        
        vdate := vdate + 1;
    end loop;
    
end;
/


-- 표준 SQL (****)
-- 계층형 쿼리 > 루프 역할

select 
    level,
    sysdate + level -1
from dual
    connect by level <= 10;


-- 원하는 시작 날짜 ~ 종료 날짜 생성 > 기억해주면 좋다!!!!(**************)


create view

select
    to_date('2024-08-01','yyyy-mm-dd') + level -1 as regdate
from dual
    connect by level <= (to.date('2024-08-31','yyyy-mm-dd')
                            - to.date('2024-08-01','yyyy-mm-dd') + 1);



-- (to.date('2024-08-31','yyyy-mm-dd')- (to.date('2024-08-01','yyyy-mm-dd') + 1 : 8월1일부터 31일까지의 날짜 수



select * from vwDate; --8월 한달 날짜
select * from tblDate; --8월 근태기록



select * from vwDate v
    left outer join tblDate t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.regdate, 'yyyy-mm-dd')
            order by v.regdate asc;



select 
    v.regdate,
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when h.seq is not null then h.name
        else t.state
    end as state
from vwDate v
    left outer join tblDate t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.regdate, 'yyyy-mm-dd')
            left outer join tblHoliday h
                on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.regdate, 'yyyy-mm-dd')
                    order by v.regdate asc;































