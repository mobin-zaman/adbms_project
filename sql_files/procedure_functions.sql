CREATE OR REPLACE FUNCTION admin_login(u_name admin.username%type, passwd admin.password%type)
return number(10) --return 0 if admin doesn't exist, else return the admin id
is
admin_id NUMBER(10);
BEGIN
    SELECT id INTO admin_id FROM admin WHERE USERNAME=u_name and PASSWORD = passwd;
    if (id == null) then return 0;
    end if;
    return id;
end;


