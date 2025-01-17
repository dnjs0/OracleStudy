-- ex09_numberic_function.sql

/*
    
    수학 함수
    
    
    round()
    - 반올림 함수
    - number round(컬럼명)
    - number round(컬럼명, 소수이하 자릿수) : 원하는 자릿수 실수 반환
    
    
*/

select avg(basicpay) from tblInsa;
select round(avg(basicpay)) from tblInsa;
select round(avg(basicpay), 1) from tblInsa; --소수이하 첫째짜리
select round(avg(basicpay), 2) from tblInsa;
select round(avg(basicpay), 0) from tblInsa; -- 정수 반환

select round(3.14) from tblinsa;
select round(3.14) from tblInsa where name = '홍길동'; 
select round(3.14) from dual; -- 시스템 테이블
select * from dual;


/*
    
    
    floor(), trunc()
    - 절삭 함수
    - 무조건 내림 함구
    - number floor(컬럼명) : 정수 반환
    - number trunc(컬럼명) : 정수 반환
    - number trunc(컬럼명, 소수이하 자릿수) : 실수 반환

    
*/

select
    3.6789,
    round(3.6789),
    floor(3.6789),
    trunc(3.6789,2)
from dual;



/*
    
    ceil()
    - 무조건 올림 함수
    - number ceil(컬럼명)

*/

select
    3.14,
    round(3.14),
    ceil(3.14)
from dual;

select
    round(3.14),
    floor(3.14),
    ceil(3.14),
    round(3.64),
    floor(3.64),
    ceil(3.64)
from dual;


/*
    
    mod()
    - 나머지 함수
    - num mod(피제수, 제수)
    
    
    
    
*/


select
    10/3,
    floor(10/3) as 몫 ,
    mod(10,3) as 나머지
from dual;

select 
    abs(10), abs(-10),-- 절댓값 구하는 함수
    power(2,2), power(2,3), power(2,4),--제곱
    sqrt(4), sqrt(9) --루트
from dual;



