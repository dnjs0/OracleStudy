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
        



-- 이름pk, 이름, 성별, 프로그램 이름,횟수, 시작일, 종료일 view      
select 
    m.member_id as 회원번호, 
    m.name as 회원이름, 
    p.title as 프로그램명,
    tpr.program_registration as 등록pk,
    op.total_count as 횟수, 
    op.start_date as 시작일, 
    op.end_date as 종료일
from tProgramRegistration tpr
    inner join tmember m on m.member_id = tpr.member_id
    inner join tOpenProgram op on op.open_program_id=tpr.open_program_id
    inner join tProgram p on p.program_id = op.program_id;
    
-- 요일, 프로그램명, 시작 시간 view    
select d.day, p.title, t.start_time
from tDayType dt
    inner join tday d on d.day_id=dt.day_id
    inner join tOpenProgram op on op.open_program_id=dt.open_program_id
    inner join tProgram p on p.program_id = op.program_id
    inner join tTime t on t.time_id = op.time_id;





--tCommute 상태 변경 PL/SQL

DECLARE
    -- 커서 선언
    CURSOR commute_cursor IS
        SELECT c.commute_id, c.go_to_work, c.leave_work, 
               i.work_start_time, i.work_end_time
        FROM tCommute c
        JOIN tInstroctor i ON c.instroctor_id = i.instroctor_id;
    
    -- 변수 선언
    v_situation VARCHAR2(20);
    v_work_start VARCHAR2(8);
    v_work_end VARCHAR2(8);
    v_actual_start VARCHAR2(8);
    v_actual_end VARCHAR2(8);
BEGIN
    -- 커서를 통해 출퇴근 기록을 순회
    FOR commute_rec IN commute_cursor LOOP
        -- 해당 날짜의 시간만 추출
        v_work_start := TO_CHAR(commute_rec.work_start_time, 'HH24:MI:SS');
        v_work_end := TO_CHAR(commute_rec.work_end_time, 'HH24:MI:SS');
        v_actual_start := TO_CHAR(commute_rec.go_to_work, 'HH24:MI:SS');
        v_actual_end := TO_CHAR(commute_rec.leave_work, 'HH24:MI:SS');
        
        -- 출근 상황 판단
        IF v_actual_start > v_work_start THEN
            v_situation := '지각';
        ELSIF v_actual_end < v_work_end THEN
            v_situation := '조기퇴근';
        ELSE
            v_situation := '정상출근';
        END IF;
        
        -- 상황 업데이트
        UPDATE tCommute
        SET situation = v_situation
        WHERE commute_id = commute_rec.commute_id;
    END LOOP;
    
    -- 변경사항 저장
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        -- 오류 발생 시 롤백
        ROLLBACK;
        RAISE;
END;
/


select * from tCommute;



