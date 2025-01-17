-- ex14_sequence.sql

/*

    시퀀스, Sequence
    - 데이터베이스 객체 중 하나(테이블, 제약사항, 계정, 시퀀스)
    - 오라클 전용 객체(다른 DB에는 없음)
    - 일련 번호를 생성하는 객체(*****)
    - 주로 식별자 만들 때 사용한다. > 주로 PK 값으로 사용된다.
                                    > 다양한 용도로도 사용된다.
    
    시퀀스 객체 생성하기
    - CREATE SEQUENCE 시퀀스명;
    
    시퀀스 객체 생성하기
    - DROP SEQUENCE 시퀀스명;
    
    시퀀스 객체 사용하기
    - number 시퀀스명.nextVal
    - number 시퀀스명.currVal

*/
create sequence seqNum;

select seqNum.nextVal from dual; --11 > 12 > 13 : 스택.pop(), 오프라인에서도 저장한다.껐다켜도 중복되지 않는다.
select seqNum.currVal from dual; --18 > 18 > 18 : 스택.peek(),

select * from tblMemo;

insert into tblMemo (seq, name, memo, regdate)
    values (seqNum.nextVal, '아무개', '할일 정리하기', sysdate);

-- 쇼핑몰 > 상품번호 > ABC001, ABC002,
select 'ABC' || seqNum.nextval from dual; --ABC22
select 'ABC' || lpad(seqNum.nextval, 3, '0') from dual; ----ABC026
select 'ABC' || trim(to_char(seqNum.nextVal,'000')) from dual; --ABC027


-----------------------------------------------------------------------------------

/*
    ~심화~
    
    시퀀스 객체 생성하기
    - CREATE SEQUENCE 시퀀스명;
    
    시퀀스 객체 생성하기
    - CREATE SEQUENCE 시퀀스명 
                INCREMENT BY N --증감치
                START WITH N -- 시작값
                MAXVALUE N  -- 최댓값
                MINVALUE N  --최솟값
                CYCLE       -- 순환 유무
                CACHE N;    -- 캐시 크기



*/
drop sequence seqTest;

create sequence seqTest
                --increment by -1 -- 증감
                --start with 10  --시작값
                --maxvalue 10
                --minvalue 1 --maxvalue와 같이 사용해야한다.
                --cycle --cache와 같이 사용해야한다.
                cache 5
                ;
select seqTest.nextval from dual;

















