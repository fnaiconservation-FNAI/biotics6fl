CREATE OR REPLACE  VIEW ext.fnai_loc_use (est_id, sci_name, loc_use) AS
SELECT
    est.element_subnational_id AS est_id, ext.sci_name(est.element_subnational_id) AS sci_name,
    /* Use 'Not applicable' for Animal EST without Eo Specs. Nulls default to 'Undetermined' during bulk sf create. Not cool */
    CASE
        WHEN loc_use IS NULL THEN 'Not applicable'
        ELSE loc_use
    END AS loc_use
    FROM core.element_subnational AS est
    LEFT OUTER JOIN (SELECT
        *
        FROM (SELECT DISTINCT
            est_id, loc_use
            FROM (
            /* EGT LOC_USE */
            SELECT DISTINCT
                est.element_subnational_id AS est_id, shared.dlookup('D_LOCATION_USE_CLASS_ID '::TEXT, d_location_use_class_id) AS loc_use
                FROM core.element_global AS egt
                LEFT OUTER JOIN core.element_national AS ent
                    ON egt.element_global_id = ent.element_global_id
                LEFT OUTER JOIN core.element_subnational AS est
                    ON ent.element_national_id = est.element_national_id
                LEFT OUTER JOIN core.eo_specs
                    ON core.eo_specs.element_global_id = egt.element_global_id
                JOIN core.eo_specs_detail
                    ON core.eo_specs_detail.eo_specs_id = core.eo_specs.eo_specs_id
                WHERE est.subnation_id = 12 AND core.eo_specs.eo_specs_id IS NOT NULL AND ext.elgroup_name(est.element_subnational_id) <> 'Plants and Lichens' AND d_location_use_class_id <> 14
            UNION ALL /* Element Group LOC_USE */
            SELECT DISTINCT
                est.element_subnational_id, shared.dlookup('D_LOCATION_USE_CLASS_ID '::TEXT, d_location_use_class_id) AS loc_use
                FROM core.element_global AS egt
                LEFT OUTER JOIN core.element_national AS ent
                    ON egt.element_global_id = ent.element_global_id
                LEFT OUTER JOIN core.element_subnational AS est
                    ON ent.element_national_id = est.element_national_id
                LEFT OUTER JOIN core.element_group_membership AS egm
                    ON egm.element_global_id = egt.element_global_id
                LEFT OUTER JOIN core.element_group AS egp
                    ON egp.element_group_id = egm.element_group_id
                LEFT OUTER JOIN core.eo_specs AS eo_specs2
                    ON eo_specs2.element_group_id = egp.element_group_id
                JOIN core.eo_specs_detail
                    ON core.eo_specs_detail.eo_specs_id = eo_specs2.eo_specs_id
                WHERE est.subnation_id = 12 AND eo_specs2.eo_specs_id IS NOT NULL AND ext.elgroup_name(est.element_subnational_id) <> 'Plants and Lichens' AND d_location_use_class_id <> 14) AS var_sbq
        UNION /* Add 'Undetermined' records when species returns 2 or more LUCs. See ticket [#23731] Location Use Class (LUC) questions */
        SELECT DISTINCT
            est_id, 'Undetermined' AS loc_use
            FROM (SELECT DISTINCT
                est_id, loc_use
                FROM (SELECT DISTINCT
                    est.element_subnational_id AS est_id, shared.dlookup('D_LOCATION_USE_CLASS_ID '::TEXT, d_location_use_class_id) AS loc_use
                    FROM core.element_global AS egt
                    LEFT OUTER JOIN core.element_national AS ent
                        ON egt.element_global_id = ent.element_global_id
                    LEFT OUTER JOIN core.element_subnational AS est
                        ON ent.element_national_id = est.element_national_id
                    LEFT OUTER JOIN core.eo_specs
                        ON core.eo_specs.element_global_id = egt.element_global_id
                    JOIN core.eo_specs_detail
                        ON core.eo_specs_detail.eo_specs_id = core.eo_specs.eo_specs_id
                    WHERE est.subnation_id = 12 AND core.eo_specs.eo_specs_id IS NOT NULL AND ext.elgroup_name(est.element_subnational_id) <> 'Plants and Lichens' AND d_location_use_class_id <> 14
                UNION ALL
                SELECT DISTINCT
                    est.element_subnational_id, shared.dlookup('D_LOCATION_USE_CLASS_ID '::TEXT, d_location_use_class_id) AS loc_use
                    FROM core.element_global AS egt
                    LEFT OUTER JOIN core.element_national AS ent
                        ON egt.element_global_id = ent.element_global_id
                    LEFT OUTER JOIN core.element_subnational AS est
                        ON ent.element_national_id = est.element_national_id
                    LEFT OUTER JOIN core.element_group_membership AS egm
                        ON egm.element_global_id = egt.element_global_id
                    LEFT OUTER JOIN core.element_group AS egp
                        ON egp.element_group_id = egm.element_group_id
                    LEFT OUTER JOIN core.eo_specs AS eo_specs2
                        ON eo_specs2.element_group_id = egp.element_group_id
                    JOIN core.eo_specs_detail
                        ON core.eo_specs_detail.eo_specs_id = eo_specs2.eo_specs_id
                    WHERE est.subnation_id = 12 AND eo_specs2.eo_specs_id IS NOT NULL AND ext.elgroup_name(est.element_subnational_id) <> 'Plants and Lichens' AND d_location_use_class_id <> 14) AS var_sbq_2) AS var_sbq_3
            GROUP BY est_id
            HAVING COUNT(*) >= 2) AS var_sbq_4
        WHERE NOT
        /* NeSmith approved Bird LUC_USE 2025 */
        ((est_id IN (20710, 19213, 22589, 21530, 22609, 22612, 21075, 22711, 17486, 15797, 18331, 21587, 22410, 15263, 21413, 17420, 18177, 20961, 21325, 21145, 22303, 22671, 16690, 21548, 17526, 22455, 22285, 17453, 16890, 18953, 17086, 18212, 15846, 17102, 22297, 21693) AND loc_use NOT IN ('Breeding')) OR (est_id IN (18887) AND loc_use NOT IN ('Breeding', 'Migratory stopover', 'Nonbreeding', 'Undetermined')) OR (est_id IN (18501, 20065, 21685, 22048, 17283, 20484, 19161) AND loc_use NOT IN ('Breeding', 'Nonbreeding', 'Undetermined')) OR (est_id IN (18399) AND loc_use NOT IN ('Breeding', 'Roost', 'Nonbreeding', 'Undetermined')) OR (est_id IN (385207, 20448) AND loc_use NOT IN ('Breeding', 'Nonbreeding', 'Undetermined')) OR (est_id IN (21341, 18728, 19823) AND loc_use NOT IN ('Extinct')) OR (est_id IN (18363) AND loc_use NOT IN ('Migratory stopover')) OR (est_id IN (18271, 31846, 19354, 22242, 18541, 18439, 15243, 22634) AND loc_use NOT IN ('Nonbreeding')) OR (est_id IN (18047, 17977, 21698, 19601, 22211, 18353, 15305, 15365, 21821, 19846, 20912) AND loc_use NOT IN ('Nonmigratory')) OR (est_id IN (19327, 17681, 19400, 17471) AND loc_use NOT IN ('Not applicable')))) AS loc
        ON est.element_subnational_id = loc.est_id
    WHERE ext.elgroup_name(est.element_subnational_id) <> 'Plants and Lichens';

