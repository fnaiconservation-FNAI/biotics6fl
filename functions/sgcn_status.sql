CREATE OR REPLACE FUNCTION ext.sgcn_status(IN est_id BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_exists INTEGER;
BEGIN
    SELECT
        CASE
            WHEN EXISTS (SELECT
                1
                FROM core.el_subnatl_agency_status
                WHERE agency_status = 'SGCN' AND agency_name LIKE '%2018%' AND element_subnational_id = est_id) THEN 1
            ELSE 0
        END
        INTO STRICT v_exists;

    IF v_exists = 1 THEN
        RETURN 'Y';
    ELSE
        RETURN 'N';
    END IF;
END;
$BODY$
LANGUAGE  plpgsql;

