drop table tblCountryMade;
drop table tblCountry;
drop table tblmovie;
DROP TABLE tblAgeGrade;


--create

create table tblAgeGrade(
    seqAgeGrade varchar2(3) primary key, --(PK)	시청자등급	VARCHAR2(3)
    age	VARCHAR2(100)   --연령대등급	
);

create table tblMovie (
    seqM	        NUMBER primary key,  --영화번호(PK)	
    korName		    VARCHAR2(1000) DEFAULT '정보가 없습니다',  --영화한글이름
    engName		    VARCHAR2(1000)  DEFAULT '정보가 없습니다',  --영화영어이름
    pplCount	    NUMBER DEFAULT 0,  --영화관람객수
    pplTotalCount	NUMBER DEFAULT 0,  --누적관객수
    openDate	    DATE,    --개봉일
    movieTime		NUMBER  DEFAULT 0,  --상영시간
    movieAge	    VARCHAR2(3) DEFAULT '0',
    content		    VARCHAR2(2500) DEFAULT '정보가 없습니다',  --줄거리
    CONSTRAINT FKmovieAge FOREIGN KEY (movieAge) references tblAgeGrade(seqAgeGrade)  --시청자등급(FK)
);




create table tblCountry(
    seqCountry NUMBER primary key,   --(PK)	국가번호	
    countryName	VARCHAR2(100)   --나라명	
);


create table tblCountryMade(
    seqMadeCountry number primary key, --(PK)	제작국가번호	NUMBER
    seqM number, --(FK)	영화번호	NUMBER
    seqCountryNum number,--(FK)	국가번호	NUMBER
    CONSTRAINT FKseqM FOREIGN KEY (seqM) references tblMovie(seqM),
    CONSTRAINT FKseqCountryNum FOREIGN KEY (seqCountryNum) references tblCountry(seqCountry)
);









