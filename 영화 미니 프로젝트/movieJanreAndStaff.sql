--movieJanreAndStaff

Create table tblStaff2(
    seqStaff number primary key,
    buseo varchar2(100),
    staffName varchar2(30)
);
--2
Create table tblCategory(
    seqCategory number primary key,
    categoryName varchar2(30) 
);
--3
Create table tblCompany(
    seqCompany number primary key,
    seqM number ,
    seqStaff number ,
    CONSTRAINT FK_Company_seqStaff FOREIGN KEY (seqStaff) REFERENCES tblStaff2(seqStaff),
    CONSTRAINT FK_Company_seqM FOREIGN KEY (seqM) REFERENCES tblMovie(seqM)  
);

--4
Create table tblMovieCategory(
    seqMovieCategory number primary key,
    seqM number,
    seqCategory number,
    CONSTRAINT FK_MovieCategory_seqCategory FOREIGN KEY (seqCategory) REFERENCES tblCategory(seqCategory),
    CONSTRAINT FK_MovieCategory_seqMovie FOREIGN KEY (seqM) REFERENCES tblCategory(seqCategory)
);



--1
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (1, '촬영', '홍경표');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (2, '미술', '김보묵');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (3, '의상', '곽정애');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (4, '제작', '(주)하이브미디어코프');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (5, '배급', 'CJ ENM');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (6, '제작', '㈜에스크로드 픽쳐스');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (7, '제작', '㈜아센디오');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (8, '배급', '㈜바이포엠스튜디오');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (9, '제작', '㈜바이포엠스튜디오');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (10, '제작', '골드독엔터테인먼트㈜');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (11, '제작', '㈜영화사수작');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (12, '배급', '㈜미디어캔');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (13, '배급', '㈜영화특별시SMC');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (14, '공동제작', '㈜필콘스튜디오');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (15, '제공', '㈜미디어캔');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (16, '각본', '코랄리 파르쟈');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (17, '편집', '랄리 파르쟈');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (18, '배급', '㈜넥스트엔터테인먼트월드(NEW)');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (19, '수입', '찬란');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (20, '공동제공', '㈜퍼스트맨스튜디오');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (21, '공동제공', '소지섭');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (22, '공동제공', '㈜51K');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (23, '제작', '㈜오콘');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (24, '제작', '스튜디오스윗');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (25, '배급', 'CJ CGV');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (26, '제작', '파라마운트픽쳐스');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (27, '배급', '롯데컬처웍스㈜롯데엔터테인먼트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (28, '수입', '롯데컬처웍스㈜롯데엔터테인먼트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (29, '각본', '모랄');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (30, '원작', '우스이 요시토');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (31, '수입', 'CJ ENM');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (32, '각본', '위니 홀즈먼');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (33, '각본', '스티븐 슈워츠');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (34, '배급', '유니버설 픽쳐스인터내셔널 코리아(유)');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (35, '수입', '유니버설 픽쳐스인터내셔널 코리아(유)');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (36, '배급', '월트디즈니컴퍼니코리아');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (37, '수입', '월트디즈니컴퍼니코리아');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (38, '배급', '플러스엠 엔터테인먼트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (39, '공동제작', '플러스엠 엔터테인먼트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (40, '제작', '신범수');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (41, '제작', '박성일');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (42, '각본', '황성구');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (43, '각본', '김성제');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (44, '제작', '영화사 이디오플랜');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (45, '제작', '(주)영화사 수박');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (46, '제작', '현해리');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (47, '제작', '주식회사 무암');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (48, '제작', '주식회사 무암');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (49, '배급', '영화로운 형제');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (50, '제작', '고마키 지로');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (51, '제작', '이케다 도모키');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (52, '제작', '마쓰시타 치아키');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (53, '제작', '아베 슈지');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (54, '각본', '이와이 순지');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (55, '제작', '후지텔테비전네트워크');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (56, '배급', '워터홀컴퍼니㈜');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (57, '제작', '조앤 K. 롤링');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (58, '배급', '워너브러더스 코리아㈜');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (59, '배급', '㈜BoXoo엔터테인먼트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (60, '배급', '오드(AUD)');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (61, '배급', '㈜올랄라스토리');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (62, '배급', '롯데컬처웍스㈜롯데엔터테인먼트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (63, '제작', '피터 잭슨');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (64, '제작', '뉴 라인 시네마');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (65, '제작', '제시 아이젠버그');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (66, '배급', '월트디즈니컴퍼니코리아㈜');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (67, '제작', '앤드류 맥도널드');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (68, '배급', '㈜마인드마크');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (69, '제작', '린다 옵스트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (70, '배급', '와이드릴리즈㈜');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (71, '제작', '킬리언 머피');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (72, '배급', '그린나래미디어㈜');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (73, '제작', '김도연');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (74, '배급', '㈜디스테이션');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (75, '배급', '㈜누리픽쳐스');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (76, '제작', '㈜하이브미디어코프');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (77, '배급', 'M&M 인터내셔널');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (78, '제작', 'MAPPA');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (79, '제작', '베네딕트 코브류');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (80, '제작', '게니우스 유한회사 GENIUS');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (81, '제작', 'CJ 4DPLEX');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (82, '배급', 'CJ 4DPLEX');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (83, '배급', '메가박스㈜플러스엠');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (84, '제작', '서울의 소리');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (85, '제작', '㈜스타월드몰');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (86, '제작', '빌 콩');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (87, '제작', '코믹스 웨이브 필름');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (88, '배급', '㈜미디어캐슬');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (89, '제공', '㈜팬엔터테인먼트');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (90, '제작', '한국영화아카데미(KAFA)');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (91, '수입', '㈜블루라벨픽쳐스');
INSERT INTO tblStaff2(seqStaff, buseo, staffName) VALUES (92, '제작', '황 원잉');


--2
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (1, '드라마');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (2, '실화');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (3, '코미디');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (4, '어드벤처');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (5, '애니메이션');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (6, '판타지');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (7, '뮤지컬');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (8, '범죄');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (9, '멜로');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (10, '공포');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (11, '미스터리');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (12, '액션');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (13, 'SF');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (14, '뮤직');
INSERT INTO tblCategory(seqCategory,categoryName)  VALUES (15, '다큐멘터리');


--3
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (1,1,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (2,2,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (3,2,2);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (4,3,3);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (5,4,4);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (6,4,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (7,5,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (8,6,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (9,7,4);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (10,7,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (11,8,6);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (12,8,7);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (13,9,4);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (14,9,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (15,10,4);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (16,10,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (17,10,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (18,11,8);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (19,11,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (20,12,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (21,12,8);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (22,13,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (23,13,9);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (24,14,10);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (25,15,6);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (26,15,11);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (27,16,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (28,17,6);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (29,17,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (30,18,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (31,19,6);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (32,20,3);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (33,21,null);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (34,22,12);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (35,23,12);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (36,24,13);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (37,25,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (38,26,null);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (39,27,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (40,28,3);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (41,29,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (42,30,10);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (43,31,6);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (44,32,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (45,33,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (46,34,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (47,35,3);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (48,36,14);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (49,37,null);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (50,38,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (51,39,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (52,40,15);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (53,41,15);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (54,42,9);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (55,43,5);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (56,44,9);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (57,45,1);
INSERT INTO tblMovieCategory(seqMovieCategory,seqM,seqCategory)  VALUES (58,46,6);



--4
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (35,8,34);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (36,8,35);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (37,9,36);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (38,9,37);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (39,10,38);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (40,10,39);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (41,11,40);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (42,11,41);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (43,11,42);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (44,11,43);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (45,11,44);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (46,11,45);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (47,11,38);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (48,11,39);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (49,12,46);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (50,12,47);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (51,12,48);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (52,12,49);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (53,13,50);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (54,13,51);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (55,13,52);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (56,13,53);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (57,13,54);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (58,13,55);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (59,13,56);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (60,14,34);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (61,14,35);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (62,15,57);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (63,15,58);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (64,16,59);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (65,17,60);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (66,18,61);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (67,18,62);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (68,19,63);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (69,19,64);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (70,19,58);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (71,20,65);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (72,20,66);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (73,21,null);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (74,22,67);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (75,22,68);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (76,23,5);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (77,24,58);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (78,24,69);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (79,25,70);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (80,26,null);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (81,27,71);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (82,27,72);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (83,28,8);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (84,28,73);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (85,29,74);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (86,30,75);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (87,31,76);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (88,32,77);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (89,33,78);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (90,34,72);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (91,34,79);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (92,35,27);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (93,35,80);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (94,36,81);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (95,36,82);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (96,37,null);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (97,38,45);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (98,38,83);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (99,39,70);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (100,40,84);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (101,41,85);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (102,41,25);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (103,42,86);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (104,42,74);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (105,43,87);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (106,44,88);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (107,44,89);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (108,45,90);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (109,46,91);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (110,47,null);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (111,48,92);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (112,49,74);
INSERT INTO tblCompany(seqCompany,seqM,seqStaff )  VALUES (113,50,null);



