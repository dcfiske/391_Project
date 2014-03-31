CREATE SEQUENCE person_id_sequence;
CREATE SEQUENCE record_id_sequence;
CREATE SEQUENCE image_id_sequence;

CREATE INDEX record_desc_index ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX record_diag_index ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX person_fname_index ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX person_lname_index ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;

@drjobdml record_desc_index 1
@drjobdml record_diag_index 1
@drjobdml person_fname_index 1
@drjobdml person_lname_index 1

CREATE TABLE PATIENT_NUM_IMAGE2(PATIENT_ID varchar(24),TEST_TYPE varchar(24),TIME_ID int, NUM int default 0);

commit;
