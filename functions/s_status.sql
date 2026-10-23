CREATE OR REPLACE FUNCTION ext.s_status(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    status CHARACTER VARYING(20) := 'N';
BEGIN
    SELECT
        est.s_protection_status
        INTO STRICT status
        FROM core.element_subnational AS est
        WHERE est.element_subnational_id = est_id_arg;

    IF status IN ('LE', 'FE', 'E') THEN
        status := 'E';
    ELSIF status IN ('LT', 'FT', 'T') THEN
        status := 'T';
    ELSIF status IN ('CE') THEN
        status := 'CE';
    ELSE
        status := 'N';
    END IF;
    RETURN status;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN 'N';
END;
$BODY$
LANGUAGE  plpgsql;

