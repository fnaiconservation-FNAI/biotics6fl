CREATE OR REPLACE FUNCTION ext.plant_comm(IN p_element_subnational_id BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_result CHARACTER VARYING(4000);
BEGIN
    SELECT
        STRING_AGG(communities, ', '::TEXT ORDER BY communities)
        INTO STRICT v_result
        FROM (SELECT DISTINCT
            communities
            FROM (SELECT
                INITCAP(shared.dlookup('D_MARINE_HABITAT'::TEXT, d_marine_habitat_id)) AS communities
                FROM core.plant_cas_marine_hab
                WHERE element_subnational_id = p_element_subnational_id
            UNION
            SELECT
                INITCAP(shared.dlookup('D_ESTUARINE_HABITAT'::TEXT, d_estuarine_habitat_id))
                FROM core.plant_cas_estuarine_hab
                WHERE element_subnational_id = p_element_subnational_id
            UNION
            SELECT
                INITCAP(shared.dlookup('D_RIVERINE_HABITAT'::TEXT, d_riverine_habitat_id))
                FROM core.plant_cas_riverine_hab
                WHERE element_subnational_id = p_element_subnational_id
            UNION
            SELECT
                INITCAP(shared.dlookup('D_LACUSTRINE_HABITAT'::TEXT, d_lacustrine_habitat_id))
                FROM core.plant_cas_lacus_hab
                WHERE element_subnational_id = p_element_subnational_id
            UNION
            SELECT
                INITCAP(shared.dlookup('D_PALUSTRINE_HABITAT'::TEXT, d_palustrine_habitat_id))
                FROM core.plant_cas_palus_hab
                WHERE element_subnational_id = p_element_subnational_id
            UNION
            SELECT
                INITCAP(shared.dlookup('D_TERRESTRIAL_HABITAT'::TEXT, d_terrestrial_habitat_id))
                FROM core.plant_cas_terr_hab
                WHERE element_subnational_id = p_element_subnational_id) AS var_sbq) AS var_sbq_2;
    RETURN v_result;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN NULL;
END;
$BODY$
LANGUAGE  plpgsql;

