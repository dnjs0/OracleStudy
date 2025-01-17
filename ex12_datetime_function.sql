-- ex12_datetime_function.sql

/*
    1. 날짜시간 관련 함수
    2. 날짜시간 연산 함수

    sysdate
    - 현재 오라클의 시스템 시각 변환
    - date sysdate
    - Calendar.getInstance()


*/

select sysdate from dual;


/*
    날짜 연산
    1. 시각 - 시각 = 시간 tick-tick
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 시각

*/

-- 1. 시각-시각 = 시간
-- tblInsa. 현재 - 입사일 = 근무기간
select 
    name,
    to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    round(sysdate - ibsadate) as 근무일수,
    round((sysdate - ibsadate)*24) as 근무시수,
    round(((sysdate - ibsadate)*24)*60) as 근무분수,
    round((((sysdate - ibsadate)*24)*60)*60) as 근무초수,
    round((sysdate - ibsadate)/30.4) as 근무개월수, --부정확
    round(((sysdate - ibsadate)/30.4),365) as 근무년수 --부정확
from tblInsa;

-- 맘먹고 실핼하기까지 얼마나 걸렸는디?
-- Oracle 12c 이전 : 식별자(테이블명, 컬럼명, 별칭)은 최대 30바이트까지
select
    title,
    adddate,
    completedate,
    round((completedate-adddate)*24) as "실행하기까지 걸린시간"
from tblTodo;


/*
    2. 시각 + 시간(일) = 시각 > now.add(+)
*/
select
    sysdate,
    sysdate +1,
    sysdate +100,
    sysdate - 7,
    to_char(sysdate + (3/24), 'hh24:mi:ss'), --3시간 뒤
    to_char(sysdate + (30/60/24), 'hh24:mi:ss') --30분 뒤
from dual;

/*
    1. 일, 시, 분, 초 > 연산
    a. 시각 - 시각 = 시간(일)
    b. 시각 + 시간(일) = 시각
    c. 시각 - 시간(일) = 시각
    
    2. 월, 일 > 연산
    a. months_between()
        시각 - 시각 = 시간(월)
    b. add_months
         시각 + 시간(월) = 시각
         시각 - 시간(월) = 시각
*/

select 
    name,
    round(sysdate - ibsadate) as 근무일수,
    round((sysdate - ibsadate)/30.4) as 근무월수,
    round(months_between(sysdate, ibsadate)) as 근무월수,
    round((months_between(sysdate, ibsadate)) / 12) as 근무년수
from tblInsa;

select
    sysdate, --오늘
    sysdate +1, --내일
    sysdate + 30.4, --한달 후?
    add_months(sysdate,1), --한달 후
    add_months(sysdate,-1), --한달전
    add_months(sysdate, 3*12) --3년 후
from dual;

-- 마지막 날짜
-- date last_day(날짜)
-- 인자값이 포함된 년/월의 마지막 날짜 반환

-- 25년 1월의 마지막 날?
select 
    last_day(sysdate)
from dual;

select
    last_day(add_months(sysdate,1))
from dual;























































































