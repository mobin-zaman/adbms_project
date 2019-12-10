CREATE OR REPLACE PACKAGE student_package AS
    PROCEDURE insert_student(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                             a_year in number);
    PROCEDURE update_student(s_id in number, s_name in varchar2, s_email in varchar2, s_phone_number in number,
                             did in number,
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
    PROCEDURE update_student(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                             a_year in number) AS
        student_id number(10);
    BEGIN
    END;

    FUNCTION check_student_validity(s_name in varchar2, s_email in varchar2, s_phone_number in number, did in number,
                                    a_year in number)
        return number
        IS
        student_id number(10);
    BEGIN
        select id
        into student_id
        from student
        where NAME = s_name
          and EMAIL = s_email
          and PHONE = s_phone_number
          and DEPT_ID = did
          and ADMITTED_YEAR = a_year; --TODO: start from here
        return student_id;
    EXCEPTION
        WHEN no_data_found THEN
            return 0;
    END;

END student_package;