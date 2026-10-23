CREATE OR REPLACE FUNCTION ext.genus(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(80);
BEGIN
    SELECT
        oracle.substr(sn.scientific_name, 1, 80)
        INTO STRICT name
        FROM core.element_subnational AS est
        JOIN core.scientific_name AS sn
            ON sn.scientific_name_id = est.sname_id AND est.element_subnational_id = est_id_arg;
    name := oracle.substr(name, 1, oracle.INSTR(name, ' ') - 1);
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;

