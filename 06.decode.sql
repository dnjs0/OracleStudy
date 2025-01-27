-- decode

-- 1. tblInsa. 부장 몇명? 과장 몇명? 대리 몇명? 사원 몇명?
select 
    count(decode(jikwi, '부장', '1')) as 부장,
    count(decode(jikwi, '과장', '1')) as 과장, 
    count(decode(jikwi, '대리', '1')) as 대리, 
    count(decode(jikwi, '사원', '1')) as 사원 
from tblInsa;


-- 2. tblInsa. 간부(부장, 과장) 몇명? 사원(대리, 사원) 몇명?
select
    count(case
        when jikwi in ('부장','과장') then 1
    end) as 간부,
    count(decode(jikwi, '대리','1','사원','1')) as 사원
from tblInsa;

-- 3. tblInsa. 기획부, 영업부, 총무부, 개발부의 각각 평균 급여?
select
    round(avg(decode(buseo,'기획부',basicpay)),1) as "기획부 평균 급여",
    round(avg(decode(buseo,'영업부',basicpay)),1) as "영업부 평균 급여",
    round(avg(decode(buseo,'총무부',basicpay)),1) as "총무부 평균 급여",
    round(avg(decode(buseo,'개발부',basicpay)),1) as "개발부 평균 급여"
from tblInsa;


-- 4. tblInsa. 남자 직원 가장 나이가 많은 사람이 몇년도 태생? 여자 직원 가장 나이가 어린 사람이 몇년도 태생? **
select 
    case
        when ssn like '%-1%' then '남자'
    end as 나이많은남자
from tblInsa;
