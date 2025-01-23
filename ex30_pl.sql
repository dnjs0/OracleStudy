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
    -- buseo := (select buseo from tblInsa where name = '홍길동');

    -- select buseo from tblInsa where name = '홍길동'; -- 표준 SQL은 비긴~엔드안에서 못씀
    select buseo into vbuseo from tblInsa where name = '이순신';
    dbms_output.put_line(vbuseo);
    
    -- tblTodo 할일 등록하기
    insert into tblTodo(seq, title, adddate, completedate)
        values((select max(seq) +1 from tbltodo),vbuseo || '할일',sysdate, null);
    
    
    
end;
/

select * from tblInsa;
select * from tblTodo;
select * from tblBonus;

-- tblInsa > 성과급을 받는 직원 내역
create table tblBouns(
    name varchar2(15)
);

-- 1. 개발부 부장한테 성과급을 지급해라! > select > name?
-- 2. tblBonus에 insert해라
declare
    vname varchar2(15);
begin
    --1.
    select name into vname from tblInsa where buseo = '개발부' and jikwi = '부장';
    --2.
    insert into tblBonus (name) values (vname);
end;
/


-- select into 절에서 여러 컬럼 가져오기
-- insert 사용시
-- 1. 컬럼의 개수와 변수의 개수 동일
-- 2. 컬럼의 순서와 변수의 순서 동일
-- 3. 컬럼와 변수의 자료형과 길이를 동일

desc tblinsa;

declare
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number;
begin
    select 
        name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay 
    from tblInsa where num = 1002;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    
end;
/


/*

    타입 참조
    - 테이블 컬럼 자료형 참조 > PL/SQL 변수의 자료형 활용
    
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
    --vbuseo varchar2(15);
    vbuseo tblInsa.buseo%type;
begin
    select buseo into vbuseo from tblInsa where name = '이순신';
    dbms_output.put_line(vbuseo);
end;
/




desc tblinsa;

declare
    vname tblInsa.name%type;
    vbuseo tblInsa.buseo%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
begin
    select 
        name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay 
    from tblInsa where num = 1002;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    
end;
/

drop table tblBonus;

create table tblBonus(
    seq number primary key,
    num number(5) not null references tblInsa(num), --직원번호(FK)
    bonus number not null
);

create sequence seqBonus;

-- 프로시저 선언
-- 1. 서울 + 부장 + 영업부
-- 2. tblBonus > 지급 > 보너스(급여 * 1.5)

declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
begin
    select num, basicpay into vnum, vbasicpay
    from tblInsa
        where city = '서울' and jikwi = '부장' and buseo = '영업부';
        
    insert into tblBonus(seq, num, bonus)
        values(seqBonus.nextVal, vnum, vbasicpay *1.5);
end;
/

select * from tblBonus;

-- 보너스 지급 내역 페이지
select
    i.name,
    i.city,
    i.jikwi,
    i.basicpay,
    b.bonus
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;


--롤백을 위한 커밋
commit;



select * from tblMen;
select * from tblWomen;

--무명씨 > 성전환 수술 > tblMen에서 tblWomen 으로 옮기기 > 프로시저 제작!!
-- 1. 무명씨의 모든 정보 > select * from tblMen
-- 2. 1결과는 tblWomen에 insert
-- 3. tblMen에서 무명씨 delete
declare
    vname tblMen.name%type;
    vage tblMen.age%type;
    vheight tblMen.height%type;
    vweight tblMen.weight%type;
    vcouple tblMen.couple%type;
begin
    
    --1.
    select 
        name, age, height, weight, couple into vname, vage, vheight, vweight, vcouple
    from tblMen
        where name = '무명씨';
        
    --2.
    insert into tblWomen(name,age, height, weight, couple)
        values (vname, vage, vheight, vweight, vcouple);
        
    --3.
    delete from tblMen where name = vname;
        
    dbms_output.put_line(vname);
    dbms_output.put_line(vage);
    dbms_output.put_line(vheight);
    dbms_output.put_line(vweight);
    dbms_output.put_line(vcouple);
    
end;
/


rollback;



declare
--    vname tblMen.name%type;
--    vage tblMen.age%type;
--    vheight tblMen.height%type;
--    vweight tblMen.weight%type;
--    vcouple tblMen.couple%type;
    vrow tblMen%rowtype; --변수 5개 분량
begin
    --1.
    select * into vrow
    from tblMen
        where name = '무명씨';
        
        --dbms_output.put_line(vrow); --vrow는 출력 불가
        
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.age);
    dbms_output.put_line(vrow.height);
    
    
    
    --2.
    insert into tblWomen(name,age, height, weight, couple)
        values (vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);
        
    --3.
    delete from tblMen where name = vrow.name;
    
    
end;
/
rollback;



/*

    제어문
    1. 조건문
    2. 반복문
    3. 분기문
    

    
*/


-- if문
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
    vnum number := -10;
begin 
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum =0 then
        dbms_output.put_line('0입니다');
    else
        dbms_output.put_line('음수');
    end if;
    
end;
/





-- tblInsa 직원 지정(num)> 남자? 여자? > 각각에 다른 업무 진행

declare
    vgender char(1);
begin

    select substr(ssn,8,1) into vgender from tblInsa where num = 1002;
    
    if vgender = '1' then
        dbms_output.put_line('남자업무를 진행합니다.');
    elsif vgender = '2' then
        dbms_output.put_line('여자업무를 진행합니다.');
    end if;

end;
/


--문제
-- 직원 1명 선택(num) > 보너스(tblBonus) 지급 > 차등 지급
-- a. 과장/부장 > basicpay *1.5
-- b. 사원/대리 > basicpay * 2

declare
    vnum tblInsa.num%type;
    --vname tblInsa.name%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
    vbonus number;
begin

    select num,basicpay, jikwi into vnum, vbasicpay, vjikwi from tblInsa where num = 1004;
    
    if vjikwi = '과장' or vjikwi =  '부장' then
        vbonus := vbasicpay*1.5;
    elsif vjikwi in('사원','대리') then
        vbonus := vbasicpay*2;
        
    end if;

    insert into tblBonus(seq, num, bonus)
            values(seqBonus.nextVal, vnum, vbonus);
    
    
end;
/


select
    i.name,
    i.city,
    i.jikwi,
    i.basicpay,
    b.bonus
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;




-- 프로시저 선언
-- 1. 서울 + 부장 + 영업부
-- 2. tblBonus > 지급 > 보너스(급여 * 1.5)

declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
begin
    select num, basicpay into vnum, vbasicpay
    from tblInsa
        where city = '서울' and jikwi = '부장' and buseo = '영업부';
        
    insert into tblBonus(seq, num, bonus)
        values(seqBonus.nextVal, vnum, vbasicpay *1.5);
end;
/

select * from tblBonus;

-- 보너스 지급 내역 페이지
select
    i.name,
    i.city,
    i.jikwi,
    i.basicpay,
    b.bonus
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;






/*

    case문
    - 표준 SQL > PL/SQL에도 동일하게 제공
    
*/

-- AS > 아시아 로 바꾸기

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

select * from tblCountry;



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
        dbms_output.put_line('구현부 '||to_char(sysdate, 'hh24-mi-ss'));
        
    end loop; 

end;
/


declare
    vnum number := 1; --루프변수
begin

    loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
        
        exit when vnum > 10;
        
        
    end loop;

end;
/


create table tblloop(
    seq number primary key,
    data varchar2(100) not null
);

create sequence seqLoop2;
drop sequence seqLoop;

-- tblLoop > 데이터 > 항목001, 항목002, 항목003,,, 항목999
declare
    vnum number := 1;
begin
    loop
        --dbms_output.put_line(lpad(vnum,3,'0'));
        --vnum := vnum+1;
        
        insert into tblLoop
            values(seqLoop2.nextVal, '항목' || lpad(vnum,3,'0'));
        vnum:= vnum +1;
        exit when vnum > 999;
    end loop;
end;
/

select * from tblloop;

drop table tblloop;




/*

    2. for loop
    for(int n : list){
    
    }
    
    
    for(int n in list){
    
    }

*/

begin

    for i in 1.. 10 loop
        dbms_output.put_line(i);
    end loop;
    
end;
/

-- 구구단, 복합키 사용
-- 복합키(Composite key) : 컬럼 수준 정의 불가, 테이블 수준 or 외부 선언 가능
create table tblGugudan(
    dan number not null,
    num number not null,
    result number not null,
    constraint tblgugudan_dan_num_pk primary key(dan, num)
);

insert into tblGugudan values (1,1,1);
insert into tblGugudan values (1,2,2);
insert into tblGugudan values (1,3,3);
insert into tblGugudan values (3,1,3);

delete from tblGugudan;

begin

    for i in 2..9 loop
        for j in 1..9 loop
            insert into tblGugudan(dan, num, result)
                values(i, j, i*j);
        end loop;
    end loop;

end;
/

select * from tblGugudan order by dan, num;


-- 복합키 > 관계 맺기
-- 학생 + 성적
create table tblStudent(
    name varchar2(30) not null,
    subject varchar2(30) not null,
    tel varchar2(15) not null,
    constraint tblStudent_name_subject_pk primary key(name, subject)
);

insert into tblStudent (name, subject, tel)
    values('홍길동','자바','010-1234-5678');
    
insert into tblStudent (name, subject, tel)
    values('홍길동','오라클','010-1234-5678');    
    
insert into tblStudent (name, subject, tel)
    values('홍길동','html','010-1234-5678');
    
insert into tblStudent (name, subject, tel)
    values('아무개','자바','010-2345-6789');

insert into tblStudent (name, subject, tel)
    values('아무개','Css','010-2345-6789');

select * from tblStudent;


create table tblScore(
    score number not null,
    name varchar2(30) not null,     --FK
    subject varchar2(30) not null,  --FK
    constraint tblscore_name_subject_fk
        foreign key(name, subject) references tblStudent(name, subject),
    constraint tblscore_name_subject_pk
        primary key(name, subject) 
);


insert into tblScore(score, name, subject) values (100,'홍길동','자바');
insert into tblScore(score, name, subject) values (90,'홍길동','오라클');
insert into tblScore(score, name, subject) values (80,'홍길동','html');

insert into tblScore(score, name, subject) values (97,'아무개','자바');
insert into tblScore(score, name, subject) values (75,'아무개','Css');


select * from tblScore;

--join
select 
    st.name as 학생명,
    st.subject 과목명,
    sc.score as 점수
from tblStudent st
    inner join tblscore sc
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
        vnum := vnum +1;
    end loop;
end;
/

-- select into 절의 결과값이 없으면 에러 발생!!!
declare
    vnum number := 1002;
    vname tblInsa.name%type;
    vbasicpay tblInsa.basicpay%type;
    vcnt number;
begin

    select count(*) into vcnt from tblInsa where num = vnum;

    if vcnt > 0 then
        select name, basicpay into vname, vbasicpay from tblInsa where num = vnum;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbasicpay);
    end if;
end;
/




-- 루프 언제 사용?
-- 1. 반복 업무
-- 2. select > 결과셋에 레코드가 N개 > 탐색


/*

    select > 결과셋 > Pl/SQL 변수에 대입
    
    1. select into
    - 결과셋의 레코드가 1개일때만 사용이 가능하다. PK일때 사용하자
    - 2개이상일 경우 에러가 난다.
    - 0개일 경우도 에러가 발생한다.
    
    2. cursor + 루프
    - 결과셋의 레코드가 N개일때 사용이 가능하다.(0~이상)
    
    declare
        변수 선언;
        커서 선언; -- 결과셋 참조 객체
    begin
        커서 열기;
            loop
                커서 참조 > 레코드 접근
                exit when 조건;
            end loop;
        커서 닫기;
    end;

*/

-- tblInsa 직원들 이름을 가져오시오.(60명)
declare
    vname tblInsa.name%type;
begin
    select name into vname from tblInsa; --에러 인자값 많이 갖고오기때문이다.
    dbms_output.put_line(vname);
end;
/


declare
    vname tblInsa.name%type;
    
    -- cursor 커서명 is select 문;
    cursor vcursor
    is
    select name from tblInsa;
begin
    
    -- 커서를 사용해서 > 결과셋 탐색
    open vcursor; --커서 열기 > select 문 실행 > 결과셋을 생성한다. + 커서도 참조한다.
    
        -- fetch 커서 into 변수
        -- select 컬럼 into 변수
        /*
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
        dbms_output.put_line(vname);case 
            when vcursor%notfound then dbms_output.put_line('데이터 없음');
            else dbms_output.put_line('데이터 있음');
        end case;
        
        fetch vcursor into vname;
        dbms_output.put_line(vname);
        
        -- dbms_output.put_line(vcursor%notfound); -->커서 속성
        case 
            when vcursor%notfound then dbms_output.put_line('데이터 없음');
            else dbms_output.put_line('데이터 있음');
        end case;
    
    */
        
        loop
            fetch vcursor into vname;
            exit when vcursor%notfound;
            
            dbms_output.put_line(vname);
        close loop;
    
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
        
        -- 1회전 > 기획부 직원 1명
        dbms_output.put_line(vname || ',' ||vjikwi||','||vbasicpay);
        
    end loop;
    close vcursor;

end;
/




-- 문제. tblBonus
-- 1. 모든 직원에세 보너스 지금(60명 전원)
-- 2. 과장/부장(급여 1.5배), 사원/대기(급여 2배)

-- 어떤 select를 cursor로 정의할지?
-- '기획부' > 이름, 직위, 급여 > 출력
select * from tblBonus;
delete from tblBonus;
create sequence seqBonus;
drop sequence seqBonus;

declare

    cursor vcursor
    is
    select num,jikwi, basicpay  from tblInsa;
    
    vnum        tblInsa.num%type;
    vjikwi      tblInsa.jikwi%type;
    vbasicpay   tblInsa.basicpay%type;
    vbonus      number;

begin
    
    open vcursor;
    loop
        fetch vcursor into  vnum, vjikwi, vbasicpay;
        exit when vcursor%notfound;
        
        if vjikwi in ('과장', '부장') then
            vbonus := vbasicpay *2;
        elsif vjikwi in ('사원', '대리') then
            vbonus := vbasicpay *1.5;
        end if;
        
        insert into tblBonus(seq, num, bonus)
                        values(seqBonus.nextVal, vnum, vbonus);  
        
    end loop;
    close vcursor;

end;
/

-- 커서영역
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
        
        dbms_output.put_line(vrow.name ||','||vrow.buseo);
    
    end loop;
    close vcursor;
    
end;
/


--간단 버전
declare
    cursor vcursor is select * from tblInsa;
begin
    
    for vrow in vcursor loop
        
        dbms_output.put_line(vrow.name ||','||vrow.buseo);
    
    end loop;
    
end;
/

-- 예외 처리
declare
    vcnt number;
    vname tblInsa.name%type;
begin

--    select count(*) into vcnt from tblInsa where buseo = '기2획부';
--    dbms_output.put_line(100000000/vcnt);
--    
    
    select name into vname from tblInsa where num = 1100;
    dbms_output.put_line(vname);
    
    dbms_output.put_line('또 다른 업무');
exception

    when ZERO_DIVIDE then
        dbms_output.put_line('0으로 나누기');
    when no data found then
        dbms_output.put_line('데이터가 없습니다.');
    when others then
        dbms_output.put_line('예외처리') ;

end;
/


---------------------------------------------------------------------------------

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

-- 표준 sql 영역에서 프로시저 호출하는 방법 > 자바와 연동할 때 사용
execute proctest();
execute procTest;
exec procTest;
call procTest();





/*

    SQL 명령어가 실행되는 전체 과정
    1. 직접 sql을 실행하는 경우 > 표준 sql(~ex29) > 텍스트 sql
    2. 익명 프로시저 실행
    ----------------------------------------------------------------
    3. 저장 프로시저 실행
    
    
    1+2
    a. SQL Developer > 구문을 작성한다.(코딩)
    b. 영역을 선택한다 > ctrl + enter > 텍스트가 오라클 서버에게 전송한다 > SQL실행(X)
    c. 오라클 서버가 b를 수신한다.
    d. 수신한 SQL을 파싱한다. (구문을 쪼개고 분석한다. > 문법 검사)
    e. sql을 컴파일한다(인터프리터, 실시간 번역) > 기계어
    f. SQL을 실행한다.
    g. 결과셋을 생성한다.(서버 메모리에)
    h. 결과셋을 클라이언트에게 반환한다.
    i. 반환받은 결과셋 > 화면에 출력한다.
    
    - 동일한 SQL 또 실행 > 동일한 비용 발생!!!!!!!!
    
    
    
    
    
    3.
    a. SQL Developer > 프로시저 선언문(호출X)을 작성한다.(코딩)
    b. 영역을 선택한다 > ctrl + enter > 텍스트가 오라클 서버에게 전송한다 > SQL실행(X)
    c. 오라클 서버가 b를 수신한다.
    d. 수신한 SQL을 파싱한다. (구문을 쪼개고 분석한다. > 문법 검사)
    e. sql을 컴파일한다(인터프리터, 실시간 번역) > 기계어 -> 젤 비쌈
    f. SQL을 실행한다.
    g. 오라클 서버에 프로시저를 생성한다.(+저장)
    h. 생성 완료 메시지를 클라이언트에게 반환한다.
    
    
    a. SQL Developer > 프로시저 선언문을 작성한다.(코딩)
    b. 영역을 선택한다 > ctrl + enter > 텍스트가 오라클 서버에게 전송한다 > SQL실행(X)
    c. 오라클 서버가 b를 수신한다.
    d. 수신한 SQL을 파싱한다. (구문을 쪼개고 분석한다. > 문법 검사)
    e. sql을 컴파일한다(인터프리터, 실시간 번역) > 기계어
    f. SQL을 실행한다.
    g. 저장된 프로시저를 찾아서 호출한다(***) > 프로기저는 이미 컴파일 + 저장
    h. 결과를 반환한다.
    i.SQL Developer > 결과를 처리한다.
    
    - 동일한 구문 호출 > 컴파일이 된 프로시저 사용
        1. 생산 비용 + 컴파일(저장) > 고가
        2. 사용 비용 > 저렴 > 반복(*****)
    - 저장된 객체 > 관리 비용 발생 > 사람이 관리하는 비용 발생(권한, 네이밍 ..)
                                    > 유지 보수 난이도 높음

*/

select * from tblInsa;


-- 저장 프로시저 > 매개변수 or 반환값

-- 1. 매개변수가 있는 프로시저
create or replace procedure procTest(pnum number)   --매개변수
is
    vnum number; --일반 변수

begin
    vnum := pnum *2;
   dbms_output.put_line(vnum);

end procTest;
/



-- 프로시저 호출 구문 = PL/SQL
begin
    procTest(10);
    procTest(20);
    procTest(30);
end;
/

create or replace procedure procTest(
        pwidth number, 
        pheight number)
is
    varea number
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;
/

begin 
    procTest(10,20);
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
    dbms_output.put_line(pname||'님 안녕하세요.');
end procTest;
/


begin 
    procTest('홍길동');
end;
/



create or replace procedure procTest(
    pwidth number ,
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
    --procTest('',10); 에러남, default는 밑에서 부터 채워나가야한다.
    procTest(20);
end;
/


/*

    매개변수 모드
    - 매개변수가 값을 전달하는 방식
    
    1. in > 기본 모드
    2. out
    3. in out > 안씀

*/


create or replace procedure procTest(
    pnum1 number,       -- in mode > in parameter
    pnum2 in number,    -- 매배변수(인자값)
    pnum3 out number,   -- out perameter(주소값을 전달) > 반환값 포함
    pnum4 out number,
    pnum5 out number
)
is begin
    pnum3 := pnum1 + pnum2;
end procTest;
/

declare
    vresult1 number;-- 주소 전달
    vresult2 number;
    vresult3 number;
begin
    --procTest(10,20,vresult);
    --dbms_output.put_line(vresult);
    
    procTest(10,20,vresult1,vresult2,vresult3);
    dbms_output.put_line(vresult1);
    dbms_output.put_line(vresult2);
    dbms_output.put_line(vresult3);
end;
/




/*

    문제
    1.procTest1
        - 부서 전달(인자 1개) > in parameter
        - 해당 부서의 직원중 급여를 가장 많이 받는 직원을 num을 반환 > out parameter
        - procTest1 호출 >  num을 화면에 출력
        
    2. procTest2
        - 직원 번호 전달 > in
        - 같은 지역에 사는 지역수 ? > out
        - 같은 직위를 가지는 직원수? > out
        - 전달 직원의 급여보다 더 많이 받는 직원수? > out
        - 호출 > 3개의 숫자를 출력

*/
select * from tblInsa;





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
    pnum in number,
    pcnt1 out number,
    pcnt2 out number,
    pcnt3 out number
)
is
begin
    -- 같은 지역에 사는 직원수 
    -- count(*)-1 : 나빼고
    select count(*)-1 into pcnt1 from tblInsa
        where city = (select city from tblInsa where num = pnum);

    -- 같ㅌ은 직위        
    select count(*)-1 into pcnt2 from tblInsa
        where jikwi = (select jikwi from tblInsa where num = pnum);
    
    -- 급여 많이 받는 직원 수    
    select count(*) into pcnt3 from tblInsa
        where basicpay > (select basicpay from tblInsa where num = pnum);
    
    
end procTest2;
/

--호출하기
declare
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;
begin
    procTest2('1030', vcnt1,vcnt2,vcnt3);
    dbms_output.put_line(vcnt1); --2
    dbms_output.put_line(vcnt2); --7
    dbms_output.put_line(vcnt3); --10
end;
/

select *  from tblInsa where num=1030;






























select *  from tblStaff;
select * from tblProject;

-- 직원 퇴사 프로시저
-- 1. 퇴사 직원의 담당 프로젝트 유무 확인?
-- 2. 담당 프로젝트 존재 >  위임
-- 3. 퇴사 직원 삭제
create or replace procedure procDeleteStaff(
    pseq    in number,  --퇴사할 직원 번호
    pstaff  in number,  -- 위임받을 직원 번호
    presult out number  -- 결과 > 성공(1) or 실패(0)
)
is
    vcnt number;
begin

    -- . 사전 체크 >> 회사직원 & 위임 직원이 존재하는지 ? 
    select count(*) into vcnt from tblStaff where seq = pseq or seq = pstaff;
    
    if vcnt = 2 then 
    
        -- 1. 
        select count(*) into vcnt from tblProject where staff_seq = pseq;
            
        --2.
        if vcnt >0 then
            --2.1 위임
            update tblProject set staff_seq = pstaff where staff_seq = pseq;
        else
            --2.2 아무것도 안함
            null;
        end if;
        
        -- 3.
        delete from tblStaff where seq = pseq;
        
        -- 4. 
        presult := 1; --성공
    
    else
        presult := 0; -- 실패
    end if;

end procDeleteStaff;
/



--호출하기
declare
    vresult number;
begin
    procDeleteStaff(1,2,vresult);
    dbms_output.put_line(vresult);
end;
/


select *  from tblStaff;
select * from tblProject;




























rollback;--ddl호출할때 실행됨

select *  from tblStaff;
select * from tblProject;

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


-- num1* num2 > 합 변환

create or replace procedure procSum(
    pnum1 number,
    pnum2 number,
    presult out number
)
is
begin
    presult := pnum1*pnum2;
end procSum;
/



create or replace function fnSum(
    pnum1 in number,
    pnum2 in number
)return number
is begin
    return pnum1 + pnum2;
end fnSum;
/






















declare
    vresult number;
begin
    procSum(10,20,vresult);
    dbms_output.put_line(vresult);
    
    
    -- PL/SQL에서는 함수를 잘 사용 안한다.
    vresult := fnSum(10,20);
    dbms_output.put_line(vresult);
end;
/

select first, height, weight, fnSum(height,weight) from tblComedian;

select
    name, buseo, jikwi,
    case
        when substr(ssn,8,1) = '1' then '남자'
        when substr(ssn,8,1) = '2' then '여자'
    end as gender
from tblInsa;




create or replace function fnGender(
    pssn varchar2
)return varchar2
is 
begin
    return case
        when substr(pssn,8,1) = '1' then '남자'
        when substr(pssn,8,1) = '2' then '여자'
    end as gender;
end fnGender;
/

--적용하기
select
    name, buseo, jikwi,
    fnGender(ssn) as gender
from tblInsa;

-- 함수를 만들어서 좋은점 : 필요할거면 써 , 같이 쓸 수 있다. > 침 전체의 생산성이 높아진다

-- 프로시저 > PL/SQL용
-- 함수 > 표준 SQL용









