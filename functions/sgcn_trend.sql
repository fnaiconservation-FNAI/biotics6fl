CREATE OR REPLACE FUNCTION ext.sgcn_trend(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    status CHARACTER VARYING(50);
    nrecs BIGINT;
BEGIN
    SELECT
        COUNT(stat.el_subnatl_agency_status_id)
        INTO STRICT nrecs
        FROM core.el_subnatl_agency_status AS stat
        WHERE stat.agency_name = 'Fl Fish and Wildlife Conservation Commission, SGCN' AND stat.element_subnational_id = est_id_arg;

    IF nrecs > 0 THEN
        SELECT
            stat.agency_status
            INTO STRICT status
            FROM core.el_subnatl_agency_status AS stat
            WHERE stat.agency_name = 'Fl Fish and Wildlife Conservation Commission, SGCN' AND stat.element_subnational_id = est_id_arg;
        status := oracle.substr(status, oracle.INSTR(status, '/') + 1, LENGTH(status) - oracle.INSTR(status, '/'));
    ELSE
        status := 'N/A';
    END IF;
    RETURN (status);
END;
$BODY$
LANGUAGE  plpgsql;

