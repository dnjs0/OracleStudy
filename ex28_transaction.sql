-- ex28_transaction.sql
/*

    트랜잭션, Transaction
    - 데이터 조작하는 업무(DML > insert, update, delete)의 물리적(시간적) 단위
    - DML 1개 이상의 명령어를 묶어놓은 단위
    
    *** 트랜잭션 처리를 통해서 과거로 돌아갈 수 있는 이유?
    - 트랜잭션내의 insert, update, delete 작업은 실제 데이터베이스에 적용되지 않는다.
        > 캐시(임시 메모리)에 적용된다.
        
    트랜잭션 명령어
    - DCL, TCL
    1. commit
    2. rollback
    3. savepoint
    
*/

create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';

select * from tblTrans;

-- 이제부터 우리가 하는 행동(SQL) > 반드시 시간 순서대로 기억!!!

-- 로그인(접속) 직후 > 트랜잭션 시작~
-- > 우리가 하는 행동(insert, update, delete) 감시

select * from tblTrans; --현재 트랜잭션 포함(X)

delete from tblTrans where name = '박문수'; --현재 트랜잭션 포함(O)

select * from tblTrans;

-- 오라클 강제 종료 > 사용 트랜잭션이 소멸

-- 재접속 > 새로운 트랜잭션이 생성
select * from tblTrans;

delete from tblTrans where name = '박문수';

select * from tblTrans;

-- 현재까지 작업한 임시 결과들을
-- 1. 실제 오라클에 반영? > commit
-- 2. 없었던 일로? > rollback
select * from tblTrans;

commit;

select * from tblTrans;

delete from tblTrans where name = '김영년';

select * from tblTrans;

rollback;

select * from tblTrans;

insert into tblTrans values ('강아지', '기획부', '사원');

update tblTrans set jikwi = '대리' where name = '한석봉';

delete from tblTrans where buseo = '영업부';

select * from tblTrans;

commit;
rollback;

select * from tblTrans;

/*

    트랜잭션이 언제 시작해서 ~ 언제 끝나는지?
    
    새로운 트랜잭션이 시작하는 경우
    1. 클라이언트 접속 직 후
    2. commit 실행 직 후
    3. rollback 실행 직 후
    4. DDL 실행 직 후
        
    현재(기존) 트랜잭션이 끝나는 경우
    1. 클라이언트 접속 해제 직 후
        a. 정상 종료
            - 현재 트랜잭션에 아직 반영이 안된 명령어가 남아 있으면.. > 질문?
        b. 비정상 종료
            - 트랜잭션을 처리할만한 시간 여유가 없어서..
            - rollback과 동일한 마무리가 발생한다.
    2. commit 실행 순간
    3. rollback 실행 순간
    4. DDL 실행 순간(***** 조심!!!)
        - create, alter, drop > 실행 > 즉시 commit 호출
        - DDL 성격 > DB의 구조 변경 > 데이터 영향 미치는 행동 > 사전에 미리 저장(commit)
        
*/
rollback;

select * from tblTrans;

update tblTrans set jikwi = '상무' where name = '홍길동';
update tblTrans set buseo = '기획부', jikwi = '과장' where name = '한석봉';

create sequence setAAA;

rollback;

select * from tblTrans;


-- 지금부터 트랜잭션을 적극적으로 관리해야할 업무 진행할 예정~
commit;

select * from tblTrans;

update tblTrans set jikwi = '타조' where name = '홍길동';

commit;

rollback;

commit;

-- savepoint
select * from tblTrans;

insert into tblTrans values ('고양이', '기획부', '사원');

savepoint a;

update tblTrans set jikwi = '부장' where name = '홍길동';

savepoint b;

delete from tblTrans where name = '홍길동';

rollback to b;

select * from tblTrans;

rollback to a;

select * from tblTrans;

commit;

























