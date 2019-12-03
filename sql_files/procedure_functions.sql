--create package for organazing, package for each type of procedure
-- create or replace package packagename as
--procudure insert_dept(param list);
--create replace package body dept_info as
--proocudure dpet_info(param list) is
--begin
--end;
--end;
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
CREATE OR REPLACE PACKAGE util AS
    function department_validity(did number);
    end  util;

CREATE OR REPLACE PACKAGE faculty_package AS
    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, dept_id in number);
END faculty_package;

CREATE PACKAGE BODY faculty_package AS
    PROCEDURE insert_faculty(f_name in varchar2, f_email in varchar2, f_phone_number in number, dept_id in number) IS



