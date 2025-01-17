-- ex21_view.sql

/*

    View, 뷰
    - 데이터베이스 객체 중 하나(테이블, 제약사항, 시퀀스, 뷰..)
    - 가상 테이블, 뷰 테이블 등..
    
    CREATE [OR REPLACE] VIEW 뷰이름
    AS
    SELECT문;
    
*/
create or replace view vwInsa
as
select * from tblInsa;


select * from vwInsa;


-- 자주 반복 업무 > '영업부' + '서울' + '과장급 이상' > 명단 조회
create or replace view vwMy
as
select * from tblInsa
    where buseo = '영업부' and city = '서울' and jikwi in ('과장', '부장');


select * from vwMy;

-- 비디오 대여점 사장 > 날마다 하는 업무
create or replace view vwMy
as
select
    m.name as 회원,
    v.name as 비디오,
    r.rentdate as 언제,
    r.retdate as 반납,
    g.period as 대여기간,
    r.rentdate + g.period as 반납예정일,
    --floor(sysdate - (r.rentdate + g.period)) as 연체기간
    case
        when r.rentdate + g.period < r.retdate then '연체'
        when r.retdate is null then '미반납'
        else '정상반납'
    end as 상태,
    case
        when r.rentdate + g.period < r.retdate then to_char(floor(r.retdate - (r.rentdate + g.period)))
        when r.retdate is null then to_char(floor(sysdate - (r.rentdate + g.period)))
        else '없음'
    end as 연체기간,
    case
        when r.rentdate + g.period < r.retdate then to_char(floor(r.retdate - (r.rentdate + g.period)))
        when r.retdate is null then to_char(floor(sysdate - (r.rentdate + g.period)))
        else '없음'
    end as 연체료
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    inner join tblMember m
                        on m.seq = r.member;



-- 서울 직원 > 명단
create or replace view vwSeoul
as
select * from tblInsa where city = '서울';

-- 밑 두 문장은 같은 문장
-- 차이점 : 이름의 유무
select * from vwSeoul;  --이름이 있는 뷰, 재사용이 가능하다.
select * from tblInsa where city = '서울';    -- 이름이 없는 뷰, 일회성

delete from tblInsa where num = 1001;

-- 원본을 지우면 view도 같이 지워짐
-- view는 복사본이 아님,view는 메서드 처럼 이해하면 된다.
-- 자주 쓰는 쿼리를 줄인것

rollback;

/*
    뷰를 사용할때 주의할 점!!!
    1. select > 실행O > 뷰는 읽기전용 == 읽기전용 테이블
    2. insert > 경우에 따라 실행O > 절대 사용 금지!!!!!
    3. update > 경우에 따라 실행O > 절대 사용 금지!!!!!
    4. delete > 경우에 따라 실행O > 절대 사용 금지!!!!!

*/

create or replace view vwTodo
as
select * from tblTodo; --테이블 1개 > 단순뷰 (join, subquery등을 안씀)

select * from vwTodo
    order by seq;
    
insert into vwTodo(seq, title, adddate, completedate)
    values(21,'러닝뛰기',sysdate,null);
    
    



    
    
    
create or replace view vwSales
as
select
    c.name, s.item
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq; --테이블 2개 이상 사용 > 복합뷰

    
select * from vwsales;   --1. select

insert into vwSales(name,item)  --2.insert > 오류남, view가 전체가 아닌 name,item만 select했기 때문이다.
    values('호호호','맥북');




-- 신입 사원 > 담당업무 > 전직원에게 문자 메시지를 전송하는 업무 > 전직원의 연락처?
-- 데이터 베이스 로그인 > 계정 배정 > system(X), hr(O) > hr사용하세요~ > 민감 정보 다 보임 ㄷ ㄷ
-- 신입사원용 계정을 만들어야함 > hong > table정보 차단/열람 가능하지만 컬럼까지는 제어 못함 > view 만들어야함
select * from tblInsa;

create or replace view vwTel
as
select name, buseo, jikwi, tel from tblInsa;

select * from vwTel ; --신입사원은 vwtel만 접근 가능하도록 함, 골라서 보여줄수 있다.
