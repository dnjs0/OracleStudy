
drop table tAdminister;
-- 관리자
create table tAdminister (
    administer_id number primary key,   -- PK
    id varchar2(200) not null,          -- ID
    pw varchar2(200) not null,          -- PW
    name varchar2(200) not null,        -- 이름
    birth_date date not null,           -- 생년월일
    gender varchar2(10) not null,       -- 성별 
    tell varchar2(30) not null,         -- 전화번호
    mail varchar2(50) not null,         -- 이메일
    address varchar2(200) not null      -- 주소 
);
select * from tAdminister;


drop table tSituationType;
--(인간)상태
create table tSituationType (
    situation_type_id number primary key,   -- PK
    type varchar2(50) not null              -- 상태명(기간만료, 진행중, 휴회, 재직, 퇴사, 휴가, 병결)
);
select * from tSituationType;


drop table tInstroctor;
-- 강사
create table tInstroctor (
    instroctor_id number primary key,   -- PK
    name varchar2(200) not null,        -- 이름      
    birth_date date not null,           -- 생년월일
    gender varchar2(10) not null,       -- 성별
    tell varchar2(30) not null,         -- 전화번호
    mail varchar2(50) not null,         -- 이메일
    address varchar2(200) not null,     -- 주소
    
    situation_type_id number,           -- 상태(FK)
    constraint fk_tInstroctor_tSituationType foreign key (situation_type_id) references tSituationType(situation_type_id)
);
select * from tInstroctor;


drop table tMember;
-- 회원
create table tMember (
    member_id number primary key,   -- PK
    name varchar2(200) not null,    -- 이름
    birth_date date not null,       -- 생년월일 
    gender varchar2(10) not null,   -- 성별
    tell varchar2(30) not null,     -- 전화번호
    mail varchar2(50) not null,     -- 이메일
    address varchar2(200) not null, -- 주소 
    
    situation_type_id number,       -- (인간)상태(FK)
    constraint fk_tMember_tSituationType foreign key (situation_type_id) references tSituationType(situation_type_id)
);
select * from tMember;


drop table tTime;
-- 강습시간
create table tTime (
    time_id number primary key, -- PK
    start_time varchar2(50) not null      -- 시작시간 
);
select * from tTime;


drop table tPayment;
-- 결제상태유형
create table tPayment (
    payment_id number primary key,  -- PK
    payment varchar2(50)            -- 결재상태유형명
);
select * from tPayment;


drop table tPaymentType;
-- 납부유형
create table tPaymentType (
    payment_type_id number primary key, -- PK
    type varchar2(50) not null          -- 납부유형명(카드, 현금)
);
select * from tPaymentType;


drop table tDay;
-- 요일
create table tDay(
    day_id number primary key,  -- PK
    day varchar2(50) not null   -- 요일명
);
select * from tDay;


drop table tProgram;
-- 프로그램(종류)
create table tProgram (
    program_id number primary key,  -- PK
    Title varchar2(1000) not null,  -- 프로그램명
    period number not null,         -- 기간(일수)
    max_people number,              -- 최대인원
    price number                    -- 금액
);
select * from tProgram;


drop table tOpenProgram;
-- 프로그램(개설) 
CREATE TABLE tOpenProgram (
	open_program_id number primary key, -- PK
    start_date date,                     -- 시작일
    end_date date,                       -- 종료일 
    total_count number,                   -- 총횟수
   
    program_id number,      -- 프로그램(종류)(FK)
    constraint fk_tOpenProgram_tProgram foreign key (program_id) references tProgram(program_id), 
    instroctor_id number,   -- 강사(FK)
    constraint fk_tOpenProgram_tInstroctor foreign key (instroctor_id) references tInstroctor(instroctor_id),
    time_id number,         -- 강습시간(fk)
    constraint fk_tOpenProgram_tTime foreign key (time_id) references tTime(time_id)
);
select * from tOpenProgram;


drop table tProgramRegistration;
-- 프로그램(등록)
create table tProgramRegistration (
    program_registration number primary key,    -- PK
    payment_day date,                           -- 결제일(=등록일)
    
    open_program_id number, -- 프로그램(개설)(FK)
    constraint fk_tProgramRegistration_tOpenProgram foreign key (open_program_id) references tOpenProgram(open_program_id),
    member_id number,       -- 회원번호(FK)
    constraint fk_tProgramRegistration_tMember foreign key (member_id) references tMember(member_id),
    payment_id number,      -- 결재상태유형(FK)
    constraint fk_tProgramRegistration_tPayment foreign key (payment_id) references tPayment(payment_id),
    payment_type_id number, -- 납부유형(FK)
    constraint fk_tProgramRegistration_tPaymentType  foreign key (payment_type_id) references tPaymentType(payment_type_id)
);
select * from tProgramRegistration;


drop table tDayType;
-- 강습요일
create table tDayType (
    lesson_day_id number primary key,   -- PK
    
    day_id number,          -- 요일(FK)
    constraint fk_tDayType_tDay foreign key (day_id) references tDay(day_id),
    open_program_id number, -- 프로그램(개설)(FK)
    constraint fk_tDayType_tOpenProgram foreign key (open_program_id) references tOpenProgram(open_program_id)
);
select * from tDayType;


-- +추가 


drop table tLocker;
-- 락커
create table tLocker (
    locker_id number primary key,   -- PK
    title varchar2(50) not null,    -- 락커명(남자n, 여자n)
    period number,                  -- 기간 
    price number                    -- 가격
);
select * from tLocker;


drop table tLokerReistration;
-- 락커등록
create table tLokerReistration (
    locker_reistration_id number primary key,   -- PK
    start_date date not null,                   -- 시작일 
    end_date date not null,                     -- 종료일 
    
    member_id number,   -- 회원(FK)
    constraint fk_tLokerReistration_tMember foreign key (member_id) references tMember(member_id),
    locker_id number,   -- 락커(FK)
    constraint fk_tLokerReistration_tLocker foreign key (locker_id) references tLocker(locker_id)
);
select * from tLokerReistration;


drop table tMemberAttendance;
-- 회원 출석
create table tMemberAttendance (
    member_attendance_id number primary key,    -- PK
    day_date varchar2(50),                          -- 날짜
    position date,                              -- 입장                                       
    
    member_id number,   -- 회원(FK)
    constraint fk_tMemberAttendance_tMember foreign key (member_id) references tMember(member_id)
);
select * from tMemberAttendance;


drop table tCommute;
-- 강사 출퇴근
create table tCommute (
    commute_id number primary key,      -- PK
    day_date varchar2(50),                   -- 날짜
    go_to_work date,                    -- 출근시간 
    leave_work date,                    -- 퇴근시간  
    situation varchar2(50) not null,    -- 상태
    
    instroctor_id number,   -- 강사(FK)
    constraint fk_tCommute_tInstroctor foreign key (instroctor_id) references tInstroctor(instroctor_id)
);
select * from tCommute;

