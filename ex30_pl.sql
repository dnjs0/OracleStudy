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











