--교육생 업무


/* D-01 교육생 로그인 기능 */
/* 조회 */
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
                    
                    


/* D-02 교육생 개인성적정보 확인기능 */
/* 조회 */
select * from subject;
select * from course;
select * from process;
select * from prcsubject;
select * from book;
select * from sbjectBook;
select * from teacher;
select * from tsubject;
select * from scoreallot;
select * from test;
select * from tsubject where teacherseq =6;
select * from test where teacherseq =6;
select * from studentcls where studentseq=27;

select * from tsubject ts inner join test t on t.teacherseq=ts.teacherseq where t.teacherseq = 6;

select * from score where studentseq=27;

WITH student_test AS (
    SELECT 
        test.subjectseq, 
        test.testtype, 
        test.testdate, 
        test.testcontext,
        ROW_NUMBER() OVER (PARTITION BY test.subjectseq ORDER BY test.testdate DESC) AS rn
    FROM test
)
select distinct
    pc.subjectseq as "과목 번호",
    s.subjectname as "과목 이름",
    pc.prcsubjectsdate as "과목 시작 날짜",
    pc.prcsubjectedate as "과목 종료 날짜",
    b.bookname as "교재명",
    t.teachername as "교사명",
    sa.attendallot as "출석 배점" ,
    sa.writingallot as "필기 배점" ,
    sa.realallot as "실기 배점" ,
    score.attendancescore as "출석 점수",
    score.writingscore as "필기 점수",
    score.realscore as "실기 점수",
    score.totalscore as "총 점수",
    test.testtype as "시험 종류",
    test.testdate as "시험 날짜",
    test.testcontext as "시험 문제"
from prcsubject pc
    inner join process p
        on p.processseq = pc.processseq
            inner join subject s
                on s.subjectseq = pc.subjectseq
                    inner join sbjectBook sb
                        on sb.subjectseq = pc.subjectseq
                            inner join book b
                                on b.bookseq = sb.bookseq
                                    inner join teacher t
                                        on t.teacherseq = p.teacherseq
                                            inner join scoreallot sa
                                                on sa.prcsubjectseq = pc.prcsubjectseq 
                                                    inner join test
                                                        on test.subjectseq = pc.subjectseq
                                                            inner join studentcls scl
                                                                on scl.processseq = p.processseq
                                                                    inner join score
                                                                        on scl.studentseq=score.studentseq
                                                                            where t.teacherseq=1 and p.processseq=2 and scl.studentseq = 27
                                                                                order by pc.prcsubjectsdate;







-- 중복 없앤것
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
WHERE t.teacherseq = 1 
  AND p.processseq = 2 
  AND scl.studentseq = 27
  AND test.testdate = (
      SELECT min(testdate) 
      FROM test t2 
      WHERE t2.subjectseq = test.subjectseq
  )
ORDER BY pc.prcsubjectsdate;





-----------------------------------------------------------------------------------
--다시해보기
-------------------------------------------------------------------------------------
select * from subject; --과목번호
select * from prcsubject; --과정번호(2), 과목번호, 과목시작,끝시간
select * from prcsubject where processseq =2; --1~11
select * from process;-- 과정번호, 교사번호
select * from book; -- 교재번호, 교재이름
select * from sbjectbook;-- 과목번호, 교재번호
select * from teacher; --교사이름, 교사번호 (process)
select * from test;--교사번호
select * from scoreallot where teacherseq=1;
select * from score where studentseq=27;
select processseq from studentcls where studentseq=27; -- 과정번호 2가 나옴
select teacherseq from process where processseq = (select processseq from studentcls where studentseq=27);-- 교사번호1가 나옴
select * from process;


select * from scoreallot sa inner join prcsubject pc on sa.prcsubjectseq=pc.prcsubjectseq where teacherseq=1;
select * from scoreallot;
select * from test where teacherseq=1;
select * from score where studentseq=27;
select * from score;

-- 학생 번호가 27

select 
    pc.subjectseq as 과목번호,
    sj.subjectname as 과목명,
    pc.prcsubjectsdate||' ~ '||pc.prcsubjectedate as "시작날짜 ~ 종료날짜",
    b.bookname as 교재명,
    t.teachername as 교사명,
    sa.attendallot as 출석배점,
    sa.writingallot as 필기배점,
    sa.realallot as 실기배점 ,
    test.testseq,
    score.writingscore as 필기점수,
    score.realscore as 실기점수,
    score.attendancescore as 출석점수,
    score.totalscore as 총점수,
    test.testtype as 시험유형,
    test.testdate as 시험날짜,
    test.testcontext as 시험문제
from prcsubject pc
    inner join subject sj on sj.subjectseq = pc.subjectseq
    inner join sbjectbook sb on sb.subjectseq = pc.subjectseq
    inner join book b on b.bookseq = sb.bookseq
    inner join process p on p.processseq = pc.processseq
    inner join teacher t on t.teacherseq = p.teacherseq
    inner join scoreallot sa  on sa.prcsubjectseq=pc.prcsubjectseq
    inner join test on test.teacherseq = t.teacherseq and pc.subjectseq=test.subjectseq
    inner join studentcls scl on scl.processseq = p.processseq
    inner join student st on st.studentseq =scl.studentseq
    inner join score on score.subjectseq=pc.subjectseq and score.studentseq = st.studentseq
where st.studentseq=27 
    and pc.processseq=(select processseq from studentcls where studentseq=27) --과정번호 1임
    and test.teacherseq=(select teacherseq from process where processseq = (select processseq from studentcls where studentseq=27));-- 교사번호가 1임

select * from subject;


select * 
from test 
inner join teacher t on  test.teacherseq = t.teacherseq
    where test.teacherseq=(select teacherseq from process where processseq = (select processseq from studentcls where studentseq=27));                                    

select * from prcsubject where processseq=2;
select * from test where teacherseq=1;



SELECT 
    pc.*,  -- prcsubject의 모든 컬럼
    t.*    -- teacher의 모든 컬럼
FROM prcsubject pc
INNER JOIN teacher t ON t.teacherseq = (
    SELECT teacherseq FROM process WHERE processseq = pc.processseq
)
WHERE pc.processseq = 2;




select * 
from test 
inner join prcsubject pc on pc.subjectseq=test.subjectseq 
where test.teacherseq=1 and pc.processseq=2; 














                                            
/* D-03 교육생 출결관리 기능 */
/* 조회 */

select * from attendance;

select 
    attendanceseq as "번호",
    attendancedate as "날짜",
    TO_char(attendancestime, 'HH24:MI') as "등원 시간",
    to_char(attendanceetime, 'HH24:MI') as "하원 시간"
from attendance
where studentseq=1;


/* 등원 추가 */
INSERT INTO attendance 
VALUES (
    attendance_seq.nextval, 
    1, 
    TRUNC(SYSDATE),  -- 날짜 (시간 00:00:00 초기화)
    SYSDATE,         -- 현재 시간으로 출근 기록
    NULL,            -- 퇴근 시간은 아직 없음
    '출석'
);


/* 수업종료 */
UPDATE attendance
SET attendanceetime = SYSDATE,   -- 현재 시간으로 퇴근 기록
    attendancest = '정상'       -- 상태 변경
WHERE studentseq = 1 
  AND attendancedate = TRUNC(SYSDATE)  -- 오늘 날짜의 출석 기록만 수정
  AND attendanceetime IS NULL;      -- 아직 퇴근 기록이 없는 경우


                          

/* D-04 교육생 출결조회 기능 */
/* 다닌날 전체 조회 */
create or replace view vwTotalDate
as
select
    to_date('2024-07-03', 'yyyy-mm-dd') + level - 1 as regdate
from dual
    connect by level <= (to_date('2025-01-03', 'yyyy-mm-dd')
                            - to_date('2024-07-03', 'yyyy-mm-dd') + 1);

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
            left outer join holiday h
                on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.holidaydate, 'yyyy-mm-dd')
                    order by v.regdate asc;

                       
/*7월 조회*/
create or replace view vwMonth
as
select
    to_date('2024-07-03', 'yyyy-mm-dd') + level - 1 as regdate
from dual
    connect by level <= (to_date('2024-07-31', 'yyyy-mm-dd')
                            - to_date('2024-07-03', 'yyyy-mm-dd') + 1);

select 
    v.regdate as "날짜",
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when h.holidayseq is not null then h.holidayname
        when h.holidayseq is null and t.attendanceseq is null then '결석'
        else t.attendancest
    end as "상태"
from vwMonth v
    left outer join attendance t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.attendancedate, 'yyyy-mm-dd')
            left outer join holiday h
                on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.holidaydate, 'yyyy-mm-dd')
                    order by v.regdate asc;              
                    
                    
                    
/* 특정 날짜 조회 */
create or replace view vwDate
as
select
    to_date('2024-07-03', 'yyyy-mm-dd') regdate
from dual;

select s
    v.regdate as "날짜",
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when h.holidayseq is not null then h.holidayname
        when h.holidayseq is null and t.attendanceseq is null then '결석'
        else t.attendancest
    end as "상태"
from vwDate v
    left outer join attendance t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.attendancedate, 'yyyy-mm-dd')
            left outer join holiday h
                on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.holidaydate, 'yyyy-mm-dd')
                    order by v.regdate asc;   