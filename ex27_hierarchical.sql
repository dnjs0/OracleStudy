-- ex27_hierarchical.sql
/*

    계층형 쿼리, Hierarchical Query
    - 테이블내의 레코드끼리 계층형 관계일 때 사용하는 쿼리
    - 오라클 전용
    - 자기 참조를 하는 테이블에서 사용
    
*/
select * from tblSelf;

select * from tblComputer;

-- 직원 가져오기 + 상사명
-- 부품 가져오기 + 부모 부품의 정보
select
    c2.name as 부품명,
    c1.name as 부모부품명
from tblComputer c1             --부모부품(부모 테이블) > Sub
    inner join tblComputer c2   --자식부품(자식 테이블) > 보려는 부품 목록(Main)
        on c1.seq = c2.pseq;


/*

    계층형 쿼리 구문
    1. start with절 + connect by절
    2. 의사 컬럼(계층형 쿼리 전용)
        a. prior: 자신과 연관된 부모 레코드를 참조하는 객체
        b. level: 세대수(depth)
        c. connect_by_root: 루트 레코드 참조 객체
        d. connect_by_isleaf: 해당 레코드가 말단 레코드인지 확인

*/
select
    seq as 번호,
    lpad(' ', (level - 1) * 3) || name as 부품명,
    prior name as 부모부품명,
    level,
    connect_by_root name,
    connect_by_isleaf,
    sys_connect_by_path(name, ' → ')
from tblComputer
    --start with seq = 1
    --start with seq = (select seq from tblComputer where name = '컴퓨터')
    start with pseq is null
        connect by prior seq = pseq --자식과 부모를 어떻게 연결할지? > 조건절
            order siblings by name asc
    ;


































