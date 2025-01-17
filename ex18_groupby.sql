-- ex18_groupby.sql
/*
    [WITH <Sub Query>]
    SELECT column_list  --4
      FROM table_name  --1
    [WHERE search_condition]  --2
    [GROUP BY group_by_expression]  --3
   [HAVING search_condition]  
    [ORDER BY order_expression [ASC|DESC]]; --5

    SELECT column_list > 5.컬럼 지정(보고 싶은 컬럼만 가져오기) > Projection
      FROM table_name > 1.테이블 지정
    WHERE search_condition > 2.레코드마다 질문, 조건 지정(보고 싶은 행만 가져오기) > Selection
    GROUP BY group_by_expression > 3. 그룹을 나눈다.
   HAVING search_condition > 4. 그룹에 대한 조건
    ORDER BY order_expression [ASC|DESC] > 6. 결과셋의 레코드 순서를 정한다.

    각 절의 순서(*****)
    1. FROM
    2. WHERE
    3. GROUP BY
    4. HAVING
    5. SELECT
    6. ORDER BY
    
    group by절
    - 특정 기준으로 레코드들을 그룹을 나눈다.(수단)
      > 각각의 그룹을 대상으로 집계 함수를 실행한다.(목적)
      
    having절
    - 그룹에 대한 조건
    - having을 만족하는 그룹만 남는다. 불만족하면 버린다.
    
    비교
    - from 테이블 where 조건 > 개인(객체, 레코드, 튜플, 행)에 대한 조건
    - group by 그룹 having 조건 > 그룹(7개) > 그룹에 대한 조건
    
      
*/

-- tblinsa . 부서별 평균 급여?
select * from tblinsa;

select round(avg(basicpay)) from tblinsa;  --155만원, 전체직원

select distinct buseo from tblinsa; --7개 부서

select round(avg(basicpay))  from tblinsa where buseo = '기획부'; --185
select round(avg(basicpay))  from tblinsa where buseo = '총무부'; --171
select round(avg(basicpay))  from tblinsa where buseo = '개발부'; --138
select round(avg(basicpay))  from tblinsa where buseo = '영업부'; --160
select round(avg(basicpay))  from tblinsa where buseo = '홍보부'; --145
select round(avg(basicpay))  from tblinsa where buseo = '인사부'; --153
select round(avg(basicpay))  from tblinsa where buseo = '자재부'; --141

-- group by 사용하면 > select절에는 반드시 집계함수만 사용이 가능하다.
select buseo
     , round(avg(basicpay)) as "부서별 평균 급여"
     , count(*) as "부서별 인원 수"
     , sum(basicpay) as "부서별 총지급액"
     , max(basicpay) as "부서별 최고 급여"
     , min(basicpay) as "부서별 최저 급여"
  from tblinsa 
 group by buseo;
 
-- tblcomedian. 남자수? 여자수?
select 
       count(decode(gender, 'm', 1) ) as 남자수
     , count(decode(gender, 'f', 1) ) as 여자수
  from tblcomedian;
  
select gender, count(*)
  from tblcomedian
 group by gender;
 
select 
       jikwi, count(*)
  from tblinsa
 group by jikwi;
 
select 
       city, count(*)
  from tblinsa
 group by city; 
 
select 
       buseo, count(*)
  from tblinsa
 group by buseo
 order by count(*) desc;
 
-- 다중 그룹
select buseo
     , jikwi
     , city
     , count(*)
  from tblinsa
 group by buseo, jikwi, city
;

-- 급여별 그룹
-- 100만원 이하
-- 100만원~200만원
-- 200만원 이상
select basicpay
     , count(*)
  from tblinsa
 group by basicpay;
 
select 1
     , (floor(basicpay / 1000000) + 1) * 100 || '만원 이하' as money
     , count(*)
  from tblinsa
 group by floor(basicpay / 1000000);

--tblinsa. 남자수? 여자수?
select substr(ssn, 8,1)
     , count(*)
  from tblinsa
 group by substr(ssn, 8,1);



-- tbltodo. 한일? 안한일?
select 
       case 
         when completedate is not null then '한일'
         when completedate is null then '안한일'
        end
     , count(*)
  from tbltodo
 group by case 
         when completedate is not null then '한일'
         when completedate is null then '안한일'
        end
  ;
  
-- tblinsa, 직위별 인원수
select jikwi
     , count(*)
  from tblinsa
 group by jikwi;
 
-- tblinsa, 직위별 > 과장+부장? 사원+대리 인원수
select decode(jikwi, '과장', 1, '부장', 1, '사원', 2, '대리', 2)
     , count(*)
  from tblinsa
 group by decode(jikwi, '과장', 1, '부장', 1, '사원', 2, '대리', 2);
 
 
-- 개인 급여가 150만원 이상인 직원 수? > 개인에 대한 조건(where절)
select count(*)
  from tblinsa
 where basicpay >= 1500000; --27
 
select buseo
     , count(*)
--     , round(avg(basicpay))
  from tblinsa
 group by buseo
   having avg(basicpay) >= 1500000;
   
select buseo
     , count(*)
     , round(avg(basicpay))
  from tblinsa
 where basicpay >= 1500000
 group by buseo
   having avg(basicpay) >= 1500000;

-- 부서별(group by) 과장수+부장수?(where) 3명 이상 부서?
select buseo
     , count(*)
  from tblinsa
 where jikwi in('과장', '부장')
 group by buseo
   having count(*) >= 3;




--rollup

select buseo
     , count(*)
     , sum(basicpay)
     , round(avg(basicpay))
     , max(basicpay)
     , min(basicpay)
  from tblinsa
 group by rollup(buseo);
 
 
select buseo, jikwi, city
     , count(*)
     , sum(basicpay)
     , round(avg(basicpay))
     , max(basicpay)
     , min(basicpay)
  from tblinsa
 group by rollup(jikwi, buseo, city);
 
/*
    cube()
    - group by의 집계 결과를 좀 더 자세하게 반환
*/
select buseo
     , count(*)
     , sum(basicpay)
     , round(avg(basicpay))
     , max(basicpay)
     , min(basicpay)
  from tblinsa
 group by cube(buseo);

select buseo, jikwi, city
     , count(*)
     , sum(basicpay)
     , round(avg(basicpay))
     , max(basicpay)
     , min(basicpay)
  from tblinsa
 group by cube(buseo, jikwi, city);
