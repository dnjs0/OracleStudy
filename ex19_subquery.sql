-- ex19_subquery.sql

/*
    
    Sub Query
    - 하나의 SQL(SELECT, INSERT, UPDATE, DELETE)안에 또 다른 SQL을 사용하는 기술
    
    Main Query
    - 주목적. 바깥쪽 쿼리
    
    Sub Query
    - 메인 쿼리에서 일부 테이터 역할
    - 데이터(값)을 넣을 수 있는 곳이며 모두 사용 가능

    

*/

-- tblCountry, 인구수가 가장 많은 나라의 이름? 중국
select max(population) from tblCountry; --120660
select name from tblCountry where population = 120660;

select max(population) from tblCountry; --120660
select name from tblCountry where population = (select max(population) from tblCountry);

-- tbiComedian, 몸무게가 가장 많이 나가는 사람?
select max(weight) from tblComedian;
select * from tblComedian where weight = 129;

select * from tblComedian where weight = (select max(weight) from tblComedain));

-- tblInsa. 평균급여보다 많이 받는 딕원들?
select * from tblInsa where basicpay >= (select avg(basicpay) from tblInsa);

--tblInsa 홍길동급여보다 작고, 김말자 급여보다 큰 직원들?
select * from tblInsa
    where basicpay between (select basicpay from tblInsa where name = '김말자') 
        and (select basicpay from tblInsa where name = '홍길동')
            order by basicpay;


-- 서브쿼리를 잘하려면?
--      어떤 질문이 서브쿼리? 어떤 질문이 메인쿼리? 구분~
-- 남자(키166)의 여자키?
select * from tblMen;
select * from tblWomen;

select height from tblWomen
    where couple = (select name from tblMen where height = 166);



/*
    
    서브 쿼리 삽입 위치
    1. 조건절 > 비교값으로 사용
        a. 반환값이 1행 1열 > 단일값 반환 > 상수 취급
        b. 반환값이 N행 1열 > 다중값 반환 > 열거형 비교 > in 연산자 사용
        c. 반환값이 1행 N열 > 다중값 반환 > 그룹 비교 > N컬럼 : N컬럼
        d. 반환값이 N행 N열 > 다중값 반환 > b + c > in 연산자 + 그룹비교

    2. 컬럼리스트
    


*/

-- 급여가 260만원 이상 받는 직원이 > 근무하는 부서 직원들 명단?
-- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--      single-row subquery returns more than one row
select * from tblInsa
    where buseo = (select buseo from tblInsa where basicpay >= 2600000);
    
select * from tblInsa
    where buseo in ('기획부','총무부');

select * from tblInsa
    where buseo in (select buseo from tblInsa where basicpay >= 2600000);


-- '홍길동'과 같은 지역(city), 같은 부서(buseo)인 직원 명단? > 서울, 기획부
select city, buseo from tblInsa where name = '홍길동';

select * from tblInsa where city = '서울' and buseo = '기획부';

select * from tblInsa 
    where city = (select city from tblInsa where name = '홍길동') 
        and buseo = (select buseo from tblInsa where name = '홍길동');
        --where 1:1 비교

select * from tblInsa 
    where (city,buseo) = (select city, buseo from tblInsa where name = '홍길동');
    --where 2:2 비교


-- 급여가 200만원 이상 받은 직원과 같은 부서, 같은 지역 > 명단?
select buseo, city from tblInsa where basicpay >= 2600000;

select * from tblInsa
    where (buseo, city) in (select buseo, city from tblInsa where basicpay >= 2600000);



/*

    2. 컬럼리스트
        - 반드시 결과값이 1행 1열이어야한다. > 스칼라쿼리(원자값을 반환)
        a. 정적 서브 쿼리 > 모든 행에 동일한 값을 반환 > 쓸곳이 거의 없음
        b. 상관 서브 쿼리(*****) > 메인쿼리의 일부 컬럼값을 서브쿼리에서 사용
    
    
    3. from 절에서 사용
        - 서브쿼리의 결과 테이블을 또 하나의 ㅇ테이블이라고 생각하고 메인쿼리를 작성
        - 인라인 뷰(Inline view)
    
*/

select 
    name, buseo, basicpay,
    (select avg(basicpay) from tblInsa)
from tblInsa;


-- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--              single-row subquery returns more than one row
select 
    name, buseo, basicpay,
    (select jikwi from tblInsa)
from tblInsa;


select 
    name, buseo, basicpay,
    (select jikwi,city from tblInsa where num = 1001)
from tblInsa;




select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa where buseo = a.buseo)
from tblInsa a;


select * from tblMen;

select * from tblWomen;

-- 남자(이름,키,몸무게) + 여자(이름,키,몸무게) > 1개의 테이블
select 
    name height, weight, couple,
    (select height from tblWomen where name = tblmen.couple),
    (select height from tblWomen adhere name = tblmen.couple)
from tblMen;





/*
    3. from 절에서 사용
    
    
*/s

selcet * from(select name from tblInsa;



















