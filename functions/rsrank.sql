CREATE OR REPLACE FUNCTION ext.rsrank(IN p_element_subnational_id BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_rank CHARACTER VARYING(50);
BEGIN
    SELECT
        es.rounded_s_rank
        INTO STRICT v_rank
        FROM core.element_subnational AS es
        WHERE es.element_subnational_id = p_element_subnational_id;
    RETURN v_rank;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN NULL;
END;
$BODY$
LANGUAGE  plpgsql;

