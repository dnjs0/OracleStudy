-- ex11_casting_function.sql

/*

    형변환 함수
    
    1. varchar2 to_char(숫자형): 숫자 > 문자열: 간혹 사용
    2. varchar2 to_char(날짜형): 날짜 > 문자열: 자주 사용  
    3. number to_number(문자형): 문자열 > 숫자 : 사용 안함
    4. date   to_date(문자형)  : 문자열 > 날짜 : 자주 사용
    
    
    1. varchar2 to_char(숫자형 [,형식 문자열]): 숫자 > 문자열
    
    형식 문자열 구성요소
    a. 9: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 공백으로 치환 > %5d
    b. 0: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 '0'으로 치환  > %05d
    c. $: 통화 기호
    d. L: 통화 기호(Locale) \
    e. .: 소수점
    f. ,: 첫단위 표기

*/

select
    100,
    '100',
    to_char(100),
    '@' || to_char(100, '99999') || '@', --@   100@
    '@' || to_char(100, '00000') || '@', --@ 00100@
    to_char(100, '$999'), -- $100
    --to_char(100, '999달러')
    '$' || ltrim(to_char(100, '999')), --$ 100 > $100
    to_char(100, 'L999') --        ￦100
from dual;


select
    3.14,
    to_char(3.14),
    to_char(3.14, '9.99'),
    to_char(3.14, '9.9'),
    1000000,
    to_char(1000000),
    to_char(1000000, '9,999,999')
from dual;


/*

    2. varchar2 to_char(날짜형, 형식문자열): 날짜 > 문자열
    
    형식문자열
    a. yyyy    b. yy
    c. month   d. mon
    e. mm      f. day
    g. dy      h. ddd
    i. dd      j. d
    k. hh      l. hh24
    m. mi      n. ss
    o. am(pm)
    
*/
select sysdate, to_char(sysdate) from dual;

select to_char(sysdate, 'yyyy') from dual;  --2025 > 년(4자리)
select to_char(sysdate, 'yy') from dual;    --25 > 년(2자리)
select to_char(sysdate, 'month') from dual; --1월 > 월(풀네임)
select to_char(sysdate, 'mon') from dual;   --1월 > 월(약어)
select to_char(sysdate, 'mm') from dual;    --01 > 월(2자리)
select to_char(sysdate, 'day') from dual;   --수요일 > 요일(풀네임)
select to_char(sysdate, 'dy') from dual;    --수 > 요일(약어)
select to_char(sysdate, 'ddd') from dual;   --015 > 일(올해의 며칠)
select to_char(sysdate, 'dd') from dual;    --15 > 일(이번달의 며칠)
select to_char(sysdate, 'd') from dual;     --4 > 일(이번주의 며칠, 요일)
select to_char(sysdate, 'hh') from dual;    --11 > 시(12H)
select to_char(sysdate, 'hh24') from dual;  --11 > 시(24H)
select to_char(sysdate, 'mi') from dual;    --30 > 분
select to_char(sysdate, 'ss') from dual;    --54 > 초
select to_char(sysdate, 'am') from dual;    --오전 > 오전/오후
select to_char(sysdate, 'pm') from dual;    --오전 > 오전/오후


select
    sysdate, --25/01/15
    to_char(sysdate, 'yyyy-mm-dd'), --2025-01-15
    to_char(sysdate, 'hh24:mi:ss'),  --11:33:40
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), --2025-01-15 11:33:58
    to_char(sysdate, 'am hh:mi:ss day') --오전 11:35:01 수요일
from dual;


-- 평일 입사 or 휴일 입사
select 
    name, to_char(ibsadate, 'yyyy-mm-dd day') as ibsadate,
    case
        --when to_char(ibsadate, 'day') in ('일요일', '토요일') then '휴일 입사'
        when to_char(ibsadate, 'd') in ('1', '7') then '휴일 입사'
    end
from tblInsa;


/*
    Java : 엄격한 문법, String type
    SQL : 약한 문법, Weak type

    3. number to_number(문자형) : 문자열 > 숫자
    
    
*/

select 
    '100',
    to_number('100'),
    100*2,
    '100'*2
from dual;


/*
    
    4. date to_date(문자형) : 문자열 > 날짜
    
*/

select * from tblinsa where ibsadate >= '2010-01-01'; --날짜 리터럴

--2010년에 입사한 모든 직원
-- 2010-01-01 ~ 2010-12-31
select * from tblinsa where ibsadate between '2010-01-01' and '2010-12-31';

select 
    sysdate, 
    ibsadate,
    '2010-01-01', 
    to_date('2010-01-01'),
    to_char(to_date('2010-01-01'), 'yyyy-mm-dd hh24:mi:ss')
from tblinsa;


select * from tblinsa 
    where ibsadate between '2010-01-01' and '2010-12-31';

select * from tblinsa 
    where ibsadate between to_date('2010-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date('2010-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss');

select * from tblinsa 
    where ibsadate between to_date('20100101 00:00:00','yyyymmdd hh24:mi:ss') and to_date('20101231 23:59:59','yyyymmdd hh24:mi:ss');


select * from tblinsa where to_char(ibsadate, 'yyyy')='2010';

-- to_char(숫자)
-- to_char(날짜) ******
-- to_number(문자)
-- to_date(문자) ***












