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
