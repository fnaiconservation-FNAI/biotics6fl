CREATE OR REPLACE FUNCTION ext.lower_comm_name(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(60);
BEGIN
    SELECT
        TRIM(tax.s_lowercase_common_name)
        INTO STRICT name
        FROM ext.taxon_sub_flext1 AS tax
        WHERE tax.element_subnational_id = est_id_arg;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;

