--------------------------------------------------------
--1.�W�a �|��Drop
--------------------------------------------------------
DROP SEQUENCE "DA106G5"."ABILITY_NO_SEQ";
DROP SEQUENCE "DA106G5"."MB_RPT_NO_SEQ";
DROP SEQUENCE "DA106G5"."NTF_NO_SEQ";
DROP SEQUENCE "DA106G5"."QUESTION_NO_SEQ";
DROP SEQUENCE "DA106G5"."MSG_NO_SEQ";

DROP TABLE "DA106G5"."ABILITY" cascade constraints;
DROP TABLE "DA106G5"."AUTHORITY" cascade constraints;
DROP TABLE "DA106G5"."MB_RPT" cascade constraints;
DROP TABLE "DA106G5"."MEMBER" cascade constraints;
DROP TABLE "DA106G5"."MESSAGE" cascade constraints;
DROP TABLE "DA106G5"."NOTIFY" cascade constraints;
DROP TABLE "DA106G5"."QUESTION_RPT" cascade constraints;
DROP TABLE "DA106G5"."STAFF" cascade constraints;

CREATE TABLE ability (
 ability_no VARCHAR2(2) NOT NULL,
 ability_name VARCHAR2(20) NOT NULL
);

ALTER TABLE ability ADD CONSTRAINT PK_ability PRIMARY KEY (ability_no);


CREATE TABLE member (
 mb_id VARCHAR2(20) NOT NULL,
 mb_pwd VARCHAR2(20) NOT NULL,
 mb_line VARCHAR2(20),
 mb_name VARCHAR2(20) NOT NULL,
 mb_gender NUMBER(1) NOT NULL,
 mb_birthday DATE,
 mb_lv NUMBER(2) DEFAULT '1' NOT NULL,
 mb_pic BLOB,
 mb_rpt_times NUMBER(2) DEFAULT '0' NOT NULL,
 mb_email VARCHAR2(20) NOT NULL,
 mb_status NUMBER(1) DEFAULT '1' NOT NULL
);

ALTER TABLE member ADD CONSTRAINT PK_member PRIMARY KEY (mb_id);


CREATE TABLE message (
 msg_no VARCHAR2(20) NOT NULL,
 mb_id_1 VARCHAR2(20) NOT NULL,
 mb_id_2 VARCHAR2(20) NOT NULL,
 msg_content CLOB NOT NULL,
 msg_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 msg_status NUMBER(1) DEFAULT '1' NOT NULL
);

ALTER TABLE message ADD CONSTRAINT PK_message PRIMARY KEY (msg_no);


CREATE TABLE notify (
 ntf_no VARCHAR2(20) NOT NULL,
 mb_id VARCHAR2(20) NOT NULL,
 ntf_content CLOB NOT NULL,
 ntf_status NUMBER(1) DEFAULT '1' NOT NULL
);

ALTER TABLE notify ADD CONSTRAINT PK_notify PRIMARY KEY (ntf_no);


CREATE TABLE question_rpt (
 question_no VARCHAR2(20) NOT NULL,
 mb_id VARCHAR2(20) NOT NULL,
 question_content CLOB NOT NULL,
 question_status NUMBER(1) DEFAULT '1' NOT NULL
);

ALTER TABLE question_rpt ADD CONSTRAINT PK_question_rpt PRIMARY KEY (question_no);


CREATE TABLE staff (
 staff_id VARCHAR2(20) NOT NULL,
 staff_pwd VARCHAR2(20) NOT NULL,
 staff_name VARCHAR2(20) NOT NULL,
 staff_join TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 staff_status NUMBER(1) DEFAULT '1' NOT NULL
);

ALTER TABLE staff ADD CONSTRAINT PK_staff PRIMARY KEY (staff_id);


CREATE TABLE authority (
 staff_id VARCHAR2(20) NOT NULL,
 ability_no VARCHAR2(2) NOT NULL
);

ALTER TABLE authority ADD CONSTRAINT PK_authority PRIMARY KEY (staff_id,ability_no);


CREATE TABLE mb_rpt (
 mb_rpt_no VARCHAR2(20) NOT NULL,
 mb_id_1 VARCHAR2(20) NOT NULL,
 mb_id_2 VARCHAR2(20) NOT NULL,
 rpt_reason CLOB NOT NULL,
 rpt_status NUMBER(1) DEFAULT '1' NOT NULL
);

ALTER TABLE mb_rpt ADD CONSTRAINT PK_mb_rpt PRIMARY KEY (mb_rpt_no);


ALTER TABLE message ADD CONSTRAINT FK_message_0 FOREIGN KEY (mb_id_1) REFERENCES member (mb_id);
ALTER TABLE message ADD CONSTRAINT FK_message_1 FOREIGN KEY (mb_id_2) REFERENCES member (mb_id);


ALTER TABLE notify ADD CONSTRAINT FK_notify_0 FOREIGN KEY (mb_id) REFERENCES member (mb_id);


ALTER TABLE question_rpt ADD CONSTRAINT FK_question_rpt_0 FOREIGN KEY (mb_id) REFERENCES member (mb_id);


ALTER TABLE authority ADD CONSTRAINT FK_authority_0 FOREIGN KEY (staff_id) REFERENCES staff (staff_id);
ALTER TABLE authority ADD CONSTRAINT FK_authority_1 FOREIGN KEY (ability_no) REFERENCES ability (ability_no);


ALTER TABLE mb_rpt ADD CONSTRAINT FK_mb_rpt_0 FOREIGN KEY (mb_id_1) REFERENCES member (mb_id);
ALTER TABLE mb_rpt ADD CONSTRAINT FK_mb_rpt_1 FOREIGN KEY (mb_id_2) REFERENCES member (mb_id);

CREATE SEQUENCE msg_no_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;


CREATE SEQUENCE ntf_no_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE mb_rpt_no_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE ability_no_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE question_no_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--�|��
Insert into MEMBER( MB_ID, MB_PWD, MB_LINE, MB_NAME ,MB_GENDER, MB_BIRTHDAY, MB_EMAIL) 
values('soowii123','123456','soowii_line','soowii','1',TO_DATE('1990-02-15','YYYY-MM-DD'),'soowii123@yahoo.com');
Insert into MEMBER( MB_ID, MB_PWD, MB_LINE, MB_NAME ,MB_GENDER, MB_BIRTHDAY, MB_EMAIL) 
values('xuan123','1234567','xuan_line','xuan','1',TO_DATE('1992-05-01','YYYY-MM-DD'),'xuan123@hotmail.com');
Insert into MEMBER( MB_ID, MB_PWD, MB_LINE, MB_NAME ,MB_GENDER, MB_BIRTHDAY, MB_EMAIL) 
values('michael123','12345678','michael_line','Michael','1',TO_DATE('1989-06-25','YYYY-MM-DD'),'Michael123@yahoo.com');
Insert into MEMBER( MB_ID, MB_PWD, MB_LINE, MB_NAME ,MB_GENDER, MB_BIRTHDAY, MB_EMAIL) 
values('vain123','123456789','vain)line','vain','1',TO_DATE('1987-07-01','YYYY-MM-DD'),'vain123@hotmail.com');
Insert into MEMBER( MB_ID, MB_PWD, MB_LINE, MB_NAME ,MB_GENDER, MB_BIRTHDAY, MB_EMAIL) 
values('yiwen123','1234566','yiwen_line','yiwen123','1',TO_DATE('1985-09-14','YYYY-MM-DD'),'yiwen123@yahoo.com');
Insert into MEMBER( MB_ID, MB_PWD, MB_LINE, MB_NAME ,MB_GENDER, MB_BIRTHDAY, MB_EMAIL) 
values('weijhih123','1234577','weijhih_line','weijhih123','1',TO_DATE('1989-10-19','YYYY-MM-DD'),'weijhih123@yahoo.com');

--�T��
Insert into MESSAGE( MSG_NO, MB_ID_1, MB_ID_2, MSG_CONTENT) 
values('MSN'||LPAD(to_char(msg_no_seq.NEXTVAL), 5, '0'),'soowii123','xuan123','���o�A�n��');
Insert into MESSAGE( MSG_NO, MB_ID_1, MB_ID_2, MSG_CONTENT) 
values('MSN'||LPAD(to_char(msg_no_seq.NEXTVAL), 5, '0'),'xuan123','soowii123','�ٶ٧A�n');
Insert into MESSAGE( MSG_NO, MB_ID_1, MB_ID_2, MSG_CONTENT) 
values('MSN'||LPAD(to_char(msg_no_seq.NEXTVAL), 5, '0'),'michael123','vain123','�ڬO���i');
Insert into MESSAGE( MSG_NO, MB_ID_1, MB_ID_2, MSG_CONTENT) 
values('MSN'||LPAD(to_char(msg_no_seq.NEXTVAL), 5, '0'),'vain123','michael123','�ڬOVain');
Insert into MESSAGE( MSG_NO, MB_ID_1, MB_ID_2, MSG_CONTENT) 
values('MSN'||LPAD(to_char(msg_no_seq.NEXTVAL), 5, '0'),'vain123','michael123','���P');

--�q��
Insert into NOTIFY( NTF_NO, MB_ID, NTF_CONTENT) 
values('NTF'||LPAD(to_char(ntf_no_seq.NEXTVAL), 5, '0'),'xuan123','�o�O��xuan123���q��');
Insert into NOTIFY( NTF_NO, MB_ID, NTF_CONTENT) 
values('NTF'||LPAD(to_char(ntf_no_seq.NEXTVAL), 5, '0'),'xuan123','�o�O��xuan123���q��2');
Insert into NOTIFY( NTF_NO, MB_ID, NTF_CONTENT) 
values('NTF'||LPAD(to_char(ntf_no_seq.NEXTVAL), 5, '0'),'soowii123','�o�O��soowii123���q��');
Insert into NOTIFY( NTF_NO, MB_ID, NTF_CONTENT) 
values('NTF'||LPAD(to_char(ntf_no_seq.NEXTVAL), 5, '0'),'michael123','�o�O��michael123���q��');
Insert into NOTIFY( NTF_NO, MB_ID, NTF_CONTENT) 
values('NTF'||LPAD(to_char(ntf_no_seq.NEXTVAL), 5, '0'),'vain123','�o�O��vain123���q��');

--�|�����|
Insert into MB_RPT( MB_RPT_NO, MB_ID_1, MB_ID_2, RPT_REASON) 
values('MBR'||LPAD(to_char(MB_RPT_NO_SEQ.NEXTVAL), 5, '0'),'xuan123','michael123','xuan123���|michael123');
Insert into MB_RPT( MB_RPT_NO, MB_ID_1, MB_ID_2, RPT_REASON) 
values('MBR'||LPAD(to_char(MB_RPT_NO_SEQ.NEXTVAL), 5, '0'),'soowii123','vain123','soowii123���|vain123');
Insert into MB_RPT( MB_RPT_NO, MB_ID_1, MB_ID_2, RPT_REASON) 
values('MBR'||LPAD(to_char(MB_RPT_NO_SEQ.NEXTVAL), 5, '0'),'yiwen123','weijhih123','yiwen123���|weijhih123');
Insert into MB_RPT( MB_RPT_NO, MB_ID_1, MB_ID_2, RPT_REASON) 
values('MBR'||LPAD(to_char(MB_RPT_NO_SEQ.NEXTVAL), 5, '0'),'weijhih123','xuan123','weijhih123���|xuan123');
Insert into MB_RPT( MB_RPT_NO, MB_ID_1, MB_ID_2, RPT_REASON) 
values('MBR'||LPAD(to_char(MB_RPT_NO_SEQ.NEXTVAL), 5, '0'),'vain123','yiwen123','vain123���|yiwen123');

--�^�����D
Insert into QUESTION_RPT( QUESTION_NO, MB_ID, QUESTION_CONTENT) 
values('QUR'||LPAD(to_char(QUESTION_NO_SEQ.NEXTVAL), 5, '0'),'xuan123','xuan123�^�����D');
Insert into QUESTION_RPT( QUESTION_NO, MB_ID, QUESTION_CONTENT) 
values('QUR'||LPAD(to_char(QUESTION_NO_SEQ.NEXTVAL), 5, '0'),'michael123','michael123�^�����D');
Insert into QUESTION_RPT( QUESTION_NO, MB_ID, QUESTION_CONTENT) 
values('QUR'||LPAD(to_char(QUESTION_NO_SEQ.NEXTVAL), 5, '0'),'vain123','vain123�^�����D');
Insert into QUESTION_RPT( QUESTION_NO, MB_ID, QUESTION_CONTENT) 
values('QUR'||LPAD(to_char(QUESTION_NO_SEQ.NEXTVAL), 5, '0'),'weijhih123','weijhih123�^�����D');
Insert into QUESTION_RPT( QUESTION_NO, MB_ID, QUESTION_CONTENT) 
values('QUR'||LPAD(to_char(QUESTION_NO_SEQ.NEXTVAL), 5, '0'),'soowii123','soowii123�^�����D');

--�޲z��
Insert into STAFF( STAFF_ID, STAFF_PWD, STAFF_NAME) 
values('staff_xuan','1234','xuan');
Insert into STAFF( STAFF_ID, STAFF_PWD, STAFF_NAME) 
values('staff_michael','12345','michael');
Insert into STAFF( STAFF_ID, STAFF_PWD, STAFF_NAME) 
values('staff_vain','123456','vain');
Insert into STAFF( STAFF_ID, STAFF_PWD, STAFF_NAME) 
values('staff_soowii','1234567','soowii');
Insert into STAFF( STAFF_ID, STAFF_PWD, STAFF_NAME) 
values('staff_weijhih','12345678','weijhih');

--�\��
Insert into ABILITY( ABILITY_NO, ABILITY_NAME) 
values(LPAD(to_char(ABILITY_NO_SEQ.NEXTVAL), 2, '0'),'�v���޲z');
Insert into ABILITY( ABILITY_NO, ABILITY_NAME) 
values(LPAD(to_char(ABILITY_NO_SEQ.NEXTVAL), 2, '0'),'�d���޲z');
Insert into ABILITY( ABILITY_NO, ABILITY_NAME) 
values(LPAD(to_char(ABILITY_NO_SEQ.NEXTVAL), 2, '0'),'���|�޲z');
Insert into ABILITY( ABILITY_NO, ABILITY_NAME) 
values(LPAD(to_char(ABILITY_NO_SEQ.NEXTVAL), 2, '0'),'�ӫ��޲z');
Insert into ABILITY( ABILITY_NO, ABILITY_NAME) 
values(LPAD(to_char(ABILITY_NO_SEQ.NEXTVAL), 2, '0'),'���D�^���޲z');

--�\��
Insert into AUTHORITY( STAFF_ID, ABILITY_NO) 
values('staff_xuan','01');
Insert into AUTHORITY( STAFF_ID, ABILITY_NO) 
values('staff_xuan','02');
Insert into AUTHORITY( STAFF_ID, ABILITY_NO) 
values('staff_michael','03');
Insert into AUTHORITY( STAFF_ID, ABILITY_NO) 
values('staff_michael','01');
Insert into AUTHORITY( STAFF_ID, ABILITY_NO) 
values('staff_michael','02');