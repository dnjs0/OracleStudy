-- moveProject

GRANT CREATE TABLE TO project;

select * from tabs;

CREATE TABLE tblAgeGrade (
    seqAgeGrade VARCHAR2(3) PRIMARY KEY,  -- 시청자등급(PK)
    age         VARCHAR2(100)            -- 연령대등급
);


CREATE TABLE tblMovie (
    seqM            NUMBER PRIMARY KEY,       -- 영화번호(PK)
    korName         VARCHAR2(1000),          -- 영화한글이름
    engName         VARCHAR2(1000),          -- 영화영어이름
    pplCount        NUMBER,                  -- 영화관람객수
    pplTotalCount   NUMBER,                  -- 누적관객수
    firstDate       DATE,                    -- 최초개봉일
    openDate        DATE,                    -- 개봉일
    content         VARCHAR2(2500),          -- 줄거리
    movieTime       NUMBER,                  -- 상영시간
    movieAge        VARCHAR2(3),             -- 시청자등급(FK)
    CONSTRAINT FK_movieAge FOREIGN KEY (movieAge) 
        REFERENCES tblAgeGrade(seqAgeGrade)  -- 외래 키 제약 조건
);



CREATE TABLE tblActor (
    seqActor NUMBER PRIMARY KEY,  -- 출연배우번호PK)
    actorName         VARCHAR2(50),            -- 출연배우이름
    actorMovie         VARCHAR2(100)            -- 배우대표작
);


select * from tblActor;



CREATE TABLE tblMovieActor (
    seqMovieActor NUMBER PRIMARY KEY,  -- 출연배우번호PK
    character     VARCHAR2(50),        -- 배역명
    seqM          NUMBER,              -- 외래키로 참조할 영화 번호
    seqActor      NUMBER,              -- 외래키로 참조할 배우 번호
    CONSTRAINT fk_seqM FOREIGN KEY (seqM) REFERENCES tblMovie(seqM),  -- tblMovie 테이블의 seqM을 참조
    CONSTRAINT fk_seqActor FOREIGN KEY (seqActor) REFERENCES tblActor(seqActor)  -- tblActor 테이블의 seqActor을 참조
);

select * from tblMovieActor;


CREATE TABLE tblMasterpiece(
    seqMasterpiece NUMBER PRIMARY KEY,  -- 대표작번호PK)
    directorName         VARCHAR2(50),            -- 감독이름
    Masterpiece         VARCHAR2(100)            -- 감독대표작
);


select * from tblMasterpiece;


CREATE TABLE tblDirector (
    seqDirector NUMBER PRIMARY KEY,  -- 감독번호PK
    seqM        NUMBER,              -- 외래키로 참조할 영화 번호
    seqMasterpiece NUMBER,              -- 외래키로 참조할 대표작번호
    CONSTRAINT fk_seqM_director FOREIGN KEY (seqM) REFERENCES tblMovie(seqM),  -- tblMovie 테이블의 seqM을 참조
    CONSTRAINT fk_seqMasterpiece FOREIGN KEY (seqMasterpiece) REFERENCES tblMasterpiece(seqMasterpiece)  -- tblMasterpiece 테이블의 seqMasterpiece을 참조
);

select * from tblDirector;
