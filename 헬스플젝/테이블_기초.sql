BEGIN
  FOR c IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE ('DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS');
  END LOOP;
END;
/

select * from tabs;
show user;


-- 이름pk, 이름, 성별, 프로그램 이름, 시작일, 종료일 view

select m.member_id, m.name,m.gender, p.title, op.start_date, op.end_date
from tProgramRegistration tpr
    inner join tmember m on m.member_id = tpr.member_id
    inner join tOpenProgram op on op.open_program_id=tpr.open_program_id
    inner join tProgram p on p.program_id = op.program_id;
--WHERE op.end_date >'2025-02-22'
    --order by m.member_id;
        
