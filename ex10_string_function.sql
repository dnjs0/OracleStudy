-- ex10_string_function.sql

/*
    
    문자열 함수
    
    대소문자 변환
    - upper(), lower(), initcap()
    - varchar2 upper(컬럼명)
    - varchar2 lower(컬럼명)
    - varchar2 initcap(컬럼명)
    
*/

select 
    'javaTEST',
    upper('javaTEST'), --JAVATEST
    lower('javaTEST'), --javatest
    initcap('javaTEST') --Javatest
from dual;


--employess 이름에 'de'가 포함된 직원들
select first_name , last_name
from employees
where first_name like '%de%'
    or first_name like '%DE%'
    or first_name like '%dE%'
    or first_name like '%De%';

select first_name from employees
where upper(first_name) like '%DE%';


/*

    문자열 추출
    - substr()
    - varchar2 substr(컬럼명, 시작 위치, 가져올 문자 갬수)
    - varchar2 substr(컬럼명, 시작위치)
    

*/

select
    name, 
    substr(name,1,3),
    substr(name, 3)
from tblcountry;

select
    name, ssn,
    '19' || substr(ssn,1, 2) as 생년,
    substr(ssn,3,2) as 생월,
    substr(ssn,5,2) as 생일,
    substr(ssn,8,1) as 성별
from tblinsa;


-- iblinsa > 김이박정최 > 각각 일정?
select * from tblinsa where name like '김%';

select * from tblinsa where substr(name,1,1)='김';

select count(*) from tblinsa where substr(name,1,1)='김'; --12
select count(*) from tblinsa where substr(name,1,1)='이'; --14
select count(*) from tblinsa where substr(name,1,1)='박'; --2
select count(*) from tblinsa where substr(name,1,1)='최'; --1
select count(*) from tblinsa where substr(name,1,1)='정'; --5

select
    count(case
        when substr(name,1,1)='김' then 1
    end) as 김씨,
    count(case
        when substr(name,1,1)='이' then 1
    end) as 이씨,
    count(case
        when substr(name,1,1)='박' then 1
    end) as 박씨,
    count(case
        when substr(name,1,1)='최' then 1
    end) as 최씨,
    count(case
        when substr(name,1,1)='정' then 1
    end) as 정씨
from tblinsa;
    
    
/*
    
    문자열 길이 함수
    - length()
    - number length(컬럼명)
    
    
*/
    
-- 함수 > 대부분의 절엠서 사용가능

-- SELECT 절
select name, length(name)
from tblcountry;           
    
-- 조건절에서 사용
select name, length(name)
from tblcountry           
where length(name)>3;

-- 정렬에서 사용
select name, length(name) 
from tblcountry
order by length(name) desc;
    
select name, length(name) 
from tblcountry
order by 2 desc;
    
select name, length(name) as ln
from tblcountry
order by ln desc;
    
-- tblinsa 남자 출력 후 여자출력
select name, ssn
from tblinsa
order by substr(ssn,8,1) asc;
    
/*
     문자열 검색
    -instr()
    - 검색어의 위치를 반환한다.
    - number instr(컬럼명, 검색어)
    - number instr(컬럼명, 검색어, 시작위치)
    - number instr(컬럼명, 검색어, 시작위치, -1) --반대로 검색해
    - 못찾으면 0을 반환
     
*/
    
select
    '안녕하세요, 홍길동님',
    instr('안녕하세요. 홍길동님' ,'홍길동'),
    instr('안녕하세요. 홍길동님' ,'아무개'),
    instr('안녕하세요. 홍길동님. 홍길동' ,'홍길동'),
    instr('안녕하세요. 홍길동님 홍길동' ,'홍길동',-1)
from dual;
    
    
    
/*

    페딩
    - lpad(), rpad()
    - left padding, right padding
    - 공간을 확보하려고 할때 쓴다.
    - varchar2 lpad(컬럼명, 개수, 문자)
    - varchar2 rpad(컬럼명, 개수, 문자)
    
    
*/    
    
select
    lpad('A',5) --왼족 여백 획득
from dual;

select
    lpad('A',5,'B'),
    lpad('A',5,'BC'),
    lpad('AA',5,'B'),
    lpad('A',5,'BCD'),
    lpad('AAA',5,'B'), 
    lpad('1',3,0)
from dual;

/*
    
    공백제거
    - trim(), ltrim(), rtrim()
    - varchar2 trim(컬럼명)
    - varchar2 ltrim(컬럼명)
    - varchar2 rtrim(컬럼명)
    
*/
    
select
    '    하나  둘  셋   ',
    trim('    하나  둘  셋   '),
    ltrim('    하나  둘  셋   '),
    rtrim('    하나  둘  셋   ')
from dual;
    
/*
    문자열 치환
    - replace()
    - varchar2 replace(컬럼명, 찾을 문자열, 바꿀 문자열)
    - varchar2 regex_replace(컬럼명, 찾을 문자열, 바꿀 문자열)
    
*/
    
    
select
    replace('홍길동', '홍',' 김'),
    replace('홍길동', '이',' 김'),
    replace('홍홍홍', '홍',' 김')
from dual;
    
   
/*
    split() > 없음 > 배열이 없기 때문이다.
*/ 

/*
    문자열 치환
    - decode()
    - replace()와 거의 유사 > replace를 반복하는 함수
    - varchar2 decode(컬럼명, 찾을 문자열, 바꿀 문자열)
    - varchar2 decode(컬럼명, 찾을 문자열, 바꿀 문자열, [찾을 문자열, 바꿀 문자열]x N)
    
*/
    
-- tblComedian 성별 > f,m 말고 남자, 여자
select
    last||first as name,
    gender,
    case
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as g1,
    replace(gender, 'm', '남자') as g2,
    decode(gender, 'm', '남자', 'f','여자') as g3
from tblcomedian;
    
-- tblcomedian 남자 몇명 여자 몇명
select
    count(decode(gender,'m',1)) as men,
    count(decode(gender,'f',1)) as women
from tblcomedian;
    
    
    
    
    
    
    
    
    