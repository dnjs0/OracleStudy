-- ex17_delete.sql

/*
    
    delete 문
    - DML
    - 원하는 행을 삭제하는 명령어
    
    DELETE [FROM] 테이블명 [WHERE 절];
    
*/

rollback;

select * from tblInsa;

delete from tblinsa where num = 1001;
delete from tblinsa where buseo = '영업부';
delete from tblinsa; -- 다지움 주의















