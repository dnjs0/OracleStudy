-- ex01.sql
-- 단일 라인 주석

/*

    다중 라인 주석

*/

--ctrl + / : 단일 라인 주석


-- 실행문
-- 문장종결자(;)
-- 실행할 문장을 선택(블럭)한 후 ctrl + enter

show user;

-- 계정 생성 하기(관리자만 가능)
create user c##project identified by java1234;

--oracle c## 제거 방법 > alter로 시작하는거 복사
alter session set "_ORACLE_SCRIPT"=true;

--c## 안적어도 생성 됨
create user project identified by java1234;

-- hong0 삭제
drop user c##project;

-- homg 계정 생성
create user hong identified by java1234;



grant connect to project;

show user;

-- hr 계정 생성하기
-- > hr를 생성하기
-- C:\app\user\product\21c\dbhomeXE\demo\schema\human_resources


-- 샘플 계정
-- scott/tiger
-- hr/hr

-- 비밀번호 수정
alter user hr identified by java1234;

-- 샘플 데이터
select * from employees;



/*
    
    데이터베이스 프로그램
    - Oracle : 오라클, 기업용, 대용량 데이터 처리, 기업에서 가장 많이 쓰는 것중 하나
    - MS-SQL : 마이크로소프트, 기업용
    - DB2 : IBM
    - MySQL(**) : 오라클, 개인용, 소규모, 기업용 > AWS
    - MariaDB : 개인용, 소규모, 기업용
    - PostreSQL : 개인용, 소규모, 기업용
    - SQLlite : 초경량, 임베디드(모바일)
    - H2 : 스프링부트(초경량)
    
    Oracle
     - 1 ~ 23c
     - 11g 이후 > 거의 동일
     
    오라클(데이터베이스) <-> SQL Developer(클라이언트) <-> SQL <-> 사람
     
    SQL, Struectured Query Language
        - 구조화된 질의 언어
        - 데이터베이스와 대화를 하기 위한 언어
        
    1. 데이터베이스 제작사와 독립적이다.
        - 모든 데이터베이스에서 공통으로 사용하기 위해 만들어진 언어
        - DB 제작사에서 SQL이라는 언어를 가져다가 자신의 제품에서 사용
        
        
    2. 표준 SQL, ANSI-SQL
        - 모든 DB에서 적용 가능한 SQL
        
    3. 제조사별 SQL
        - 특정 DB에서만 적용 가능한 SQL
        - Oracle > PL/SQL
        - MS-SQL > T-SQL
        
        
    오라클 수업 = ANSI-SQL(60%) + DB 설계(10%) + PL/SQL(30%) 
    
    관계형 데이터베이스, Relational Database, RDB
    - 데이터를 표로 저장한다.
    - SQL를 사용한다.
    
    
    오라클 = 관계형 데이터베이스 + 관리 시스템
          = Relational Database Management System
          = RDBMS
          
          
          
    ANSI-SQL
    
    1. DDL
        - Data Definition Language
        - 데이터 정의어
        - 테이블, 뷰, 사용자, 인덱스, 트리거 등의 데이터베이스 오브젝트를 
            생성/수정/삭제하는 명령어
        - 구조를 생성/관리하는 역할(***)
        a. create : 생성
        b. drop : 삭제
        c. alter : 수정
        
        - 데이터베이스 관리자가 사용
        - 데이터베이스 개발자가 사용
        - 우리같은) 프로그래머들은 사용할수도, 안할수도 있다.
        
    2. DML
        - Data Manipulation Language
        - 데이터 조작어
        - 데이터를 추가/수정/삭제/조회하는 명령어(CRUD)
        - 사용 빈도가 가장 높음
        a. select : 조회(읽기) 
        b. insert : 추가(생성)
        c. update : 수정
        d. delete : 삭제
        -  프로그래머 사용(*****)
        
    3. DCL
        - DAta Control Language
        - 데이터 제어어
        - 게정 관리, 보안제어, 트랜잭션 처리 등,,
        a. commit
        b. rollback
        c. grant
        d. revoke
        - 데이터베이스 관리자
        - 데이터베이스 설계자
        - 프로그래머 (일부)
        
    4. DQL
        - Date Query Language
        - DML 중에서 select 문을 따로 부르는 표현
        
    5. TCL
        - Transactgion Control 
        - DCL 중에서 commit/rollback문을 따로 부르는 표현
        
    SQL 
    - 대소문자를 구분하지 않는다.
    - 데이터는 대소문자를 구분한다.
    - 공백 문자도 영향을 주지 않는다.(엔터 X) > 문장 종결자(;) 
 
    - 키워드(SQL 구문) > 대문자
    -  식별자(테이블 명, 컬럼명 등) > 소문자
*/

select * from tabs; --현재 계정이 소유하고 있는 테이블 목록을 가져오기
SELECT * FROM TABS; --대소문자를 구별하지 않는다.

--수업 진행 > all 소문자
-- alt + ' 하면 대소문자 바꿀수 있다.
select * from tabs;

select * from tabs where table_name = 'JOBS';
