CREATE OR REPLACE FUNCTION ext.county(IN p_element_subnational_id BIGINT, IN p_eo_rank BIGINT DEFAULT 99, IN p_county_occurrence BIGINT DEFAULT 99)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_result CHARACTER VARYING(4000);
BEGIN
    SELECT
        STRING_AGG(county, ', '::TEXT ORDER BY county)
        INTO STRICT v_result
        FROM (SELECT DISTINCT
            core.eo.element_subnational_id, domain.d_county.county_name AS county
            FROM core.eo_county AS c
            INNER JOIN core.eo
                ON core.eo.eo_id = c.eo_id
            JOIN domain.d_county
                ON c.d_county_id = domain.d_county.d_county_id
            WHERE core.eo.element_subnational_id = p_element_subnational_id AND core.eo.d_basic_eo_rank_id <= p_eo_rank
        UNION
        SELECT
            element_subnational_id, domain.d_county.county_name AS county
            FROM core.animal_cas_county
            JOIN domain.d_county
                ON core.animal_cas_county.d_county_id = domain.d_county.d_county_id
            WHERE element_subnational_id = p_element_subnational_id AND d_occurrence_status_id <= p_county_occurrence
        UNION
        SELECT
            element_subnational_id, domain.d_county.county_name AS county
            FROM core.plant_cas_county
            JOIN domain.d_county
                ON core.plant_cas_county.d_county_id = domain.d_county.d_county_id
            WHERE element_subnational_id = p_element_subnational_id AND d_occurrence_status_id <= p_county_occurrence) AS var_sbq
        GROUP BY element_subnational_id;
    RETURN v_result;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN NULL;
END;
$BODY$
LANGUAGE  plpgsql;

