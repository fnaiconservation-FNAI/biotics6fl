CREATE OR REPLACE FUNCTION ext.links(IN est_id BIGINT, IN tbl TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    result CHARACTER VARYING(4000);
    plant_exists BOOLEAN;
    animal_exists BOOLEAN;
    v_plant_count BIGINT;
    v_animal_count BIGINT;
BEGIN
    /* Normalize tbl to uppercase */
    CASE UPPER(COALESCE(tbl, 'EST'))
        WHEN 'EST' THEN
            SELECT
                CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/ElementSubnational/', est_id, '.html" target="_blank">', est_id, '</a>')
                INTO STRICT result;
        WHEN 'ENT' THEN
            SELECT
                CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/ElementNational/', element_national_id, '.html" target="_blank">', element_national_id, '</a>')
                INTO STRICT result
                FROM core.element_subnational
                WHERE element_subnational_id = est_id;
        WHEN 'EGT' THEN
            SELECT
                CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/ElementGlobal/', en.element_global_id, '.html" target="_blank">', en.element_global_id, '</a>')
                INTO STRICT result
                FROM core.element_national AS en
                JOIN core.element_subnational AS es
                    ON en.element_national_id = es.element_national_id
                WHERE es.element_subnational_id = est_id;
        WHEN 'ESR' THEN
            SELECT
                CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/ElementSubnatlRank/', est_id, '.html" target="_blank">ESR</a>')
                INTO STRICT result;
        WHEN 'EO' THEN
            SELECT
                CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', MIN(eo_id), '.html?ek=ElementSubnational_', est_id, '_Eo', CHR(38), 'p=1', CHR(38), 't=', COUNT(*), '" target="_blank">EOR</a>')
                INTO STRICT result
                FROM core.eo
                WHERE element_subnational_id = est_id
                GROUP BY element_subnational_id;
        WHEN 'SF' THEN
            SELECT
                CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', MIN(source_feature_id), '.html?ek=ElementSubnational_', est_id, '_SOURCE_FEATURE', CHR(38), 'p=1', CHR(38), 't=', COUNT(*), '" target="_blank">SF </a>')
                INTO STRICT result
                FROM core.source_feature
                WHERE element_subnational_id = est_id
                GROUP BY element_subnational_id;
        WHEN 'CAS' THEN
            SELECT
                COUNT(*)
                INTO STRICT v_plant_count
                FROM core.plant_cas
                WHERE element_subnational_id = est_id;
            SELECT
                COUNT(*)
                INTO STRICT v_animal_count
                FROM core.animal_cas
                WHERE element_subnational_id = est_id;
            plant_exists := (v_plant_count > 0);
            animal_exists := (v_animal_count > 0);

            IF ext.elgroup_name(est_id) LIKE 'Plant%' AND plant_exists THEN
                result := CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/PlantCas/', est_id, '.html" target="_blank">PlantCAS</a>');
            ELSIF ext.elgroup_name(est_id) NOT LIKE 'Plant%' AND animal_exists THEN
                result := CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/AnimalCas/', est_id, '.html" target="_blank">AnimalCAS</a>');
            ELSE
                result := NULL;
            END IF;
        ELSE
            result := NULL;
    END CASE;
    RETURN result;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN NULL;
        WHEN others THEN
            RETURN CONCAT_WS('', 'Error: ', SQLERRM);
END;
$BODY$
LANGUAGE  plpgsql;

