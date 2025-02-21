
-- 1. 관리자(1명)
INSERT INTO tAdminister (administer_id, id, pw, name, birth_date, gender, tell, mail, address) 
VALUES (1, 'admin01', 'password123', '홍길동', TO_DATE('1985-06-15', 'YYYY-MM-DD'), '남성', '010-1234-5678', 'hong@example.com', '서울특별시 강남구');

select * from tAdminister;


-- 2. 인간상태
INSERT INTO tSituationType (situation_type_id, type) VALUES (1, '기간만료');
INSERT INTO tSituationType (situation_type_id, type) VALUES (2, '진행중');
INSERT INTO tSituationType (situation_type_id, type) VALUES (3, '휴회');
INSERT INTO tSituationType (situation_type_id, type) VALUES (4, '재직');
INSERT INTO tSituationType (situation_type_id, type) VALUES (5, '퇴사');
INSERT INTO tSituationType (situation_type_id, type) VALUES (6, '휴가');
INSERT INTO tSituationType (situation_type_id, type) VALUES (7, '병결');

select * from tSituationType;


-- 3. 교사
INSERT INTO tInstroctor VALUES (1, '김성훈', TO_DATE('1985-03-15', 'YYYY-MM-DD'), '남성', '010-1234-5678', 'seonghoon85@example.com', '서울시 강남구', 4);
INSERT INTO tInstroctor VALUES (2, '이주영', TO_DATE('1990-07-23', 'YYYY-MM-DD'), '여성', '010-2345-6789', 'jooyoung90@example.com', '부산시 해운대구', 4);
INSERT INTO tInstroctor VALUES (3, '박지훈', TO_DATE('1988-11-12', 'YYYY-MM-DD'), '남성', '010-3456-7890', 'jihoon88@example.com', '대구시 수성구', 4);
INSERT INTO tInstroctor VALUES (4, '정하나', TO_DATE('1993-06-25', 'YYYY-MM-DD'), '여성', '010-4567-8901', 'hana93@example.com', '인천시 연수구', 4);
INSERT INTO tInstroctor VALUES (5, '최광수', TO_DATE('1986-09-14', 'YYYY-MM-DD'), '남성', '010-5678-9012', 'kwangsoo86@example.com', '광주시 북구', 4);
INSERT INTO tInstroctor VALUES (6, '김민수', TO_DATE('1990-05-21', 'YYYY-MM-DD'), '남성', '010-1234-5678', 'minsu90@example.com', '서울시 강남구', 4);
INSERT INTO tInstroctor VALUES (7, '이서연', TO_DATE('1992-08-15', 'YYYY-MM-DD'), '여성', '010-2345-6789', 'seoyeon92@example.com', '부산시 해운대구', 4);
INSERT INTO tInstroctor VALUES (8, '정우진', TO_DATE('1985-03-10', 'YYYY-MM-DD'), '남성', '010-3456-7890', 'woojin85@example.com', '대전시 유성구', 4);
INSERT INTO tInstroctor VALUES (9, '박수현', TO_DATE('1993-12-30', 'YYYY-MM-DD'), '여성', '010-4567-8901', 'soohyun93@example.com', '광주시 북구', 4);
INSERT INTO tInstroctor VALUES (10, '최영호', TO_DATE('1987-07-07', 'YYYY-MM-DD'), '남성', '010-5678-9012', 'youngho87@example.com', '인천시 남동구', 4);
INSERT INTO tInstroctor VALUES (11, '한지훈', TO_DATE('1991-06-25', 'YYYY-MM-DD'), '남성', '010-6789-0123', 'jihoon91@example.com', '경기도 성남시', 5);
INSERT INTO tInstroctor VALUES (12, '서민경', TO_DATE('1994-09-18', 'YYYY-MM-DD'), '여성', '010-7890-1234', 'mingyeong94@example.com', '대구시 중구', 5);
INSERT INTO tInstroctor VALUES (13, '오상혁', TO_DATE('1986-04-05', 'YYYY-MM-DD'), '남성', '010-8901-2345', 'sanghyuk86@example.com', '울산시 남구', 5);
INSERT INTO tInstroctor VALUES (14, '강예진', TO_DATE('1995-11-22', 'YYYY-MM-DD'), '여성', '010-9012-3456', 'yejin95@example.com', '전주시 완산구', 6);
INSERT INTO tInstroctor VALUES (15, '배준호', TO_DATE('1989-02-14', 'YYYY-MM-DD'), '남성', '010-0123-4567', 'junho89@example.com', '창원시 성산구', 7);

select * from tInstroctor;


-- 4.회원
INSERT INTO tMember VALUES (1, '김민수', TO_DATE('1990-05-14', 'YYYY-MM-DD'), '남성', '010-1234-5678', 'minsu90@example.com', '서울시 강남구', 3);
INSERT INTO tMember VALUES (2, '이서윤', TO_DATE('1995-09-22', 'YYYY-MM-DD'), '여성', '010-9876-5432', 'seoyoon95@example.com', '부산시 해운대구', 2);
INSERT INTO tMember VALUES (3, '박지훈', TO_DATE('1988-03-10', 'YYYY-MM-DD'), '남성', '010-5555-1111', 'jihoon88@example.com', '대구시 수성구', 4);
INSERT INTO tMember VALUES (4, '정하영', TO_DATE('1992-07-18', 'YYYY-MM-DD'), '여성', '010-6666-2222', 'hayoung92@example.com', '인천시 연수구', 5);
INSERT INTO tMember VALUES (5, '최도현', TO_DATE('1997-12-25', 'YYYY-MM-DD'), '남성', '010-7777-3333', 'dohyun97@example.com', '광주시 북구', 1);
INSERT INTO tMember VALUES (6, '한지민', TO_DATE('1994-09-05', 'YYYY-MM-DD'), '여성', '010-8888-4444', 'jimin94@example.com', '대전시 서구', 3);
INSERT INTO tMember VALUES (7, '서준호', TO_DATE('1989-06-30', 'YYYY-MM-DD'), '남성', '010-9999-5555', 'junho89@example.com', '울산시 남구', 2);
INSERT INTO tMember VALUES (8, '문예슬', TO_DATE('1996-11-23', 'YYYY-MM-DD'), '여성', '010-1111-6666', 'yesul96@example.com', '경기도 성남시', 4);
INSERT INTO tMember VALUES (9, '윤성우', TO_DATE('1991-04-02', 'YYYY-MM-DD'), '남성', '010-2222-7777', 'sungwoo91@example.com', '경기도 고양시', 1);
INSERT INTO tMember VALUES (10, '배지연', TO_DATE('1998-08-15', 'YYYY-MM-DD'), '여성', '010-3333-8888', 'jiyeon98@example.com', '강원도 원주시', 5);
INSERT INTO tMember VALUES (11, '강현우', TO_DATE('1993-03-08', 'YYYY-MM-DD'), '남성', '010-4444-9999', 'hyunwoo93@example.com', '충청북도 청주시', 3);
INSERT INTO tMember VALUES (12, '이수민', TO_DATE('1990-02-17', 'YYYY-MM-DD'), '여성', '010-5555-1212', 'sumin90@example.com', '전라북도 전주시', 2);
INSERT INTO tMember VALUES (13, '조민호', TO_DATE('1996-04-30', 'YYYY-MM-DD'), '남성', '010-6666-1313', 'minho96@example.com', '제주특별자치도 제주시', 1);
INSERT INTO tMember VALUES (14, '박세영', TO_DATE('1987-11-21', 'YYYY-MM-DD'), '여성', '010-7777-1414', 'seyoung87@example.com', '서울시 서초구', 4);
INSERT INTO tMember VALUES (15, '김도윤', TO_DATE('1992-05-09', 'YYYY-MM-DD'), '남성', '010-8888-1515', 'doyoon92@example.com', '경상남도 창원시', 5);
INSERT INTO tMember VALUES (16, '신혜진', TO_DATE('1999-08-28', 'YYYY-MM-DD'), '여성', '010-9999-1616', 'hyejin99@example.com', '부산시 수영구', 3);
INSERT INTO tMember VALUES (17, '최강민', TO_DATE('1995-01-11', 'YYYY-MM-DD'), '남성', '010-1111-1717', 'kangmin95@example.com', '대구시 동구', 2);
INSERT INTO tMember VALUES (18, '김하늘', TO_DATE('1993-06-25', 'YYYY-MM-DD'), '여성', '010-2222-1818', 'haneul93@example.com', '전라남도 목포시', 1);
INSERT INTO tMember VALUES (19, '유지호', TO_DATE('1990-09-15', 'YYYY-MM-DD'), '남성', '010-3333-1919', 'jiho90@example.com', '충청남도 천안시', 4);
INSERT INTO tMember VALUES (20, '노예린', TO_DATE('1997-07-03', 'YYYY-MM-DD'), '여성', '010-4444-2020', 'yerin97@example.com', '강원도 춘천시', 5);
INSERT INTO tMember VALUES (21, '송민석', TO_DATE('1988-12-12', 'YYYY-MM-DD'), '남성', '010-5555-2121', 'minseok88@example.com', '경기도 수원시', 3);
INSERT INTO tMember VALUES (22, '배수아', TO_DATE('1994-03-19', 'YYYY-MM-DD'), '여성', '010-6666-2222', 'sua94@example.com', '서울시 송파구', 2);
INSERT INTO tMember VALUES (23, '이태양', TO_DATE('1999-10-07', 'YYYY-MM-DD'), '남성', '010-7777-2323', 'taeyang99@example.com', '인천시 남동구', 1);
INSERT INTO tMember VALUES (24, '장수빈', TO_DATE('1989-05-14', 'YYYY-MM-DD'), '여성', '010-8888-2424', 'subin89@example.com', '대전시 유성구', 4);
INSERT INTO tMember VALUES (25, '허준호', TO_DATE('1996-02-28', 'YYYY-MM-DD'), '남성', '010-9999-2525', 'junho96@example.com', '광주시 서구', 5);
INSERT INTO tMember VALUES (26, '임도현', TO_DATE('1992-11-03', 'YYYY-MM-DD'), '남성', '010-1234-2626', 'dohyun92@example.com', '부산시 남구', 2);
INSERT INTO tMember VALUES (27, '윤지수', TO_DATE('1995-07-19', 'YYYY-MM-DD'), '여성', '010-2345-2727', 'jisu95@example.com', '대구시 달서구', 4);
INSERT INTO tMember VALUES (28, '강민석', TO_DATE('1987-06-25', 'YYYY-MM-DD'), '남성', '010-3456-2828', 'minseok87@example.com', '서울시 강서구', 3);
INSERT INTO tMember VALUES (29, '조서윤', TO_DATE('1998-09-12', 'YYYY-MM-DD'), '여성', '010-4567-2929', 'seoyoon98@example.com', '인천시 미추홀구', 5);
INSERT INTO tMember VALUES (30, '김태영', TO_DATE('1991-04-30', 'YYYY-MM-DD'), '남성', '010-5678-3030', 'taeyoung91@example.com', '경기도 부천시', 1);
INSERT INTO tMember VALUES (31, '박수정', TO_DATE('1993-12-14', 'YYYY-MM-DD'), '여성', '010-6789-3131', 'sujung93@example.com', '전라북도 군산시', 4);
INSERT INTO tMember VALUES (32, '이재훈', TO_DATE('1990-08-22', 'YYYY-MM-DD'), '남성', '010-7890-3232', 'jaehoon90@example.com', '충청북도 충주시', 2);
INSERT INTO tMember VALUES (33, '한지우', TO_DATE('1997-10-17', 'YYYY-MM-DD'), '여성', '010-8901-3333', 'jiwoo97@example.com', '강원도 속초시', 3);
INSERT INTO tMember VALUES (34, '정승환', TO_DATE('1989-01-29', 'YYYY-MM-DD'), '남성', '010-9012-3434', 'seunghwan89@example.com', '광주시 남구', 5);
INSERT INTO tMember VALUES (35, '유나리', TO_DATE('1996-05-06', 'YYYY-MM-DD'), '여성', '010-1234-3535', 'nari96@example.com', '대전시 중구', 1);
INSERT INTO tMember VALUES (36, '노현우', TO_DATE('1994-02-18', 'YYYY-MM-DD'), '남성', '010-2345-3636', 'hyunwoo94@example.com', '서울시 마포구', 3);
INSERT INTO tMember VALUES (37, '강다연', TO_DATE('1992-09-27', 'YYYY-MM-DD'), '여성', '010-3456-3737', 'dayeon92@example.com', '경상남도 진주시', 2);
INSERT INTO tMember VALUES (38, '오지훈', TO_DATE('1995-07-30', 'YYYY-MM-DD'), '남성', '010-4567-3838', 'jihoon95@example.com', '부산시 북구', 4);
INSERT INTO tMember VALUES (39, '배지수', TO_DATE('1999-11-11', 'YYYY-MM-DD'), '여성', '010-5678-3939', 'jisu99@example.com', '대구시 중구', 5);
INSERT INTO tMember VALUES (40, '김성민', TO_DATE('1991-03-15', 'YYYY-MM-DD'), '남성', '010-6789-4040', 'sungmin91@example.com', '충청남도 공주시', 1);
INSERT INTO tMember VALUES (41, '박유진', TO_DATE('1998-06-23', 'YYYY-MM-DD'), '여성', '010-7890-4141', 'yujin98@example.com', '전라남도 여수시', 3);
INSERT INTO tMember VALUES (42, '최현호', TO_DATE('1988-10-09', 'YYYY-MM-DD'), '남성', '010-8901-4242', 'hyunho88@example.com', '경기도 안양시', 2);
INSERT INTO tMember VALUES (43, '송하은', TO_DATE('1993-05-01', 'YYYY-MM-DD'), '여성', '010-9012-4343', 'haeun93@example.com', '강원도 강릉시', 4);
INSERT INTO tMember VALUES (44, '이도훈', TO_DATE('1990-12-20', 'YYYY-MM-DD'), '남성', '010-1234-4444', 'dohun90@example.com', '부산시 기장군', 5);
INSERT INTO tMember VALUES (45, '문수빈', TO_DATE('1997-04-14', 'YYYY-MM-DD'), '여성', '010-2345-4545', 'subin97@example.com', '서울시 은평구', 1);
INSERT INTO tMember VALUES (46, '강우진', TO_DATE('1989-02-07', 'YYYY-MM-DD'), '남성', '010-3456-4646', 'woojin89@example.com', '경기도 용인시', 3);
INSERT INTO tMember VALUES (47, '이채연', TO_DATE('1995-08-31', 'YYYY-MM-DD'), '여성', '010-4567-4747', 'chaeyeon95@example.com', '대전시 동구', 2);
INSERT INTO tMember VALUES (48, '윤승현', TO_DATE('1994-07-05', 'YYYY-MM-DD'), '남성', '010-5678-4848', 'seunghyun94@example.com', '충청남도 서산시', 4);
INSERT INTO tMember VALUES (49, '조민지', TO_DATE('1992-01-25', 'YYYY-MM-DD'), '여성', '010-6789-4949', 'minji92@example.com', '전라북도 남원시', 5);
INSERT INTO tMember VALUES (50, '강소영', TO_DATE('1989-12-29', 'YYYY-MM-DD'), '여성', '010-7890-5050', 'soyoung89@example.com', '경상북도 구미시', 3);

select * from tMember;

