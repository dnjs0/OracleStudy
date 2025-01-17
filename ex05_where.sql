-- ex05_where.sql

/*
    
    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC | DESC]];

    SELECT column_list > 컬럼 지정(보고싶은 컬럼만 가져오기) > Projection
    FROM table_name > 테이블 지정
    WHERE search_condition > 조건 지정(보고싶은 행만 가져오기) > Selection
    
    각 절의 순서(***반드시 외워야한다***)
    1. FROM 절 (거의 1등)
    2. WHERE 절
    3. SELECT 절 (거의 꼴등)
    
    where 절
    - 레코드마다 진행
    - 레코드(행)을 검색한다.
    - 원하는 레코드만 추출
    
    
*/

-- 무슨 레코드 있는지 보기
desc employees;


-- select : 컬럼을 거르는 역할
-- whrere : 레코드를 거르는 역할
select first_name, salary
from employees
where salary >= 10000;

-- 적게 받을 경우
select first_name, salary
    from employees
        where salary <= 3000;
        
-- 조건 두개 넣기
select first_name, salary
    from employees
        where salary > 3000 and salary < 10000;
        
-- 이름 찾기
select first_name, salary
    from employees
        where first_name='Diana';

--예시        
select *
    from employees
        where job_id = 'IT_PROG' or job_id='ST_MAN';




-- 테이블 뭐 있는지 보기
select * from tabs;

-- 직원정보        
select *from employees;

-- 부서정보
select * from departments;

--회사의 위치 정보
select * from locations;

--국가 정보
select * from countries;

-- 지역 정보(대륙)
select * from regions;

-- 직원의 직무 정보
select * from jobs; 

-- 직원의 적직 이력 정보
select * from job_history;

-- 테이블 추가하고 난 이후
select * from tabs;

select * from tblcountry;

-- 아시아에 있는 나라와 인구
select name, population
    from tblcountry
        where continent = 'AS';
        
-- 아시아를 제외한 나라와 인구        
select name, population
    from tblcountry
        where continent <> 'AS';
        
        
/*
    tblComedian
    1. 몸무게가 68kg 이상이고, 키가 178cm 미만인 사람을 가져오시오.
    2. 몸무게가 78kg이하인 여자만 가져오시오
    
    tblInsa
    3. 부서가 '개발부'이고, 급여가  150만원 이상 받는 직원을 가져오시오.
    4. 급여 + 수당을 합한 금액이 200만원 이상 박는 직원을 가져오시오.
*/

select * from tblcomedian;

--1.
select last, first, height, weight
    from tblcomedian
        where height < 178 and weight>= 68;
        
--2.        
select last, first,gender, weight
    from tblcomedian
        where gender = 'f' and weight<= 78;
        
select * from tblInsa;

--3.
select name,buseo, basicpay
    from tblInsa
        where buseo = '개발부' and basicpay >=1500000;
        
 --4.       
select name, basicpay, sudang,basicpay+sudang
    from tblInsa
        where basicpay+sudang>=2000000;
        
        
/*

    
    between 연산자
    - where절에서 사용 > 조건으로 사용
    - 컬럼명 between 최솟값 and 최댓값
    - 최솟값과 최댓값 둘다 포함
    - 범위 조건
    - 가독성 향상
    
    
    in 연산자
    - where절에서 사용 > 조건으로 사용
    - 열거형 조건
    - 컬럼명  in (값, 값, [,값] X N)
    - 가독성 향상
    
    like 
    - where 절에서 사용
    - 패턴비교
    - 컬럼명 like '패턴문자열'
    - 정규 표현식 > 간단한 버전
    - 패턴문자열의 구성요소
        1. _ : 임의의 문자 1개
        2. % : 임의이 문자 N개(0~무한대)
    
    
*/

-- 아래 두 구문은 같은 결과
select * from tblInsa where basicpay >= 1000000 and basicpay <=1500000;
select * from tblInsa where basicpay between 1000000 and 1500000;


-- 비교 연산(연산자 + between)
-- 1. 숫자형
select * from tblInsa where basicpay >= 1000000 and basicpay <=1500000;
select * from tblInsa where basicpay between 1000000 and 1500000;

-- 2. 문자형
-- 문자코드 비교 가능, name.compareto('이순신')
-- 이순신 뒤에있는 이름들 갖고옴
select * from tblInsa where name >= '이순신';
select * from employees where first_name >= 'J' and first_name <='L';
select * from employees where first_name between 'J' and 'L' ;

-- 3. 날짜시간형
-- 날짜 리터럴
select * from tblInsa where ibsadate >= '2010-01-01'; 
select * from tblInsa where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31'; 
select * from tblInsa where ibsadate between '2010-01-01' and '2010-12-31';

-- in 연산자
-- tblInsa 부서 > 개발부 + 총무부 + 인사부
select * from tblInsa
    where buseo = '개발부' or buseo = '총무부' or buseo = '인사부';

select * from tblInsa
    where buseo in ('개발부', '총무부', '인사부');

-- 서울 또는 인천에 살면서, 과장 또는 부장이면서, 급여(250~300)인사람
select * from tblInsa
    where city in ('서울', '인천') 
        and jikwi in ('과장','부장')
            and  basicpay between 2500000 and 3000000;


-- like 연산자
-- 김씨 사람만 데려오고 싶다
-- 김으로 시작하는 세글자 이름
select name from tblInsa where name like '김__'; 
select name from tblInsa where name like '_길_'; 
select name from tblInsa where name like '__수'; 

-- 김으로 시작하는 모두
select name from tblInsa where name like '김%'; 
select * from employees where first_name like 'Sa%';

--a로 끝나는 사람
select * from employees where first_name like '%a';

-- am을 포함하는 이름
select * from employees where first_name like '%am%';

-- 여직원만 가져오기(성별 칼럼이 없으니 주민등록번호로 )
select * from tblInsa where ssn like '%-2%';
select * from tblInsa where ssn like '______-2______';

/*
    
    RDBMS에서의 null
    - 컬럼값이 비어있는 상태
    - null 상수 제공 > null
    - 대부분의 언어는 null 은 연산의 대상이 될 수 없다.(*******************)
        (population = null이 안됨)
    
    null 조건
    - where절에서 사용
    - 컬럼명 is null
    -  부정하기 : 컬럼명 is not null 또는 not 컬럼명 is null
    
    
*/

select * from tblCountry;

-- 인구수가 기재되지 않은 나라가 어디인가?
select * from tblCountry where population is null;

-- 인구수가 기재된 나라가 어디인가?
select * from tblCountry where population is not null;
select * from tblCountry where not population is null;

select * from tblinsa;
select * from tblInsa where tel is null;

select * from tbltodo;
select * from tbltodo where completedate is null;
select * from tbltodo where completedate is not null;

-- 도서관 > 대여 테이블(컬럼 : 대여날짜, 반납날짜)
-- 아직 반납을 안한 사람
select * from 대여 where 반납날짜 is null;