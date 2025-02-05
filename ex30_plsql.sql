-- ex30_plsql.sql
/*

    1. ANSI-SQL
    2. 설계
    3. PL/SQL
    
    PL/SQL
    - Procedural Language for SQL
    - Procedural Language extension to SQL
    - 표준 SQL + 절차 지향 언어의 기능을 추가(변수, 제어 흐름, 객체 정의 등)
    
    
    프로시저, Procedure
    - 메서드, 함수 등
    - 순서가 있는 명령어의 집합
    - 모든 PL/SQL 구문은 프로시저내에서만 작성/동작이 가능하다.
    - 작업(코드) 영역 = 표준 SQL 영역 + 프로시저(PL/SQL) 영역
    
    1. 익명 프로시저
        - 1회용 코드 작성
    
    2. 저장(실명) 프로시저
        - 저장 & 재사용
        - 데이터베이스 객체(create, drop)
    
    
    PL/SQL 프로시저 구조
    - 4개의 블럭(파트)으로 구성
        a. DECLARE
        b. BEGIN
        c. EXCEPTION
        d. END
    
    1. DECLARE
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략 가능
    
    2. BEGIN({) ~ 4.END(})
        - 구현부
        - 구현된 코드를 가지는 영역(=메서드의 body 영역)
        - 생략 불가능
        - 구현된 코드? > 표준 SQL(DDL,DML,DCL) + PL/SQL(연산, 제어 등)

    3. EXCEPTION
        - 예외 처리부
        - 자바의 catch절
        - 평소에는 실행(X) > 에러가 발생했을 때(O)
        - 생략 가능

    
    익명 프로시저 구문
    
    [DECLARE
        변수 선언;
        객체 선언;]
    BEGIN
        업무 코드(제어문);
        업무 코드(표준 SQL);
    [EXCEPTION
        예외처리 코드;]
    END;
    
    
    PL/SQL 자료형
    - 표준 SQL과 동일
    
    PL/SQL 연산자
    - 표준 SQL과 동일
    
    
    변수 선언하기
    - 변수명 자료형(길이) [NOT NULL] [DEFAULT 값];
    
*/

-- 지금 이 영역이 표준 SQL 영역
select * from tabs;

-- dbms_output.put_line() 함수는 평상 시에는 결과가 눈에 안보임
-- 로그인할 때마다 실행
set serveroutput on;
set serverout on;
set serveroutput off;

begin
    -- PL/SQL 영역
    dbms_output.put_line('Hello~'); --System.out.println();
end;
/

begin
    dbms_output.put_line('Hi!!');
end;
/



declare
    num number;
    name varchar2(30);
    today date;
begin

    num := 10;
    dbms_output.put_line(num);
    
    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    today := to_date('2025-01-01', 'yyyy-mm-dd');
    dbms_output.put_line(today);
    
end;
/


declare
    num1 number; --null 상태
    num2 number;
    num3 number := 30;
    num4 number default 40;
    num5 number not null := 50; --선언과 동시에 초기화(not null)
begin
    dbms_output.put_line('@' || num1 || '@'); --null  출력
    
    num2 := 10;
    dbms_output.put_line(num2);
    
    dbms_output.put_line(num3);
    
    num4 := 400;
    num4 := null;
    --num4 := default;
    dbms_output.put_line(num4);
    
    --PLS-00218: NOT NULL로 정의된 변수는 초기치를 할당하여야 합니다
    num5 := 500;
    --num5 := null;
    dbms_output.put_line(num5);
    
end;
/


/*
    
    변수 > 어떤 용도로 사용?
    - 일반적인 값을 저장하는 용도 > 비중 낮음
    - select 결과를 저장하는 용도 > 비중 높음
    
    select 결과 > (대입) > PL/SQL 변수
    - select into 절(PL/SQL)
    
*/

--*** 중요!!!
declare
    vbuseo varchar2(15);
begin
    
    --buseo := (select buseo from tblInsa where name = '홍길동');
    
    select buseo into vbuseo from tblInsa where name = '한석봉'; --표준 SQL
    
    dbms_output.put_line(vbuseo);
    --dbms_output.put_line(buseo);
    
    -- tblTodo 할일 등록하기
    insert into tblTodo (seq, title, adddate, completedate)
        values ((select max(seq) + 1 from tblTodo)
                    , vbuseo || '에 택배 보내기', sysdate, null);
    
end;
/

select * from tblTodo;



-- tblInsa > 성과급을 받는 직원 내역
create table tblBonus (
    name varchar2(15)
);

-- 1. 개발부 + 부장 > select > name?
-- 2. tblBonus > insert
declare
    vname varchar2(15);
begin
    --1.
    select name into vname from tblInsa where buseo = '개발부' and jikwi = '부장';
    --2.
    insert into tblBonus (name) values (vname);
end;
/


insert into tblBonus (name) 
    values ((select name from tblInsa where buseo = '개발부' and jikwi = '부장'));

select * from tblBonus;

desc tblInsa;

-- select into절 > 여러 컬럼 가져오기
declare
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number;
begin
--    select 
--        name into vname, 
--        buseo into vbuseo, 
--        jikwi into vjikwi, 
--        basicpay into vbasicpay 
--    from tblInsa where num = 1001;
    
    -- into 사용 시
    -- 1. 컬럼의 개수와 변수의 개수 동일
    -- 2. 컬럼의 순서와 변수의 순서 동일
    -- 3. 컬럼과 변수의 자료형(길이) 동일
    
    select 
        name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay
    from tblInsa where num = 1001;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    
end;
/





/*

    타입 참조
    - 테이블 컬럼 자료형을 참조 > PL/SQL 변수의 자료형 활용
    
    1. %type
        - 컬럼 참조
        - 사용하는 테이블의 특정 컬럼의 스키마를 알아내서 변수에 적용
        - 안정성 확보
        - 복사되는 정보
            a. 자료형
            b. 길이
            c. not null or 제약사항 > 복사(X)
    
    2. %rowtype
        - 행 참조
        - 모든 컬럼을 참조
        - 배열 역할

*/
declare
    --vbuseo varchar2(30);
    vbuseo tblInsa.buseo%type;
begin
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
end;
/


declare
    vname       tblInsa.name%type;
    vbuseo      tblInsa.buseo%type;
    vjikwi      tblInsa.jikwi%type;
    vbasicpay   tblInsa.basicpay%type;
begin

    select 
        name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay
    from tblInsa where num = 1001;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    
end;
/


drop table tblBonus;

create table tblBonus (
    seq number primary key,
    num number(5) not null references tblInsa(num), --직원번호(FK)
    bonus number not null
);

create sequence seqBonus;


-- 프로시저 선언
-- 1. 서울 + 부장 + 영업부
-- 2. tblBonus > 지급 > 보너스(급여 * 1.5)
declare
    vnum        tblInsa.num%type;
    vbasicpay   tblInsa.basicpay%type;
begin
    select 
        num, basicpay into vnum, vbasicpay
    from tblInsa
        where city = '서울' and jikwi = '부장' and buseo = '영업부';
        
    insert into tblBonus (seq, num, bonus)
        values (seqBonus.nextVal, vnum, vbasicpay * 1.5);
end;
/

select * from tblBonus; --1	1023 3750000

-- 보너스 지급 내역 페이지
select
    i.name,
    i.city,
    i.buseo,
    i.jikwi,
    i.basicpay,
    b.bonus
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;


commit;
rollback;

select * from tblMen;
select * from tblWomen;

-- 무명씨 > 성전환 수술 > tblMen > tblWomen 옮기기 > 프로시저 제작!!
-- 1. '무명씨' > select * from tblMen
-- 2. 1 결과 > tblWomen > insert
-- 3. tblMen > delete
declare
    vname   tblMen.name%type;
    vage    tblMen.age%type;
    vheight tblMen.height%type;
    vweight tblMen.weight%type;
    vcouple tblMen.couple%type;
begin
    --1.
    select
        name, age, height, weight, couple
        into
        vname, vage, vheight, vweight, vcouple
    from tblMen
        where name = '무명씨';
    
    --2.
    insert into tblWomen (name, age, height, weight, couple)
        values (vname, vage, vheight, vweight, vcouple);
    
    --3.
    delete from tblMen where name = vname;
    
end;
/


declare
--    vname   tblMen.name%type;
--    vage    tblMen.age%type;
--    vheight tblMen.height%type;
--    vweight tblMen.weight%type;
--    vcouple tblMen.couple%type;
    vrow tblMen%rowtype; --변수 5개 분량
begin
    --1.
    select * into vrow
    from tblMen
        where name = '무명씨';
    
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.age);
    dbms_output.put_line(vrow.height);
    
    
    --2.
    insert into tblWomen (name, age, height, weight, couple)
        values (vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);
    
    --3.
    delete from tblMen where name = vrow.name;
    
end;
/

/*

    제어문
    1. 조건문
    2. 반복문
    3. 분기문

*/

--if문
declare
    vnum number := 10;
begin
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    end if;
    
end;
/


declare
    vnum number := -10;
begin
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    else
        dbms_output.put_line('양수 아님');
    end if;
    
end;
/

declare
    vnum number := 0;
begin
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum < 0 then --else if, elsif, elseif 등..
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('0입니다.');
    end if;
    
end;
/


-- tblInsa. 직원 지정(num) > 남자 or 여자 > 각각에 따른 업무 진행
declare
    vgender char(1);
begin
    
    select substr(ssn, 8, 1) into vgender from tblInsa where num = 1015;
    
    if vgender = '1' then
        dbms_output.put_line('남자 업무를 진행합니다.');
    elsif vgender = '2' then
        dbms_output.put_line('여자 업무를 진행합니다.');
    end if;
    
end;
/


-- 문제
-- 직원 1명 선택(num) > 보너스(tblBonus) 지급 > 차등 지급
-- a. 과장/부장 > basicpay * 1.5
-- b. 사원/대리 > basicpay * 2
declare
    vnum        tblInsa.num%type; 
    vbasicpay   tblInsa.basicpay%type;
    vjikwi      tblInsa.jikwi%type;
    vbonus      number;
begin

    -- num, basicpay, jikwi
    select num, basicpay, jikwi into vnum, vbasicpay, vjikwi from tblInsa where num = 1002;
    
    if vjikwi = '과장' or vjikwi = '부장' then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in ('사원', '대리') then
        vbonus := vbasicpay * 2;
    end if;
    
    insert into tblBonus values (seqBonus.nextVal, vnum, vbonus);
    
end;
/

-- 보너스 지급 내역 페이지
select
    i.name,
    i.city,
    i.buseo,
    i.jikwi,
    i.basicpay,
    b.bonus
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;

select * from tblInsa;



/*

    case문
    - 표준 SQL > PL/SQL에도 동일하게 제공

*/

-- AS > 아시아
declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin
    select continent into vcontinent from tblCountry where name = '대한민국';
    
    case
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
    case vcontinent
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
end;
/



/*

    PL/SQL
    - 프로시저(declare, begin, exception, end)
    - 자료형 참조(%type, %rowtype)
    - 제어문(if, case)
    
    
    반복문
    
    1. loop
    - 기본형
    - 단순 반복(무한)
    - 탈출 > exit when 조건
        
    2. for loop
    - 1번 기반 > 확장
    
    3. while loop
    - 1번 기반 > 확장
    
*/
set serveroutput on;

begin
    loop
        dbms_output.put_line('구현부' || to_char(sysdate, 'hh24:mi:ss'));
    end loop;
end;
/



declare
    vnum number := 1; --루프 변수
begin
    loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
        
        exit when vnum > 10;        
    end loop;
end;
/


create table tblLoop (
    seq number primary key,
    data varchar2(100) not null
);

create sequence seqLoop;

-- tblLoop > 데이터 > 항목001, 항목002, 항목003.. 항목999
declare
    vnum number := 1;
begin
    loop
        dbms_output.put_line(lpad(vnum, 3, '0'));
        
        insert into tblLoop
            values (seqLoop.nextVal, '항목' || lpad(vnum, 3, '0'));
        
        vnum := vnum + 1;        
        exit when vnum > 999;
        
    end loop;
end;
/

select * from tblLoop order by seq;


/*

    2. for loop
    
    for (int n : list) {
    
    }
    
    for (int n in list) {
    
    }
    
    for i in 집합 loop
    
    end loop
    
*/
begin
    for i in 1..10 loop
        dbms_output.put_line(i);
    end loop;
end;
/

-- 구구단
-- 복합키(Composite key) : 컬럼 수준 정의 불가, 테이블 수준 or 외부 선언 가능
create table tblGugudan (
    dan number not null,
    num number not null,
    result number not null,
    constraint tblgugudan_dan_num_pk primary key(dan, num)
);

insert into tblGugudan values (1, 1, 1);
insert into tblGugudan values (1, 2, 2);
insert into tblGugudan values (1, 3, 3);
insert into tblGugudan values (3, 1, 3);
insert into tblGugudan values (1, 1, 3);

delete from tblGugudan;

begin
    for i in 2..9 loop
        for j in 1..9 loop
            insert into tblGugudan (dan, num, result)
                values (i, j, i*j);
        end loop;
    end loop;
end;
/

select * from tblGugudan order by dan, num;


-- 복합키 > 관계 맺기
-- 학생 + 성적
create table tblStudent (
    name varchar2(30) not null,
    subject varchar2(30) not null,
    tel varchar2(15) not null,
    constraint tblstudent_name_suject_pk primary key(name, subject)
);

insert into tblStudent (name, subject, tel)
    values ('홍길동', '자바', '010-1234-5678');

insert into tblStudent (name, subject, tel)
    values ('홍길동', '오라클', '010-1234-5678');   

insert into tblStudent (name, subject, tel)
    values ('홍길동', 'HTML', '010-1234-5678');       
    
insert into tblStudent (name, subject, tel)
    values ('아무개', '자바', '010-1234-5555');

insert into tblStudent (name, subject, tel)
    values ('아무개', 'CSS', '010-1234-5555');

select * from tblStudent;

create table tblScore (
    score number not null,
    name varchar2(30) not null,     --PK,FK
    subject varchar2(30) not null,  --PK,FK
    constraint tblscore_name_subject_fk 
        foreign key(name, subject) references tblStudent(name, subject),
    constraint tblscore_name_subject_pk
        primary key(name, subject)
);

insert into tblScore (score, name, subject) values (100, '홍길동', '자바');
insert into tblScore (score, name, subject) values (90, '홍길동', '오라클');
insert into tblScore (score, name, subject) values (80, '홍길동', 'HTML');

insert into tblScore (score, name, subject) values (95, '아무개', '자바');
insert into tblScore (score, name, subject) values (75, '아무개', 'CSS');

select * from tblScore;

-- join
select
    st.name as 학생명,
    st.subject as 과목명,
    sc.score as 점수
from tblStudent st
    inner join tblScore sc
        --on 부모.pk = 자식.fk
        on st.name = sc.name and st.subject = sc.subject;


begin
    for i in reverse 1..10 loop
        dbms_output.put_line(i);
    end loop;
end;
/

/*
    3. while loop    
*/
declare
    vnum number := 1;
begin
    while vnum <= 10 loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
    end loop;
end;
/



-- select into 절의 결과값이 없으면 에러 발생!!!
declare
    vnum number := 1101;
    vname tblInsa.name%type;
    vbasicpay tblInsa.basicpay%type;
    vcnt number;
begin

    select count(*) into vcnt from tblInsa where num = vnum; --1, 0

    if vcnt > 0 then
        select name, basicpay into vname, vbasicpay from tblInsa where num = vnum;
        
        dbms_output.put_line(vname);
        dbms_output.put_line(vbasicpay);    
    end if;
    
end;
/




-- 루프 사용? 
-- 1. 반복 업무
-- 2. select > 결과셋 레코드 N개 > 탐색


/*

    select > 결과셋 > PL/SQL 변수에 대입
    
    1. select into
    - 결과셋의 레코드가 1개일때만 사용이 가능하다.
    - 2개 이상? 에러 발생!!
    - 0개? 에러 발생!!
    
    2. cursor + 루프
    - 결과셋의 레코드가 N개일때 사용이 가능하다.(0~이상)
    
    declare
        변수 선언;
        커서 선언; --결과셋 참조 객체
    begin
        커서 열기;
            loop
                커서 참조 > 레코드 접근
                exit when 조건;
            end loop;
        커서 닫기;
    end;
    
*/

-- tblInsa. 직원들 이름을 가져오시오.(60명)
declare
    vname tblInsa.name%type;
begin
    select name into vname from tblInsa;
    dbms_output.put_line(vname);
end;
/

--create view vwTest
--as
--select name from tblInsa;
--
--cursor vcursor
--is
--select name from tblInsa;

set serveroutput on;
select name from tblInsa;
rollback;


declare
    vname tblInsa.name%type;
    
    -- cursor 커서명 is select문;
    cursor vcursor
    is
    select name from tblInsa;
begin

    --커서 사용 > 결과셋 탐색
    
    open vcursor; --커서 열기 > select문 실행 > 결과셋 생성 + 커서 참조
    
        /*
        -- fetch 커서 into 변수
        -- select 컬럼 into 변수
        fetch vcursor into vname;
        dbms_output.put_line(vname);
        
        --dbms_output.put_line(vcursor%notfound); --커서 속성
        case
            when vcursor%notfound then dbms_output.put_line('데이터 없음');
            else dbms_output.put_line('데이터 있음');
        end case;
        
        fetch vcursor into vname;
        dbms_output.put_line(vname);
        
        case
            when vcursor%notfound then dbms_output.put_line('데이터 없음');
            else dbms_output.put_line('데이터 있음');
        end case;
        
        fetch vcursor into vname;
        dbms_output.put_line(vname);
        
        case
            when vcursor%notfound then dbms_output.put_line('데이터 없음');
            else dbms_output.put_line('데이터 있음');
        end case;
        
        fetch vcursor into vname;
        dbms_output.put_line(vname);
        
        case
            when vcursor%notfound then dbms_output.put_line('데이터 없음');
            else dbms_output.put_line('데이터 있음');
        end case;
        
        fetch vcursor into vname;
        dbms_output.put_line(vname);
        */
        
        loop
            fetch vcursor into vname;
            exit when vcursor%notfound;
            
            dbms_output.put_line(vname);        
        end loop;    
        
    close vcursor;

end;
/


-- '기획부' > 이름, 직위, 급여 > 출력
declare
    
    cursor vcursor
    is
    select name, jikwi, basicpay from tblInsa where buseo = '기획부';
    
    vname       tblInsa.name%type;
    vjikwi      tblInsa.jikwi%type;
    vbasicpay   tblInsa.basicpay%type;
    
begin
    
    open vcursor;
    loop    
        fetch vcursor into vname, vjikwi, vbasicpay;
        exit when vcursor%notfound;
        
        --1회전 > 기획부 직원 1명
        dbms_output.put_line(vname || ',' || vjikwi || ',' || vbasicpay);
        
    end loop;
    close vcursor;
    
end;
/

-- 문제. tblBonus
-- 1. 모든 직원에게 보너스 지급(60명 전원)
-- 2. 과장/부장(급여 1.5배), 사원/대리(급여 2배)

-- 어떤 select를 cursor로 정의할지?
declare
    cursor vcursor
    is
    select num, jikwi, basicpay from tblInsa;
    
    vnum        tblInsa.num%type;
    vjikwi      tblInsa.jikwi%type;
    vbasicpay   tblInsa.basicpay%type;
    vbonus      number;
    
begin
    open vcursor;
    loop
    
        fetch vcursor into vnum, vjikwi, vbasicpay;
        exit when vcursor%notfound;
        
        if vjikwi in ('사원', '대리') then
            vbonus := vbasicpay * 2;
        elsif vjikwi in ('과장', '부장') then
            vbonus := vbasicpay * 1.5;
        end if;
        
        insert into tblBonus values (seqBonus.nextVal, vnum, vbonus);
        
    end loop;
    close vcursor;
end;
/
-- 보너스 지급 내역 페이지
select
    i.name,
    i.city,
    i.buseo,
    i.jikwi,
    i.basicpay,
    b.bonus
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;



-- 커서 탐색
-- 1. 커서(fetch) + loop > 기본형
-- 2. 커서 + for loop > 간단한 버전

-- 60명 직원 정보(모든 컬럼) 출력
declare
    cursor vcursor is select * from tblInsa;
    vrow tblInsa%rowtype;
begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
        
    end loop;
    close vcursor;
end;
/

declare
    cursor vcursor is select * from tblInsa;
begin
    for vrow in vcursor loop        
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
    end loop;
end;
/


-- 예외처리
declare
    vcnt number;
    vname tblInsa.name%type;
begin
    
    select count(*) into vcnt from tblInsa where buseo = '기획부';
    dbms_output.put_line(100000000 / vcnt);
    
    
    select name into vname from tblInsa where num = 1100;
    dbms_output.put_line(vname);
    
    
    dbms_output.put_line('또 다른 업무');

exception

    when NO_DATA_FOUND then
        dbms_output.put_line('데이터가 없습니다.');

    when ZERO_DIVIDE then
        dbms_output.put_line('0으로 나누기');

    when others then
        dbms_output.put_line('예외 처리');
    
end;
/



------------------------------------------


/*

    프로시저
    1. 익명 프로시저
    2. 실명 프로시저
    
    
    저장 프로시저, Stored Procedure
    1. 저장 프로시저, Stored Procedure
        - 매개변수 / 반환값 > 구성 자유
    
    2. 저장 함수, Stored Function
        - 매개변수 / 반환값 > 필수
    
    
    익명 프로시저 선언
    [DECLARE
        변수 선언;
        커서 선언;]
    BEGIN
        구현부;
    [EXCEPTION
        예외 처리;]
    END;
    
    저장 프로시저 선언
    
    CREATE [OR REPLACE] PROCEDURE 프로시저명
    IS(AS)
    [   변수 선언;
        커서 선언;]
    BEGIN
        구현부;
    [EXCEPTION
        예외 처리;]
    END;
    
*/

create or replace procedure procTest
is
    vnum number;
begin
    vnum := 10;
    dbms_output.put_line(vnum);
end procTest;
/

-- 프로시저 호출 구문 = PL/SQL
begin
    procTest();
end;
/

-- 표준 SQL 영역에서 프로시저 호출하는 방법 > 자바와 연동할 때 사용
execute procTest();
execute procTest;
exec procTest;
call procTest();
--call procTest;


/*

    [SQL 명령어가 실행되는 전체 과정]
    1. 직접 SQL 실행 > 표준 SQL(~ex29) > 텍스트 SQL
    2. 익명 프로시저 실행
    ------------------------------------------------
    3. 저장 프로시저 실행
    

    1+2
    a. SQL Developer > 구문을 작성한다.(코딩)
    b. 영역을 선택한다. > Ctrl + Enter > 텍스트가 오라클 서버에게 전송한다. > SQL 실행(X)
    c. 오라클 서버가 b를 수신한다.
    d. 수신한 SQL을 파싱한다.(구문을 쪼개고 분석한다. > 문법 검사)
    e. SQL을 컴파일한다.(인터프리터) > 기계어
    f. SQL을 실행한다.
    g. 결과셋을 생성한다.(서버 메모리에)
    h. 결과셋을 클라이언트에게 반환한다.
    i. 반환받은 결과셋 > 화면에 출력한다.
    
    - 동일한 SQL을 또 실행 > 동일한 비용 발생!!!
    
    
    3
    a. SQL Developer > 프로시저 선언문(호출X)을 작성한다.(코딩)
    b. 영역을 선택한다. > Ctrl + Enter > 텍스트가 오라클 서버에게 전송한다. > SQL 실행(X)
    c. 오라클 서버가 b를 수신한다.
    d. 수신한 SQL을 파싱한다.(구문을 쪼개고 분석한다. > 문법 검사)
    e. SQL을 컴파일한다.(인터프리터) > 기계어
    f. SQL을 실행한다.
    g. 오라클 서버에 프로시저를 생성한다.(+저장)
    h. 생성 완료 메시지를 클라이언트에게 반환한다.
    
    a. SQL Developer > 프로시저 호출문을 작성한다.(코딩)
    b. 영역을 선택한다. > Ctrl + Enter > 텍스트가 오라클 서버에게 전송한다. > SQL 실행(X)
    c. 오라클 서버가 b를 수신한다.
    d. 수신한 SQL을 파싱한다.(구문을 쪼개고 분석한다. > 문법 검사)
    e. SQL을 컴파일한다.(인터프리터) > 기계어
    f. SQL을 실행한다.
    g. 저장된 프로시저를 찾아서 호출한다.(***) > 프로시저는 이미 컴파일 + 저장
    h. 결과를 반환한다.
    i. SQL Developer > 결과를 처리한다.
    
    - 동일한 구문 호출 > 컴파일이된 프로시저 사용
        1. 생산 비용 + 컴파일(저장) > 고가
        2. 사용 비용 > 저렴 > 반복(*****)
    - 저장된 객체 > 관리 비용 발생 > 사람이 관리 비용 발생(권한 or 네이밍)
                                    > 유비 보수 난이도 높음
    
*/

select * from tblInsa;


-- 저장 프로시저 > 매개변수 or 반환값

-- 1. 매개변수가 있는 프로시저
create or replace procedure procTest(pnum number) --매개변수
is
    vnum number; --일반변수
begin
    
    vnum := pnum * 2;
    dbms_output.put_line(vnum);
    
end procTest;
/

begin
    procTest(10);
    procTest(20);
    procTest(30);
end;
/

create or replace procedure procTest(
    pwidth number,
    pheight number
)
is
    varea number;
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;
/

begin
    procTest(10, 20);
end;
/

-- 매개변수 규칙
-- 1. 길이 표현(X)
-- 2. NOT NULL 표현(X)
-- 3. default 표현(O)
create or replace procedure procTest(
    pname varchar2
)
is
begin
    dbms_output.put_line(pname || '님 안녕하세요.');
end procTest;
/

begin
    procTest('홍길동');
end;
/

create or replace procedure procTest(
    pwidth number,
    pheight number default 10
)
is
    varea number;
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;
/

begin
    procTest(10, 20);
    --procTest(10);
    --procTest();
end;
/


/*

    매개변수 모드
    - 매개변수가 값을 전달하는 방식
    
    1. in > 기본 모드
    2. out
    3. in out > X

*/

create or replace procedure procTest (
    pnum1 number,           -- in mode > in parameter
    pnum2 in number,        -- 매개변수(인자값)
    pnum3 out number,       -- out parameter(주소값을 전달) > 반환값 역할
    pnum4 out number,
    pnum5 out number    
)
is
begin
    pnum3 := pnum1 + pnum2;
    pnum4 := pnum1 - pnum2;
    pnum5 := pnum1 * pnum2;
end procTest;
/

declare
    vresult1 number; --100번지
    vresult2 number;
    vresult3 number;
begin
    --procTest(10, 20, vresult);
    --dbms_output.put_line(vresult);
    
    procTest(10, 20, vresult1, vresult2, vresult3);
    dbms_output.put_line(vresult1);
    dbms_output.put_line(vresult2);
    dbms_output.put_line(vresult3);
    
end;
/


/*

    문제
    1. procTest1
        - 부서 전달(인자 1개) > in parameter
        - 해당 부서의 직원 중 급여를 가장 많이 받는 직원을 num을 반환 > out paramter
        - procTest1 호출 > num을 화면에 출력
    
    2. procTest2
        - 직원 번호 전달 > in
        - 같은 지역에 사는 직원수? > out
          같은 직위을 가지는 직원수? > out
          전달 직원의 급여보다 더 많이 받는 직원수? > out
        - 호출 > 3개의 숫자를 출력
    
*/
create or replace procedure procTest1 (
    pbuseo  in    varchar2,
    pnum    out   number
)
is
begin
    
    select num into pnum from tblInsa
        where buseo = pbuseo
            and basicpay = (select max(basicpay) from tblInsa
                                where buseo = pbuseo);
    
end procTest1;
/

declare
    vnum number;
begin
    procTest1('총무부', vnum);
    dbms_output.put_line(vnum);
end;
/


create or replace procedure procTest2 (
    pnum    in  number,
    pcnt1   out number,
    pcnt2   out number,
    pcnt3   out number
)
is
begin
    
    -- 같은 지역에 사는 직원수? > out
    select count(*) - 1 into pcnt1 from tblInsa 
        where city = (select city from tblInsa where num = pnum);
    
    -- 같은 직위을 가지는 직원수? > out
    select count(*) - 1 into pcnt2 from tblInsa 
        where jikwi = (select jikwi from tblInsa where num = pnum);
    
    -- 전달 직원의 급여보다 더 많이 받는 직원수? > out
    select count(*) into pcnt3 from tblInsa 
        where basicpay > (select basicpay from tblInsa where num = pnum);
    
end procTest2;
/


declare
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;
begin
    procTest2(1030, vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1); --2
    dbms_output.put_line(vcnt2); --7
    dbms_output.put_line(vcnt3); --10
end;
/

select * from tblInsa where num = 1030;




rollback;

select * from tblStaff;
select * from tblProject;

-- 직원 퇴사 프로시저
-- 1. 퇴사 직원 > 담당 프로젝트 유무 확인?
-- 2. 담당 프로젝트 존재 > 위임
-- 3. 퇴사 직원 삭제
create or replace procedure procDeleteStaff (
    pseq    in  number,     --퇴사할 직원 번호
    pstaff  in  number,     --위임받을 직원 번호
    presult out number      --결과 > 성공(1) or 실패(0)
)
is
    vcnt number;
begin
    
    --. 사전 체크 > 퇴사 직원 & 위임 직원 > 존재하는지?
    select count(*) into vcnt from tblStaff where seq = pseq or seq = pstaff;
    
    if vcnt = 2 then
        
        --1.
        select count(*) into vcnt from tblProject where staff_seq = pseq;
        
        --2.
        if vcnt > 0 then
            --2.1 위임
            update tblProject set staff_seq = pstaff where staff_seq = pseq;
        else
            --2.2 아무것도 안함
            null;
        end if;
        
        --3.
        delete from tblStaff where seq = pseq;
        
        --4.
        presult := 1; --성공
    
    else
        presult := 0; --실패
    end if;    
    
end procDeleteStaff;
/

declare
    vresult number;
begin
    procDeleteStaff(1, 2, vresult);
    dbms_output.put_line(vresult);
end;
/



-- 직원 퇴사 프로시저
-- 1. 퇴사 직원 > 담당 프로젝트 유무 확인?
-- 2. 담당 프로젝트 존재 > 위임
-- 3. 퇴사 직원 삭제
create or replace procedure procDeleteStaff (
    pseq    in  number,     --퇴사할 직원 번호 > 가장 담당 프로젝트가 적은 직원에게 위임
    presult out number      --결과 > 성공(1) or 실패(0)
)
is
    vcnt number;
begin
    
    --. 사전 체크 > 퇴사 직원 > 존재하는지?
    select count(*) into vcnt from tblStaff where seq = pseq;
    
    if vcnt = 1 then
        
        --1.
        select count(*) into vcnt from tblProject where staff_seq = pseq;
        
        --2.
        if vcnt > 0 then
        
            --담당 프로젝트의 개수가 가장 적은 직원?
            
        
            --2.1 위임
            update tblProject set staff_seq = (select seq from
                                                (select 
                                                    s.seq, count(p.seq) 
                                                from tblStaff s
                                                    left outer join tblProject p
                                                        on s.seq = p.staff_seq
                                                            group by s.seq
                                                                order by count(p.seq) asc) a
                                                                    where rownum = 1) where staff_seq = pseq;
        else
            --2.2 아무것도 안함
            null;
        end if;
        
        --3.
        delete from tblStaff where seq = pseq;
        
        --4.
        presult := 1; --성공
    
    else
        presult := 0; --실패
    end if;    
    
end procDeleteStaff;
/


declare
    vresult number;
begin
    procDeleteStaff(1, vresult);
    dbms_output.put_line(vresult);
end;
/




select * from tblStaff;
select * from tblProject;

select seq from
    (select 
        s.seq, count(p.seq) 
    from tblStaff s
        left outer join tblProject p
            on s.seq = p.staff_seq
                group by s.seq
                    order by count(p.seq) asc) a
                        where rownum = 1;


/*

    저장 프로시저
    1. 저장 프로시저
    2. 저장 함수
    
    저장 함수 > 함수(Function)
    - 저장 프로시저와 거의 동일
    - 사용하는 목적이 조금 다르다.

*/
-- num1 + num2 > 합 반환
create or replace procedure procSum (
    pnum1 number,
    pnum2 number,
    presult out number
)
is
begin
    presult := pnum1 + pnum2;
end procSum;
/

create or replace function fnSum (
    pnum1 in number,
    pnum2 in number
) return number
is
begin
    return pnum1 + pnum2;
end fnSum;
/

declare
    vresult number;
begin
    procSum(10, 20, vresult);
    dbms_output.put_line(vresult);
    
    -- PL/SQL에서는 함수를 잘 사용 안한다.
    vresult := fnSum(10, 20);
    dbms_output.put_line(vresult);
end;
/

select first, height, weight, procSum(height, weight, 변수) from tblComedian;

select first, height, weight, fnSum(height, weight) from tblComedian;

select
    name, buseo, jikwi,
    case
        when substr(ssn, 8, 1) = '1' then '남자'
        when substr(ssn, 8, 1) = '2' then '여자'
    end as gender
from tblInsa;

select
    name, buseo, jikwi,
    fnGender(ssn) as gender
from tblInsa;


create or replace function fnGender (
    pssn varchar2
) return varchar2
is
begin
    return case
                when substr(pssn, 8, 1) = '1' then '남자'
                when substr(pssn, 8, 1) = '2' then '여자'
            end;
end fnGender;
/


-- 프로시저 > PL/SQL 용
-- 함수 > 표준 SQL 용


/*

    자바
    - main() 메서드 > 콜백 함수(Callback Method)
    - hello() 메서드 > 개발자 hello() 호출

    트리거, Trigger
    - 개발자의 호출이 아닌, 미리 지정한 특정 사건이 발생하면 시스템이
      자동으로 호출하는 객체
      
    트리거 구문
    
    CREATE [OR REPLACE] TRIGGER 트리거명
        BEFORE|AFTER
        INSERT|UPDATE|DELETE
        ON 테이블명
        [FOR EACH ROW]
    [DECLARE
        변수 선언;
        커서 선언;]
    BEGIN
        구현부;
    [EXCEPTION
        예외 처리;]
    END;

*/

-- 트리거 선언(생성 + 자동 작동 실행) > 트리거가 담당 사건을 감시하기 시작
-- > 사건 발생!! > 트리거 구현부 실행

-- tblInsa > 직원 삭제
-- ORA-02292: 무결성 제약조건(HR.SYS_C008506)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- 1. 자식 레코드 삭제 > 부모 레코드 삭제
-- 2. 부모 테이블과 자식 테이블의 관계 삭제 > 부모 레코드 삭제
delete from tblInsa where num = 1001;
select * from tblBonus;

rollback;

delete from tblBonus where num = 1001;
delete from tblInsa where num = 1001;

drop table tblBonus;


rollback;
set serveroutput on;

-- tblInsa > 직원 삭제
delete from tblInsa where num = 1003;

create or replace trigger trgInsa
    before      --3. 삭제가 발생하기 바로 직전에 구현을 실행해라
    delete      --2. 삭제가 발생하는지?
    on tblInsa  --1. tblInsa 테이블에서
begin
    dbms_output.put_line('트리거 실행 ' || to_char(sysdate, 'day hh24:mi:ss'));    
    
    -- 금요일에는 퇴사 불가능
    if to_char(sysdate, 'd') = '6' then
        
        -- 강제로 예외 발생!!
        -- throw new Exception() > 예외 던지기
        -- ORA-1001
        -- 사용자 정의 에러(-20000 ~ -29999)
        raise_application_error(-20001, '금요일에는 퇴사가 불가능합니다');
        
    end if;
    
end trgInsa;
/

-- 트리거 > 동작 유무 > 시각(X)
-- 트리거 상태 확인(시스템 테이블)
select * from user_triggers
    where table_name = 'TBLINSA'; --TBLINSA > STATUS > ENABLED > DISABLED

-- 트리거 중지
alter trigger trgInsa disable;

drop trigger trgInsa; --중지 + 삭제

-- 트리거 시작
alter trigger trgInsa enable;

-- *** 오라클 모든 객체(테이블, 뷰 등..)의 이름을 시스템 테이블에 저장
--     > 객체의 이름을 대문자로 저장

select * from tblInsa;


-- 로그 기록
-- tblTodo > 업무 발생 기록
create table tblLog (
    seq number primary key,                     --PK
    message varchar2(1000) not null,            --메시지
    regdate date default sysdate not null       --발생시각
);
create sequence seqLog;

create or replace trigger trgTodo
    after
    insert or update or delete
    on tblTodo
declare
    vmessage varchar2(1000);
begin
    
    dbms_output.put_line('trgTodo 호출됨');
    
    -- 3개의 사건 > 1개의 트리거 호출 > 누가 호출??
    if inserting then
        dbms_output.put_line('insert');
        vmessage := '새로운 할일이 추가되었습니다.';
    elsif updating then
        dbms_output.put_line('update');
        vmessage := '기존 할일이 수정되었습니다.';
    elsif deleting then
        dbms_output.put_line('delete');
        vmessage := '기존 할일이 삭제되었습니다.';
    end if;
    
    insert into tblLog values (seqLog.nextVal, vmessage, default);
    
end trgTodo;
/
    
select * from tblTodo;
insert into tblTodo values (24, '새로운 할일', sysdate, null);
update tblTodo set title = '새로운 할입니다.' where seq = 24;
delete from tblTodo where seq = 24;

select * from tblLog;

--3	기존 할일(???)이 삭제되었습니다.	25/01/24

drop trigger trgInsa;
drop trigger trgTodo;


/*

    *** 트리거는 남용을 하면 안된다.
    


    [FOR EACH ROW]
    
    1. 생략
    - 문장(DML) 단위 트리거
    - Table Level Trigger
        
    2. 사용
    - 행(Record) 단위 트리거

*/

create or replace trigger trgMen
    after
    delete
    on tblMen
    for each row
begin
    dbms_output.put_line('남자 데이터를 삭제했습니다.'); --누구를 삭제?
end trgMen;
/

select * from tblMen;
delete from tblMen where name = '하하하';
delete from tblMen;

rollback;


create or replace trigger trgMen
    before
    update
    on tblMen
    for each row
begin
    dbms_output.put_line('레코드 수정: ' || :old.name);
    dbms_output.put_line('수정 전 나이: ' || :old.age);
    dbms_output.put_line('수정 후 나이: ' || :new.age);
    dbms_output.put_line('전 여친: ' || :old.couple);
    dbms_output.put_line('현 여친: ' || :new.couple);
end trgMen;
/

-- :old > 사건이 적용되기 전의 레코드 상태 참조
-- :new > 사건이 적용된 후의 레코드 상태 참조
select * from tblMen;
update tblMen set age = 26 where name = '홍길동';
update tblMen set couple = '박나래' where name = '홍길동';

-- *** 의사 컬럼 / 연산자
-- insert > :old(X), :new(O)
-- update > :old(O), :new(O)
-- delete > :old(O), :new(X)


-- 회원 테이블, 게시판 테이블
-- 포인트 정책
-- 1. 글 작성 > 포인트 + 100
-- 2. 글 삭제 > 포인트 -  50
create table tblUser (
    id varchar2(30) primary key,
    point number not null
);
insert into tblUser values ('hong', 1000);

create table tblBoard (
    seq number primary key,
    subject varchar2(1000) not null,
    id varchar2(30) not null references tblUser(id)
);
create sequence seqBoard;

-- 절차
-- 1. 글을 쓴다.(삭제한다.)
-- 2. 포인트를 누적한다.(차감한다.)

-- Case 1. 하드 코딩
-- 개발자 직접 제어
-- 실수 > 일부 업무 누락;;

-- 1.1 글쓰기
insert into tblBoard values (seqBoard.nextVal, '게시판입니다.', 'hong');

-- 1.2 포인트 누적하기
update tblUser set point = point + 100 where id = 'hong';

-- 1.3 글삭제
delete from tblBoard where seq = 1;

-- 1.4 포인트 차감하기
update tblUser set point = point - 50 where id = 'hong';



-- Case 2. 프로시저
-- 장점: 전체 업무 단위화 > 간단함, 가독성, 재사용성
-- 단점: 초기 비용 증가
create or replace procedure procAddBoard (
    pid varchar2,
    psubject varchar2
)
is
begin
    
    --2.1
    insert into tblBoard values (seqBoard.nextVal, psubject, pid);
    
    --2.2
    update tblUser set point = point + 100 where id = pid;
    
end procAddBoard;
/


create or replace procedure procDeleteBoard (
    pseq number
)
is
    vid tblUser.id%type;
begin
    
    select id into vid from tblBoard where seq = pseq;
    
    --2.3
    delete from tblBoard where seq = pseq;
    
    --2.4
    update tblUser set point = point - 50 where id = vid;
    
end procDeleteBoard;
/


begin
    --procAddBoard('hong', '안녕하세요.');
    procDeleteBoard(2);
end;
/



-- Case 3. 트리거
create or replace trigger trgBoard
    after
    insert or delete
    on tblBoard
    for each row
begin
    
    if inserting then
        update tblUser set point = point + 100 where id = :new.id;
    elsif deleting then
        update tblUser set point = point -  50 where id = :old.id;
    end if;
    
end trgBoard;
/


select * from tblUser; --1050 > 1150 > 1100 > 1200 > 1150
select * from tblBoard;

--3.1
insert into tblBoard values (seqBoard.nextVal, '게시판입니다.', 'hong');

--3.2
delete from tblBoard where seq = 3;


-- 엔티티명(테이블명)
-- 1. 단수형 > 권장
-- 2. 복수형

-- 상품(재고) 테이블, 주문 테이블
-- 1. 주문 발생
-- 2. 재고 감소
create table tblProduct (
    seq number primary key,
    name varchar2(100) not null,
    stock number not null
);

create table tblOrder (
    seq number primary key,
    pseq number not null references tblProduct(seq),
    qty number not null
);

create sequence seqProduct;
create sequence seqOrder;

insert into tblProduct values (seqProduct.nextVal, '마우스', 100);
insert into tblProduct values (seqProduct.nextVal, '키보드', 50);

create or replace trigger trgOrder
    after insert on tblOrder
    for each row
begin
    update tblProduct set
        stock = stock - :new.qty
            where seq = :new.pseq;
end trgOrder;
/

-- 주문발생
insert into tblOrder (seq, pseq, qty) values (seqOrder.nextVal, 1, 3); --100 > 97
insert into tblOrder (seq, pseq, qty) values (seqOrder.nextVal, 2, 1); -- 50 > 49

select * from tblProduct;



/*

    인덱스, Index
    - 색인
    - 검색을 빠른 속도로 하기 위해 사용하는 도구
    
    데이터베이스
    - 실제 데이터베이스(저장 장치.HDD) > 레코드 순서가 사용자가 insert한 순서(X)
        > DBMS가 자체적으로 순서에 맞게 저장
    - 어떤 데이터를 검색(select) > 처음 ~ 끝까지 차례대로 검색 > table full scan
    - 특정 컬럼 선택 > 별도의 테이블 복사 > 미리 정렬 >> 인덱스
    
    인덱스 장단점
    - 처리 속도를 향상 시킨다.(where)
    - DB 성능을 저하시킬 수 있다. > 주의!!
    
    자동으로 인덱스가 걸리는 컬럼
    1. Primary key
    2. Unique
    
    where num = 1001
    where name = '홍길동'

*/
select * from tblInsa;


select count(*) from tblAddressBook;

create table tblIndex
as
select * from tblAddressBook;

insert into tblIndex select * from tblIndex;

select count(*) from tblIndex; --8,192,000


set timing on;

-- 인덱스없이 검색
select /*+ INDEX(tblIndex idxName) */
count(*) from tblIndex where name = '최민기'; --1.6초

select count(*) from tblIndex where job = '학생'; --2.5초

-- 인덱스 생성
create index idxName on tblIndex(name);

-- 인덱스 삭제
drop index idxName;


alter index idxName visible;


/*

    인덱스 종류
    1. 고유 인덱스
        - PK, UQ > 자동으로 생성되는 인덱스
        - 색인의 값이 중복이 불가능하다.
    2. 비고유 인덱스
        - 일반 컬럼 > 사용자가 생성하는 인덱스
        - 색인의 값이 중복이 가능하다.    
    3. 단일 인덱스
        - 컬럼 1개를 대상으로 만드는 인덱스
    4. 복합 인덱스
        - 컬럼 N개를 대상으로 만드는 인덱스
    5. 함수 기반 인덱스

*/
select
    count(*) from tblIndex where hometown = '서울'; --경과 시간: 00:00:01.606

create index idxHometown on tblIndex(hometown);

select /*+ index(tblIndex idxHometown) */
    count(*) from tblIndex where hometown = '서울'; --경과 시간: 00:00:00.088

select /*+ index(tblIndex idxHometown) */
    count(*) from tblIndex where hometown = '서울' and job = '학생'; --경과 시간: 00:00:07.051
    
create index idxHometownJob on tblIndex(hometown, job);

select /*+ index(tblIndex idxHometownJob) */
    count(*) from tblIndex where hometown = '서울' and job = '학생'; --경과 시간: 00:00:00.126

select /*+ index(tblIndex idxHometownJob) */
    count(*) from tblIndex where job = '학생' and hometown = '서울'; --경과 시간: 00:00:00.021
    
select /*+ index(tblIndex idxHometownJob) */
    count(*) from tblIndex where job = '학생'; --경과 시간: 00:00:00.239


select * from tblAddressBook where rownum <= 3;

create index idxEmail on tblIndex(email);
drop index idxEmail;
create index idxEmail on tblIndex(substr(email, instr(email, '@')));

select /*+ index(tblIndex idxEmail) */
count(*) from tblIndex
    where substr(email, instr(email, '@')) = '@gmail.com'; --경과 시간: 00:00:02.189
    
/*

    프로젝트 과정 마지막 > 부하 걸리는 작업 선별 > 인덱스 적용 > 차이 발생?
    
    인덱스를 사용해야 하는 상황
    1. 테이블에 데이터(레코드)가 많을 때
    2. where절에 사용되는 횟수가 많은 컬럼에 적용 or 조인의 조건
    3. 인덱스 손익분기점 > 검색 결과가 원본 테이블의 10~15% 이하인 경우
    4. null을 포함하는 경우 > 인덱스에는 null 미포함
    
    인덱스를 사용하지 말아야 하는 상황
    1. 테이블에 데이터(레코드)가 적을 때
    2. 인덱스 손익분기점 > 검색 결과가 원본 테이블의 15% 이상인 경우
    3. 해당 테이블이 삽입,수정,삭제가 빈번할 경우

*/    

















