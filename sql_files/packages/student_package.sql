CREATE OR REPLACE PACKAGE student_package AS
    PROCEDURE insert_student(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                             a_year in number);
    PROCEDURE update_student(s_id in number, s_name in varchar2, s_email in varchar2, s_phone_number in number,
                             did in number,
                             a_year in number);
END student_package;

CREATE OR REPLACE PACKAGE BODY student_package AS

    FUNCTION check_email_validity(s_email in varchar2) RETURN BOOLEAN
        IS
        student_id number;
        BEGIN
            select id into student_id from student where email = s_email;
            return false;
        EXCEPTION
            WHEN no_data_found THEN
                return true;
        END;

    FUNCTION check_student_id(s_id in number) RETURN boolean
        is
        student_id number;
            BEGIN
                SELECT ID INTO student_id FROM STUDENT WHERE ID = S_ID;
                return true;

            EXCEPTION
                WHEN no_data_found THEN
                    return false;

            END;


    PROCEDURE insert_student(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                             a_year in number) AS
    BEGIN
        if not util.DEPARTMENT_VALIDITY(did) THEN
            raise_application_error(-2600, 'department id invalid');

        elsif not check_email_validity(s_email) THEN
            raise_application_error(-2700,'email already exists');

        end if;
        insert into STUDENT(email, phone, dept_id, admitted_year) values (s_name, s_email, s_phone_number, did);
    END;

    PROCEDURE update_student(s_id in number, s_name in varchar2, s_email in varchar2, s_phone_number in number,
                             did in number,
                             a_year in number) AS
    BEGIN
       if not util.DEPARTMENT_VALIDITY(did) THEN
            raise_application_error(-2600, 'department id invalid');

        elsif not check_email_validity(s_email) THEN
            raise_application_error(-2700,'email already exists');

        elsif not check_student_id(s_id) THEN
           raise_application_error(-2800,'student id does not exist');

        end if;

       update student set name = s_name, EMAIL=s_email, PHONE=s_phone_number, DEPT_ID=did where id = s_id ;
       END;
END student_package;