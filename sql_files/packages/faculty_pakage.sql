CREATE OR REPLACE PACKAGE faculty_package AS
    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number);
END faculty_package;


CREATE OR REPLACE PACKAGE BODY faculty_package AS
    --test the procedure
   FUNCTION check_email_availabity(f_email varchar) RETURN BOOLEAN IS
    faculty_id number(10);
    BEGIN
       select id into faculty_id from FACULTY where email = f_email;
       return true;
    EXCEPTION
        WHEN no_data_found THEN
        return false;

    End;

    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number) AS
    BEGIN
        if not (util.department_validity(did)) then
            raise_application_error(-2600, 'department id invalid');

        if not (check_email_availabity(f_email)) then
            raise_application_error(-2700, 'faculty email invalid');
        end if;

        end if;

        insert into faculty(name, email, phone, dept_id) values (f_name, f_email, f_phone_number, did);

    end;

--     PROCEDURE update_faculty(f_id in number, f_email in varchar2, f_phone_number in number, did in number)


    END faculty_package;