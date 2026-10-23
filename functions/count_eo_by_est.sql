CREATE OR REPLACE FUNCTION ext.count_eo_by_est(IN p_element_subnational_id BIGINT)
RETURNS BIGINT
AS
$BODY$
DECLARE
    v_count BIGINT := 0;
BEGIN
    SELECT
        COALESCE(COUNT(*), 0)
        INTO STRICT v_count
        FROM core.eo
        WHERE element_subnational_id = p_element_subnational_id;
    RETURN v_count;
END;
$BODY$
LANGUAGE  plpgsql;

