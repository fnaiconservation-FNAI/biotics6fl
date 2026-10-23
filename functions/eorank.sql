CREATE OR REPLACE FUNCTION ext.eorank(IN eo_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    rvalue CHARACTER VARYING(2);
BEGIN
    SELECT
        dtab.basic_eo_rank_cd
        INTO STRICT rvalue
        FROM core.eo
        JOIN domain.d_basic_eo_rank AS dtab
            ON dtab.d_basic_eo_rank_id = core.eo.d_basic_eo_rank_id AND
            /* FROM eo, d_basic_eo_rank dtab */
            /* WHERE dtab.d_basic_eo_rank_id(+) = eo.d_basic_eo_rank_id */
            core.eo.eo_id = eo_id_arg;
    RETURN (rvalue);
END;
$BODY$
LANGUAGE  plpgsql;

