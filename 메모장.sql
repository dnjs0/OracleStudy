--------------------------------------------------------
--  파일이 생성됨 - 목요일-1월-16-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TBLMEMO
--------------------------------------------------------

  CREATE TABLE "HR"."TBLMEMO" 
   (	"SEQ" NUMBER(3,0), 
	"NAME" VARCHAR2(30 BYTE) DEFAULT '익명', 
	"MEMO" VARCHAR2(1000 BYTE), 
	"REGDATE" DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into HR.TBLMEMO
SET DEFINE OFF;
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (45,'홍길동','메모입니다.',to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (46,'홍길동','메모입니다.',to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (47,'홍길동',null,to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (48,'홍길동',null,to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (49,'익명',null,to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (50,null,'메모입니다.',to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (51,'익명','메모입니다.',to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (61,'홍길동','메모입니다.',to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (62,'홍길동',null,to_date('25/01/16','RR/MM/DD'));
Insert into HR.TBLMEMO (SEQ,NAME,MEMO,REGDATE) values (63,'익명','메모입니다.',to_date('25/01/16','RR/MM/DD'));
--------------------------------------------------------
--  DDL for Index TBLMEMO_SEQ_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."TBLMEMO_SEQ_PK" ON "HR"."TBLMEMO" ("SEQ") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table TBLMEMO
--------------------------------------------------------

  ALTER TABLE "HR"."TBLMEMO" MODIFY ("REGDATE" NOT NULL ENABLE);
  ALTER TABLE "HR"."TBLMEMO" ADD CONSTRAINT "TBLMEMO_SEQ_PK" PRIMARY KEY ("SEQ")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
