CREATE OR REPLACE FUNCTION ext.report_eonum(IN eo_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    DECLARE
        rvalue CHARACTER VARYING(9);
        parent_shape BIGINT;
        nbr_subs BIGINT;
        eonum1 BIGINT;
        eonum2 BIGINT;
    BEGIN
        SELECT
            core.eo.eo_num, core.eo.principal_eo_shape_id
            INTO STRICT eonum1, parent_shape
            FROM core.eo
            WHERE core.eo.eo_id = eo_id_arg;

        IF parent_shape IS NULL THEN
            SELECT
                COUNT(eo2.eo_id)
                INTO STRICT nbr_subs
                FROM core.eo AS eo1
                JOIN core.eo AS eo2
                    ON eo1.shape_id = eo2.principal_eo_shape_id
                WHERE eo1.eo_id = eo_id_arg;
            rvalue := oracle.to_char(eonum1);

            IF nbr_subs > 0 THEN
                rvalue := CONCAT_WS('', rvalue, '_0');
            END IF;
        ELSE
            SELECT
                core.eo.eo_num
                INTO STRICT eonum2
                FROM core.eo
                WHERE core.eo.shape_id = parent_shape;
            rvalue := CONCAT_WS('', oracle.to_char(eonum2), '_', oracle.to_char(eonum1));
        END IF;
        RETURN (rvalue);
    END;
END;
$BODY$
LANGUAGE  plpgsql;

