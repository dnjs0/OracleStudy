--업무pl.sql
set serverout on;

/*  공휴일  */

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

select * from student;


/* D-01 교육생 로그인 기능 */
CREATE OR REPLACE PROCEDURE pStudentLogin(
    pstudentNum in STUDENT.studentseq%type,
    pstudentPW in STUDENT.studentpw%type
)
IS
[   변수 선언;
    커서 선언;]
BEGIN
    구현부;
[EXCEPTION
    예외 처리;]
END;

-- 호출문의 매개변수 : 학생 번호, 학생 비밀번호
BEGIN
    pStudentLogin(1,2345678);
END;
/


select
    s.studentname as "학생 이름",
    s. studentpw as "비밀번호",
    s.studenttel as "학생의 전화번호",
    s.studentdate as "학생의 등록일",
    c.coursename as "과정명",
    p.processsdate as "과정 시작일",
    p.processedate as "과정 종료일",
    cr.clsroomname as "강의실"
from student s
    inner join studentcls sc
        on s.studentseq = sc.studentseq
            inner join process p
                on sc.processseq = p.processseq
                    inner join course c
                        on c.courseseq = p.courseseq
                            inner join clsroom cr
                                on cr.clsroomseq = p.clsroomseq
                                    where s.studentseq=1;
                    


/* D-04 교육생 출결조회 기능 */
--날짜의 뷰 먼저 생성
create or replace view vwTotalDate
as
select
    to_date('2024-07-03', 'yyyy-mm-dd') + level - 1 as regdate
from dual
    connect by level <= (to_date('2025-08-24', 'yyyy-mm-dd')
                            - to_date('2024-07-03', 'yyyy-mm-dd') + 1);
                                                        


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

/* C-05. 출결 관리 및 출결 조회 */
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































