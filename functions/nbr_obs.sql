CREATE OR REPLACE FUNCTION ext.nbr_obs(IN sf_id_arg BIGINT)
RETURNS BIGINT
AS
$BODY$
BEGIN
    DECLARE
        nbr_obs BIGINT;
    BEGIN
        SELECT
            COUNT(obs.source_feature_id)
            INTO STRICT nbr_obs
            FROM core.source_feature AS sf
            LEFT OUTER JOIN core.visit AS obs
                ON sf.source_feature_id = obs.source_feature_id
            WHERE sf.source_feature_id = sf_id_arg;
        RETURN (nbr_obs);
    END;
END;
$BODY$
LANGUAGE  plpgsql;

