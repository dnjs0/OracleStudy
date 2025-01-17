-- ex16_update.sql

/*
    
    update문
    - UML
    - 원하는 행의 원하는 컬럼값을 수정하는 명령어
    
    UPDATE 테이블명 SET 컬럼명 = 값 [, 컬럼명 = 값] x N [WHERE 절];
    
    
    
*/

commit;
rollback;

select * from tblcountry;

-- 대한민국 : 서울 > 세종
update tblCountry set capital = '세종'; --14개 행 이(가) 업데이트되었습니다.> 모두 세종으로 바뀜
update tblCountry set capital = '세종' where name = '대한민국';

update tblCountry set
        capital = '제주',
        population = 5000,
        continent = 'EU'
            where name = '대한민국';

-- AS > 인구수 10% 증가 > 반영
update tblCountry set
        population = population *1.1
        where continent = 'AS';
        
select * from tblCountry;


























































