-- 조회 생성 수정 삭제



--1. 출결조회, 공휴일테이블

select * from vwDate;  --8월 한달 날짜
select * from tblDate; --8월 근태 기록

select * from vwDate v
    left outer join tblDate t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.regdate, 'yyyy-mm-dd')
            order by v.regdate asc;



select 
    v.regdate,
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when h.seq is not null then h.name
        when h.seq is null and t.seq is null then '결석'
        else t.state
    end as state
from vwDate v
    left outer join tblDate t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.regdate, 'yyyy-mm-dd')
            left outer join tblHoliday h
                on to_char(v.regdate, 'yyyy-mm-dd') = to_char(h.regdate, 'yyyy-mm-dd')
                    order by v.regdate asc;
            
            