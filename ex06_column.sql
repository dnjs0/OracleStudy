-- ex06_column.sql

-- select column_list
-- 컬럼 리스트에 올 수 있는 표현들

-- 1. 컬럼명
select name from tblCountry;

select * from tblcountry;

-- 에러 : * 와 다른 컬럼은 동시에 사용 불가능
select *, name from tblcountry;
    
-- 오라클
-- 모든 요소들이 곋정에 소속된다.
-- 다른 계정에서 실행할때 소속을 밝혀야한다.
select name from hr.tblcountry;

select hr.tblcountry.name from hr.tblcountry;

-- 에러 나지 않게 *와 다른 칼럼 사용
select tblcountry.*, name from tblcountry;

--- 2. 연산식
select name, basicpay, sudang, basicpay + sudang from tblInsa;

-- 식별자 수정 > 별칭(alias)
-- 대상 : 컬럼명, 테이블 명
select name, basicpay, sudang, basicpay + sudang as total from tblInsa;

-- 테이블은 as 안붙인다.
-- 짧게 만들게 함이 목적이므로 1~2글자만 이용한다.
select c.name from hr.tblcountry c;

-- 3. 상수 
select 100 from tblcountry;

-- 4. 함수(메서드) > 반환값 > 값
select name, length(name) as length from tblcountry;

select name, length(name) as "문자 수" from tblcountry;


/*
    distinct
    - Java Stream : list.stream().distinct().forEach()
    - 중복값 제거
    - 컬럼 리스트에서 사용
    - 특정 컬럼이 아니라 모든 컬럼에 적용!
    
    case
    - 대부분의 절에서 사용 가능
    - switch case 역할
    - 조건을 만족하면 then 을 반환
    - 조건을 불만족하면 null을 반환(***)
    
    
    
*/

-- tblcountry 에는 어떤 종류의 대륙이 있습니까?
-- 중복됨
select continent from tblcountry;

--중복 제거
select DISTINCT continent from tblcountry;

select * from tblinsa;
select distinct buseo from tblinsa;
select distinct jikwi from tblinsa;

-- 값이 같으면 동명이인이 없다.
select name from tblInsa;
select distinct name from tblInsa;


-- 이름이 중복되지 않았기때문에 부서는 중복되어서 나온다.
select distinct buseo, name from tblinsa;



select distinct buseo, jikwi from tblInsa;


select 
    last||first as name,
    gender,
    case
        --when 조건 then 값
        -- 순서대로 실행함
        when gender='m' then '남자'
        when gender = 'f' then '여자'
    end as genderName,
    case gender
        when 'm' then '남자'
        when 'f' then '여자'
    end as genderName2
    from tblcomedian;

select
    name, continent,
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        when continent = 'SA' then '남아메리카'
        --else '기타등등'
        --else 100 --자료형 준수
        --else name --실행은 되지만 의미와 타입이 맞지 않음
        else continent
    end as 대륙
    from tblCountry;


select
    last||first as name,
    weight,
    case
        when weight > 98 then '과체중'
        when weight > 50 then '정상체중'
        else '저체중'
    end as weightState,
    case
        when weight >= 50 and weight <= 90 then '정상체중'
        else '주의체중'
    end as weightState2,
    case
        when weight between 50 and 90 then '정상체중'
        else '주의체중'
    end as weightState3
    from tblcomedian;

-- 사원하고 대리 > 현장직
-- 과장, 부장 > 관리직
select 
    name,jikwi,
    case
        when jikwi = '사원'or jikwi='대리' then '현장직'
        when jikwi ='과장' or jikwi = '부장' then '관리직'
        else '관리직'
    end,
    case
        when jikwi in ('사원','대리') then '현장직'
        when jikwi  in ('과장','대리') then '관리직'
        else '관리직'
    end
from tblinsa;


select 
    name, ssn,
    case
        when ssn like '%-1%'then '남자'
        else '여자'
    end as 성별
from tblInsa;

select
    title,
    case
        when completedate is not  null then'완료'
        else '미완료'
    end as state
from tblTodo;
