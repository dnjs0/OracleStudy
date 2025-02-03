-- 쌍용학원관리DDL

BEGIN
  -- 테이블 삭제
  FOR t IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
  
  -- 시퀀스 삭제
  FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
  END LOOP;
END;
/

select * from tabs;

DROP INDEX PK_Admin;

select * from tabs; 
drop  table TBLAGEGRADE;


/* 관리자 */
CREATE TABLE Admin (
	AdminSeq NUMBER NOT NULL, /* 관리자번호 */
	AdminName VARCHAR2(30) NOT NULL, /* 관리자명 */
	AdminTel VARCHAR2(30) NOT NULL, /* 전화번호 */
	AdminPw NUMBER NOT NULL /* 주민번호뒷자리 */
);

COMMENT ON TABLE Admin IS '관리자';

COMMENT ON COLUMN Admin.AdminSeq IS '관리자번호';

COMMENT ON COLUMN Admin.AdminName IS '관리자명';

COMMENT ON COLUMN Admin.AdminTel IS '전화번호';

COMMENT ON COLUMN Admin.AdminPw IS '주민번호뒷자리';

CREATE UNIQUE INDEX PK_Admin
	ON Admin (
		AdminSeq ASC
	);

ALTER TABLE Admin
	ADD
		CONSTRAINT PK_Admin
		PRIMARY KEY (
			AdminSeq
		);

DROP INDEX PK_holiday;

/* 공휴일 */
CREATE TABLE holiday (
	holidaySeq NUMBER NOT NULL, /* 공휴일번호 */
	holidayDate DATE, /* 날짜 */
	holidayName VARCHAR2(100) /* 공휴일명 */
);

COMMENT ON TABLE holiday IS '공휴일';

COMMENT ON COLUMN holiday.holidaySeq IS '공휴일번호';

COMMENT ON COLUMN holiday.holidayDate IS '날짜';

COMMENT ON COLUMN holiday.holidayName IS '공휴일명';

CREATE UNIQUE INDEX PK_holiday
	ON holiday (
		holidaySeq ASC
	);

ALTER TABLE holiday
	ADD
		CONSTRAINT PK_holiday
		PRIMARY KEY (
			holidaySeq
		);

DROP INDEX PK_teacher;

/* 교사 */
CREATE TABLE teacher (
	teacherSeq NUMBER NOT NULL, /* 교사번호 */
	teacherName VARCHAR2(30), /* 교사명 */
	teacherPw NUMBER, /* 주민번호뒷자리 */
	teacherTel VARCHAR2(30) /* 전화번호 */
);

COMMENT ON TABLE teacher IS '교사';

COMMENT ON COLUMN teacher.teacherSeq IS '교사번호';

COMMENT ON COLUMN teacher.teacherName IS '교사명';

COMMENT ON COLUMN teacher.teacherPw IS '주민번호뒷자리';

COMMENT ON COLUMN teacher.teacherTel IS '전화번호';

CREATE UNIQUE INDEX PK_teacher
	ON teacher (
		teacherSeq ASC
	);

ALTER TABLE teacher
	ADD
		CONSTRAINT PK_teacher
		PRIMARY KEY (
			teacherSeq
		);
        
DROP INDEX PK_book;

/* 교재 */
CREATE TABLE book (
	bookSeq NUMBER NOT NULL, /* 교재번호 */
	bookName VARCHAR2(1000) NOT NULL, /* 교재명 */
	bookPublisher VARCHAR2(100), /* 출판사명 */
	bookAuthor VARCHAR2(100), /* 저자 */
	bookYear DATE /* 발행연도 */
);

COMMENT ON TABLE book IS '교재';

COMMENT ON COLUMN book.bookSeq IS '교재번호';

COMMENT ON COLUMN book.bookName IS '교재명';

COMMENT ON COLUMN book.bookPublisher IS '출판사명';

COMMENT ON COLUMN book.bookAuthor IS '저자';

COMMENT ON COLUMN book.bookYear IS '발행연도';

CREATE UNIQUE INDEX PK_book
	ON book (
		bookSeq ASC
	);

ALTER TABLE book
	ADD
		CONSTRAINT PK_book
		PRIMARY KEY (
			bookSeq
		);


DROP INDEX PK_subject;

/* 과목 */

CREATE TABLE subject (
	subjectSeq NUMBER NOT NULL, /* 과목번호 */
	subjectName VARCHAR2(1000) NOT NULL, /* 과목명 */
	subjectEsn VARCHAR2(10) DEFAULT '선택' NOT NULL /* 필수여부(필수,선택) */
);

COMMENT ON TABLE subject IS '과목';

COMMENT ON COLUMN subject.subjectSeq IS '과목번호';

COMMENT ON COLUMN subject.subjectName IS '과목명';

COMMENT ON COLUMN subject.subjectEsn IS '필수여부(필수,선택)';

CREATE UNIQUE INDEX PK_subject
	ON subject (
		subjectSeq ASC
	);

ALTER TABLE subject
	ADD
		CONSTRAINT PK_subject
		PRIMARY KEY (
			subjectSeq
		);
     
DROP INDEX PK_sbjectBook;

/* 과목별교재 */
CREATE TABLE sbjectBook (
	sbjectBookSeq NUMBER NOT NULL, /* 과목별교재번호 */
	subjectSeq NUMBER NOT NULL, /* 과목번호 */
	bookSeq NUMBER NOT NULL /* 교재번호 */
);

COMMENT ON TABLE sbjectBook IS '과목별교재';

COMMENT ON COLUMN sbjectBook.sbjectBookSeq IS '과목별교재번호';

COMMENT ON COLUMN sbjectBook.subjectSeq IS '과목번호';

COMMENT ON COLUMN sbjectBook.bookSeq IS '교재번호';

CREATE UNIQUE INDEX PK_sbjectBook
	ON sbjectBook (
		sbjectBookSeq ASC
	);

ALTER TABLE sbjectBook
	ADD
		CONSTRAINT PK_sbjectBook
		PRIMARY KEY (
			sbjectBookSeq
		);

ALTER TABLE sbjectBook
	ADD
		CONSTRAINT FK_subject_TO_sbjectBook
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES subject (
			subjectSeq
		);

ALTER TABLE sbjectBook
	ADD
		CONSTRAINT FK_book_TO_sbjectBook
		FOREIGN KEY (
			bookSeq
		)
		REFERENCES book (
			bookSeq
		);
        
DROP INDEX tSubject;

/* 교사가능과목 */
CREATE TABLE tSubject (
	tSubjectSeq NUMBER NOT NULL, /* 교사가능과목번호 */
	teacherSeq NUMBER NOT NULL, /* 교사번호 */
	subjectSeq NUMBER NOT NULL /* 과목번호 */
);

COMMENT ON TABLE tSubject IS '교사가능과목';

COMMENT ON COLUMN tSubject.tSubjectSeq IS '교사가능과목번호';

COMMENT ON COLUMN tSubject.teacherSeq IS '교사번호';

COMMENT ON COLUMN tSubject.subjectSeq IS '과목번호';

CREATE UNIQUE INDEX tSubject
	ON tSubject (
		tSubjectSeq ASC
	);

ALTER TABLE tSubject
	ADD
		CONSTRAINT tSubject
		PRIMARY KEY (
			tSubjectSeq
		);

ALTER TABLE tSubject
	ADD
		CONSTRAINT FK_teacher_TO_tSubject
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES teacher (
			teacherSeq
		);

ALTER TABLE tSubject
	ADD
		CONSTRAINT FK_subject_TO_tSubject
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES subject (
			subjectSeq
		);
        
DROP INDEX PK_clsRoom;

/* 강의실 */
CREATE TABLE clsRoom (
	clsRoomSeq NUMBER NOT NULL, /* 강의실번호 */
	clsRoomName VARCHAR(20) NOT NULL, /* 강의실명 */
	clsRoomPpl NUMBER NOT NULL /* 강의실인원 */
);

COMMENT ON TABLE clsRoom IS '강의실';

COMMENT ON COLUMN clsRoom.clsRoomSeq IS '강의실번호';

COMMENT ON COLUMN clsRoom.clsRoomName IS '강의실명';

COMMENT ON COLUMN clsRoom.clsRoomPpl IS '강의실인원';

CREATE UNIQUE INDEX PK_clsRoom
	ON clsRoom (
		clsRoomSeq ASC
	);

ALTER TABLE clsRoom
	ADD
		CONSTRAINT PK_clsRoom
		PRIMARY KEY (
			clsRoomSeq
		);


DROP INDEX PK_Course;

/* 과정 */
CREATE TABLE Course (
	courseSeq NUMBER NOT NULL, /* 과정번호 */
	courseName VARCHAR2(1000) NOT NULL /* 과정명 */
);

COMMENT ON TABLE Course IS '과정';

COMMENT ON COLUMN Course.courseSeq IS '과정번호';

COMMENT ON COLUMN Course.courseName IS '과정명';

CREATE UNIQUE INDEX PK_Course
	ON Course (
		courseSeq ASC
	);

ALTER TABLE Course
	ADD
		CONSTRAINT PK_Course
		PRIMARY KEY (
			courseSeq
		);
        
DROP INDEX PK_studentCls;

/* 교육생수강정보 */
CREATE TABLE studentCls (
	studentClsSeq NUMBER NOT NULL, /* 교육생수강정보번호  */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	processSeq NUMBER NOT NULL /* 개설과정번호 */
);

COMMENT ON TABLE studentCls IS '교육생수강정보';

COMMENT ON COLUMN studentCls.studentClsSeq IS '교육생수강정보번호 ';

COMMENT ON COLUMN studentCls.studentSeq IS '교육생번호';

COMMENT ON COLUMN studentCls.processSeq IS '개설과정번호';

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'STUDENTCLS';

CREATE UNIQUE INDEX PK_studentCls
	ON studentCls (
		studentClsSeq ASC
	);

ALTER TABLE studentCls
	ADD
		CONSTRAINT PK_studentCls
		PRIMARY KEY (
			studentClsSeq
		);
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ALTER TABLE studentCls
	ADD
		CONSTRAINT FK_student_TO_studentCls
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ALTER TABLE studentCls
	ADD
		CONSTRAINT FK_process_TO_studentCls
		FOREIGN KEY (
			processSeq
		)
		REFERENCES process (
			processSeq
		);        
        
--

DROP INDEX PK_student;

/* 교육생 */
CREATE TABLE student (
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	studentName VARCHAR2(50), /* 이름 */
	studentPw NUMBER, /* 주민번호뒷자리 */
	studentTel VARCHAR2(30), /* 전화번호 */
	studentDate DATE DEFAULT sysdate /* 등록일 */
);

COMMENT ON TABLE student IS '교육생';

COMMENT ON COLUMN student.studentSeq IS '교육생번호';

COMMENT ON COLUMN student.studentName IS '이름';

COMMENT ON COLUMN student.studentPw IS '주민번호뒷자리';

COMMENT ON COLUMN student.studentTel IS '전화번호';

COMMENT ON COLUMN student.studentDate IS '등록일';

CREATE UNIQUE INDEX PK_student
	ON student (
		studentSeq ASC
	);

ALTER TABLE student
	ADD
		CONSTRAINT PK_student
		PRIMARY KEY (
			studentSeq
		);
        
DROP INDEX PK_stStatus;

/* 교육생상태리스트 */
drop table stStatus;
CREATE TABLE stStatus (
	stStatusSeq NUMBER NOT NULL, /* 교육생상태리스트번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	status VARCHAR2(50), /* 상태(수료,중도탈락) */
	stStatusDate DATE /* 날짜(수료,중도탈락) */
);

COMMENT ON TABLE stStatus IS '교육생상태리스트';

COMMENT ON COLUMN stStatus.stStatusSeq IS '교육생상태리스트번호';

COMMENT ON COLUMN stStatus.studentSeq IS '교육생번호';

COMMENT ON COLUMN stStatus.status IS '상태(수료,중도탈락)';

COMMENT ON COLUMN stStatus.stStatusDate IS '날짜(수료,중도탈락)';

CREATE UNIQUE INDEX PK_stStatus
	ON stStatus (
		stStatusSeq ASC
	);

ALTER TABLE stStatus
	ADD
		CONSTRAINT PK_stStatus
		PRIMARY KEY (
			stStatusSeq
		);

ALTER TABLE stStatus
	ADD
		CONSTRAINT FK_student_TO_stStatus
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);
        
DROP INDEX PK_score;

/* 과목성적 */
CREATE TABLE score (
	scoreSeq NUMBER NOT NULL, /* 과목성적번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	subjectSeq NUMBER NOT NULL, /* 과목번호 */
	writingScore NUMBER, /* 필기점수 */
	realScore NUMBER, /* 실기점수 */
	attendanceScore NUMBER, /* 출석점수 */
	totalScore NUMBER /* 총점수 */
);

COMMENT ON TABLE score IS '과목성적';

COMMENT ON COLUMN score.scoreSeq IS '과목성적번호';

COMMENT ON COLUMN score.studentSeq IS '교육생번호';

COMMENT ON COLUMN score.subjectSeq IS '과목번호';

COMMENT ON COLUMN score.writingScore IS '필기점수';

COMMENT ON COLUMN score.realScore IS '실기점수';

COMMENT ON COLUMN score.attendanceScore IS '출석점수';

COMMENT ON COLUMN score.totalScore IS '총점수';

CREATE UNIQUE INDEX PK_score
	ON score (
		scoreSeq ASC
	);

ALTER TABLE score
	ADD
		CONSTRAINT PK_score
		PRIMARY KEY (
			scoreSeq
		);

ALTER TABLE score
	ADD
		CONSTRAINT FK_student_TO_score
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);

ALTER TABLE score
	ADD
		CONSTRAINT FK_subject_TO_score
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES subject (
			subjectSeq
		);
        
DROP INDEX PK_money;

/* 지원금 */
CREATE TABLE money (
	moneySeq NUMBER NOT NULL, /* 지원금번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	moneyMonth DATE, /* 월 */
	receivedMoney NUMBER /* 지원금 */
);

COMMENT ON TABLE money IS '지원금';

COMMENT ON COLUMN money.moneySeq IS '지원금번호';

COMMENT ON COLUMN money.studentSeq IS '교육생번호';

COMMENT ON COLUMN money.moneyMonth IS '월';

COMMENT ON COLUMN money.receivedMoney IS '지원금';

CREATE UNIQUE INDEX PK_money
	ON money (
		moneySeq ASC
	);

ALTER TABLE money
	ADD
		CONSTRAINT PK_money
		PRIMARY KEY (
			moneySeq
		);

ALTER TABLE money
	ADD
		CONSTRAINT FK_student_TO_money
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);
        
DROP INDEX PK_test;

/* 시험정보 */
CREATE TABLE test (
	testSeq NUMBER NOT NULL, /* 시험정보번호 */
	subjectSeq NUMBER NOT NULL, /* 과목번호 */
	teacherSeq NUMBER NOT NULL, /* 교사번호 */
	testType VARCHAR2(10), /* 시험종류(필기,실기) */
	testContext VARCHAR2(3000), /* 시험문제 */
	testDate DATE /* 날짜 */
);

COMMENT ON TABLE test IS '시험정보';

COMMENT ON COLUMN test.testSeq IS '시험정보번호';

COMMENT ON COLUMN test.subjectSeq IS '과목번호';

COMMENT ON COLUMN test.teacherSeq IS '교사번호';

COMMENT ON COLUMN test.testType IS '시험종류(필기,실기)';

COMMENT ON COLUMN test.testContext IS '시험문제';

COMMENT ON COLUMN test.testDate IS '날짜';

CREATE UNIQUE INDEX PK_test
	ON test (
		testSeq ASC
	);

ALTER TABLE test
	ADD
		CONSTRAINT PK_test
		PRIMARY KEY (
			testSeq
		);

ALTER TABLE test
	ADD
		CONSTRAINT FK_teacher_TO_test
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES teacher (
			teacherSeq
		);

ALTER TABLE test
	ADD
		CONSTRAINT FK_subject_TO_test
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES subject (
			subjectSeq
		);
        
DROP INDEX PK_process;

/* 개설과정 */
CREATE TABLE process (
	processSeq NUMBER NOT NULL, /* 개설과정번호 */
	courseSeq NUMBER NOT NULL, /* 과정번호 */
	clsRoomSeq NUMBER NOT NULL, /* 강의실번호 */
	teacherSeq NUMBER NOT NULL, /* 교사번호 */
	processSDate DATE, /* 과정시작날짜 */
	processEDate DATE, /* 과정종료날짜 */
	processCount NUMBER /* 수강정원 */
);

COMMENT ON TABLE process IS '개설과정';

COMMENT ON COLUMN process.processSeq IS '개설과정번호';

COMMENT ON COLUMN process.courseSeq IS '과정번호';

COMMENT ON COLUMN process.clsRoomSeq IS '강의실번호';

COMMENT ON COLUMN process.teacherSeq IS '교사번호';

COMMENT ON COLUMN process.processName IS '과정명';

COMMENT ON COLUMN process.processSDate IS '과정시작날짜';

COMMENT ON COLUMN process.processEDate IS '과정종료날짜';

COMMENT ON COLUMN process.processCount IS '수강정원';

CREATE UNIQUE INDEX PK_process
	ON process (
		processSeq ASC
	);

ALTER TABLE process
	ADD
		CONSTRAINT PK_process
		PRIMARY KEY (
			processSeq
		);

ALTER TABLE process
	ADD
		CONSTRAINT FK_Course_TO_process
		FOREIGN KEY (
			courseSeq
		)
		REFERENCES Course (
			courseSeq
		);

ALTER TABLE process
	ADD
		CONSTRAINT FK_clsRoom_TO_process
		FOREIGN KEY (
			clsRoomSeq
		)
		REFERENCES clsRoom (
			clsRoomSeq
		);

ALTER TABLE process
	ADD
		CONSTRAINT FK_teacher_TO_process
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES teacher (
			teacherSeq
		);
        
DROP INDEX PK_prcSubject;

/* 개설과정과목 */
CREATE TABLE prcSubject (
	prcSubjectSeq NUMBER NOT NULL, /* 개설과정과목번호 */
	processSeq NUMBER NOT NULL, /* 개설과정번호 */
	subjectSeq NUMBER NOT NULL, /* 과목번호 */
	prcSubjectSDate DATE, /* 과목시작날짜 */
	prcSubjectEDate DATE /* 과목종료날짜 */
);

COMMENT ON TABLE prcSubject IS '개설과정과목';

COMMENT ON COLUMN prcSubject.prcSubjectSeq IS '개설과정과목번호';

COMMENT ON COLUMN prcSubject.processSeq IS '개설과정번호';

COMMENT ON COLUMN prcSubject.subjectSeq IS '과목번호';

COMMENT ON COLUMN prcSubject.prcSubjectSDate IS '과목시작날짜';

COMMENT ON COLUMN prcSubject.prcSubjectEDate IS '과목종료날짜';

CREATE UNIQUE INDEX PK_prcSubject
	ON prcSubject (
		prcSubjectSeq ASC
	);

ALTER TABLE prcSubject
	ADD
		CONSTRAINT PK_prcSubject
		PRIMARY KEY (
			prcSubjectSeq
		);

ALTER TABLE prcSubject
	ADD
		CONSTRAINT FK_process_TO_prcSubject
		FOREIGN KEY (
			processSeq
		)
		REFERENCES process (
			processSeq
		);

ALTER TABLE prcSubject
	ADD
		CONSTRAINT FK_subject_TO_prcSubject
		FOREIGN KEY (
			subjectSeq
		)
		REFERENCES subject (
			subjectSeq
		);
        
DROP INDEX PK_scoreAllot;

/* 과목배점 */
CREATE TABLE scoreAllot (
	scoreAllotSeq NUMBER NOT NULL, /* 과목배점번호 */
	prcSubjectSeq NUMBER NOT NULL, /* 개설과정과목번호 */
	teacherSeq NUMBER NOT NULL, /* 교사번호 */
	attendAllot NUMBER, /* 출석배점 */
	writingAllot NUMBER, /* 필기배점 */
	realAllot NUMBER /* 실기배점 */
);

COMMENT ON TABLE scoreAllot IS '과목배점';

COMMENT ON COLUMN scoreAllot.scoreAllotSeq IS '과목배점번호';

COMMENT ON COLUMN scoreAllot.prcSubjectSeq IS '개설과정과목번호';

COMMENT ON COLUMN scoreAllot.teacherSeq IS '교사번호';

COMMENT ON COLUMN scoreAllot.attendAllot IS '출석배점';

COMMENT ON COLUMN scoreAllot.writingAllot IS '필기배점';

COMMENT ON COLUMN scoreAllot.realAllot IS '실기배점';

CREATE UNIQUE INDEX PK_scoreAllot
	ON scoreAllot (
		scoreAllotSeq ASC
	);

ALTER TABLE scoreAllot
	ADD
		CONSTRAINT PK_scoreAllot
		PRIMARY KEY (
			scoreAllotSeq
		);

ALTER TABLE scoreAllot
	ADD
		CONSTRAINT FK_teacher_TO_scoreAllot
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES teacher (
			teacherSeq
		);

ALTER TABLE scoreAllot
	ADD
		CONSTRAINT FK_prcSubject_TO_scoreAllot
		FOREIGN KEY (
			prcSubjectSeq
		)
		REFERENCES prcSubject (
			prcSubjectSeq
		);
        
        
/* 츨결 */
DROP TABLE attendance 
	CASCADE CONSTRAINTS;

/* 츨결 */
CREATE TABLE attendance (
	attendanceSeq NUMBER NOT NULL, /* 출결번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	processSeq NUMBER NOT NULL, /* 개설과정번호 */
	attendanceDate DATE, /* 날짜 */
	attendanceStime DATE, /* 등원시간 */
	attendanceETime DATE, /* 하원시간 */
	attendanceST VARCHAR2(20) /* 상태(정상,지각,조퇴,외출,병가,기타) */
);

CREATE UNIQUE INDEX PK_attendance
	ON attendance (
		attendanceSeq ASC
	);

ALTER TABLE attendance
	ADD
		CONSTRAINT PK_attendance
		PRIMARY KEY (
			attendanceSeq
		)
		NOT DEFERRABLE
		INITIALLY IMMEDIATE
		ENABLE
		VALIDATE;

ALTER TABLE attendance
	ADD
		CONSTRAINT FK_student_TO_attendance
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		)
		NOT DEFERRABLE
		INITIALLY IMMEDIATE
		ENABLE
		VALIDATE;

ALTER TABLE attendance
	ADD
		CONSTRAINT FK_process_TO_attendance
		FOREIGN KEY (
			processSeq
		)
		REFERENCES process (
			processSeq
		)
		NOT DEFERRABLE
		INITIALLY IMMEDIATE
		ENABLE
		VALIDATE;

ALTER TABLE attendance DROP CONSTRAINT FK_process_TO_attendance;
        
--=========================================================================================================================================================        
--=========================================================================================================================================================
-- 나중에 만들 기능관련 테이블 
--=========================================================================================================================================================        
--=========================================================================================================================================================

-- 교사평가
DROP INDEX PK_tGrade;

/* 교사평가 */
DROP TABLE tGrade 
	CASCADE CONSTRAINTS;

/* 교사평가 */
CREATE TABLE tGrade (
	tGradeSeq NUMBER NOT NULL, /* 교사평가번호 */
	teacherSeq NUMBER NOT NULL, /* 교사번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	tGradeScore NUMBER, /* 점수(1~10) */
	tGradeRw VARCHAR2(1000) /* 한줄평 */
);

COMMENT ON TABLE tGrade IS '교사평가';

COMMENT ON COLUMN tGrade.tGradeSeq IS '교사평가번호';

COMMENT ON COLUMN tGrade.teacherSeq IS '교사번호';

COMMENT ON COLUMN tGrade.studentSeq IS '교육생번호';

COMMENT ON COLUMN tGrade.tGradeScore IS '점수(1~10)';

COMMENT ON COLUMN tGrade.tGradeRw IS '한줄평';

CREATE UNIQUE INDEX PK_tGrade
	ON tGrade (
		tGradeSeq ASC
	);

ALTER TABLE tGrade
	ADD
		CONSTRAINT PK_tGrade
		PRIMARY KEY (
			tGradeSeq
		);

ALTER TABLE tGrade
	ADD
		CONSTRAINT FK_teacher_TO_tGrade
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES teacher (
			teacherSeq
		);

ALTER TABLE tGrade
	ADD
		CONSTRAINT FK_student_TO_tGrade
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);
        
        
-- 과정평가
DROP INDEX PK_cGrade;

/* 과정평가 */
DROP TABLE cGrade 
	CASCADE CONSTRAINTS;

/* 과정평가 */
CREATE TABLE cGrade (
	cGradeSeq NUMBER NOT NULL, /* 과정평가번호 */
	processSeq NUMBER NOT NULL, /* 개설과정번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	cGradeScore NUMBER, /* 점수(1~10) */
	cGradeRw VARCHAR2(1000) /* 한줄평 */
);

COMMENT ON TABLE cGrade IS '과정평가';

COMMENT ON COLUMN cGrade.cGradeSeq IS '과정평가번호';

COMMENT ON COLUMN cGrade.processSeq IS '개설과정번호';

COMMENT ON COLUMN cGrade.studentSeq IS '교육생번호';

COMMENT ON COLUMN cGrade.cGradeScore IS '점수(1~10)';

COMMENT ON COLUMN cGrade.cGradeRw IS '한줄평';

CREATE UNIQUE INDEX PK_cGrade
	ON cGrade (
		cGradeSeq ASC
	);

ALTER TABLE cGrade
	ADD
		CONSTRAINT PK_cGrade
		PRIMARY KEY (
			cGradeSeq
		);

ALTER TABLE cGrade
	ADD
		CONSTRAINT FK_student_TO_cGrade
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);

ALTER TABLE cGrade
	ADD
		CONSTRAINT FK_process_TO_cGrade
		FOREIGN KEY (
			processSeq
		)
		REFERENCES process (
			processSeq
		);
        
-- 교육생 평가
DROP INDEX PK_sGrade;

/* 교육생평가 */
DROP TABLE sGrade 
	CASCADE CONSTRAINTS;

/* 교육생평가 */
CREATE TABLE sGrade (
	sGradeSeq NUMBER NOT NULL, /* 교육생평가번호 */
	teacherSeq NUMBER NOT NULL, /* 교사번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	sGradeScore NUMBER, /* 학생평균점수 */
	sGradeRw VARCHAR2(1000) /* 한줄평 */
);

COMMENT ON TABLE sGrade IS '교육생평가';

COMMENT ON COLUMN sGrade.sGradeSeq IS '교육생평가번호';

COMMENT ON COLUMN sGrade.teacherSeq IS '교사번호';

COMMENT ON COLUMN sGrade.studentSeq IS '교육생번호';

COMMENT ON COLUMN sGrade.sGradeScore IS '학생평균점수';

COMMENT ON COLUMN sGrade.sGradeRw IS '한줄평';

CREATE UNIQUE INDEX PK_sGrade
	ON sGrade (
		sGradeSeq ASC
	);

ALTER TABLE sGrade
	ADD
		CONSTRAINT PK_sGrade
		PRIMARY KEY (
			sGradeSeq
		);

ALTER TABLE sGrade
	ADD
		CONSTRAINT FK_student_TO_sGrade
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);

ALTER TABLE sGrade
	ADD
		CONSTRAINT FK_teacher_TO_sGrade
		FOREIGN KEY (
			teacherSeq
		)
		REFERENCES teacher (
			teacherSeq
		);
        
-- 자격증
DROP INDEX PK_crtf;

/* 자격증 */
DROP TABLE crtf 
	CASCADE CONSTRAINTS;

/* 자격증 */
CREATE TABLE crtf (
	crtfSeq NUMBER NOT NULL, /* 자격증번호 */
	crtfName VARCHAR2(200) NOT NULL, /* 자격증명 */
	crtfService VARCHAR2(200) /* 인증기관 */
);

COMMENT ON TABLE crtf IS '자격증';

COMMENT ON COLUMN crtf.crtfSeq IS '자격증번호';

COMMENT ON COLUMN crtf.crtfName IS '자격증명';

COMMENT ON COLUMN crtf.crtfService IS '인증기관';

CREATE UNIQUE INDEX PK_crtf
	ON crtf (
		crtfSeq ASC
	);

ALTER TABLE crtf
	ADD
		CONSTRAINT PK_crtf
		PRIMARY KEY (
			crtfSeq
		);
        
-- 교육생 자격증
DROP INDEX PK_studentCrtf;

/* 교육생자격증 */
DROP TABLE studentCrtf 
	CASCADE CONSTRAINTS;

/* 교육생자격증 */
CREATE TABLE studentCrtf (
	studentCrtfSeq NUMBER NOT NULL, /* 교육생자격증번호 */
	crtfSeq NUMBER NOT NULL, /* 자격증번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	studentCrtfDate DATE /* 취득일 */
);

COMMENT ON TABLE studentCrtf IS '교육생자격증';

COMMENT ON COLUMN studentCrtf.studentCrtfSeq IS '교육생자격증번호';

COMMENT ON COLUMN studentCrtf.crtfSeq IS '자격증번호';

COMMENT ON COLUMN studentCrtf.studentSeq IS '교육생번호';

COMMENT ON COLUMN studentCrtf.studentCrtfDate IS '취득일';

CREATE UNIQUE INDEX PK_studentCrtf
	ON studentCrtf (
		studentCrtfSeq ASC
	);

ALTER TABLE studentCrtf
	ADD
		CONSTRAINT PK_studentCrtf
		PRIMARY KEY (
			studentCrtfSeq
		);

ALTER TABLE studentCrtf
	ADD
		CONSTRAINT FK_crtf_TO_studentCrtf
		FOREIGN KEY (
			crtfSeq
		)
		REFERENCES crtf (
			crtfSeq
		);

ALTER TABLE studentCrtf
	ADD
		CONSTRAINT FK_student_TO_studentCrtf
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);
        
-- 주요기술스택

DROP INDEX PK_tech;

/* 주요기술스택 */
DROP TABLE tech 
	CASCADE CONSTRAINTS;

/* 주요기술스택 */
CREATE TABLE tech (
	techSeq NUMBER NOT NULL, /* 주요기술스택번호 */
	techName VARCHAR2(200) /* 기술명(자바.파이썬,AWS등) */
);

COMMENT ON TABLE tech IS '주요기술스택';

COMMENT ON COLUMN tech.techSeq IS '주요기술스택번호';

COMMENT ON COLUMN tech.techName IS '기술명(자바.파이썬,AWS등)';

CREATE UNIQUE INDEX PK_tech
	ON tech (
		techSeq ASC
	);

ALTER TABLE tech
	ADD
		CONSTRAINT PK_tech
		PRIMARY KEY (
			techSeq
		);
        
-- 팀
DROP INDEX PK_team;

/* 팀 */
DROP TABLE team 
	CASCADE CONSTRAINTS;

/* 팀 */
CREATE TABLE team (
	teamSeq NUMBER NOT NULL, /* 팀번호 */
	testSeq NUMBER NOT NULL, /* 시험정보번호 */
	studentSeq NUMBER NOT NULL, /* 교육생번호 */
	teamName VARCHAR2(200) /* 팀이름 */
);

COMMENT ON TABLE team IS '팀';

COMMENT ON COLUMN team.teamSeq IS '팀번호';

COMMENT ON COLUMN team.testSeq IS '시험정보번호';

COMMENT ON COLUMN team.studentSeq IS '교육생번호';

COMMENT ON COLUMN team.teamName IS '팀이름';

CREATE UNIQUE INDEX PK_team
	ON team (
		teamSeq ASC
	);

ALTER TABLE team
	ADD
		CONSTRAINT PK_team
		PRIMARY KEY (
			teamSeq
		);

ALTER TABLE team
	ADD
		CONSTRAINT FK_test_TO_team
		FOREIGN KEY (
			testSeq
		)
		REFERENCES test (
			testSeq
		);

ALTER TABLE team
	ADD
		CONSTRAINT FK_student_TO_team
		FOREIGN KEY (
			studentSeq
		)
		REFERENCES student (
			studentSeq
		);
        
-- 기업

drop table enter;

--기업 
CREATE TABLE enter (
    enterSeq NUMBER NOT NULL, /* 기업번호 */
    crtfSeq NUMBER NOT NULL, /*자격증번호 */
    techSeq NUMBER NOT NULL, /* 주요기술스택번호 */
    enterName VARCHAR2(100), /* 기업명 */
    enterBuseo VARCHAR2(300), /* 부서 */
    enterLocation VARCHAR2(100), /* 위치 */
    enterSalary NUMBER /* 초봉 */
);

COMMENT ON TABLE enter IS '기업';

COMMENT ON COLUMN enter.enterSeq IS '기업번호';

COMMENT ON COLUMN enter.crtfSeq IS '자격증번호';

COMMENT ON COLUMN enter.techSeq IS '주요기술스택번호';

COMMENT ON COLUMN enter.enterName IS '기업명';

COMMENT ON COLUMN enter.enterBuseo IS '부서';

COMMENT ON COLUMN enter.enterLocation IS '위치';

COMMENT ON COLUMN enter.enterSalary IS '초봉';

CREATE UNIQUE INDEX PK_enter
    ON enter (
        enterSeq ASC
    );

ALTER TABLE enter
    ADD
        CONSTRAINT PK_enter
        PRIMARY KEY (
            enterSeq
        );

ALTER TABLE enter
    ADD
        CONSTRAINT FK_tech_TO_enter
        FOREIGN KEY (
            techSeq
        )
        REFERENCES tech (
            techSeq
        );

ALTER TABLE enter
    ADD
        CONSTRAINT FK_crtf_TO_enter
        FOREIGN KEY (
            crtfSeq
        )
        REFERENCES crtf (
            crtfSeq
        );
        
-- 프로젝트

DROP INDEX PK_project;

/* 프로젝트 */
DROP TABLE project 
	CASCADE CONSTRAINTS;

/* 프로젝트 */
CREATE TABLE project (
	projectSeq NUMBER NOT NULL, /* 프로젝트번호 */
	teamSeq NUMBER NOT NULL, /* 팀번호 */
	techSeq NUMBER NOT NULL, /* 주요기술스택번호 */
	projectName VARCHAR2(300), /* 프로젝트명 */
	projectDate DATE, /* 수행기간 */
	projectContent VARCHAR2(2000) /* 프로젝트설명 */
);

COMMENT ON TABLE project IS '프로젝트';

COMMENT ON COLUMN project.projectSeq IS '프로젝트번호';

COMMENT ON COLUMN project.teamSeq IS '팀번호';

COMMENT ON COLUMN project.techSeq IS '주요기술스택번호';

COMMENT ON COLUMN project.projectName IS '프로젝트명';

COMMENT ON COLUMN project.projectDate IS '수행기간';

COMMENT ON COLUMN project.projectContent IS '프로젝트설명';

CREATE UNIQUE INDEX PK_project
	ON project (
		projectSeq ASC
	);

ALTER TABLE project
	ADD
		CONSTRAINT PK_project
		PRIMARY KEY (
			projectSeq
		);

ALTER TABLE project
	ADD
		CONSTRAINT FK_team_TO_project
		FOREIGN KEY (
			teamSeq
		)
		REFERENCES team (
			teamSeq
		);

ALTER TABLE project
	ADD
		CONSTRAINT FK_tech_TO_project
		FOREIGN KEY (
			techSeq
		)
		REFERENCES tech (
			techSeq
		);
        



















































