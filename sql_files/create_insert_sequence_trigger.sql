CREATE TABLE admin (
    id NUMBER(10) NOT null ,
    username varchar2(255) NOT NULL,
    password varchar2(255) NOT NULL,
    CONSTRAINT admin_pk PRIMARY KEY(id)
);

CREATE SEQUENCE project_seq --sequence 1
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 20;

CREATE SEQUENCE thesis_seq --sequence 2
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 20;


CREATE TABLE project (
        id NUMBER(10) NOT NULL,
        name VARCHAR2(255) NOT NULL,
        description VARCHAR2(255) NOT NULL,

        CONSTRAINT project_pk PRIMARY KEY(id)
);


--now creating the trigger for autoincrement using the sequence

CREATE OR REPLACE TRIGGER project
    BEFORE INSERT ON project FOR EACH ROW
    BEGIN
        SELECT project_seq.nextval INTO :NEW.id FROM dual;
    end;
--trigger created successfully, now testing the trigger and inserting the data



insert into project(name,description) values('Software Project 1','These phases are placed in context through a general introduction to software project management, ethics and software process maturity.In the project, students firstly produce a requirements document.');
insert into project(name,description) values('Software Project 2','After completion of software project 1 students will develop than project in software project 2');
insert into project(name,description) values('Android Task Monitoring','The developed project is a tasks reminder app, with AI-powered Chatbot that will make user enjoy productivity.This application helps you to make sure that the tasks you set actually get done, with the help of its AI assistant.');
insert into project(name,description) values('E Commerce for Online Medicine Shopping','All the stock of medicine is update automatically in the new system.Maintaining stock, Supplier information, Customer information & bill information are easy.');
insert into project(name,description) values('Canteen Food Ordering and Management System','In Online Food Ordering System Admin can handle the functionalities like add new food items, edit/delete food items, Enable/Disable the food items according to season and availability.');
select * from project;

--insertion successful, the trigger working fine

CREATE TABLE thesis (
        id NUMBER(10) NOT NULL,
        name VARCHAR2(255) NOT NULL,
        description VARCHAR2(255) NOT NULL,


        CONSTRAINT thesis_pk PRIMARY KEY(id) );


drop sequence thesis_seq;

CREATE SEQUENCE thesis_seq
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 20; --sequence created


CREATE OR REPLACE TRIGGER thesis
    BEFORE INSERT ON thesis FOR EACH ROW
    BEGIN
        SELECT thesis_seq.nextval INTO :NEW.id FROM dual;
    end; --thesis

--now inserting value and testing trigger in the thesis table

insert into thesis(name,description) values('Image Processing','In computer science, digital image processing is the use of computer algorithms to perform image processing on digital images.');
insert into thesis(name,description) values('Mobile Cloud Computing','Mobile Cloud Computing is the combination of cloud computing and mobile computing to bring rich computational resources to mobile users, network operators, as well as cloud computing providers.');
insert into thesis(name,description) values('Natural Language Processing','Natural language processing is a subfield of linguistics, computer science, information engineering, and artificial intelligence.');
insert into thesis(name,description) values('BIG DATA','"Big data" is a field that treats ways to analyze, systematically extract information from, or otherwise deal with data sets that are too large or complex to be dealt with by traditional data-processing application software.');
insert into thesis(name,description) values('Self-Switching Power Supply','A switched-mode power supply is an electronic circuit that converts power using switching devices that are turned on and off at high frequencies, and storage components such as inductors.');

select * from thesis; --thesis table done

CREATE TABLE university(
        id NUMBER(10) NOT NULL,
        name VARCHAR2(100) NOT NULL,
        address VARCHAR2(100) NOT NULL,
        CONSTRAINT university_pk PRIMARY KEY(id)
);

CREATE SEQUENCE  university_seq--sequence 3
MINVALUE 1
START WITH 10
INCREMENT BY 10
CACHE 20; --sequence for university

CREATE OR REPLACE TRIGGER university --trigger 4
    BEFORE INSERT ON university FOR EACH ROW
    BEGIN
        SELECT university_seq.nextval INTO :NEW.id FROM dual;
    end; --university trigger for auto increment

--testing insert, sequence and trigger in the university table
insert into university(NAME,ADDRESS) values('AMERICAN INTERNATIONAL UNIVERSITY-BANGLADESH','Kuraitoli Road,Dhaka 1212') ;
insert into university(NAME,ADDRESS) values('Independent University,Bangladesh','Bashundhara,Dhaka 1229,Bangladesh') ;
insert into university(NAME,ADDRESS) values('North South University','Block B Kuril-NSU Rd,Dhaka 1229') ;
insert into university(NAME,ADDRESS) values('DAFFODIL INTERNATIONAL UNIVERSITY','Sobhanbag,Mirpur Rd,Dhaka 1207') ;
insert into university(NAME,ADDRESS) values('East West University ','A/2 Jahurul Islam Ave,Dhaka 1212') ;
insert into university(NAME,ADDRESS) values('BUP ','DOHS ,Mirpur 12,Dhaka 1212') ;

select * from university; --university table done

CREATE TABLE department( id NUMBER(10) not null, dept_name VARCHAR2(100) NOT NULL,
        university_id NUMBER(10) not null,
        CONSTRAINT department_pk PRIMARY KEY(id),
        CONSTRAINT fk_university FOREIGN KEY(university_id) REFERENCES university(id) );



CREATE  SEQUENCE  department_seq--sequence 4
MINVALUE 1
START WITH 10
INCREMENT BY 10
CACHE 20; --sequence for university



CREATE OR REPLACE TRIGGER department --trigger 4
    BEFORE INSERT ON department FOR EACH ROW
    BEGIN
        SELECT department_seq.nextval INTO :NEW.id FROM dual;
    end; --department trigger for auto increment
--start from here
insert into department(dept_name,university_id) values('CSE',10);
insert into department(dept_name,university_id) values('EEE',10);
insert into department(dept_name,university_id) values('CSE',20);
insert into department(dept_name,university_id) values('EEE',20);
insert into department(dept_name,university_id) values('CSE',30);
insert into department(dept_name,university_id) values('EEE',30);
insert into department(dept_name,university_id) values('EEE',40);
insert into department(dept_name,university_id) values('CSE',40);
insert into department(dept_name,university_id) values('CSE',50);
insert into department(dept_name,university_id) values('EEE',50);

select * from department;
--department table done and working fine
CREATE TABLE faculty (
        id NUMBER(10) NOT NULL,
        name VARCHAR2(100) NOT NULL,
        email VARCHAR2(100) NOT NULL,
        phone VARCHAR2(100) NOT NULL,
        dept_id NUMBER(10) NOT NULL,

        CONSTRAINT faculty_pk PRIMARY KEY(id),
        CONSTRAINT fk_dept_faculty FOREIGN KEY (dept_id) REFERENCES department(id) );

select * from department;
insert into faculty(id,name,email,phone,dept_id) values(1,'Oshim Banerjee','oshim@gmail.com','01655543234',250);
insert into faculty(id,name,email,phone,dept_id) values(2,'Tanvir Khan','tanvir@gmail.com','01612343234',220);
insert into faculty(id,name,email,phone,dept_id) values(3,'Navid Bin Alam','navid@gmail.com','01789943234',230);
insert into faculty(id,name,email,phone,dept_id) values(4,'Zahid','zahid@gmail.com','01988543234',240);
insert into faculty(id,name,email,phone,dept_id) values(5,'Jesmin Nahar','jesmin@gmail.com','01933555433',270);

select * from faculty;
--faculty table done
CREATE TABLE student (
        id NUMBER(10) NOT NULL,
        name VARCHAR2(100) NOT NULL,
        email VARCHAR2(100) NOT NULL,
        phone VARCHAR2(100) NOT NULL,
        dept_id NUMBER(10) NOT NULL,
        admitted_year NUMBER(10) NOT NULL,
        CONSTRAINT student_pk PRIMARY KEY(id),
        CONSTRAINT fk_dept_student FOREIGN KEY (dept_id) REFERENCES department(id) );


insert into student(id,name,email,phone,dept_id,admitted_year) values(35065,'Sizan','sizan@gmail.com','01793862457',220,2017);
insert into student(id,name,email,phone,dept_id,admitted_year) values(35066,'Rezwan','rezwan@gmail.com','01521166553',220,2017);
insert into student(id,name,email,phone,dept_id,admitted_year) values(35067,'Mahtab','mahtab@gmail.com','01734562342',230,2017);
insert into student(id,name,email,phone,dept_id,admitted_year) values(35068,'Rahil','rahil@gmail.com','01976862342',230,2017);
insert into student(id,name,email,phone,dept_id,admitted_year) values(35070,'Mobin','mobin@gmail.com','01623338817',240,2017);
insert into student(id,name,email,phone,dept_id,admitted_year) values(35071,'Asif','asif@gmail.com','01733220099',240,2017);
insert into student(id,name,email,phone,dept_id,admitted_year) values(35072,'Nabil','nabil@gmail.com','01734562311',250,2016);
insert into student(id,name,email,phone,dept_id,admitted_year) values(30001,'Towsif','towsif@gmail.com','01734561232',250,2015);
insert into student(id,name,email,phone,dept_id,admitted_year) values(30012,'Niloy','niloy@gmail.com','01734565435',260,2018);
insert into student(id,name,email,phone,dept_id,admitted_year) values(40100,'Minar','minar@gmail.com','01734561232',260,2017);
insert into student(id,name,email,phone,dept_id,admitted_year) values(40101,'Sajjad','sajjad@gmail.com','01734513232',270,2016);

select * from student;
--student table done

CREATE TABLE technology (
   id NUMBER(10) NOT NULL,
   name VARCHAR2(255) NOT NULL,
   description VARCHAR2(255) NOT NULL,


   CONSTRAINT technology_pk PRIMARY KEY(id)
);

insert into technology(id,name,description) values(1,'Java','Java is a general-purpose programming language that is class-based, object-oriented, and designed to have as few implementation dependencies as possible.');
insert into technology(id,name,description) values(2,'Python','Python is an interpreted, high-level, general-purpose programming language.');
insert into technology(id,name,description) values(3,'JavaScript','JavaScript was developed by Brendan Eich in 1995, which appeared in Netscape, a popular browser of that time. The language was initially called LiveScript and was later renamed JavaScript.');
insert into technology(id,name,description) values(4,'Php','PHP started out as a small open source project that evolved as more and more people found out how useful it was.');
insert into technology(id,name,description) values(5,'C++','C++ is a cross-platformed language that can be used to create sophisticated high-performance applications.');

CREATE TABLE project_student( --relationship table
        id NUMBER(10) NOT NULL,
        project_id NUMBER(10) NOT NULL,
        student_id NUMBER(10) NOT NULL,

        CONSTRAINT project_student_pk PRIMARY KEY(id),
        CONSTRAINT fk_project_student FOREIGN KEY (project_id) REFERENCES project(id),
        CONSTRAINT fk_student_project FOREIGN KEY (student_id) REFERENCES student(id) );

--………...Insert values of project_student………
insert into project_student values(1,1,35065);
insert into project_student values(2,1,35066);
insert into project_student values(3,2,35068);
insert into project_student values(4,2,35071);
insert into project_student values(5,3,35067);
insert into project_student values(6,3,30001);
insert into project_student values(7,4,40101);
insert into project_student values(8,4,40100);
insert into project_student values(9,5,30012);
insert into project_student values(10,5,30001);



CREATE TABLE faculty_project (
        id NUMBER(10) NOT NULL,
        project_id NUMBER(10) NOT NULL,
        faculty_id NUMBER(10) NOT NULL,

   CONSTRAINT faculty_project_pk PRIMARY KEY(id),
   CONSTRAINT fk_project_faculty FOREIGN KEY (project_id) REFERENCES project(id),
   CONSTRAINT fk_faculty_project FOREIGN KEY(faculty_id) REFERENCES faculty(id) );

--…….insert values fro faculty -project….
Insert into faculty_project values(1,2,1);
Insert into faculty_project values(2,1,2);
Insert into faculty_project values(3,3,4);
Insert into faculty_project values(4,4,3);
Insert into faculty_project values(5,5,5);


CREATE TABLE student_thesis (
   id NUMBER(10) NOT NULL,
   thesis_id NUMBER(10) NOT NULL,
   student_id NUMBER(10) NOT NULL,


   CONSTRAINT student_thesis_pk PRIMARY KEY(id),
   CONSTRAINT fk_thesis_student FOREIGN KEY(thesis_id) REFERENCES thesis(id),
   CONSTRAINT fk_student_thesis FOREIGN KEY(student_id) REFERENCES student(id)
);
--…..insert into student_thesis …………...

Insert into student_thesis values(1,1,30001);
Insert into student_thesis values(2,1,35065);
Insert into student_thesis values(3,1,35066);
Insert into student_thesis values(4,2,35068);
Insert into student_thesis values(5,2,35071);
Insert into student_thesis values(6,3,35067);
Insert into student_thesis values(7,3,30001);
Insert into student_thesis values(8,4,40101);
Insert into student_thesis values(9,4,40100);
Insert into student_thesis values(10,5,30012);
Insert into student_thesis values(11,5,35070);

CREATE TABLE faculty_thesis (
   id NUMBER(10) NOT NULL,
   thesis_id NUMBER(10) NOT NULL,
   faculty_id NUMBER(10) NOT NULL,


   CONSTRAINT faculty_thesis_pk PRIMARY KEY(id),
   CONSTRAINT fk_thesis_faculty FOREIGN KEY(thesis_id) REFERENCES thesis(id),
   CONSTRAINT fk_faculty_thesis FOREIGN KEY(faculty_id) REFERENCES faculty(id)
);
--……insert into faculty thesis………..
Insert into faculty_thesis values(1,2,1);
Insert into faculty_thesis values(2,1,2);
Insert into faculty_thesis values(3,3,3);
Insert into faculty_thesis values(4,4,5);
Insert into faculty_thesis values(5,5,4);


CREATE TABLE technology_project (
   id NUMBER(10) NOT NULL,
   technology_id NUMBER(10) NOT NULL,
   project_id NUMBER(10) NOT NULL,

   CONSTRAINT technology_project_pk PRIMARY KEY(id),
   CONSTRAINT fk_technology_project FOREIGN KEY(technology_id) REFERENCES technology(id),
   CONSTRAINT fk_project_technology FOREIGN KEY(project_id) REFERENCES project(id)
);

--…...insert into technology project………
Insert into technology_project  values(1,1,1);
Insert into technology_project  values(2,3,1);
Insert into technology_project  values(3,1,2);
Insert into technology_project  values(4,3,2);
Insert into technology_project  values(5,1,3);
Insert into technology_project  values(6,3,3);

CREATE TABLE technology_thesis (
   id NUMBER(10) NOT NULL,
   technology_id NUMBER(10) NOT NULL,
   thesis_id NUMBER(10) NOT NULL,

   CONSTRAINT technology_thesis_pk PRIMARY KEY(id),
   CONSTRAINT fk_technology_thesis FOREIGN KEY(technology_id) REFERENCES technology(id),
   CONSTRAINT fk_thesis_technology FOREIGN KEY(thesis_id) REFERENCES thesis(id)
);


--….insert into technology_thesis ……
Insert into technology_thesis  values(1,1,1);
Insert into technology_thesis  values(2,3,1);
Insert into technology_thesis  values(3,1,2);
Insert into technology_thesis  values(4,3,2);
Insert into technology_thesis  values(5,1,3);
Insert into technology_thesis  values(6,3,3);



CREATE TABLE competition (
   id NUMBER(10) NOT NULL,
   name varchar2(255) NOT NULL,
   description varchar2(255) NOT NULL,
   year NUMBER(10) NOT NULL,

   CONSTRAINT competition_pk PRIMARY KEY(id) );



insert into competition(id,name,description,year) values(1,'DIU App Contest 2017','The contest will be held on May 19-20, 2017. This is 24 hours long App contest for the undergraduate students of different public & private universities of Bangladesh.',2017);
insert into competition(id,name,description,year) values(2,'AIUB CS FEST','This is an event for both faculties and students of AIUB. Since its advent in 2012, CS Fest has been organized every year by AIUB Computer Club (ACC). It is one of the biggest events that ACC organizes every year.',2018);
insert into competition(id,name,description,year) values(3,'ICPC','The contest represents the geographic area of Bangladesh. The contest is sponsored by -Bangladesh Computer Council(BCC), ICT Division, Bangladesh.',2018);
insert into competition(id,name,description,year) values(4,'SUB ICPC','SUB Inter-University Programming Contest (IUPC) 2019. The State University of Bangladesh (SUB) hosted the BrainCraft Ltd.-SUB Inter-University Programming Contest (IUPC) 2019 on March 9, 2019 at its permanent campus at Kanchan, South Purbachal, Dhaka.',2018);
insert into competition(id,name,description,year) values(5,'Battle of Brains','Battle Of Brains 2019. This is an individual programming contest among students of 1st and 2nd year of the University of Dhaka. There will be exciting prizes for the winners. Its mostly for the students of CSEDU.',2019);


CREATE TABLE competition_project (
   id NUMBER(10) NOT NULL,
   competition_id NUMBER(10) NOT NULL,
   project_id NUMBER(10) NOT NULL,


   CONSTRAINT competition_project_pk PRIMARY KEY(id),
   CONSTRAINT fk_competition_project FOREIGN KEY(competition_id) REFERENCES competition(id),
   CONSTRAINT fk_project_competition FOREIGN KEY(project_id) REFERENCES project(id) );


--……….insert into competition project……


Insert into competition_project  values(1,1,1);
Insert into competition_project  values(2,2,1);
Insert into competition_project  values(3,3,2);
Insert into competition_project  values(4,3,2);
Insert into competition_project  values(5,4,3);
Insert into competition_project  values(6,4,3);


CREATE TABLE competition_thesis (
   id NUMBER(10) NOT NULL,
   competition_id NUMBER(10) NOT NULL,
   thesis_id NUMBER(10) NOT NULL,


   CONSTRAINT competition_thesis_pk PRIMARY KEY(id),
   CONSTRAINT fk_competition_thesis FOREIGN KEY(competition_id) REFERENCES competition(id),
   CONSTRAINT fk_thesis_competition FOREIGN KEY(thesis_id) REFERENCES thesis(id) );

--……...insert into competition thesis…………..
Insert into competition_thesis  values(1,1,1);
Insert into competition_thesis  values(2,2,1);
Insert into competition_thesis  values(3,3,2);
Insert into competition_thesis  values(4,3,2);
Insert into competition_thesis  values(5,4,3);
Insert into competition_thesis  values(6,4,3);

