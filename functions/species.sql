CREATE OR REPLACE FUNCTION ext.species(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(80);
    sp1 INTEGER;
    sp2 INTEGER;
BEGIN
    SELECT
        oracle.substr(sn.scientific_name, 1, 80)
        INTO STRICT name
        FROM core.element_subnational AS est
        JOIN core.scientific_name AS sn
            ON sn.scientific_name_id = est.sname_id
        WHERE est.element_subnational_id = est_id_arg;
    sp1 := oracle.INSTR(name, ' ', 1, 1);
    sp2 := oracle.INSTR(name, ' ', 1, 2);

    IF sp2 > 0 THEN
        name := oracle.substr(name, sp1 + 1, sp2 - 1 - sp1);
    END IF;

    IF sp2 = 0 THEN
        name := oracle.substr(name, sp1 + 1, LENGTH(name) - sp1);
    END IF;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;

