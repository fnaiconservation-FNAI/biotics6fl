CREATE OR REPLACE FUNCTION ext.chk_date(IN v_date TEXT)
RETURNS INTEGER
AS
$BODY$
DECLARE
    v_date1 TIMESTAMP(0) WITHOUT TIME ZONE;
BEGIN
    SELECT
        oracle.TO_DATE(v_date::TEXT, 'YYYY-MM-DD')
        INTO STRICT v_date1;
    RETURN 1;
    EXCEPTION
        WHEN others THEN
            RETURN 0;
END;
$BODY$
LANGUAGE  plpgsql;

