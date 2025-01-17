-- ex22_union.sql


/*
    
    A = {10,20,30}
    B = {30,40,50}
    A ∪ B = {10,20,30,40,50}
    
    
    조인 : 테이블 X 테이블
    유니온 : 테이블 + 테이블
    
    유니온, union
    - 테이블과 테이블을 합치는 기술
    - 반드시 두 결과셋의 스키마가 동일해야한다.
    
    
*/

select * from tblMen
union
select * from tblWomen;

-- 열구성이 다르기때문에 에러
select * from tblInsa
union
select * from tblTodo;

-- 문자 ,날짜 이므로 가능은 함
select name,ibsadate from tblInsa
union
select title, adddate from tblTodo;


-- 회사 > 게시판 > 부서별 게시판
select * from 영업부게시판;
select * from 총무부게시판;
select * from 개발부게시판;

-- 사장님 > 모든 부서의 게시물 한번에 열람 >  union 사용
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;

-- 야구 선수 > 공격수, 수비수
select 이름, 체중, 키, 타율 from 공격수;
select 이름, 체중, 키, 방어율 from 수비수;

-- 전체 선수 명단
select 이름, 체중, 키 from 공격수
union
select 이름, 체중, 키 from 수비수;


-- 홍길동 찾기
select * from(  select 이름, 체중, 키 from 공격수
                union
                select 이름, 체중, 키 from 수비수)
                    where 이름 = '홍길동';






create table tblAAA(
    name varchar2(30) primary key,
    color varchar2(30) not null

);

create table tblBBB(
    name varchar2(30) primary key,
    color varchar2(30) not null

); 

insert into tblAAA values('강아지','검정');
insert into tblAAA values('고양이','노랑');
insert into tblAAA values('토끼','갈색');
insert into tblAAA values('거북이','녹색');
insert into tblAAA values('송아지','회색');

insert into tblBBB values('강아지','검정');
insert into tblBBB values('고양이','노랑');
insert into tblBBB values('호랑이','주황');
insert into tblBBB values('사자','회색');
insert into tblBBB values('노루','검정');

select * from tblAAA;
select * from tblBBB;

-- 합집합이므로 중복되는것은 1번만 표시
-- union은 수학의 집합 > 중복 제거
select * from tblAAA
union
select * from tblBBB;

-- union all > 중복 허용
select * from tblAAA
union all
select * from tblBBB;

-- distinct를 적용하면? > 원래 유니온
select distinct * from (select * from tblAAA
                        union all
                        select * from tblBBB);

-- intersect > 교집합
select * from tblAAA
intersect
select * from tblBBB;

-- minus > A의 차집합
select * from tblAAA
minus
select * from tblBBB;

-- minus > B의 차집합
select * from tblBBB
minus
select * from tblAAA;

--교집합, 차집합 등을 관계대수 연산이라고 한다~,~






















































