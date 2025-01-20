-- ex25_rank.sql

/*
    
    오라클 순위 조작
    - rownum > 순위 함수 > rows fetch
    
    순위 함수
    - rownum 기반으로 만든 함수
    - order by(순위를 매기기 위한 정렬 기준) + partition by(그룹별 순위)
    
    1. rank() over(order by 컬럼명 [esc|desc])
    
    2. dense_rank() over(order by 컬럼명 [esc|desc])
    
    3. row_number() over(order by 컬럼명 [esc|desc])
    
    
*/

-- tblInsa 급여순으로 가져오시오. + 순위 표시
-- 수치가 같으면 임의로 정렬
select name, buseo, basicpay, rownum from
    (select name, buseo, basicpay, rownum from tblInsa order by basicpay desc);


-- rank()
-- 수치가 같으면 같은 숫자로 표시
-- 7 7 이면 다음숫자는 9
select 
    name,buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;


-- dense_rank()
-- 수치가 같으면 같은 숫자로 표시
-- 7 7 이면 다음숫자는 8
select 
    name,buseo, basicpay,
    dense_rank() over(order by basicpay desc) as rnum
from tblInsa;


-- row_number
-- subquery로 만든것과 결과 같음 
select 
    name,buseo, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa;

-- 급여 1위 가져오기
select * from
    (select 
        name,buseo, basicpay,
        row_number() over(order by basicpay desc) as rnum
    from tblInsa)
        where rnum=5;


-- partition by
-- 그룹별 순위 매길때 사용
select
    name, buseo,jikwi, basicpay,
    rank() over(partition by jikwi order by basicpay desc) as rnum
from tblInsa;


-- 그룹별 1등
select * from
    (select
        name, buseo,jikwi, basicpay,
        rank() over(partition by jikwi order by basicpay desc) as rnum
    from tblInsa)
        where rnum=1;






