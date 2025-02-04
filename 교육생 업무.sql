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

                                            
                                            
/* D-03 교육생 출결관리 기능 */
/* 조회 */

select * from attendance;

select 
    attendanceseq as "번호",
    attendancedate as "날짜",
    TO_char(attendancestime, 'HH24:MI') as "등원 시간",
    to_char(attendanceetime, 'HH24:MI') as "하원 시간",
    attendancest as "상태"
from attendance
where studentseq=1;

/* 추가 */
INSERT INTO attendance 
VALUES (attendance_seq.nextval, 1, sysdate, TO_DATE('09:00', 'HH24:MI'), TO_DATE('18:00', 'HH24:MI'), '정상');

                          

/* D-04 교육생 출결조회 기능 */
/*조회*/
create or replace view vwDate
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
from vwDate v
    left outer join attendance t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.attendancedate, 'yyyy-mm-dd')
            left outer join holiday h
                on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.holidaydate, 'yyyy-mm-dd')
                    order by v.regdate asc;

                                                                                        