CREATE OR REPLACE FUNCTION ext.grank(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    code CHARACTER VARYING(12);
BEGIN
    SELECT
        egt.g_rank
        INTO STRICT code
        FROM core.element_subnational AS est
        JOIN core.element_national AS ent
            ON ent.element_national_id = est.element_national_id
        JOIN core.element_global AS egt
            ON egt.element_global_id = ent.element_global_id
        WHERE est.element_subnational_id = est_id_arg;
    /* FROM element_subnational est, */
    /* element_national ent, */
    /* element_global egt */
    /* WHERE egt.element_global_id = ent.element_global_id */
    /* and ent.element_national_id = est.element_national_id */
    /* and est.element_subnational_id = est_id_arg; */
    RETURN (code);
END;
$BODY$
LANGUAGE  plpgsql;

