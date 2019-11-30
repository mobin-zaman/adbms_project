create or replace function deptno_validity(dno dept.deptno%type)
return boolean
is 
count_dept number(10);
Begin
select count(*) into count_dept from dept where deptno=dno;

if count_dept = 0 then 
  return false;
else
  return true;
end if;
end

Declare 
dept_no emp.deptno%type:=:deptno;

Begina
if (deptno_validity(dept_no)) then
 dbms_output.put_line('department exists');
else 
  dbms_output.put_line('department doesnt exist');

end if;
end

create table student (
snum number(10),
sname varchar2(100),
standing number(1),
gpa varchar2(10)
);

create table course (
cnum number(10),
ctitle varchar2(100),
crhr number(10),
standing number(1),
capacity number(10)
);

create table enroll(
eid number(10),
s# number(10),
c# number(10),
grade varchar2(10)
);


create or replace function CheckValidStudent(psnum student.snum%type)
return boolean
is 
count_snum number(10);
begin
select count(*) into count_snum from student where snum=psnum;

if count_snum = 0 then return false;
else return true;
end if;
end;


create or replace function CheckValidCourse(pcnum course.cnum%type)
return boolean
is 
count_cnum number(10);
begin
select count(*) into count_cnum from course where cnum=pcnum;

if count_cnum = 0 then return false;
else return true;
end if;
end;


create or replace function CheckClassCapacity(pcnum course.cnum%type)
return boolean
is 
count_existing_student number(10);
count_course_capacity  number(10);
begin 
select count(*) into count_existing_student from enroll where c#=pcnum;
select capacity INTO count_course_capacity from course where cnum=pcnum;

if count_existing_student < count_course_capacity then return true;
else return false;
end if;
end;

create or replace function CheckStanding(psnum student.snum%type, pcnum course.cnum%type)
return boolean
is
student_standing number(10);
course_standing number(10);

begin
select standing into student_standing from student where snum=psnum;
select standing into course_standing from course where cnum=pcnum;

if student_standing >= course_standing then return true;
else return false;
end if;
end


create or replace function total_credit_hourse(psnum student.snum%type)
return number
is
hour number(10);
total_hour number(10):=0;
cursor c is select c# from enroll where s#=psnum;

begin
for i in c
loop
select crhr into hour from course where cnum=i.c#;
total_hour := total_hour + hour;
end loop;

return total_hour;
end

create or replace function CheckStanding(psnum student.snum%type, pcnum course.cnum%type)
return boolean
is
student_standing number(10);
course_standing number(10);

begin
select standing into student_standing from student where snum=psnum;
select standing into course_standing from course where cnum=pcnum;

if student_standing >= course_standing then return true;
else return false;
end if;
end


create or replace function CheckStanding(psnum student.snum%type, pcnum course.cnum%type)
return boolean
is
student_standing number(10);
course_standing number(10);

begin
select standing into student_standing from student where snum=psnum;
select standing into course_standing from course where cnum=pcnum;

if student_standing >= course_standing then return true;
else return false;
end if;
end

create or replace procedure addCourse( psnum IN student.snum%type ,  pcnum  IN course.cnum%type)

is
grade_status enroll.grade%type;

begin

if (!CheckValidStudent(psnum)) then raise_application_error(-4545,'Invalid Student');
elsif  (!CheckValidCourse(pcnum)) then raise_application_error(-6565,'Invalid Course');
elsif (!CheckStanding(psnum, pcnum)) then raise_application_error(-5676,'Invalid Standing');
elsif  (!CheckClassCapacity(pcnum)) then raise_application_error(-9878,'Capacity Full');
end if;

select grade into grade_status from enroll where s#=psnum and c#=pcnum;

if grade_status != NULL then raise_application_error(-22201,'Already enrolled');
end if;
if total_credit_hourse(psnum) > 15 then raise_application_error(-22202,'Credit Hour Above 15');
end if;

insert into enroll values(null,psnum,pcnum,null);
end


create or replace procedure update_standing
is
cursor c is select snum from student;
total_hours number(10);
begin

for i in c
loop

total_hours:=total_credit_hourse(i.snum);

if total_hours<30 then 
 update student set standing=1 where snum=i.snum;
elsif total_hours<60 then
 update student set standing=2 where snum=i.snum;
elsif total_hours<90 then
 update student set standing=3 where snum=i.snum;
else 
 update student set standing=4 where snum=i.snum;
end if;
end loop;

end


create or replace procedure addCourse( psnum IN student.snum%type ,  pcnum  IN course.cnum%type)

is
grade_status enroll.grade%type;

begin

if not (CheckValidStudent(psnum)) then raise_application_error(-45455,'Invalid Student');
elsif  not (CheckValidCourse(pcnum)) then raise_application_error(-65565,'Invalid Course');
elsif not (CheckStanding(psnum, pcnum)) then raise_application_error(-56576,'Invalid Standing');
elsif  not (CheckClassCapacity(pcnum)) then raise_application_error(-98578,'Capacity Full');
end if;

select grade into grade_status from enroll where s#=psnum and c#=pcnum;

if grade_status != NULL then raise_application_error(-22201,'Already enrolled');
end if;
if total_credit_hourse(psnum) > 15 then raise_application_error(-22202,'Credit Hour Above 15');
end if;

insert into enroll values(null,psnum,pcnum,null);
end


