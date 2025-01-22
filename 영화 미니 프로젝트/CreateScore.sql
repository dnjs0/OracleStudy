-- 1. 
CREATE TABLE tblppl (
    seqppl NUMBER PRIMARY KEY,    -- 관람객번호(PK)
    pplname         VARCHAR2(100)  -- 관람객이름
);


-- 2.
CREATE TABLE tblpplScore (
    seqpplStar   NUMBER PRIMARY KEY,       -- 관람객평점번호(PK)
    seqM         NUMBER,                   -- 영화번호(FK)
    seqppl       NUMBER,                   -- 관람객번호(FK)
    pplStar      NUMBER,                   -- 별점
    pplReview    VARCHAR2(2000),           -- 관람객리뷰

    CONSTRAINT FK_seqppl FOREIGN KEY (seqppl) 
        REFERENCES tblppl(seqppl),  -- 외래 키 제약 조건
    CONSTRAINT FK_seqMpplScore FOREIGN KEY (seqM) 
        REFERENCES tblMovie(seqM)       -- 외래 키 제약 조건 dlfm
);

-- 3.
CREATE TABLE tblExpert (
    seqExpert NUMBER PRIMARY KEY,    -- 평론가번호(PK)
    expertName         VARCHAR2(30)  -- 평론가이름
);

-- 4.
CREATE TABLE tblExpertScore (
    seqExpertScore   NUMBER PRIMARY KEY,       -- 평론가평점번호(PK)
    seqM             NUMBER,                   -- 영화번호(FK)
    seqExpert        NUMBER,                   -- 평론가번호(FK)
    expertStar       NUMBER,                   -- 별점
    expertReview     VARCHAR2(2000),           -- 리뷰

    CONSTRAINT FK_seqExpert FOREIGN KEY (seqExpert) 
        REFERENCES tblExpert(seqExpert),  -- 외래 키 제약 조건
    CONSTRAINT FK_seqMExpertScore FOREIGN KEY (seqM) 
        REFERENCES tblMovie(seqM)  -- 외래 키 제약 조건
);