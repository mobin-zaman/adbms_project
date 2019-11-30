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


declare
    admin_id number(10);
begin
    admin_id := admin_login('admins','admin');
    DBMS_OUTPUT.PUT_LINE(admin_id);
end;