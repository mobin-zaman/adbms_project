CREATE OR REPLACE FUNCTION admin_login(u_name admin.username%type, passwd admin.password%type)
    return number --return 0 if admin doesn't exist, else return the admin id
    is
    admin_id NUMBER(10);
BEGIN
    SELECT id INTO admin_id FROM admin WHERE USERNAME = u_name and PASSWORD = passwd;
    RETURN admin_id;
EXCEPTION
    WHEN no_data_found THEN --exception handling, bonus marks
        RETURN 0;
END;

--GET THESIS AND PROJECT NUMBER FOR EACH STUDENT AND FACULTY

CREATE OR REPLACE PACKAGE faculty_package AS
    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number);
    PROCEDURE edit_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number);
END faculty_package;



CREATE OR REPLACE PACKAGE BODY faculty_package AS
    --test the procedure
    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number) AS
    BEGIN
        if not (util.department_validity(did)) then
            raise_application_error(-2600, 'department id invalid');
        end if;

        insert into faculty(name, email, phone, dept_id) values (f_name, f_email, f_phone_number, did);

    end;

    PROCEDURE edit_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number) AS
        faculty_id number(10);
    BEGIN
        faculty_id :=
                check_faculty_validity(f_name, f_email, f_phone_number, did); --TODO: need to check when exception happen in function scope
        update faculty
        set name    = f_name,
            email   = f_email,
            phone   = f_phone_number,
            DEPT_ID = did
        where id = faculty_id;
    END;

    function check_faculty_validity(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number)
        RETURN number
        IS
        faculty_id number(10);
    BEGIN
        select id
        into faculty_id
        from faculty
        where name = f_name
          and email = f_email
          and phone = f_phone_number
          and dept_id = did;
        return faculty_id;
    EXCEPTION
        WHEN no_data_found THEN
            return 0;
    END;
END faculty_package;

CREATE OR REPLACE PACKAGE student_package AS
    PROCEDURE insert_student(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                             a_year in number);
    PROCEDURE update_student(s_id in number,s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                             a_year in number);
END student_package;

CREATE OR REPLACE PACKAGE BODY student_package AS
    PROCEDURE insert_student(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                             a_year in number) AS
    BEGIN
        if not util.DEPARTMENT_VALIDITY(did) THEN
            raise_application_error(-2600, 'department id invalid');
        end if;
        insert into STUDENT(email, phone, dept_id, admitted_year) values (s_name, s_email, s_phone_number, did);
    END;
    PROCEDURE update_student(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number, a_year in number) AS
        student_id  number(10);
        BEGIN
            END;

    FUNCTION check_student_validity(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number, a_year in number)
    return number
    IS
        student_id number(10);
        BEGIN
            select id into student_id from student where NAME=s_name and EMAIL=s_email and PHONE=s_phone_number and DEPT_ID=did and ADMITTED_YEAR = a_year;  --TODO: start from here
            return student_id;
        EXCEPTION
            WHEN no_data_found THEN
            return 0;
        END;

END student_package;


--TODO: how to send out variable to a procedure in python cx_Oracle

--TODO: add function for checking email and phone number validity
CREATE OR
    REPLACE PACKAGE util AS
    function department_validity(did number)
        return boolean;
end util;

CREATE OR REPLACE PACKAGE BODY util AS
    function department_validity(did number)
        RETURN boolean
        IS
        dept_id number(10);
    BEGIN
        SELECT id into dept_id FROM DEPARTMENT WHERE ID = DID;
        return true;
    EXCEPTION
        WHEN no_data_found THEN
            return false;
    END; --what is wrong?
END util;
