/*for table PERSONS*/
insert into Persons values (1, 'Queenie', 'Luc', '123street', 'qluc@ualberta.ca', 7804443333);
insert into Persons values (2, 'Bobby', 'Locket', 'abcstreet', 'blocet@ualberta.ca', 7804657777);
insert into Persons values (3, 'Mai', 'Lee', '456street', 'mlee@ualberta.ca', 7804423333);
insert into Persons values (4, 'Dawn', 'Tea', '444street', 'dtea@ualberta.ca', 7804553333);
insert into Persons values (5, 'John', 'Mary', '13street', 'jmary@ualberta.ca', 7804448888);
insert into Persons values (6, 'Poppy', 'Flower', '1223street', 'pflower@ualberta.ca', 7804443326);
insert into Persons values (7, 'Merphie', 'Johnston', '1456 Park Ave', 'mjohnston@ualberta.ca', 7804473333);
insert into Persons values (8, 'Shirley', 'Li', 'University driveway', 'sli@ualberta.ca', 7804233553);
insert into Persons values (9, 'Hope', 'Star', 'Heaven street', 'hstar@ualberta.ca', 7804773333);
insert into Persons values (10, 'Bob', 'Duncan', '4455 ave 123street', 'bduncan@ualberta.ca', 7804493566);
insert into Persons values (11, 'Life of', 'Student', 'Unversity', 'los@ualberta.ca', 7807765555);

/*for table USERS*/
insert into USERS values ('user1', 'testing', 'a', 001, '03-Apr-32');

insert into USERS values ('daGreatone', 'iamadoctor123', 'd', 001, '03-Apr-32');

insert into USERS values ('patient', 'test123', 'p', 2, '03-Apr-1972');
insert into USERS values ('radio', 'test@45', 'r', 2, '03-Jan-1982');

insert into USERS values ('doc', 'imdoctortwo', 'd', 3, '15-Mar-1942');
insert into USERS values ('admin', 'admin', 'a', 3, '03-Jan-1952');

insert into USERS values ('record', 'radio', 'r', 4, '03-Mar-1933');
insert into USERS values ('catz', 'lollipop', 'p', 4, '03-Mar-1933');

insert into USERS values ('katz', 'candy', 'a', 5, '19-Jun-2000');
insert into USERS values ('qatz', 'cars5000', 'd', 5, '03-Feb-2004');
insert into USERS values ('third_five', 'hondacivic', 'p', 5, '09-Oct-2000');


insert into USERS values ('cowboyz', 'red', 'p', 6, '03-Apr-2010');
insert into USERS values ('zee', 'cowz', 'r', 6, '21-Aug-32');

insert into USERS values ('daqee', 'password', 'd', 7, '03-Jan-2010');
insert into USERS values ('testuser', 'test', 'a', 7, '03-Nov-2010');

insert into USERS values ('catlover', 'meow', 'r', 8, '20-Apr-1999');
insert into USERS values ('dogz', 'woof', 'p', 8, '09-Apr-1995');

insert into USERS values ('golden_retriever', 'gold', 'a', 9, '25-Sep-1978');

insert into USERS values ('Husky', 'awsome', 'p', 10, '30-Mar-1982');

insert into USERS values ('zombie', 'student', 'p', 11, '30-Mar-2010');

/*for table FAMILY_DOCTOR*/
/*doctors - 1, 3, 5, 7 */
/*patients - 2, 4, 5, 6, 8, 10, 11*/
insert into FAMILY_DOCTOR values (1,2);
insert into FAMILY_DOCTOR values (3,2);
insert into FAMILY_DOCTOR values (5,6);
insert into FAMILY_DOCTOR values (1,5);
insert into FAMILY_DOCTOR values (3,8);
insert into FAMILY_DOCTOR values (3,10);
insert into FAMILY_DOCTOR values (5,8);
insert into FAMILY_DOCTOR values (5,11);

/*for table RADIOLOGY_RECORD*/
/*radiologist - 2, 4, 6, 8*/
/*person id 2 diagnosis with cancer*/
INSERT into radiology_record VALUES (1, 2, 3, 2, 'leg movement', '14-Jan-1999', '14-Jan-1999', 'Cancer', 'testing if there is allowed multiple lineems to let me');
/*different person id 4 diagnosis with cancer*/
INSERT into radiology_record VALUES (2, 4, 3, 2, 'arm movement', '14-Jan-1978', '14-Apr-1978', 'Cancer', 'testing if there is allowed multiple lineems to let me');
/*differnt person id 4 diagnosis with cancer at later date*/
INSERT into radiology_record VALUES (3, 4, 1, 4, 'emr scan', '25-Dec-1989', '14-Mar-1990', 'Cancer', 'search up easy please');
INSERT into radiology_record VALUES (3, 5, 1, 2, 'emr scan', '25-Feb-1989', '14-Jan-1989', 'Cancer', 'school is almost done!');
/*person id 2 diagnosis with cancer at earlier date*/
INSERT into radiology_record VALUES (4, 2, 5, 6, 'emr scan', '26-Jan-1977', '13-Aug-1977', 'Cancer', 'city in the far distance to the far right around to the far left');
/*person id 2 diagnosis with cancer at later date*/
INSERT into radiology_record VALUES (5, 2, 7, 6, 'leg movement', '13-Jan-2001', '14-Feb-2001', 'Cancer', 'Iron man 1, 2, 3');
INSERT into radiology_record VALUES (6, 5, 1, 8, 'arm movement', '13-Jan-2008', '14-Feb-2008', 'Cancer', 'not really a description but need to fill in this field');
INSERT into radiology_record VALUES (7, 6, 3, 2, 'wavedance', '05-Sep-2000', '14-Nov-2000', 'Cancer', 'This is unrelated to cancer but do the wave VVVVVVVVVVV');
INSERT into radiology_record VALUES (8, 8, 3, 4, 'eye checkup', '13-Jan-1998', '23-Jun-1998', 'Cancer', 'a patient with a serious case of cancer');
/*person id 5 with differnt diagnosis - flu*/
INSERT into radiology_record VALUES (9, 5, 7, 6, 'eye checkup', '13-Jan-2007', '14-Feb-2007', 'Flu', 'Flu is very common');
/*same person id 5 with flu at earlier date*/
INSERT into radiology_record VALUES (11, 5, 1, 8, 'eye checkup', '13-Feb-1970', '31-May-1970', 'Flu', 'headache, red eyes, running nose');
INSERT into radiology_record VALUES (12, 10, 7, 2, 'leg movement', '13-Mar-1992', '27-May-1992', 'Flu', 'vision unclear, unable to move legs');
INSERT into radiology_record VALUES (13, 6, 5, 4, 'digestion', '13-Feb-2011', '14-May-2011', 'Flu', 'unable to swallow properly');
INSERT into radiology_record VALUES (14, 11, 5, 6, 'brain condition', '13-Feb-2011', '14-Jul-2011', 'brain fried', 'a condition of thhe brain where the student has used too much brainpower and needs a break. =P');