CREATE OR REPLACE PACKAGE faculty_package AS
    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number);
    PROCEDURE update_faculty(f_id in number, f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number);
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


    FUNCTION check_id_validity(f_id in number) RETURN BOOLEAN IS
        faculty_id number(10);
    BEGIN
        select id into faculty_id from FACULTY where id = f_id;
        return true;
    EXCEPTION
        WHEN no_data_found then
            return false;
    END;


    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, did in number) AS
    BEGIN
        if not (util.department_validity(did)) then
            raise_application_error(-2600, 'department id invalid');
            end if;

            if not (check_email_availabity(f_email)) then
                raise_application_error(-2700, 'faculty email already available');

            end if;

        insert into faculty(name, email, phone, dept_id) values (f_name, f_email, f_phone_number, did);

    end;

    PROCEDURE update_faculty(f_id in number, f_name in varchar2, f_email in varchar2, f_phone_number in number,
                             did in number) AS
    BEGIN
        if not (util.DEPARTMENT_VALIDITY(did)) then
            raise_application_error(-2600, 'department id invalid');

        elsif (check_id_validity(f_id)) then
            raise_application_error(-2800, 'faculty id valid');

        elsif (check_email_availabity(f_email)) then
            raise_application_error(-2700, 'faculty email already available');
        end if;

        update faculty set EMAIL=f_email, PHONE=f_phone_number, NAME=f_name, DEPT_ID=did WHERE id = f_id;

    END;


END faculty_package;