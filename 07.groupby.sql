-- tblHousekeeping 테이블 문제

-- 1. 각 날짜별로 구매한 물품의 총 개수와 총 금액을 구하시오.
select buydate, count(qty), sum(price)
from tblhousekeeping
group by buydate;


-- 2. 가격대별로 구매한 물품의 수를 구하시오. (가격대는 1000원 단위로 나누어 주세요)
select price, count(*)
from tblhousekeeping
group by price;

select floor(price/1000)*1000, count(*)
from tblhousekeeping
group by floor(price/1000)*1000
order by floor(price/1000)*1000;


-- 3. 각 물품별로 총 구매 금액을 구하고, 구매 금액이 높은 순으로 정렬하시오.
select item, sum(price)
from tblhousekeeping
group by item
order by sum(price) desc;

-- 4. 각 주차별로 구매한 물품의 총 개수와 총 금액을 구하시오. (주는 일요일부터 시작합니다)*****
select * 
from tblhousekeeping;

-- 5. 구매 수량이 10개 이상인 물품들의 평균 가격을 구하시오.*****
select item,qty, price
from tblhousekeeping
where qty>= 10;

select avg(price)
from tblhousekeeping
where qty>= 10;


-- 6. 각 물품별로 구매 횟수를 구하고, 구매 횟수가 1회 초과인 물품만 출력하시오.*****
select item, count(*) 
from tblhousekeeping
group by item
having count(*) >1 ;

-- 7. 구매 날짜별로 가장 비싼 물품의 가격을 구하시오.
select buydate, max(price) 
from tblhousekeeping
group by buydate;

-- 8. 각 물품 종류별로 총 구매 금액을 구하고, 10만원 이상 구매한 물품 종류만 출력하시오.*****
select item, sum(price*qty)
from tblhousekeeping
group by item
having sum(price*qty) >=100000;

-- 9. 요일별로 평균 구매 금액을 구하고, 평균 금액이 높은 순으로 정렬하시오.*****
select * from tblhousekeeping;

-- 10. 월별로 구매한 물품의 총 개수와 총 금액을 구하시오.*****
select * from tblhousekeeping;

-- tblInsa 테이블 문제

-- 1. 각 부서별로 직원 수와 평균 급여(기본급+수당)를 구하시오.
select buseo, count(num) as 직원수, round(avg(basicpay + sudang),1) as 평균급여
from tblInsa
group by buseo;

-- 2. 직위별로 직원 수와 최고 급여, 최저 급여를 구하시오.
select jikwi, count(num), max(basicpay), min(basicpay)
from tblInsa
group by jikwi;

-- 3. 입사년도별로 직원 수를 구하고, 가장 많은 직원이 입사한 연도 3개를 구하시오.*****
select ibsadate, count(*)
from tblInsa
group by ibsadate;

-- 4. 각 도시별로 직원 수와 평균 급여를 구하고, 직원 수가 5명 이상인 도시만 출력하시오.
select city, round(avg(basicpay),1),count(*)
from tblInsa
group by city
having count(*)>=5;

-- 5. 부서별, 직위별로 평균 급여를 구하고, 부서와 직위 순으로 정렬하시오.
select buseo,jikwi, round(avg(basicpay+sudang),1)
from tblInsa
group by buseo,jikwi
order by buseo,jikwi;

-- 6. 나이대별(20대, 30대, 40대 등)로 직원 수와 평균 급여를 구하시오.******
select cast(substr(ssn,1,2) as int)
from tblInsa;

-- 7. 입사월별로 직원 수와 평균 급여를 구하고, 평균 급여가 높은 순으로 정렬하시오.
select * 
from tblInsa;

-- 8. 부서별로 가장 높은 급여를 구하시오.

-- 9. 직위별로 총 급여 합계를 구하고, 총 급여가 5000만원 이상인 직위만 출력하시오.

-- 10. 입사년도별, 부서별로 직원 수를 구하고, 직원 수가 5명 이상인 그룹만 출력하시오.

-- tblMen, tblWomen 테이블 문제

-- 1. 남녀별로 평균 나이와 평균 키를 구하시오.

-- 2. 커플 상태(연인 있음, 없음)별로 남녀 수를 구하시오.

-- 3. 남녀별로 키 구간(160cm 미만, 160-170cm, 170-180cm, 180cm 이상)에 속하는 사람 수를 구하시오.

-- 5. 남녀별로 가장 높은 체중을 구하시오.
SELECT '남자' AS gender, MAX(weight) AS max_weight
FROM tblMen
WHERE weight IS NOT NULL;

SELECT '여자' AS gender, MAX(weight) AS max_weight
FROM tblWomen
WHERE weight IS NOT NULL;

-- 6. 키 구간별(10cm 단위)로 남녀 수를 구하고, 남녀 수가 많은 순으로 정렬하시오.

-- 7. 남녀별로 나이대(20대, 30대 등)에 따른 평균 키를 구하시오.

-- 9. 남녀별로 체중이 가장 적게 나가는 사람과 가장 많이 나가는 사람의 몸무게 차이를 구하시오.

-- 10. 남녀 모두에서 가장 긴 이름의 글자 수를 구하시오.

-- tblTodo 테이블 문제

-- 1. 각 날짜별로 등록된 할 일의 수와 완료된 할 일의 수를 구하시오.

-- 2. 요일별로 할 일 등록 수를 구하고, 가장 많이 등록된 요일부터 정렬하시오.

-- 3. 각 주차별로 완료된 할 일의 수와 완료되지 않은 할 일의 수를 구하시오.

-- 4. 완료 여부에 따라 평균 소요 시간(완료시간 - 등록시간)을 구하시오.

-- 5. 각 달별로 등록된 할 일의 수와 완료율(완료된 할 일 / 전체 할 일)을 구하시오.

-- 6. 등록 시간대별(0-6시, 6-12시, 12-18시, 18-24시)로 할 일의 수를 구하시오.

-- 7. 완료된 일 중에서, 소요 시간이 가장 긴 일의 소요 시간을 구하시오.

-- 8. 등록 후 완료까지 걸린 기간별(당일, 1일, 2일 이상)로 할 일의 수를 구하시오.

-- 9. 각 날짜별로 가장 늦게 완료된 시간을 구하시오.

-- 10. 완료 여부에 따라 제목의 평균 글자 수를 구하시오.
