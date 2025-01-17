-- ex02_datatype.sql

/*
    
    관계형 데이터베이스
    - 프로그래밍 요소 제공(X),변수 없음
    - SQL > 대화형 언어 > 문장 단위의 작업으로 구성된다.
    - 자료형 > 테이블 정의할 때 사용 (= 컬럼의 자료형)
    
    ANSI-SQL 자료형
    - 오라클 자료형
    
    1. 숫자형
        - 정수, 실수
        a. number 
            - (유효처리)38자리 이하의 숫자를 표현하는 자료형
            - 5~22byte
            - 1x10^-138 ~ 9.9999x10^125
        
            - number : 정수를 넣어도 되고 실수를 넣어도 됨,가장 넓은 범위 표시 가능
            - number(precision) : 전체자리수 > 정수만 저장, 소수를 입력시 정수만 저장, 반올림 됨, 123456789는 오버플로우,-999~999까지 출력가능
            - number(precision, scale) : 전체 자리수 + 소수 이하 자리수 > 정수/실수 저장, -99.99~99.99
        
    2. 문자형
        - 문자 + 문자열(문자만은 없다! 다 문자얼)
        - char vs nchar > n의 의미? n : national(유니코드)
        - char vs varchar > var의 의미?
        
        a. char(차 라고 읽음)
            - 고정 자릿수 문자열  > 무조건 10자리를 확보해라!, 남는 자리는 스페이스로 채워라(10은 예시 숫자)
            - char(n) : 최대 n자리수 문자열, n(바이트) > utf-8(영어1byte,한글3byte) > 주로 사용
                - char(n byte) > 바이트
                - char(n char) > 문자수
            - 최소 크기 : 1바이트
            - 최대 크기 : 2000바이트
        b. nchar
            - 고정 자릿수 문자열
            - nchar(n) : 최대 n자리수 문자열, n(문자 수) > utf-16(영어2byte,한글2byte)
            - 최소 크키 : 1문자
            - 최대 크리 : 1000문자

        c. varchar2
            - varchar(variable char, 바차 라고 읽음)
            - 가변 자릿수 문자열 > 삽입된 데이터 크기만의 공각만 차지한다. 나머지 7칸을 반환한다.(7는 예시 숫자)
            - varchar2(n) : 최대 n자기 문자열, n(바이트)
            - 최소 크기 : 1바이트
            - 최재 크기 : 4000바이트 
            
        d. nvarchar2
            - varchar(variable char, 바차 라고 읽음)
            - 가변 자릿수 문자열 > 삽입된 데이터 크기만의 공각만 차지한다. 나머지 7칸을 반환한다.(7는 예시 숫자)
            - varchar2(n) : 최대 n자기 문자열, n(문자 수)
            - 최소 크기 : 1바이트
            - 최재 크기 : 4000바이트 
            
        e. clob , nclob
            - 대용량 텍스트
            - character large object
            - 최대 128TB
        
    3. 날짜/시간형
        a. date
            - 년 월 일 시 분 초
            - 기원전 4712년 1월 1일 + 9999년 12월 31일
            
        b. timestamp
            - 년 월 일 시 분 초 + 밀리초 + 나노초
            
        c. interval
            - 시간
            - 틱값 저장용
        
    4. 이전 데이터형
        - 비 텍스트 데이터
        - 이미지, 동영상, 음악, 실행파일, 압축파일 등,,,
        - 게시판 > 첨부파일 >파일명만 DB에 저장
        a. blob, binary large object
            - 최대 128TB
        
    결론(*****)
    1. 숫자 > number
    2. 문자열 > varchar2
    3. 날짜 > date
    
    
    테이블 선언(생성)
    
    create table  테이블명(
        컬럼 정의,
        컬럼 정의, 
        컬럼명 자료형 ,,,
        );



*/
-- 수업 : 테이블명 > 헝가리안 표기법(자료형을 접두형으로 붙이는 표기법)
drop table tblType;


create table tblType( --테이블이구나~ vw : 뷰 군아~
    --컬럼 정의
    --num number
    --num number(3) 
    --num number(4,2)-- -99.99~99.99
    
    --txt char(10) --오라클은 어떤 인코딩방식을 사용하는가? > utf-8( 영어1byte, 한글3byte)
    --txt nchar(10)
    txt1 char(10),
    txt2 varchar2(10)
);

--모든 테이블 보여줘 
select * from tabs; 

-- 테이블의 구조를 보여주세요
desc tblType;


-- 데이터 추가하기
-- insert into 테이블명 (컬럼명) values (값);
insert into tblType (num) values (100); -- num =100
insert into tblType (num) values (3.14); 
insert into tblType (num) values (3.99); 
insert into tblType (num) values (123456789); 
insert into tblType (num) values (12345678901234567890123456789012345678);
--더 길어지면 뒤에 잘림, 정밀도 떨어짐
insert into tblType (num) values (-99.99); 
insert into tblType (num) values (99.9999); --X 반올림해서 넘음
insert into tblType (num) values (-99.9909); --O 반올림해서 버림


insert into tblType (txt) values ('A'); --문자열 리터럴
insert into tblType (txt) values ('ABC');
insert into tblType (txt) values ('ABCabcabca');
insert into tblType (txt) values ('가나다');
insert into tblType (txt) values ('가나다라마바사아자차');

insert into tblType (txt1, txt2) values ('ABC','ABC');

-- 데이터 가져오기
-- select * from 테이블명;
select * from tblType;
