-- ex30_pl/sql

/*

    PL/SQL
    - Procedural Language for SQL
    - Procedural Language extension to SQL
    - 표준 SQL + 절차지향 언어의 기능을 추가(변수, 제어 흐름, 객체 정의 등)
    
    프로시저, Procedure
    - 메서드, 함수 등
    - 순서가 있는 명령어의 집합
    - 모든 PL/SQL 구문은 프로시저내에서만 작성/동작이 가능하다.
    - 작업(코드) 영역 = 표준  SQL영역 + 프로시저 영역
    
    1. 익명 프로시저
        - 1회용 코드 작성
    
    2. 저장(실명) 프로시저
        - 저장 & 재사용
        - 데이터베이스 객체(create, drop)
        
    PL/SQL 프로시저 구조
    - 4개의 블럭(파트)로 구성
        a. DECLARE
        b. BEGIN
        c. EXCEPTION
        d. END
        
    1. DECLARE
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 목적
        - 생략 가능
        
    2. BEGIN ~ 4. END
        - 구현부
        - 구현된 코드를 가지는 영역(= 메서드의 body 영역)
        - 생략 불가능
        - 구현된 코드? > 표준 SQL(DDL, DML, DCL) + PL/SQL(연산, 제어 등)
        
    3. EXCEPTION
        - 예외 처리용
        - 자바의 catch절
        - 평소에는 실행(X) > 에러가 발생했을 때(O)
        - 생략 가능
        
        
    익명 프로시저 구문
    
    [DECLARE
        변수 선언;
        객체 선언;]
    BEGIN
        업무 코드(제어문);
        업무 코드(표준 SQL);
    [EXCEPTION
        예외처리 코드;]
    END;
    
    
    PL/SQL 자료형, 연산자
    - 표준 SQL과 동일
    
    변수 선언하기
    - 변수명 자료형(길이) [NOT NULL] [DEFAULT 값];
    
    
    
    

*/

-- 지금 이 영역이 표준 SQL 영역
select * from tabs;


-- dbms_output.put_line() 함수는 평상시에는 결과가 눈에 안보임
-- 영구 설정이 없다. 로그인 할때마다 실행해야한다.
set serveroutput on; -- 켜야함
set serverout on; 
set serveroutput off; -- 끄는것도 잇음





begin
    -- PL/SQL 영역
    dbms_output.put_line('Hello~'); --자바의 System.out.println();
end;
/

-- 안됨, developer는 블럭잡고 실행해야한다.
-- 마지막에 슬래시 붙여야 가능
begin
    dbms_output.put_line('Hi!!'); 
end;
/



-- 변수 선언하기
declare
    num number;
    name varchar2(30);
    today date;
begin
    num := 10; -- := 이것이 대입 연산자 num은 10이다.
    dbms_output.put_line(num);
    

    name := '홍길동';
    dbms_output.put_line(name);
    
    
    today :=sysdate;
    today := to_date('2025-01-01','yyyy-mm-dd');
    dbms_output.put_line(today);
    
end;
/




declare
    num1 number;
    num2 number;
    num3 number :=20;
begin
    dbms_output.put_line('@'||num1||'@'); --null출력
    
    
    num2 :=30;
    dbms_output.put_line(num2);
    
    dbms_output.put_line(num3);
end;
/













































