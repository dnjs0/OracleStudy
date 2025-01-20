-- ex26_with.sql





/*

    [WITH <Sub Query>]  --1
    SELECT column_list  --5
      FROM table_name  --2
    [WHERE search_condition]  --3
    [GROUP BY group_by_expression]  --4
   [HAVING search_condition]  
    [ORDER BY order_expression [ASC|DESC]]; --6

    WITH <Sub Query> 1.
    SELECT column_list > 6.컬럼 지정(보고 싶은 컬럼만 가져오기) > Projection
      FROM table_name > 2.테이블 지정
    WHERE search_condition > 3.레코드마다 질문, 조건 지정(보고 싶은 행만 가져오기) > Selection
    GROUP BY group_by_expression > 4. 그룹을 나눈다.
   HAVING search_condition > 5. 그룹에 대한 조건
    ORDER BY order_expression [ASC|DESC] > 7. 결과셋의 레코드 순서를 정한다.

    각 절의 순서(*****)
    1. WITH
    2. FROM
    3. WHERE
    4. GROUP BY
    5. HAVING
    6. SELECT
    7. ORDER BY

    
    with 절
    - 인라인 뷰에 이름을 붙이는 기술

*/
create or replace view vwSeoul
as
select * from tblInsa where city = '서울';

select * from vwSeoul;

-- 인라인 뷰
select * from (select * from tblInsa where city = '서울');

with seoul as (select * from tblInsa where city = '서울')
select * 
from seoul;

-- tblMen(90kg 이하) + tblWomen(60kg 이상) = join

select name, age, weight, couple from tblMen where weight < 90;
select name, age, weight, couple from tblWomen where weight > 60;

select * from tblMen m
    inner join tblWomen w
        on m.couple = w.name;
        
        
select * from (select name, age, weight, couple from tblMen where weight < 90) a
    inner join (select name, age, weight, couple from tblWomen where weight > 60) b
        on a.couple = b.name;



with  a as (select name, age, weight, couple from tblMen where weight < 90), 
    b as (select name, age, weight, couple from tblWomen where weight > 60)
select *
from a
    inner join b
        on a.couple  = b.name;
        
        
/*
    
    null 함수
    - null값을 치환하는 함수
    
    null value
    1. nvl(컬럼, 값)
    2. nvl2(컬럼, 값, 값)
    
    
    
    
    
*/


select 
    name, population,
    case
        when population is not null then population
        when population is null then 0
    end,
    nvl(population, 0) --위 case 구문과 같음
    -- nvl(population, '인구미기재') -- 에러 : int컬럼은 int만 넣기
from tblCountry;

create table tblItem(
    seq number primary key,
    name varchar2(100) not null,
    color varchar2(100) not null
);

create sequence seqItem;
  
insert into tblItem(seq, name, color)
    values(seqItem.nextVal, '마우스','white');

-- 서브 쿼리로 번호 매기기
insert into tblItem(seq, name, color)
    values((select nvl(max(seq),0)+1 from tblItem), '마우스','white');
    
select * from tblItem;
select nvl(max(seq), 0) from tblItem;


select
    name, population,
    nvl(population,0),
    nvl2(population,'인수있음','인구없음')
from tblCountry;


