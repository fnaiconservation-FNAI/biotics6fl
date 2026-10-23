CREATE OR REPLACE FUNCTION ext.trank(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    code CHARACTER VARYING(12);
    trnk CHARACTER VARYING(10);
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
    /* and egt.element_global_id = ent.element_global_id */
    /* and ent.element_national_id = est.element_national_id */
    trnk := '';

    IF (oracle.INSTR(code, 'T', 1, 1)) > 0 THEN
        trnk := oracle.substr(code, oracle.INSTR(code, 'T', 1, 1), 6);
    END IF;
    RETURN (trnk);
END;
$BODY$
LANGUAGE  plpgsql;

