-- ex24_pseudo.sql

/*
    
    의사 컬럼, Peseudo Column
    - 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체
    - 오라클 전용
    
    rownum
    - 행번호
    - 테이블의 행번호를 가져오는 객체
    - 시퀀스 객체와 연관X
    
    
    rownum이 생성되는 시점(*****)
    1. from절이 호출될 때 rownum이 만들어진다.
    2. where전에 의해서 결과셋이 변화가 발생할 때 rownum이 다시 만들어진다.
    
*/

select
    name, buseo,    -- 컬럼(속성) > 객체(레코드)마다 다른 값을 가진다.(개인 데이터)
    100,            -- 상수 > 객체가 모두 동일한 값을 가진다.
    basicpay *2,    -- 연산 > 결국은 객체의 값을 가지고 연산 > 컬럼값
    length(name),   -- 함수 > 경국은 객체의 값을 가지고 연산 > 컬럼값
    rownum          -- 의사 컬럼
from tblInsa;


-- 게시판 > 페이징
-- 1페이지 > where rownum between 1 and 20
-- 2페이지 > where rownum between 21 and 40
-- 3페이지 > where rownum between 41 and 60

-- 성적 > 장학금
-- where rand between 1 and 3


select name, buseo, rownum from tblInsa;
select name, buseo, rownum from tblInsa where rownum=1;
select name, buseo, rownum from tblInsa where rownum<=5;

-- 답이 안나옴..
select name, buseo, rownum from tblInsa where rownum=5;
select name, buseo, rownum from tblInsa where rownum between 21 and 40;

-- 1에서부터 출력하면 나옴
select name, buseo, rownum from tblInsa where rownum between 1 and 40;


-- 원하는 rownum 부분을 추출하는 방법(*********) > 서브쿼리
-- 위의 SQL에서 5~10까지 추출

-- from에서 이름을 바꾸면 select에도 이름을 바꿔야한다.
select 이름,buseo, rownum from (select name as 이름, buseo,rownum from tblInsa);


-- rownum은 서브쿼리 안과 밖에 생성은 다름
-- from이 두개이므로 rownum이 두개 생성됨
select 이름,buseo, rownum as rnum2, rnum1
    from (select name as 이름, buseo,rownum as rnum1 from tblInsa)
        where rnum1 = 5;

-- 급여 많이 받는 순  top 5을 가져오세요
select name, basicpay, rnum1 
    from(select name, basicpay, rownum as rnum1 from tblInsa order by basicpay desc)
        where rownum <=5;

-- 급여 많이 받는 순  top 6~10을 가져오세요
select name, basicpay, rnum1,rnum2, rownum from --3. 2번에서 만든 rownum을 조건으로 사용하기 위해서 
    (select name, basicpay, rnum1 ,rownum as rnum2 --2. 원하는 순서대로 만든 결과셋에 rownum붙이기 위해서
    from(select name, basicpay, rownum as rnum1 from tblInsa order by basicpay desc))--1. 원하는 순서 만들기
        where rnum2 =10;

-- tblCountry인 인구수가 3위인 나라?
-- 1. 원하는 순서대로 정렬
select * from tblCountry where population is not null order by population desc;

-- 2. 1을 서브쿼리 생성 + rownum생성
select name, population,rownum as rnum
    from (select * from tblCountry where population is not null order by population desc);

-- 3. 2을 서브쿼리생성
select * 
    from(select name, population,rownum as rnum
        from (select name, population from tblCountry where population is not null order by population desc))
            where rnum=3;

-- tblComdeian 키가 큰 순서 3-5등
-- 1. 정렬
select * from tblComedian order by height desc;

-- 2. 1을 서브쿼리 + rownum 붙이기
select a.*, rownum as rnum from
    (select * from tblComedian order by height desc) a;
    
select a.*, rownum as rnum from
    (select * from tblComedian order by height desc) a where rownum =3;

--3. 2를 서브쿼리 + rnum 조선
select * from
    (select a.*, rownum as rnum from
        (select * from tblComedian order by height desc) a )
            where rnum =3;

create or replace view vwComedian
as
select * from
    (select a.*, rownum as rnum from
        (select * from tblComedian order by height desc) a );

select * from vwComedian where rnum between 3 and 5;





---tblInsa 부서 인원(group by)이 가장 많은(rownum =1) 부서?
-- 1. 정렬
select buseo, count(*) as cnt from tblInsa group by buseo order by cnt desc;

--2. 
select buseo, cnt, rownum as rnum from
    (select buseo, count(*) as cnt from tblInsa group by buseo order by cnt desc);

--3. 
select * from
    (select buseo, cnt, rownum as rnum from
        (select buseo, count(*) as cnt from tblInsa group by buseo order by cnt desc))
        where rnum between 3 and 5;


--11g 지원 안함 > 12c이후 버전만 지원하는 구문
select * from tblInsa
    order by basicpay desc
        offset 5 rows fetch next 5 rows only;



















