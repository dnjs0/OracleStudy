-- ex04_operator.sql

/*
    
    연산자, Operator
    
    1. 산술 연산자
    - +, -, *, /
    - %(없음) > 함수로 제공(mod())
    
    2. 문자열 연산자(concat)
    - 문자열 + 문자열 > 자바
    - 문자열 || 문자열 > SQL
    
    3. 비교 연산자
    - >, >=, <, <=
    - =(==, 같다), <>(!=, 같지 않다)
    - 논리 값을 반환하지만, boolean값이 존재하지 않기 때문에 명시적 표현이 불가능하다.
        조건에서만 사용이 가능하다.
    - 컬럼리스트에서는 사용 불가
    - 조건절에서 사용
    
    4. 논리연산자
    - add(&&), or(||), not(!)
    - 컬럼리스트에서는 사용 불가
    - 조건절에서 사용
    
    5. 대입 연산자
    - =
    - 컬럼 = 값
    - update문에서 사용
    - 복합 대입 연산자 없음(+=,-=)
    
    6. 삼항 연산자
    - 없음
    - 제어문 없음
    
    7. 증감 연산자
    - 없음
    
    8. sql 연산자
    - 자바 > 객체 instanceof 타입
    - 오라클 > in, between, like, is 등 ..
    
    
    
    select
        salary

*/

-- +기호는 오직 숫자 연산할때만!!
select first_name, last_name, first_name+ last_name
from employees;

-- || 가 더하기 기호
select first_name, last_name, first_name || last_name
from employees;