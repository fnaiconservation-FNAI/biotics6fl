CREATE OR REPLACE FUNCTION ext.g_comm_name(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(60);
BEGIN
    SELECT
        TRIM(egt.g_primary_common_name)
        INTO STRICT name
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        LEFT OUTER JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        WHERE est.element_subnational_id = est_id_arg;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;

