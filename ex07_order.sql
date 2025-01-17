-- ex07_order.sql

/*

    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC | DESC]];

    SELECT column_list > 3. 컬럼 지정(보고싶은 컬럼만 가져오기) > Projection
    FROM table_name > 1. 테이블 지정
    WHERE search_condition > 2. 조건 지정(보고싶은 행만 가져오기) > Selection
    ORDER BY order_expression [ASC | DESC] > 4. 결과셋의 레코드 순서를 정한다.
    
    각 절의 실행 순서(***반드시 외워야한다***)
    1. FROM 절 
    2. WHERE 절
    3. SELECT 절 
    4. ORDER BY
    
    ORDER BY 절
    - 정렬
    - 결과셋의 레코드 정렬!!. 원본 테이블의 정렬(X > 오라클이 알아서 정렬)
    - order by 대상 칼럼 (기준) asc // ascending. 오름차순(기본값)
    - order by 대상 칼럼 (기준) desc // descending. 내름차순

*/

select * from tblinsa order by name;

-- 자료형 확인
-- 우위 비교가 가능하면 정렬이 가능하다.
select * from tblinsa order by basicpay desc; --숫자형
select * from tblinsa order by name; --문자형
select * from tblinsa order by ibsadate; --날짜형


--다중 정렬
select * from tblInsa order by buseo asc; --1차정렬
select * from tblInsa order by buseo asc, jikwi asc; --2차 정렬
select * from tblInsa order by buseo asc, jikwi asc, basicpay desc; --3차 정렬


-- Java : 첨자 0부터 시작(컴파일 언어)
-- SQL : 첨자 1부터 시작(스크립터 언어, 인터프리터 언어)
select 
    num, name, buseo, jikwi -- 2.
from tblInsa                -- 1. 
    order by 3 asc;         -- 3. 2번의 3번째 (buseo)로 나열, 비권장


-- 연산 결과로도 정렬할 수 있다.    
select * from tblinsa order by basicpay desc;   
select * from tblinsa order by basicpay+sudang desc;

--직원을 성별순으로 정렬
-- : 남자 > 여자 순으로
select * from tblcomedian order by gender desc;

-- 정석
select --2.
    name, ssn,
    case
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'       
    end as gender
from tblinsa --1.
order by gender desc;--3.마지막이므로 gender가 생성된 후임.

-- 별명을 안지은 경우
select 
    name, ssn,
    case
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'       
    end
from tblinsa
order by 3 desc;

-- 성별 컬럼을 빼되, 정렬은 성별로 해줘
select 
    name, ssn
from tblinsa
order by case
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'       
    end desc;
    

-- 직위순으로 정렬 : 부장(1) > 과장(2) > 대리(3) > 사원(4)
select
    name, jikwi,
    case
        when jikwi = '부장' then 1 --매핑과정
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
    end as numJikwi
from tblInsa
order by numJikwi;


-- 직위순으로 정렬 : 부장(1) > 과장(2) > 대리(3) > 사원(4)
-- numjikwi가 뭐예요 지워요
select
    name, jikwi
from tblInsa
order by case
        when jikwi = '부장' then 1 --매핑과정
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
    end;
    
    
    
    
-- 정렬 +  null?
-- asc : null은 맨 밑에
select * 
from tblTodo
order by completedate asc;

-- asc정렬이지만 null 맨위로 와라
select * 
from tblTodo
order by completedate asc nulls first;

--desc null이 맨 위에    
select * 
from tblTodo
order by completedate desc;

--desc 정렬이지만 null 맨 아래로 가라    
select * 
from tblTodo
order by completedate desc nulls last;