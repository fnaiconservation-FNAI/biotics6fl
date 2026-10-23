CREATE OR REPLACE  VIEW ext.fnai_eo_spec (element_subnational_id, eo_spec_group, sep_dist_unsuitable_habitat, sep_dist_suitable_habitat) AS
SELECT
    element_subnational_id, eo_spec_group, MIN(sep_dist_unsuitable_habitat) AS sep_dist_unsuitable_habitat, MIN(sep_dist_suitable_habitat) AS sep_dist_suitable_habitat
    /* , MAPPING_GUIDANCE, SEPARATION_BARRIERS, SEPARATION_JUSTIFICATION, MINIMUM_EO_CRITERIA */
    FROM (SELECT
        est.element_subnational_id, eg.element_group_name AS eo_spec_group, sep_dist_unsuitable_habitat, sep_dist_suitable_habitat, mapping_guidance, separation_barriers, separation_justification, minimum_eo_criteria
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        LEFT OUTER JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        LEFT OUTER JOIN core.eo_specs AS es
            ON egt.element_global_id = es.element_global_id
        LEFT OUTER JOIN core.eo_specs_detail AS esd
            ON es.eo_specs_id = esd.eo_specs_id
        LEFT OUTER JOIN core.animal_eo_specs AS aes
            ON esd.eo_specs_detail_id = aes.eo_specs_detail_id
        LEFT OUTER JOIN core.element_group_membership AS egm
            ON egt.element_global_id = egm.element_global_id
        LEFT OUTER JOIN core.element_group AS eg
            ON egm.element_group_id = eg.element_group_id
        WHERE ext.elgroup_name(est.element_subnational_id) NOT LIKE 'Plants%' AND COALESCE(sep_dist_unsuitable_habitat, sep_dist_suitable_habitat) IS NOT NULL
    UNION ALL
    SELECT
        est.element_subnational_id, eg.element_group_name AS eo_spec_group, sep_dist_unsuitable_habitat, sep_dist_suitable_habitat, mapping_guidance, separation_barriers, separation_justification, minimum_eo_criteria
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        LEFT OUTER JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        LEFT OUTER JOIN core.element_group_membership AS egm
            ON egt.element_global_id = egm.element_global_id
        LEFT OUTER JOIN core.element_group AS eg
            ON egm.element_group_id = eg.element_group_id
        LEFT OUTER JOIN core.eo_specs AS es
            ON eg.element_group_id = es.element_group_id
        LEFT OUTER JOIN core.eo_specs_detail AS esd
            ON es.eo_specs_id = esd.eo_specs_id
        LEFT OUTER JOIN core.animal_eo_specs AS aes
            ON esd.eo_specs_detail_id = aes.eo_specs_detail_id
        WHERE ext.elgroup_name(est.element_subnational_id) NOT LIKE 'Plants%' AND COALESCE(sep_dist_unsuitable_habitat, sep_dist_suitable_habitat) IS NOT NULL
    UNION ALL
    SELECT
        est.element_subnational_id, eg.element_group_name AS eo_spec_group, sep_dist_unsuitable_habitat, sep_dist_suitable_habitat, mapping_guidance, separation_barriers, separation_justification, minimum_eo_criteria
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        LEFT OUTER JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        LEFT OUTER JOIN core.eo_specs AS es
            ON egt.element_global_id = es.element_global_id
        LEFT OUTER JOIN core.eo_specs_detail AS esd
            ON es.eo_specs_id = esd.eo_specs_id
        LEFT OUTER JOIN core.plant_eo_specs AS aes
            ON esd.eo_specs_detail_id = aes.eo_specs_detail_id
        LEFT OUTER JOIN core.element_group_membership AS egm
            ON egt.element_global_id = egm.element_global_id
        LEFT OUTER JOIN core.element_group AS eg
            ON egm.element_group_id = eg.element_group_id
        WHERE ext.elgroup_name(est.element_subnational_id) LIKE 'Plants%' AND COALESCE(sep_dist_unsuitable_habitat, sep_dist_suitable_habitat) IS NOT NULL
    UNION ALL
    SELECT
        est.element_subnational_id, eg.element_group_name AS eo_spec_group, sep_dist_unsuitable_habitat, sep_dist_suitable_habitat, mapping_guidance, separation_barriers, separation_justification, minimum_eo_criteria
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        LEFT OUTER JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        LEFT OUTER JOIN core.element_group_membership AS egm
            ON egt.element_global_id = egm.element_global_id
        LEFT OUTER JOIN core.element_group AS eg
            ON egm.element_group_id = eg.element_group_id
        LEFT OUTER JOIN core.eo_specs AS es
            ON eg.element_group_id = es.element_group_id
        LEFT OUTER JOIN core.eo_specs_detail AS esd
            ON es.eo_specs_id = esd.eo_specs_id
        LEFT OUTER JOIN core.plant_eo_specs AS aes
            ON esd.eo_specs_detail_id = aes.eo_specs_detail_id
        WHERE ext.elgroup_name(est.element_subnational_id) LIKE 'Plants%' AND COALESCE(sep_dist_unsuitable_habitat, sep_dist_suitable_habitat) IS NOT NULL) AS var_sbq
    GROUP BY element_subnational_id, eo_spec_group
/* ,MAPPING_GUIDANCE, SEPARATION_BARRIERS, SEPARATION_JUSTIFICATION, MINIMUM_EO_CRITERIA */
;

