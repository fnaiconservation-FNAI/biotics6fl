CREATE OR REPLACE FUNCTION ext.chk_nbr(IN v_nbr TEXT)
RETURNS INTEGER
AS
$BODY$
DECLARE
    v_numero NUMERIC;
BEGIN
    SELECT
        oracle.to_number(v_nbr)
        INTO STRICT v_numero;
    RETURN 1;
    EXCEPTION
        WHEN others THEN
            RETURN 0;
END;
$BODY$
LANGUAGE  plpgsql;

