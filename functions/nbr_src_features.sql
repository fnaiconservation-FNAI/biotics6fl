CREATE OR REPLACE FUNCTION ext.nbr_src_features(IN eo_id_arg BIGINT)
RETURNS BIGINT
AS
$BODY$
BEGIN
    DECLARE
        nbr_srcs BIGINT;
    BEGIN
        SELECT
            COUNT(eosf.eo_shape_id)
            INTO STRICT nbr_srcs
            FROM core.eo
            JOIN core.eo_source_feature AS eosf
                ON eosf.eo_shape_id = core.eo.shape_id
            WHERE core.eo.eo_id = eo_id_arg;
        RETURN (nbr_srcs);
    END;
END;
$BODY$
LANGUAGE  plpgsql;

