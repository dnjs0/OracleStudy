-- ex15_insert

/*

    insert문 
    - DML
    - 테이블에 데이터를 추가하는 명령어
    
    INSERT INTO 테이블명(컬럼리스트) VALUE (값리스트);

*/


drop table tblMemo;

-- 1. 컬럼 수준
create table tblMemo (
--                comstraint 제약사항이름 제약사항종류(플젝할때 꼭 적어야해)
    seq number(3) constraint tblmemo_seq_pk primary key,      --메모번호(PK)
    name varchar2(30) default '익명',       --작성자(UQ)
    memo varchar2(1000),   --메모내용(NN)
    regdate date default sysdate not null             --작성날짜
);

create sequence seqMemo;

-- 1. 표준
-- : 원본 테이블의 정의된 컬럼 순서대로 > 컬럼 리스트의 값 리스트를 작성하는 방식
-- : 특별한 이유가 없으면 이 방식을 사용한다.
insert into tblMemo (seq, name, memo, regdate) 
    values (seqMemo.nextval, '홍길동', '메모입니다.', sysdate);

-- 2. 컬럼 리스트의 순서는 원본 테이블과 상관없다.
-- : 컬럼 리스트의 순서와 값 리스트의 순서만 동일하면 된다.
-- : 보통 원본 테이블의 순서대로 작성한다.
insert into tblMemo (name, memo, regdate, seq) 
    values ('홍길동', '메모입니다.', sysdate, seqMemo.nextval);

-- 3. ORA-00947: 값의 수가 충분하지 않습니다
insert into tblMemo (seq, name, memo, regdate)  --4개
    values (seqMemo.nextval, '홍길동', '메모입니다.'); --3개

-- 4. ORA-00913: 값의 수가 너무 많습니다
insert into tblMemo (seq, name, memo) -- 3개
    values (seqMemo.nextval, '홍길동', '메모입니다.', sysdate); -- 4개

-- 5. null을 허용한 칼럼 조작하기
--      a. null 상수 사용 > 명시적으로 null 추가
insert into tblMemo (seq, name, memo, regdate) 
    values (seqMemo.nextval, '홍길동', null, sysdate);

--      b. 컬럼 생략 > 암시적으로 null 추가
insert into tblMemo (seq, name, regdate) 
    values (seqMemo.nextval, '홍길동', sysdate);

-- 6. default 컬럼 조작하기
--      a. 컬럼생략 > null 추가됨 > default 호출됨
insert into tblMemo (seq, memo, regdate) 
    values (seqMemo.nextval, null, sysdate);

--      b. null 상수 > default 동작 안함 > 사용자 의지 반영
insert into tblMemo (seq, name, memo, regdate) 
    values (seqMemo.nextval, null, '메모입니다.', sysdate);

--      c. default 상수 > 명시적으로 default 호출
insert into tblMemo (seq, name, memo, regdate) 
    values (seqMemo.nextval, default, '메모입니다.', sysdate);

-- 7. 단축 표현
--      a. 컬럼 리스트는 생략할 수 있다.
insert into tblMemo values (seqMemo.nextval, '홍길동', '메모입니다.', sysdate);

--      b. 컬럼 리스트를 생략하면, 테이블의 원본 컬럼 순으로 값리스트를 작성해야한다.
--        ORA-00932: 일관성 없는 데이터 유형: DATE이(가) 필요하지만 NUMBER임
insert into tblMemo values ('홍길동', '메모입니다.', sysdate, seqMemo.nextval);

--      c. null 컬럼을 생략할 수 없다. > 반드시 null 상수 사용
insert into tblMemo values (seqMemo.nextval, '홍길동',  sysdate); -- 값 안넣고싶어서 지우면 오류
insert into tblMemo values (seqMemo.nextval, '홍길동',null,  sysdate);

--      d. default 컬럼을 생략할 수 없다. > 반드시 default 상수 사용
insert into tblMemo values (seqMemo.nextval,default, '메모입니다.', sysdate);

-- 8.
-- tblMemo 테이블 > 복사 > tblMemoCopy 생성
-- 데이터만 복사
create table tblMemoCopy (
--                comstraint 제약사항이름 제약사항종류(플젝할때 꼭 적어야해)
    seq number(3) constraint tblmemoCopy_seq_pk primary key,      --메모번호(PK)
    name varchar2(30) default '익명',       --작성자(UQ)
    memo varchar2(1000),   --메모내용(NN)
    regdate date default sysdate not null             --작성날짜
);


select * from tblMemo;

insert into tblMemoCopy select * from tblMemo; --서브쿼리

select * from tblMemoCopy;


-- 9. tblMemo 테이블 > 복사 > tblMemoCopy2 생성
-- 테이블 구조 복사(O)  > 데이터를 확인해서 추측
-- 제약 사항 복사(X)
-- 더미데이터 만들때 주로 사용, 대량 데이터 + 임시테이블 > 테스트용

create table tblMemoCopy2
as
select * from tblMemo;

-- seq도 not null이어야하는데 제약사항이 안걸림 > 관리 불가능 >  쓰레기 테이블
desc tblMemoCopy2;

select * from tblMemoCopy2;














































































