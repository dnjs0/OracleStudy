-- ex03_select.sql

/*
    SQL
        - Query

    SELECT문
    - DML, DQL
    - 가장 중요한 Query
    - CRUD
    - 데이터베이스의 테이블로부터 데이터를 가져오는 명령어
    
    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC | DESC]];
    -> 대괄호는 생략 가능

    SELECT column_list
    FROM table_name
    
    각 절의 순서(***반드시 외워야한다***)
    1. FROM 절 (거의 1등)
    2. SELECT 절 (거의 꼴등)
    
*/

select * --2. *(wildcard) > 모든 칼럼, select all, select star
from tblType; --1. tblType으로 부터

--hr.employess (샘플)
-- 처음 본 테이블 > 테이블 명세서 확인 
--              > 테이블 구조 확인 (desc employees)

desc employees;

select * from employees; --employees에서 모든 칼럼 갖고와라

select first_name --단일 컬럼 갖고오기
    from employees;

--다중 컬럼 갖고오기
select first_name, last_name 
from employees;

--같은거 여러번 갖고오기
select first_name, first_name
from employees;

-- 같은거 여러번 갖고오기
select first_name, length(first_name) 
from employees;

-- 테이블 원본의 컬럼 순서와 select절의 컬럼순서는 무관
select last_name, first_name 
from employees;

-- 옆에 100과 홍길동이 적힘
select first_name, 100, '홍길동'
from employees;

-- 에러 : 테이블 명에 오타가 났구나~
-- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
select *
from employee;

-- 에러 : 컬럼명에 오타가 났구나~
-- ORA-00904: "FIRSTNAME": 부적합한 식별자
select firstname
from employees;

-- select문의 결과는 항상 테이블로 반환 > 결과 테이블 이라고 부름(Result Table, Result Set)
select *from employees;








