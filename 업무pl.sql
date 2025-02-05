--업무pl.sql
set serverout on;

--==========================================================
/*  공휴일  */
--==========================================================

/*추가*/
begin
    insert into holiday values (holiday_seq.nextval,'2024-07-15','학원휴일');
end;
/

/*수정*/
begin
    update holiday set holidayname = '쉬는날' where holidayseq=16;
end;
/


/*삭제*/
BEGIN
    delete from holiday where holidayseq = 21;
END;
/







--==========================================================
/* D-01 교육생 로그인 기능 */
--==========================================================
/* 조회 */
CREATE OR REPLACE PROCEDURE pStudentLogin(
    pstudentNum IN STUDENT.studentseq%TYPE,
    pstudentPW IN STUDENT.studentpw%TYPE
)
IS
    vstudentName student.studentname%TYPE;
    vstudentTel student.studenttel%TYPE;
    vstudentDate student.studentdate%TYPE;
    vcourseName course.coursename%TYPE;
    vprocessStart process.processsdate%TYPE;
    vprocessEnd process.processedate%TYPE;
    vclassroom clsroom.clsroomname%TYPE;
    vcount NUMBER;

    -- 학생 정보
    CURSOR student_cursor 
    IS
        SELECT 
            s.studentname, 
            s.studenttel, 
            s.studentdate, 
            c.coursename, 
            p.processsdate, 
            p.processedate, 
            cr.clsroomname
        FROM student s
        INNER JOIN studentcls sc ON s.studentseq = sc.studentseq
        INNER JOIN process p ON sc.processseq = p.processseq
        INNER JOIN course c ON c.courseseq = p.courseseq
        INNER JOIN clsroom cr ON cr.clsroomseq = p.clsroomseq
        WHERE s.studentseq = pstudentNum;

BEGIN
    -- 1. 학생 존재 여부 및 비밀번호 확인
    SELECT COUNT(*) INTO vcount
    FROM student 
    WHERE studentseq = pstudentNum AND studentpw = pstudentPW;
    
    IF vcount = 0 THEN
        DBMS_OUTPUT.PUT_LINE('로그인 실패: 학번 또는 비밀번호가 틀렸습니다.');
        RETURN;
    END IF;

    -- 2. 학생 정보 출력
    OPEN student_cursor;
    
    FETCH student_cursor INTO 
        vstudentName, vstudentTel, vstudentDate, 
        vcourseName, vprocessStart, vprocessEnd, vclassroom;
    
    IF student_cursor%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('학생 정보가 존재하지 않습니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(' 로그인 성공!');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        DBMS_OUTPUT.PUT_LINE('이름: ' || vstudentName);
        DBMS_OUTPUT.PUT_LINE('전화번호: ' || vstudentTel);
        DBMS_OUTPUT.PUT_LINE('등록일: ' || TO_CHAR(vstudentDate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('과정명: ' || vcourseName);
        DBMS_OUTPUT.PUT_LINE('과정 시작일: ' || TO_CHAR(vprocessStart, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('과정 종료일: ' || TO_CHAR(vprocessEnd, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('강의실: ' || vclassroom);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END IF;
    
    CLOSE student_cursor;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('로그인 실패: 학번 또는 비밀번호가 틀렸습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생!');
END;
/


-- 호출문의 매개변수 : 학생 번호, 학생 비밀번호
BEGIN
    pStudentLogin(1,2345678);
END;
/










--==========================================================
/* D-02 교육생 개인성적정보 확인기능 */
--==========================================================
CREATE OR REPLACE PROCEDURE pStudentScore(
    pteacherNum IN teacher.teacherseq%TYPE,
    pstudentNum IN student.studentseq%TYPE,
    pprocessNum IN process.processseq%TYPE
)
IS

    CURSOR cur_score IS
        SELECT DISTINCT
            pc.subjectseq AS "과목 번호",
            s.subjectname AS "과목 이름",
            pc.prcsubjectsdate AS "과목 시작 날짜",
            pc.prcsubjectedate AS "과목 종료 날짜",
            b.bookname AS "교재명",
            t.teachername AS "교사명",
            sa.attendallot AS "출석 배점",
            sa.writingallot AS "필기 배점",
            sa.realallot AS "실기 배점",
            score.attendancescore AS "출석 점수",
            score.writingscore AS "필기 점수",
            score.realscore AS "실기 점수",
            score.totalscore AS "총 점수",
            test.testtype AS "시험 종류",
            test.testdate AS "시험 날짜",
            test.testcontext AS "시험 문제"
        FROM prcsubject pc
            INNER JOIN process p ON p.processseq = pc.processseq
            INNER JOIN subject s ON s.subjectseq = pc.subjectseq
            INNER JOIN sbjectBook sb ON sb.subjectseq = pc.subjectseq
            INNER JOIN book b ON b.bookseq = sb.bookseq
            INNER JOIN teacher t ON t.teacherseq = p.teacherseq
            INNER JOIN scoreallot sa ON sa.prcsubjectseq = pc.prcsubjectseq 
            INNER JOIN studentcls scl ON scl.processseq = p.processseq
            INNER JOIN score ON scl.studentseq = score.studentseq
            LEFT JOIN test ON test.subjectseq = pc.subjectseq
        WHERE t.teacherseq = pteacherNum 
          AND p.processseq = pprocessNum 
          AND scl.studentseq = pstudentNum
          AND test.testdate = (
              SELECT MIN(testdate) 
              FROM test t2 
              WHERE t2.subjectseq = test.subjectseq
          )
        ORDER BY pc.prcsubjectsdate;

    v_subjectseq subject.subjectseq%TYPE;
    v_subjectname subject.subjectname%TYPE;
    v_prcsubjectsdate prcsubject.prcsubjectsdate%TYPE;
    v_prcsubjectedate prcsubject.prcsubjectedate%TYPE;
    v_bookname book.bookname%TYPE;
    v_teachername teacher.teachername%TYPE;
    v_attendallot scoreallot.attendallot%TYPE;
    v_writingallot scoreallot.writingallot%TYPE;
    v_realallot scoreallot.realallot%TYPE;
    v_attendancescore score.attendancescore%TYPE;
    v_writingscore score.writingscore%TYPE;
    v_realscore score.realscore%TYPE;
    v_totalscore score.totalscore%TYPE;
    v_testtype test.testtype%TYPE;
    v_testdate test.testdate%TYPE;
    v_testcontext test.testcontext%TYPE;

BEGIN

    OPEN cur_score;
    

    LOOP
        FETCH cur_score INTO 
            v_subjectseq, v_subjectname, v_prcsubjectsdate, v_prcsubjectedate, 
            v_bookname, v_teachername, v_attendallot, v_writingallot, v_realallot, 
            v_attendancescore, v_writingscore, v_realscore, v_totalscore, 
            v_testtype, v_testdate, v_testcontext;
        
        EXIT WHEN cur_score%NOTFOUND;

        
        DBMS_OUTPUT.PUT_LINE('과목 번호: ' || v_subjectseq);
        DBMS_OUTPUT.PUT_LINE('과목 이름: ' || v_subjectname);
        DBMS_OUTPUT.PUT_LINE('과목 시작 날짜: ' || v_prcsubjectsdate);
        DBMS_OUTPUT.PUT_LINE('과목 종료 날짜: ' || v_prcsubjectedate);
        DBMS_OUTPUT.PUT_LINE('교재명: ' || v_bookname);
        DBMS_OUTPUT.PUT_LINE('교사명: ' || v_teachername);
        DBMS_OUTPUT.PUT_LINE('출석 배점: ' || v_attendallot);
        DBMS_OUTPUT.PUT_LINE('필기 배점: ' || v_writingallot);
        DBMS_OUTPUT.PUT_LINE('실기 배점: ' || v_realallot);
        DBMS_OUTPUT.PUT_LINE('출석 점수: ' || v_attendancescore);
        DBMS_OUTPUT.PUT_LINE('필기 점수: ' || v_writingscore);
        DBMS_OUTPUT.PUT_LINE('실기 점수: ' || v_realscore);
        DBMS_OUTPUT.PUT_LINE('총 점수: ' || v_totalscore);
        DBMS_OUTPUT.PUT_LINE('시험 종류: ' || v_testtype);
        DBMS_OUTPUT.PUT_LINE('시험 날짜: ' || v_testdate);
        DBMS_OUTPUT.PUT_LINE('시험 문제: ' || v_testcontext);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;


    CLOSE cur_score;
END pStudentScore;
/


-- 호출문의 매개변수 : 학생 번호, 학생 비밀번호
BEGIN
    pStudentScore(1,1,2);
END;
/





--==========================================================
/* D-03 교육생 출결관리 기능 */
--==========================================================
-- 출결 조회하기
CREATE OR REPLACE PROCEDURE pStudentAttendance(
    pstudentNum IN attendance.studentseq%TYPE
)
IS
    CURSOR cur_attendance IS
        SELECT 
            attendancedate AS 날짜,
            TO_CHAR(attendancestime, 'HH24:MI') AS 등원시간,
            TO_CHAR(attendanceetime, 'HH24:MI') AS 하원시간
        FROM attendance
        WHERE studentseq = pstudentNum
        ORDER BY attendancedate;

    v_attendancedate attendance.attendancedate%TYPE;
    v_attendancestime VARCHAR2(5);
    v_attendanceetime VARCHAR2(5);

BEGIN
    OPEN cur_attendance;
    
    LOOP
        FETCH cur_attendance INTO 
            v_attendancedate, v_attendancestime, v_attendanceetime;
        
        EXIT WHEN cur_attendance%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('날짜: ' || TO_CHAR(v_attendancedate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('등원 시간: ' || v_attendancestime);
        DBMS_OUTPUT.PUT_LINE('하원 시간: ' || v_attendanceetime);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;

    CLOSE cur_attendance;
END;
/

-- 호출문의 매개변수 : 학생 번호
BEGIN
    pStudentAttendance(1);
END;
/


-----------------------------------------------------------------------------------


-- 특정 날짜(2024-07-24) 출결 조회하기
CREATE OR REPLACE PROCEDURE pStudentAttendanceDate(
    pstudentNum IN attendance.studentseq%TYPE,
    pyear IN NUMBER,
    pmonth IN NUMBER,
    pdate IN NUMBER
)
IS
    CURSOR cur_attendance IS
        SELECT 
            attendancedate AS 날짜,
            TO_CHAR(attendancestime, 'HH24:MI') AS 등원시간,
            TO_CHAR(attendanceetime, 'HH24:MI') AS 하원시간
        FROM attendance
        WHERE studentseq = pstudentNum
            AND EXTRACT(year FROM attendancedate) = pyear
            AND EXTRACT(MONTH FROM attendancedate) = pmonth
            AND EXTRACT(day FROM attendancedate) = pdate
        ORDER BY attendancedate;

    vattendancedate attendance.attendancedate%TYPE;
    vattendancestime VARCHAR2(5);
    vattendanceetime VARCHAR2(5);

BEGIN
    OPEN cur_attendance;
    
    LOOP
        FETCH cur_attendance INTO 
            vattendancedate, vattendancestime, vattendanceetime;
        
        EXIT WHEN cur_attendance%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE('날짜: ' || TO_CHAR(vattendancedate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('등원 시간: ' || vattendancestime);
        DBMS_OUTPUT.PUT_LINE('하원 시간: ' || vattendanceetime);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;

    CLOSE cur_attendance;
END;
/


-- 호출문의 매개변수 : 학생 번호,년,월,일
BEGIN
    pStudentAttendanceDate(1,2024,7,24);
END;
/


----------------------------------------------------------------

--출석 입력하기, 등원 추가
CREATE OR REPLACE PROCEDURE pInsertAttendance(
    pstudentNum IN attendance.studentseq%TYPE
)
IS
    vstudentName student.studentname%TYPE;
    vcount number;
BEGIN
    select 
        studentname into vstudentName
    from student where studentseq = pstudentNum;
    
    -- 출석을 했는가 예외처리
    SELECT COUNT(*) 
    INTO vcount
    FROM attendance
    WHERE studentseq = pstudentNum
      AND attendancedate = TRUNC(SYSDATE);
    
    -- 이미 출석을 한 경우 종료
    IF vcount > 0 THEN
        DBMS_OUTPUT.PUT_LINE(vstudentName || ' 학생은 이미 출석이 기록되어 있습니다.');
        RETURN;
    END IF;
    
    
    INSERT INTO attendance (
        attendanceseq, 
        studentseq, 
        attendancedate, 
        attendancestime, 
        attendanceetime, 
        attendancest
    ) VALUES (
        attendance_seq.NEXTVAL,     
        pstudentNum,               
        TRUNC(SYSDATE),             -- 현재 날짜 (시간 00:00:00)
        SYSDATE,                    -- 현재 시간으로 출석 시간 기록
        NULL,                       -- 퇴근
        '출석'                     
    );

    -- 변경 사항 저장
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE(vstudentname||' 학생, '|| '출석 등록 완료 (' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || ')');
    
EXCEPTION
    WHEN OTHERS THEN
        -- 에러 발생 시 롤백
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('오류 발생');
END ;
/


-- 호출문의 매개변수 : 학생 번호
BEGIN
    pInsertAttendance(1);
END;
/

---------------------------------------------------------------------------------
-- 수업종료 입력하기, 하원 추가
CREATE OR REPLACE PROCEDURE pUpdateAttendance(
    pstudentNum IN attendance.studentseq%TYPE
)
IS
    vattendancestime DATE;
    vstudentName varchar2(50);
    vstatus VARCHAR2(10);
    vcount number;

BEGIN

    select 
        max(studentname) into vstudentName
    from student where studentseq = pstudentNum;
    
    
    -- 하원을 했는가 예외처리
    SELECT COUNT(*) 
    INTO vcount
    FROM attendance
    WHERE studentseq = pstudentNum
      AND attendancedate = TRUNC(SYSDATE)
      and attendanceetime is not null;
    
    -- 이미 하원을 한 경우 종료
    IF vcount > 0 THEN
        DBMS_OUTPUT.PUT_LINE(vstudentName || ' 학생은 이미 하원이 기록되어 있습니다.');
        RETURN;
    END IF;
    
    
    SELECT min(attendancestime)
    INTO vattendancestime
    FROM attendance
    WHERE studentseq = pstudentNum
      AND attendancedate = TRUNC(SYSDATE)  
      AND attendanceetime IS NULL;

    -- 등원 시간이 NULL -> 지각(하원은 등록했기때문)
    IF vattendancestime IS NULL THEN
        vstatus := '지각';

    -- 정상 출석
    ELSIF TO_CHAR(vattendancestime, 'HH24:MI') <= '09:00' 
      AND TO_CHAR(SYSDATE, 'HH24:MI') >= '18:00' THEN
        vstatus := '정상';
        

    -- 지각 (등원이 09:00 이후)
    ELSIF TO_CHAR(vattendancestime, 'HH24:MI') > '09:00' THEN
        vstatus := '지각';

    -- 조퇴 (하원이 18:00 이전)
    ELSIF TO_CHAR(SYSDATE, 'HH24:MI') < '18:00' THEN
        vstatus := '조퇴';

    END IF;

    --업데이트
    UPDATE attendance
    SET attendanceetime = SYSDATE,
        attendancest = vstatus
    WHERE studentseq = pstudentNum
      AND attendancedate = TRUNC(SYSDATE)  
      AND attendanceetime IS NULL;

    --저장
    COMMIT;

    DBMS_OUTPUT.PUT_LINE(vstudentname ||' 학생, '|| ' 퇴근 등록 완료 (' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || ')');
    DBMS_OUTPUT.PUT_LINE('출석 상태: ' || vstatus);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('출석 기록 없음: ' ||  vstudentName || '의 오늘 출석 정보가 없습니다.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('오류 발생: ' || SQLERRM);
END;
/


-- 호출문의 매개변수 : 학생 번호
BEGIN
    pUpdateAttendance(1);
END;
/




--==========================================================
/* D-04 교육생 출결조회 기능 */
--==========================================================
--날짜의 뷰 먼저 생성
create or replace view vwTotalDate
as
select
    to_date('2024-07-03', 'yyyy-mm-dd') + level - 1 as regdate
from dual
    connect by level <= (to_date('2025-08-24', 'yyyy-mm-dd')
                            - to_date('2024-07-03', 'yyyy-mm-dd') + 1);
                                                        

----------------------------------------------------------------------------------
--1. 1번 학생의 출결전체 조회 
-- 선언문
CREATE OR REPLACE PROCEDURE pAttendanceStudentTotal(
    pstudentNum in STUDENT.studentseq%type
)
is
    vname student.studentname%type;
    vdate date;
    vresult varchar2(50);
    vstartdate date;
    venddate date;
    
    cursor vcursor
    is
    select 
    v.regdate as "날짜",
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when h.holidayseq is not null then h.holidayname
        when h.holidayseq is null and t.attendanceseq is null then '결석'
        else t.attendancest
    end as "상태"
    from vwTotalDate v
        left outer join attendance t
            on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.attendancedate, 'yyyy-mm-dd')
            AND t.studentseq = pstudentNum 
                left outer join holiday h
                    on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.holidaydate, 'yyyy-mm-dd')
                    WHERE v.regdate BETWEEN vstartdate AND venddate
                        order by v.regdate asc;

    
begin
    select studentname into vname from student where studentseq=pstudentNum;
    
    SELECT processsdate,processedate
    INTO vstartdate, venddate
    FROM process
    where processseq=1;
    dbms_output.put_line(vname||' 학생의 출석부');
    dbms_output.put_line('----------------------------------------------------');
    dbms_output.put_line('조회할 기간 : '|| TO_CHAR(vstartdate, 'YYYY-MM-DD') || ' ~ ' || TO_CHAR(venddate, 'YYYY-MM-DD'));
    
    open vcursor;
    
    loop    
        fetch vcursor into vdate,vresult;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE('['||TO_CHAR(vdate, 'YYYY-MM-DD')||']  ' || vresult);
        
    end loop;
    close vcursor;

end;
/                            

-- 호출문의 매개변수 : 학생 번호
BEGIN
    pAttendanceStudentTotal(1);
END;
/


--------------------------------------------------------------------------------
--2. 1번 학생의 7월달 출결 조회
-- 선언문
CREATE OR REPLACE PROCEDURE pAttendanceStudentMonth(
    pstudentNum in STUDENT.studentseq%type,
    pyear in number,
    pmonth in number
)
is
    vname student.studentname%type;
    vdate date;
    vresult varchar2(50);
    vstartdate date;
    venddate date;

    cursor vcursor
    is
    select 
    v.regdate as "날짜",
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when h.holidayseq is not null then h.holidayname
        when h.holidayseq is null and t.attendanceseq is null then '결석'
        else t.attendancest
    end as "상태"
    from vwTotalDate v
        left outer join attendance t
            on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.attendancedate, 'yyyy-mm-dd')
                AND t.studentseq = pstudentNum 
                    left outer join holiday h
                        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.holidaydate, 'yyyy-mm-dd')
                            WHERE extract(year from v.regdate) = pyear
                                and extract(month from v.regdate) = pmonth
                                    order by v.regdate asc;

    
begin
    select studentname into vname from student where studentseq=pstudentNum;
    

    dbms_output.put_line(vname||' 학생의 출석부');
    dbms_output.put_line('----------------------------------------------------');
    dbms_output.put_line('조회할 월 : '||pyear || '년 ' || pmonth|| '월 ');
    
    open vcursor;
    
    loop    
        fetch vcursor into vdate,vresult;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE('['||TO_CHAR(vdate, 'YYYY-MM-DD')||']  ' || vresult);
        
    end loop;
    close vcursor;

end;
/                            

-- 매개변수 : 학생 번호, 년, 월
-- 호출문
BEGIN
    pAttendanceStudentMonth(1,2024,7);
END;
/

---------------------------------------------------------------------------------
--3. 1번 학생의 날짜별 출결 조회
-- 선언문
CREATE OR REPLACE PROCEDURE pAttendanceStudentDate(
    pstudentNum in STUDENT.studentseq%type,
    pyear in number,
    pmonth in number,
    pdate in number
)
is
    vname student.studentname%type;
    vdate date;
    vresult varchar2(50);

    cursor vcursor
    is
    select 
    v.regdate as "날짜",
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when h.holidayseq is not null then h.holidayname
        when h.holidayseq is null and t.attendanceseq is null then '결석'
        else t.attendancest
    end as "상태"
    from vwTotalDate v
        left outer join attendance t
            on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.attendancedate, 'yyyy-mm-dd')
                AND t.studentseq = pstudentNum 
                    left outer join holiday h
                        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.holidaydate, 'yyyy-mm-dd')
                            WHERE extract(year from v.regdate) = pyear
                                and extract(month from v.regdate) = pmonth
                                and extract(day from v.regdate) = pdate
                                    order by v.regdate asc;

    
begin
    select studentname into vname from student where studentseq=pstudentNum;
    

    dbms_output.put_line(vname||' 학생의 출석부');
    dbms_output.put_line('----------------------------------------------------');
    dbms_output.put_line('조회할 날짜 : '||pyear || '년 ' || pmonth|| '월 '|| pdate|| '일 ');
    
    open vcursor;
    
    loop    
        fetch vcursor into vdate,vresult;
        exit when vcursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE('['||TO_CHAR(vdate, 'YYYY-MM-DD')||']  ' || vresult);
        
    end loop;
    close vcursor;

end;
/                            

-- 매개변수 : 학생 번호, 년, 월
-- 호출문
BEGIN
    pAttendanceStudentDate(1,2024,7,24);
END;
/


--===========================================================================================================================
--===========================================================================================================================
--==========================================================
/* C-05. 출결 관리 및 출결 조회 */
--==========================================================
--날짜의 뷰 먼저 생성
create or replace view vwTotalDate
as
select
    to_date('2024-07-03', 'yyyy-mm-dd') + level - 1 as regdate
from dual
    connect by level <= (to_date('2025-08-24', 'yyyy-mm-dd')
                            - to_date('2024-07-03', 'yyyy-mm-dd') + 1);




--2-1. 2번 교사가 강의한 1번 과정의 모든 교육생의 출결
CREATE OR REPLACE PROCEDURE pAttendanceTeacherTotal(
    pteacherNum IN teacher.teacherseq%TYPE,
    pprocessNum IN process.processseq%TYPE
)
IS
    vteacherName teacher.teachername%TYPE;
    vstudentName student.studentname%TYPE;
    vdate DATE;
    vresult VARCHAR2(50);
    vstartdate date;
    venddate date;
    
    -- 교육생 목록 조회를 위한 커서
    CURSOR student_cursor IS
        SELECT s.studentseq, s.studentname
        FROM student s
        JOIN studentcls sc ON s.studentseq = sc.studentseq
        WHERE sc.processseq = pprocessNum;
    
    -- 특정 교육생의 출결 조회를 위한 커서
    CURSOR attendance_cursor(pstudentNum student.studentseq%TYPE) IS
        SELECT 
            v.regdate AS "날짜",
            CASE
                WHEN TO_CHAR(v.regdate, 'd') = '1' THEN '일요일'
                WHEN TO_CHAR(v.regdate, 'd') = '7' THEN '토요일'
                WHEN h.holidayseq IS NOT NULL THEN h.holidayname
                WHEN h.holidayseq IS NULL AND t.attendanceseq IS NULL THEN '결석'
                ELSE t.attendancest
            END AS "상태"
        FROM vwTotalDate v
        LEFT JOIN attendance t 
            ON TO_CHAR(v.regdate, 'yyyy-mm-dd') = TO_CHAR(t.attendancedate, 'yyyy-mm-dd')
            AND t.studentseq = pstudentNum
        LEFT JOIN holiday h 
            ON TO_CHAR(v.regdate, 'yyyy-mm-dd') = TO_CHAR(h.holidaydate, 'yyyy-mm-dd')
                WHERE v.regdate BETWEEN vstartdate AND venddate
                     ORDER BY v.regdate ASC;

BEGIN
    -- 교사 이름 
    SELECT teachername INTO vteacherName 
    FROM teacher 
    WHERE teacherseq = pteacherNum;
    
    -- 과정의 시작일과 종료일 가져오기
    SELECT processsdate, processedate INTO vstartdate, venddate
    FROM process 
    WHERE processseq = pprocessNum;

    DBMS_OUTPUT.PUT_LINE(vteacherName || ' 강사의 ' || pprocessNum || '번 과정 출석부');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('조회할 기간 : ' || vstartdate || '~ ' || venddate);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- 학생 목록
    FOR student_rec IN student_cursor LOOP
        vstudentName := student_rec.studentname;
        DBMS_OUTPUT.PUT_LINE(vstudentName);

        -- 특정 학생의 출결
        OPEN attendance_cursor(student_rec.studentseq);
        
        LOOP
            FETCH attendance_cursor INTO vdate, vresult;
            EXIT WHEN attendance_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('  [' || TO_CHAR(vdate, 'YYYY-MM-DD') || '] ' || vresult);
        END LOOP;

        CLOSE attendance_cursor;
    END LOOP;
END;
/

-- 매개변수 : 교사번호,과정
-- 호출문
BEGIN
    pAttendanceTeacherTotal(2,1);
END;
/




----------------------------------------------------------------------------------
--2-2. 2번 교사가 강의한 1번 과정의 월 입력시 모든 교육생의 출결
CREATE OR REPLACE PROCEDURE pAttendanceTeacherMonth(
    pteacherNum IN teacher.teacherseq%TYPE,
    pprocessNum IN process.processseq%TYPE,
    pyear IN NUMBER,
    pmonth IN NUMBER
)
IS
    vteacherName teacher.teachername%TYPE;
    vstudentName student.studentname%TYPE;
    vdate DATE;
    vresult VARCHAR2(50);
    
    -- 교육생 목록 조회를 위한 커서
    CURSOR student_cursor IS
        SELECT s.studentseq, s.studentname
        FROM student s
        JOIN studentcls sc ON s.studentseq = sc.studentseq
        WHERE sc.processseq = pprocessNum;
    
    -- 특정 교육생의 출결 조회를 위한 커서
    CURSOR attendance_cursor(pstudentNum student.studentseq%TYPE) IS
        SELECT 
            v.regdate AS "날짜",
            CASE
                WHEN TO_CHAR(v.regdate, 'd') = '1' THEN '일요일'
                WHEN TO_CHAR(v.regdate, 'd') = '7' THEN '토요일'
                WHEN h.holidayseq IS NOT NULL THEN h.holidayname
                WHEN h.holidayseq IS NULL AND t.attendanceseq IS NULL THEN '결석'
                ELSE t.attendancest
            END AS "상태"
        FROM vwTotalDate v
        LEFT JOIN attendance t 
            ON TO_CHAR(v.regdate, 'yyyy-mm-dd') = TO_CHAR(t.attendancedate, 'yyyy-mm-dd')
            AND t.studentseq = pstudentNum
        LEFT JOIN holiday h 
            ON TO_CHAR(v.regdate, 'yyyy-mm-dd') = TO_CHAR(h.holidaydate, 'yyyy-mm-dd')
        WHERE EXTRACT(YEAR FROM v.regdate) = pyear
          AND EXTRACT(MONTH FROM v.regdate) = pmonth
        ORDER BY v.regdate ASC;

BEGIN
    -- 교사 이름 
    SELECT teachername INTO vteacherName 
    FROM teacher 
    WHERE teacherseq = pteacherNum;

    DBMS_OUTPUT.PUT_LINE(vteacherName || ' 강사의 ' || pprocessNum || '번 과정 출석부');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('조회할 월 : ' || pyear || '년 ' || pmonth || '월 ');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- 학생 목록
    FOR student_rec IN student_cursor LOOP
        vstudentName := student_rec.studentname;
        DBMS_OUTPUT.PUT_LINE(vstudentName);

        -- 특정 학생의 출결
        OPEN attendance_cursor(student_rec.studentseq);
        
        LOOP
            FETCH attendance_cursor INTO vdate, vresult;
            EXIT WHEN attendance_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('  [' || TO_CHAR(vdate, 'YYYY-MM-DD') || '] ' || vresult);
        END LOOP;

        CLOSE attendance_cursor;
    END LOOP;
END;
/

-- 매개변수 : 교사번호,과정, 년
-- 호출문
BEGIN
    pAttendanceTeacherMonth(2,1,2024,7);
END;
/





-------------------------------------------------------------------------------------
--2-3. 2번 교사가 강의한 1번 과정의 날짜 입력시 모든 교육생의 출결
CREATE OR REPLACE PROCEDURE pAttendanceTeacherDate(
    pteacherNum IN teacher.teacherseq%TYPE,
    pprocessNum IN process.processseq%TYPE,
    pyear IN NUMBER,
    pmonth IN NUMBER,
    pdate IN NUMBER
)
IS
    vteacherName teacher.teachername%TYPE;
    vstudentName student.studentname%TYPE;
    vdate DATE;
    vresult VARCHAR2(50);
    
    -- 교육생 목록 조회를 위한 커서
    CURSOR student_cursor IS
        SELECT s.studentseq, s.studentname
        FROM student s
        JOIN studentcls sc ON s.studentseq = sc.studentseq
        WHERE sc.processseq = pprocessNum;
    
    -- 특정 교육생의 출결 조회를 위한 커서
    CURSOR attendance_cursor(pstudentNum student.studentseq%TYPE) IS
        SELECT 
            v.regdate AS "날짜",
            CASE
                WHEN TO_CHAR(v.regdate, 'd') = '1' THEN '일요일'
                WHEN TO_CHAR(v.regdate, 'd') = '7' THEN '토요일'
                WHEN h.holidayseq IS NOT NULL THEN h.holidayname
                WHEN h.holidayseq IS NULL AND t.attendanceseq IS NULL THEN '결석'
                ELSE t.attendancest
            END AS "상태"
        FROM vwTotalDate v
        LEFT JOIN attendance t 
            ON TO_CHAR(v.regdate, 'yyyy-mm-dd') = TO_CHAR(t.attendancedate, 'yyyy-mm-dd')
            AND t.studentseq = pstudentNum
        LEFT JOIN holiday h 
            ON TO_CHAR(v.regdate, 'yyyy-mm-dd') = TO_CHAR(h.holidaydate, 'yyyy-mm-dd')
        WHERE EXTRACT(YEAR FROM v.regdate) = pyear
          AND EXTRACT(MONTH FROM v.regdate) = pmonth
          AND EXTRACT(DAY FROM v.regdate) = pdate
        ORDER BY v.regdate ASC;

BEGIN
    -- 교사 이름 
    SELECT teachername INTO vteacherName 
    FROM teacher 
    WHERE teacherseq = pteacherNum;

    DBMS_OUTPUT.PUT_LINE(vteacherName || ' 강사의 ' || pprocessNum || '번 과정 출석부');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('조회할 날짜 : ' || pyear || '년 ' || pmonth || '월 ' || pdate || '일');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- 학생 목록
    FOR student_rec IN student_cursor LOOP
        vstudentName := student_rec.studentname;

        -- 특정 학생의 출결
        OPEN attendance_cursor(student_rec.studentseq);
        
        LOOP
            FETCH attendance_cursor INTO vdate, vresult;
            EXIT WHEN attendance_cursor%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE(vstudentName||' : '|| vresult);
        END LOOP;

        CLOSE attendance_cursor;
    END LOOP;
END;
/

-- 매개변수 : 교사번호,과정, 년, 월
-- 호출문
BEGIN
    pAttendanceTeacherDate(2,1,2024,7,24);
END;
/































