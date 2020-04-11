--------------------------------------------------------
--  2.���@ �Ѯ�B�a�� Drop
--------------------------------------------------------
DROP SEQUENCE "DA106G5"."LOC_RPT_SEQ";
DROP SEQUENCE "DA106G5"."LOC_NO_SEQ";
DROP TABLE "DA106G5"."LOC_RPT" cascade constraints;
DROP TABLE "DA106G5"."LOCATION" cascade constraints;
DROP TABLE "DA106G5"."LOC_TYPE" cascade constraints;
DROP TABLE "DA106G5"."WEATHER" cascade constraints;
DROP TABLE "DA106G5"."WEATHER_DETAIL" cascade constraints;

--�a�к��� Create--
CREATE TABLE loc_type (
 loc_typeno VARCHAR2(20) NOT NULL,
 loc_info VARCHAR2(20) NOT NULL
);

ALTER TABLE loc_type ADD CONSTRAINT PK_loc_type PRIMARY KEY (loc_typeno);

--�a�к��� ���ӬO�u���--
Insert into loc_type (loc_typeno,loc_info) values (1, '�a�I');
Insert into loc_type (loc_typeno,loc_info) values (2, '�Z��');
Insert into loc_type (loc_typeno,loc_info) values (3, '�ɤ��I');

--�a�� Create--
CREATE TABLE location (
 loc_no VARCHAR2(20) NOT NULL,
 loc_typeno VARCHAR2(20) NOT NULL,
 longitude VARCHAR2(20) NOT NULL,
 latitude VARCHAR2(20) NOT NULL,
 loc_status NUMBER(1) DEFAULT 2 NOT NULL,
 loc_address VARCHAR2(90),
 loc_pic BLOB
);

ALTER TABLE location ADD CONSTRAINT PK_location PRIMARY KEY (loc_no);

--�a�Ц��ӥ~��b�a�к���--
ALTER TABLE location ADD CONSTRAINT FK_location FOREIGN KEY (loc_typeno) REFERENCES loc_type (loc_typeno);

CREATE SEQUENCE loc_no_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE;

--�a�� �����--
Insert into location (loc_no,loc_typeno,longitude,latitude,loc_status,loc_address) values ('loc'||LPAD(to_char(loc_no_seq.NEXTVAL), 5, '0'),1,123.456,78.90,2,'��饫���c��');
Insert into location (loc_no,loc_typeno,longitude,latitude,loc_address) values ('loc'||LPAD(to_char(loc_no_seq.NEXTVAL), 5, '0'),1,123.456,78.90,'�����F�����E�M');
Insert into location (loc_no,loc_typeno,longitude,latitude,loc_status,loc_address) values ('loc'||LPAD(to_char(loc_no_seq.NEXTVAL), 5, '0'),2,123.456,78.90,2,'���Ӯa');
Insert into location (loc_no,loc_typeno,longitude,latitude,loc_address) values ('loc'||LPAD(to_char(loc_no_seq.NEXTVAL), 5, '0'),2,123.456,78.90,'�R���p��');
Insert into location (loc_no,loc_typeno,longitude,latitude,loc_status,loc_address) values ('loc'||LPAD(to_char(loc_no_seq.NEXTVAL), 5, '0'),3,123.456,78.90,2,'�a�����');
Insert into location (loc_no,loc_typeno,longitude,latitude,loc_address) values ('loc'||LPAD(to_char(loc_no_seq.NEXTVAL), 5, '0'),3,123.456,78.90,'�}�}�}');

--�a�����| Create--
CREATE TABLE loc_rpt (
 loc_rpt_no   VARCHAR2(20)          NOT NULL,
 rpt_reason   CLOB,
 rpt_status   NUMBER(1) DEFAULT'1'  NOT NULL,
 loc_no       VARCHAR2(20)          NOT NULL,
 mb_id        VARCHAR2(20)
);

ALTER TABLE loc_rpt ADD CONSTRAINT PK_loc_rpt PRIMARY KEY (loc_rpt_no);

CREATE SEQUENCE loc_rpt_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--�a�����| �����--
INSERT INTO "LOC_RPT" (LOC_RPT_NO, RPT_REASON, RPT_STATUS, LOC_NO, MB_ID) VALUES ('locr'||LPAD(to_char(LOC_RPT_SEQ.nextval), 5, '0'), 'LOCATIONreport1', '1', 'loc00001', 'soowii123');
INSERT INTO "LOC_RPT" (LOC_RPT_NO, RPT_REASON, LOC_NO, MB_ID) VALUES ('locr'||LPAD(to_char(LOC_RPT_SEQ.nextval), 5, '0'), 'LOCATIONreport2', 'loc00002', 'xuan123');
INSERT INTO "LOC_RPT" (LOC_RPT_NO, RPT_REASON, RPT_STATUS, LOC_NO, MB_ID) VALUES ('locr'||LPAD(to_char(LOC_RPT_SEQ.nextval), 5, '0'), 'LOCATIONreport3', '1', 'loc00003', 'michael123');
INSERT INTO "LOC_RPT" (LOC_RPT_NO, RPT_REASON, LOC_NO, MB_ID) VALUES ('locr'||LPAD(to_char(LOC_RPT_SEQ.nextval), 5, '0'), 'LOCATIONreport4', 'loc00004', 'vain123');
INSERT INTO "LOC_RPT" (LOC_RPT_NO, RPT_REASON, RPT_STATUS, LOC_NO, MB_ID) VALUES ('locr'||LPAD(to_char(LOC_RPT_SEQ.nextval), 5, '0'), 'LOCATIONreport5', '1', 'loc00005', 'yiwen123');


--�Ѯ� Create--
CREATE TABLE weather (
 wth_status VARCHAR2(30) NOT NULL,
 weather_pic BLOB
);

ALTER TABLE weather ADD CONSTRAINT PK_weather PRIMARY KEY (wth_status);

--�Ѯ� �����--
Insert into weather (wth_status) values ('��');
Insert into weather (wth_status) values ('�B');
Insert into weather (wth_status) values ('��');
Insert into weather (wth_status) values ('���ɦh�����}�B');
Insert into weather (wth_status) values ('�䭷');

--�ԲӤѮ� Create--
CREATE TABLE weather_detail (
 weather_time TIMESTAMP(6) NOT NULL,
 weather_place VARCHAR2(30) NOT NULL,
 wth_status VARCHAR2(30) NOT NULL,
 wth_high NUMBER(3),
 wth_low NUMBER(3),
 wth_comfort VARCHAR2(30),
 wth_rain_chance NUMBER(3)
);

ALTER TABLE weather_detail ADD CONSTRAINT PK_weather_detail PRIMARY KEY (weather_time,weather_place);

--�ԲӤѮ𦳭ӥ~��b�Ѯ�--
ALTER TABLE weather_detail ADD CONSTRAINT FK_weather_detail FOREIGN KEY (wth_status) REFERENCES weather (wth_status);

--�ԲӤѮ� �����--
Insert into weather_detail (weather_time,weather_place,wth_status) values (TO_TIMESTAMP('2020-03-14 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), '��饫','��');
Insert into weather_detail (weather_time,weather_place,wth_status) values (TO_TIMESTAMP('2020-03-14 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), '��饫','�B');
Insert into weather_detail (weather_time,weather_place,wth_status) values (TO_TIMESTAMP('2020-03-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), '��饫','��');
Insert into weather_detail (weather_time,weather_place,wth_status) values (TO_TIMESTAMP('2020-03-14 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), '������','���ɦh�����}�B');
Insert into weather_detail (weather_time,weather_place,wth_status) values (TO_TIMESTAMP('2020-03-14 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), '������','�䭷');
