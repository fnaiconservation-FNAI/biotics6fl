CREATE OR REPLACE FUNCTION ext.form_sci_name(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(150);
BEGIN
    SELECT
        TRIM(sn.formatted_scientific_name)
        INTO STRICT name
        FROM core.element_subnational AS est
        JOIN core.scientific_name AS sn
            ON sn.scientific_name_id = est.sname_id
        WHERE est.element_subnational_id = est_id_arg;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;

