-- ex08_aggregation_function.sql

/*
    
    메서드
    - 함수, 프로시저 등,,
    - 클래스 내에서 선언된 함수
    
    함수, Function
    1. 내장 함수 (Built-in Function)
    2. 사용자 정의 함수 (User Fumction) > 표준 SQL(X), PL/SQL(O)
    
    집계함수 , Aggregation Function
    - Java Stream list.stream() >count(), sum(), max(), min(), average()
    - 쉬운 편 > 이후에 수업 > 어려워짐;; 헷갈려짐;;
    
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()
    
    
    1. count()
    - 무엇의 개수? > 결과  테이블의 레코드 수를 반환한다.
    - number count(컬럼명)
    - null 값은 제외한다.
    
*/

select * from tblcomedian;
select count(*) from tblcomedian; --10
select count(first) from tblcomedian;--10
select count(last) from tblcomedian;--10 > 모두 10개로 나옴 > 왜? null값이 없기때문이다.

select * from tblcomedian where gender = 'm';
select count(*) from tblcomedian where gender = 'm';--8
select count(*) from tblcomedian where gender = 'f';--2


select * from tblcountry;
select count(*) from tblcountry; --14
select count(name) from tblcountry; --14
select count(population) from tblcountry; --13 > null값이 하나 있기때문
-- null값때문에 count 조심해서 쓰기!


select count(*) from tblinsa; --전체 직원수 60
select count(tel) from tblinsa; -- 연락처가 있는 직원 수57
select count(*)-count(tel) from tblinsa; -- 연락처가 없는 직원 수 3

select count(*), count(tel),count(*)-count(tel) from tblinsa; -- 한꺼번에 가져올때

select count(*) from tblinsa where tel is not null; --57
select count(*) from tblinsa where tel is null; --3


-- tblComedian 남자 수? 여자 수?
select * from tblComedian;

select count(*) from tblComedian where gender = 'm'; --8
select count(*) from tblComedian where gender = 'f'; --2

-- tblcomedian 남자수,여자수를 1개의 테이블 > 자주 사용되는 패턴(*****)
select 
    count(case
        when gender = 'm' then 1
    end) as men, -- null과 null이 아닌 것으로 나눈후 count
    count(case
        when gender = 'f' then 1
    end) as women
from tblComedian;



-- tblInsa 기획부 몇명? 총무부 몇명? 개발부 몇명? > 1개의 테이블
select * from tblInsa;
select count(*) from tblInsa where buseo = '기획부';
select count(*) from tblInsa where buseo = '총무부';
select count(*) from tblInsa where buseo = '개발부';

select
    count(case
        when buseo = '기획부' then 1
    end) as 기획부명수,
    count(case
        when buseo = '총무부' then 1
    end) as 총무부명수,
    count(case
        when buseo = '개발부' then 1
    end) as 개발부명수,
    count(case
        when buseo not in('기획부','총무부','개발부') then 1
    end) as 기타,
    count(*) as 전체명수
from tblInsa;


/*
    
    2. sum()
    - 해당 컬럼값의 합을 구한다.
    - number sum(컬럼명)
    
    

*/

select * from tblCountry;
select count(area) from tblCountry; -- 레코드 개수
select count(*) from tblCountry; -- 14

select sum(area) from tblCountry; -- 컬럼값의 합, 숫자만 됨
select sum(name) from tblCountry; -- 문자 안됨!!
select sum(ibsadate) from tblInsa; -- 날짜 안됨!!

select
    sum(basicpay) as "총 지출 급여",
    sum(sudang) as "총 지출 수당"
from tblInsa;


/*
    
    3. avg()
    - 해당 컬럼값의 평균값을 구한다.
    - number avg(컬럼명)
    - 숫자형에만 적용 가능
    

*/

-- tblInsa 평균급여
select sum(basicpay)/60  from tblinsa;
select sum(basicpay)/count(*)  from tblinsa;
select avg(basicpay) from tblinsa;

-- tblCountry 평균 인구수?
select * from tblcountry;
select sum(population)/14 from tblCountry;
select sum(population)/count(*) from tblCountry;
select avg(population) from tblCountry; --population에 null값이 있기때문에 14가 아닌 13으로 나눈다.


/*
    
    4. max()
        - 최댓값 반환
        - object max(컬럼명)
        -모든 곳에 쓸 수 있다. 
    5. min()
        - 최솟값 반환
        - object min(컬럼명)
        -모든 곳에 쓸 수 있다.
    

*/


select max(baiscpay),min(basicpay) from tblinsa; --숫자형

select max(name),min(name) from tblinsa; --문자형
select max(ibsadate), min(ibsadate) from tblinsa; --날짜셩


select 
    count(*) as 직원수,
    sum(basicpay) as 총 급여합,
from tblinsa;


-- 집계 함수 사용시 주의점!! > 집계 함수의 특성(이해!!!!!)
-- 컬럼리스트(select절)에서는 집계함수와 일반 컬럼을 동시에 사용할 수 없다.
-- where 절에는 절대로 집계함수를 사용할 수 없다.
-- where > 개인(레코드)에 대한 조건절
-- 서브쿼리로 해결 가능


-- 요구사항] 직원들 이름과 총 직원수를 가져오시오.
select name, count(*) from tblinsa; -- 에러


-- 요구사항] 평균 급여보다 더 많이 받는 직언이 궁금
select avg(basicpay) from tblinsa;
select * from basicpay  where baiscpay >= avg(basicpay) ;



