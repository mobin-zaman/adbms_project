CREATE OR REPLACE FUNCTION admin_login(u_name admin.username%type, passwd admin.password%type)
return number --return 0 if admin doesn't exist, else return the admin id
is
admin_id NUMBER(10);
BEGIN
    SELECT id INTO admin_id FROM admin WHERE USERNAME=u_name and PASSWORD = passwd;
    RETURN admin_id;
EXCEPTION
    WHEN no_data_found THEN  --exception handling, bonus marks
    RETURN 0;
END;
--CREATE OR REPLACE PROCEDURE insert_facutly(id_ in faculty.id%type, name_ in faculty.name%type, phone_ in faculty.phone%type,department_id_  in faculty.department%type)

select FACULTY.id, FACULTY.name, FACULTY.email, FACULTY.phone , DEPARTMENT.DEPT_NAME, UNIVERSITY.NAME from FACULTY , DEPARTMENT, UNIVERSITY where DEPARTMENT.id = FACULTY.DEPT_ID  and DEPARTMENT.UNIVERSITY_ID=university.id;

CREATE OR REPLACE VIEW facutly_information_view AS
    select FACULTY.id, FACULTY.name, FACULTY.email, FACULTY.phone , DEPARTMENT.DEPT_NAME, UNIVERSITY.NAME as univerity_name
    from FACULTY , DEPARTMENT, UNIVERSITY
    where DEPARTMENT.id = FACULTY.DEPT_ID  and DEPARTMENT.UNIVERSITY_ID=UNIVERSITY.id;

select * from facutly_information_view;

declare
    admin_id number(10);
begin
    admin_id := admin_login('admins','admin');
    DBMS_OUTPUT.PUT_LINE(admin_id);
end;