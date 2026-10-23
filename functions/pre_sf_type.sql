CREATE OR REPLACE FUNCTION ext.pre_sf_type(IN sf_id_arg BIGINT)
RETURNS CHARACTER
AS
$BODY$
BEGIN
    DECLARE
        sf_type CHARACTER(2);
    BEGIN
        SELECT
            CASE
                WHEN core.source_feature_pre_pt.source_feature_id IS NOT NULL THEN 'PT'
                WHEN core.source_feature_pre_line.source_feature_id IS NOT NULL THEN 'LN'
                WHEN core.source_feature_pre_poly.source_feature_id IS NOT NULL THEN 'PY'
                ELSE 'NS'
            END AS source_type
            INTO STRICT sf_type
            FROM core.source_feature AS sf
            LEFT OUTER JOIN core.source_feature_pre_pt
                ON sf.source_feature_id = core.source_feature_pre_pt.source_feature_id
            LEFT OUTER JOIN core.source_feature_pre_line
                ON sf.source_feature_id = core.source_feature_pre_line.source_feature_id
            LEFT OUTER JOIN core.source_feature_pre_poly
                ON sf.source_feature_id = core.source_feature_pre_poly.source_feature_id
            WHERE sf.source_feature_id = sf_id_arg;
        RETURN (sf_type);
    END;
END;
$BODY$
LANGUAGE  plpgsql;

