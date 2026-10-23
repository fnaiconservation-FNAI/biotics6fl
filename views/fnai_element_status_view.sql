CREATE OR REPLACE  VIEW ext.fnai_element_status_view (form_s_name, s_name, el_group, element_global_id, concept_reference_id, g_con_ref_name, g_classification_com, g_rank, g_rank_review_date, g_rank_change_date, g_rank_resp, g_range_extent, g_range_com, g_aoo, g_aoo_grid_size, g_area_dist_of_occupancy_com, g_number_eos, g_number_eos_com, g_pop_size, g_pop_size_com, g_number_good_eos, g_pct_area_good, g_number_good_eos_com, g_threat_impact, g_threat_com, g_short_term_trend, g_short_term_trend_com, g_long_term_trend, g_long_term_trend_com, g_intrinsic_vulnerability, g_intrinsic_vulnerability_com, g_enviro_specificity, g_enviro_specificity_com, g_other_rank_consid_com, g_number_prot_eos, g_number_prot_eos_com, g_research_needs, g_inventory_needs, g_protection_needs, g_rank_reasons, usesa_status, element_subnational_id, sgcn_num, s_primary_common_name, prim_sname_ref, endemic, s_classification_com, s_rank, s_rank_change_date, s_rank_review_date, s_protection_status, s_range_extent, s_range_com, s_aoo, s_aoo_grid_size, s_area_dist_of_occupancy_com, s_number_eos, s_number_eos_com, s_pop_size, s_pop_size_com, s_number_good_eos, s_pct_area_good, s_number_good_eos_com, s_threat_impact, s_threat_com, s_short_term_trend, s_short_term_trend_com, s_long_term_trend, s_long_term_trend_com, s_intrinsic_vulnerability, s_intrinsic_vulnerability_com, s_enviro_specificity, s_enviro_specificity_com, s_other_rank_consid_com, s_number_prot_eos, s_number_prot_eos_com, s_research_needs, s_inventory_needs, s_protection_needs, s_management_needs, s_rank_reasons, track_status, eo_reps, a, aq, ab, ac, b, bq, bc, bd, c, cq, cd, d, dq, e, f, fq, h, hq, nr, u, x, xq, null_rank) AS
SELECT
    form_s_name, s_name, el_group, element_global_id, concept_reference_id, g_con_ref_name, g_classification_com, g_rank, g_rank_review_date, g_rank_change_date, g_rank_resp, g_range_extent, g_range_com, g_aoo, g_aoo_grid_size, g_area_dist_of_occupancy_com, g_number_eos, g_number_eos_com, g_pop_size, g_pop_size_com, g_number_good_eos, g_pct_area_good, g_number_good_eos_com, g_threat_impact, g_threat_com, g_short_term_trend, g_short_term_trend_com, g_long_term_trend, g_long_term_trend_com, g_intrinsic_vulnerability, g_intrinsic_vulnerability_com, g_enviro_specificity, g_enviro_specificity_com, g_other_rank_consid_com, g_number_prot_eos, g_number_prot_eos_com, g_research_needs, g_inventory_needs, g_protection_needs, g_rank_reasons, usesa_status, element_subnational_id, sgcn_num, s_primary_common_name, prim_sname_ref, endemic, s_classification_com, s_rank, s_rank_change_date, s_rank_review_date, s_protection_status, s_range_extent, s_range_com, s_aoo, s_aoo_grid_size, s_area_dist_of_occupancy_com, s_number_eos, s_number_eos_com, s_pop_size, s_pop_size_com, s_number_good_eos, s_pct_area_good, s_number_good_eos_com, s_threat_impact, s_threat_com, s_short_term_trend, s_short_term_trend_com, s_long_term_trend, s_long_term_trend_com, s_intrinsic_vulnerability, s_intrinsic_vulnerability_com, s_enviro_specificity, s_enviro_specificity_com, s_other_rank_consid_com, s_number_prot_eos, s_number_prot_eos_com, s_research_needs, s_inventory_needs, s_protection_needs, s_management_needs, s_rank_reasons, track_status, eo_reps, a, aq, ab, ac, b, bq, bc, bd, c, cq, cd, d, dq, e, f, fq, h, hq, nr, u, x, xq, null_rank
    FROM (SELECT
        ext.form_sci_name(est.element_subnational_id) AS form_s_name, ext.sci_name(est.element_subnational_id) AS s_name, ext.elgroup_name(est.element_subnational_id) AS el_group,
        /* GLOBAL DETAILS: */
        egt.element_global_id, egt.concept_reference_id, g_con_ref_name.scientific_name AS g_con_ref_name, egt.g_classification_com, egt.g_rank, egt.g_rank_review_date, egt.g_rank_change_date, egt.g_rank_resp, d_range_extent_egr.range_extent_desc AS g_range_extent, ext.crystal_r_new_line(oracle.substr(lob_loc => egr.g_range_com, amount => 4000, "offset" => 1)) AS g_range_com, COALESCE(d_aoo_1km_egr.aoo_1km_desc, d_aoo_4km_egr.aoo_4km_desc) AS g_aoo, d_aoo_grid_size_egr.aoo_grid_size_desc AS g_aoo_grid_size, ext.crystal_r_new_line(egr.g_area_dist_of_occupancy_com) AS g_area_dist_of_occupancy_com, d_number_eos_egr.number_eos_desc AS g_number_eos, ext.crystal_r_new_line(egr.g_number_eos_com) AS g_number_eos_com, d_pop_size_egr.pop_size_desc AS g_pop_size, ext.crystal_r_new_line(egr.g_pop_size_com) AS g_pop_size_com, d_number_good_eos_egr.number_good_eos_desc AS g_number_good_eos, d_aoo_percent_good_egr.aoo_percent_good_desc AS g_pct_area_good, ext.crystal_r_new_line(egr.g_number_good_eos_com) AS g_number_good_eos_com,
        /* THREAT SCOPE, IMMEDIACY, AND SEVERITY ARE DEPRECATED */
        d_threat_impact_assigned_egr.threat_impact_assigned_desc AS g_threat_impact, ext.crystal_r_new_line(oracle.substr(lob_loc => egr.g_threat_com, amount => 4000, "offset" => 1)) AS g_threat_com, d_short_term_trend_egr.short_term_trend_desc AS g_short_term_trend, ext.crystal_r_new_line(egr.g_short_term_trend_com) AS g_short_term_trend_com, d_long_term_trend_egr.long_term_trend_desc AS g_long_term_trend, ext.crystal_r_new_line(egr.g_long_term_trend_com) AS g_long_term_trend_com, d_intrin_vulnerability_egr.intrin_vulnerability_desc AS g_intrinsic_vulnerability, ext.crystal_r_new_line(egr.g_intrinsic_vulnerability_com) AS g_intrinsic_vulnerability_com, d_enviro_specificity_egr.enviro_specificity_desc AS g_enviro_specificity, ext.crystal_r_new_line(egr.g_enviro_specificity_com) AS g_enviro_specificity_com, ext.crystal_r_new_line(oracle.substr(lob_loc => egr.g_other_rank_consid_com, amount => 4000, "offset" => 1)) AS g_other_rank_consid_com, d_number_prot_eos_egr.number_prot_eos_desc AS g_number_prot_eos, ext.crystal_r_new_line(egr.g_number_prot_eos_com) AS g_number_prot_eos_com, oracle.substr(lob_loc => egr.g_research_needs, amount => 4000, "offset" => 1) AS g_research_needs, egr.g_inventory_needs, egr.g_protection_needs, egr.g_rank_reasons, ext.federal(est.element_subnational_id) AS usesa_status,
        /* SUBNATIONAL DETAILS: */
        est.element_subnational_id, sgcn_info.sgcn_num, est.s_primary_common_name, el_s_ref.reference_id AS prim_sname_ref, endemism.endemic, est.s_classification_com, est.s_rank, est.s_rank_change_date, est.s_rank_review_date, est.s_protection_status, d_range_extent_esr.range_extent_desc AS s_range_extent, ext.crystal_r_new_line(oracle.substr(lob_loc => esr.s_range_com, amount => 4000, "offset" => 1)) AS s_range_com, COALESCE(d_aoo_1km_esr.aoo_1km_desc, d_aoo_4km_esr.aoo_4km_desc) AS s_aoo, d_aoo_grid_size_esr.aoo_grid_size_desc AS s_aoo_grid_size, ext.crystal_r_new_line(esr.s_area_dist_of_occupancy_com) AS s_area_dist_of_occupancy_com, d_number_eos_esr.number_eos_desc AS s_number_eos, ext.crystal_r_new_line(esr.s_number_eos_com) AS s_number_eos_com, d_pop_size_esr.pop_size_desc AS s_pop_size, ext.crystal_r_new_line(esr.s_pop_size_com) AS s_pop_size_com, d_number_good_eos_esr.number_good_eos_desc AS s_number_good_eos, d_aoo_percent_good_esr.aoo_percent_good_desc AS s_pct_area_good, ext.crystal_r_new_line(esr.s_number_good_eos_com) AS s_number_good_eos_com,
        /* THREAT SCOPE, IMMEDIACY, AND SEVERITY ARE DEPRECATED */
        d_threat_impact_assigned_esr.threat_impact_assigned_desc AS s_threat_impact, ext.crystal_r_new_line(oracle.substr(lob_loc => esr.s_threat_com, amount => 4000, "offset" => 1)) AS s_threat_com, d_short_term_trend_esr.short_term_trend_desc AS s_short_term_trend, ext.crystal_r_new_line(esr.s_short_term_trend_com) AS s_short_term_trend_com, d_long_term_trend_esr.long_term_trend_desc AS s_long_term_trend, ext.crystal_r_new_line(esr.s_long_term_trend_com) AS s_long_term_trend_com, d_intrin_vulnerability_esr.intrin_vulnerability_desc AS s_intrinsic_vulnerability, ext.crystal_r_new_line(esr.s_intrinsic_vulnerability_com) AS s_intrinsic_vulnerability_com, d_enviro_specificity_esr.enviro_specificity_desc AS s_enviro_specificity, ext.crystal_r_new_line(esr.s_enviro_specificity_com) AS s_enviro_specificity_com, ext.crystal_r_new_line(oracle.substr(lob_loc => esr.s_other_rank_consid_com, amount => 4000, "offset" => 1)) AS s_other_rank_consid_com, d_number_prot_eos_esr.number_prot_eos_desc AS s_number_prot_eos, ext.crystal_r_new_line(esr.s_number_prot_eos_com) AS s_number_prot_eos_com, oracle.substr(lob_loc => esr.s_research_needs, amount => 4000, "offset" => 1) AS s_research_needs, esr.s_inventory_needs, esr.s_protection_needs, esr.s_management_needs,
        CASE
            WHEN est.d_endemism_id = 1 THEN 'Because this element is restricted to Florida, rank-supporting information is recorded at the global level.'
            ELSE esr.s_rank_reasons
        END AS s_rank_reasons, domain.d_eo_track_status.eo_track_status_cd AS track_status,
        /* BIOTICS EO INFO */
        COALESCE(eo_count.eo_reps, 0) AS eo_reps, COALESCE(eo_rank_counts.a, 0) AS a, COALESCE(eo_rank_counts."A?", 0) AS aq, COALESCE(eo_rank_counts.ab, 0) AS ab, COALESCE(eo_rank_counts.ac, 0) AS ac, COALESCE(eo_rank_counts.b, 0) AS b, COALESCE(eo_rank_counts."B?", 0) AS bq, COALESCE(eo_rank_counts.bc, 0) AS bc, COALESCE(eo_rank_counts.bd, 0) AS bd, COALESCE(eo_rank_counts.c, 0) AS c, COALESCE(eo_rank_counts."C?", 0) AS cq, COALESCE(eo_rank_counts.cd, 0) AS cd, COALESCE(eo_rank_counts.d, 0) AS d, COALESCE(eo_rank_counts."D?", 0) AS dq, COALESCE(eo_rank_counts.e, 0) AS e, COALESCE(eo_rank_counts.f, 0) AS f, COALESCE(eo_rank_counts."F?", 0) AS fq, COALESCE(eo_rank_counts.h, 0) AS h, COALESCE(eo_rank_counts."H?", 0) AS hq, COALESCE(eo_rank_counts.nr, 0) AS nr, COALESCE(eo_rank_counts.u, 0) AS u, COALESCE(eo_rank_counts.x, 0) AS x, COALESCE(eo_rank_counts."X?", 0) AS xq, COALESCE(eo_rank_counts."NULL", 0) AS null_rank
        FROM core.element_global AS egt
        LEFT OUTER JOIN core.element_global_rank AS egr
            ON egt.element_global_id = egr.element_global_id
        LEFT OUTER JOIN core.element_national AS ent
            ON egt.element_global_id = ent.element_global_id
        LEFT OUTER JOIN core.element_subnational AS est
            ON ent.element_national_id = est.element_national_id
        LEFT OUTER JOIN core.element_subnatl_rank AS esr
            ON est.element_subnational_id = esr.element_subnational_id
        LEFT OUTER JOIN core.scientific_name AS g_con_ref_name
            ON egt.concept_name_id = g_con_ref_name.scientific_name_id
        LEFT OUTER JOIN core.taxon_global AS tg
            ON egt.element_global_id = tg.element_global_id
        LEFT OUTER JOIN domain.d_eo_track_status
            ON est.d_eo_track_status_id = domain.d_eo_track_status.d_eo_track_status_id
        LEFT OUTER JOIN
        /* d_table Global */
        domain.d_range_extent AS d_range_extent_egr
            ON egr.d_range_extent_id = d_range_extent_egr.d_range_extent_id
        LEFT OUTER JOIN domain.d_aoo_1km AS d_aoo_1km_egr
            ON egr.d_aoo_1km_id = d_aoo_1km_egr.d_aoo_1km_id
        LEFT OUTER JOIN domain.d_aoo_4km AS d_aoo_4km_egr
            ON egr.d_aoo_4km_id = d_aoo_4km_egr.d_aoo_4km_id
        LEFT OUTER JOIN domain.d_aoo_grid_size AS d_aoo_grid_size_egr
            ON egr.d_aoo_grid_size_id = d_aoo_grid_size_egr.d_aoo_grid_size_id
        LEFT OUTER JOIN domain.d_number_eos AS d_number_eos_egr
            ON egr.d_number_eos_id = d_number_eos_egr.d_number_eos_id
        LEFT OUTER JOIN domain.d_pop_size AS d_pop_size_egr
            ON egr.d_pop_size_id = d_pop_size_egr.d_pop_size_id
        LEFT OUTER JOIN domain.d_number_good_eos AS d_number_good_eos_egr
            ON egr.d_number_good_eos_id = d_number_good_eos_egr.d_number_good_eos_id
        LEFT OUTER JOIN domain.d_aoo_percent_good AS d_aoo_percent_good_egr
            ON egr.d_aoo_percent_good_id = d_aoo_percent_good_egr.d_aoo_percent_good_id
        LEFT OUTER JOIN domain.d_threat_impact_assigned AS d_threat_impact_assigned_egr
            ON egr.d_threat_impact_assigned_id = d_threat_impact_assigned_egr.d_threat_impact_assigned_id
        LEFT OUTER JOIN domain.d_short_term_trend AS d_short_term_trend_egr
            ON egr.d_short_term_trend_id = d_short_term_trend_egr.d_short_term_trend_id
        LEFT OUTER JOIN domain.d_long_term_trend AS d_long_term_trend_egr
            ON egr.d_long_term_trend_id = d_long_term_trend_egr.d_long_term_trend_id
        LEFT OUTER JOIN domain.d_intrin_vulnerability AS d_intrin_vulnerability_egr
            ON egr.d_intrin_vulnerability_id = d_intrin_vulnerability_egr.d_intrin_vulnerability_id
        LEFT OUTER JOIN domain.d_enviro_specificity AS d_enviro_specificity_egr
            ON egr.d_enviro_specificity_id = d_enviro_specificity_egr.d_enviro_specificity_id
        LEFT OUTER JOIN domain.d_number_prot_eos AS d_number_prot_eos_egr
            ON egr.d_number_prot_eos_id = d_number_prot_eos_egr.d_number_prot_eos_id
        LEFT OUTER JOIN
        /* d_Tables Subnational */
        domain.d_range_extent AS d_range_extent_esr
            ON esr.d_range_extent_id = d_range_extent_esr.d_range_extent_id
        LEFT OUTER JOIN domain.d_aoo_1km AS d_aoo_1km_esr
            ON esr.d_aoo_1km_id = d_aoo_1km_esr.d_aoo_1km_id
        LEFT OUTER JOIN domain.d_aoo_4km AS d_aoo_4km_esr
            ON esr.d_aoo_4km_id = d_aoo_4km_esr.d_aoo_4km_id
        LEFT OUTER JOIN domain.d_aoo_grid_size AS d_aoo_grid_size_esr
            ON esr.d_aoo_grid_size_id = d_aoo_grid_size_esr.d_aoo_grid_size_id
        LEFT OUTER JOIN domain.d_number_eos AS d_number_eos_esr
            ON esr.d_number_eos_id = d_number_eos_esr.d_number_eos_id
        LEFT OUTER JOIN domain.d_pop_size AS d_pop_size_esr
            ON esr.d_pop_size_id = d_pop_size_esr.d_pop_size_id
        LEFT OUTER JOIN domain.d_number_good_eos AS d_number_good_eos_esr
            ON esr.d_number_good_eos_id = d_number_good_eos_esr.d_number_good_eos_id
        LEFT OUTER JOIN domain.d_aoo_percent_good AS d_aoo_percent_good_esr
            ON esr.d_aoo_percent_good_id = d_aoo_percent_good_esr.d_aoo_percent_good_id
        LEFT OUTER JOIN domain.d_threat_impact_assigned AS d_threat_impact_assigned_esr
            ON esr.d_threat_impact_assigned_id = d_threat_impact_assigned_esr.d_threat_impact_assigned_id
        LEFT OUTER JOIN domain.d_short_term_trend AS d_short_term_trend_esr
            ON esr.d_short_term_trend_id = d_short_term_trend_esr.d_short_term_trend_id
        LEFT OUTER JOIN domain.d_long_term_trend AS d_long_term_trend_esr
            ON esr.d_long_term_trend_id = d_long_term_trend_esr.d_long_term_trend_id
        LEFT OUTER JOIN domain.d_intrin_vulnerability AS d_intrin_vulnerability_esr
            ON esr.d_intrin_vulnerability_id = d_intrin_vulnerability_esr.d_intrin_vulnerability_id
        LEFT OUTER JOIN domain.d_enviro_specificity AS d_enviro_specificity_esr
            ON esr.d_enviro_specificity_id = d_enviro_specificity_esr.d_enviro_specificity_id
        LEFT OUTER JOIN domain.d_number_prot_eos AS d_number_prot_eos_esr
            ON esr.d_number_prot_eos_id = d_number_prot_eos_esr.d_number_prot_eos_id
        LEFT OUTER JOIN (SELECT
            *
            FROM core.element_subnatl_ref
            WHERE primary_scientific_name_ind = 'Y') AS el_s_ref
            ON est.element_subnational_id = el_s_ref.element_subnational_id
        LEFT OUTER JOIN (SELECT
            element_subnational_id, COUNT(eo_id) AS eo_reps
            FROM core.eo
            WHERE core.eo.principal_eo_shape_id IS NULL AND
            /* exclude failed EOs */
            core.eo.shape_id NOT IN (SELECT
                shape_id
                FROM core.shape
                WHERE map_qc_status = 'F') AND core.eo.d_data_qc_status_id <> 3
            GROUP BY element_subnational_id) AS eo_count
            ON est.element_subnational_id = eo_count.element_subnational_id
        LEFT OUTER JOIN (SELECT
            element_subnational_id, MAX(CASE basic_eo_rank_cd
                WHEN 'A' THEN cnt
                ELSE 0
            END) AS a, MAX(CASE basic_eo_rank_cd
                WHEN 'A?' THEN cnt
                ELSE 0
            END) AS "A?", MAX(CASE basic_eo_rank_cd
                WHEN 'AB' THEN cnt
                ELSE 0
            END) AS ab, MAX(CASE basic_eo_rank_cd
                WHEN 'AC' THEN cnt
                ELSE 0
            END) AS ac, MAX(CASE basic_eo_rank_cd
                WHEN 'B' THEN cnt
                ELSE 0
            END) AS b, MAX(CASE basic_eo_rank_cd
                WHEN 'B?' THEN cnt
                ELSE 0
            END) AS "B?", MAX(CASE basic_eo_rank_cd
                WHEN 'BC' THEN cnt
                ELSE 0
            END) AS bc, MAX(CASE basic_eo_rank_cd
                WHEN 'BD' THEN cnt
                ELSE 0
            END) AS bd, MAX(CASE basic_eo_rank_cd
                WHEN 'C' THEN cnt
                ELSE 0
            END) AS c, MAX(CASE basic_eo_rank_cd
                WHEN 'C?' THEN cnt
                ELSE 0
            END) AS "C?", MAX(CASE basic_eo_rank_cd
                WHEN 'CD' THEN cnt
                ELSE 0
            END) AS cd, MAX(CASE basic_eo_rank_cd
                WHEN 'D' THEN cnt
                ELSE 0
            END) AS d, MAX(CASE basic_eo_rank_cd
                WHEN 'D?' THEN cnt
                ELSE 0
            END) AS "D?", MAX(CASE basic_eo_rank_cd
                WHEN 'E' THEN cnt
                ELSE 0
            END) AS e, MAX(CASE basic_eo_rank_cd
                WHEN 'F' THEN cnt
                ELSE 0
            END) AS f, MAX(CASE basic_eo_rank_cd
                WHEN 'F?' THEN cnt
                ELSE 0
            END) AS "F?", MAX(CASE basic_eo_rank_cd
                WHEN 'H' THEN cnt
                ELSE 0
            END) AS h, MAX(CASE basic_eo_rank_cd
                WHEN 'H?' THEN cnt
                ELSE 0
            END) AS "H?", MAX(CASE basic_eo_rank_cd
                WHEN 'NR' THEN cnt
                ELSE 0
            END) AS nr, MAX(CASE basic_eo_rank_cd
                WHEN 'U' THEN cnt
                ELSE 0
            END) AS u, MAX(CASE basic_eo_rank_cd
                WHEN 'X' THEN cnt
                ELSE 0
            END) AS x, MAX(CASE basic_eo_rank_cd
                WHEN 'X?' THEN cnt
                ELSE 0
            END) AS "X?", MAX(CASE
                WHEN basic_eo_rank_cd IS NULL THEN cnt
                ELSE 0
            END) AS "NULL"
            FROM (SELECT
                element_subnational_id, basic_eo_rank_cd, COUNT(*) AS cnt
                FROM core.eo
                LEFT OUTER JOIN domain.d_basic_eo_rank
                    ON core.eo.d_basic_eo_rank_id = domain.d_basic_eo_rank.d_basic_eo_rank_id
                WHERE core.eo.principal_eo_shape_id IS NULL AND
                /* exclude failed EOs */
                core.eo.shape_id NOT IN (SELECT
                    shape_id
                    FROM core.shape
                    WHERE map_qc_status = 'F') AND core.eo.d_data_qc_status_id <> 3
                GROUP BY element_subnational_id, basic_eo_rank_cd) AS var_sbq
            GROUP BY element_subnational_id, ext.sci_name(element_subnational_id)) AS eo_rank_counts
            ON est.element_subnational_id = eo_rank_counts.element_subnational_id
        LEFT OUTER JOIN (SELECT
            est.element_subnational_id,
            CASE
                WHEN (est.d_endemism_id = 1 AND core.taxon_global.d_juris_endem_id = 1) OR /* If designated at both levels as endemic, then yes */ (est.d_endemism_id = 1 AND core.taxon_global.d_juris_endem_id IS NULL) OR /* If designated at one level as endemic and the other is null, then yes */ (est.d_endemism_id IS NULL AND core.taxon_global.d_juris_endem_id = 1) THEN 'Y' /* If designated at one level as endemic and the other is null, then yes */
                WHEN (est.d_endemism_id IS NULL AND core.taxon_global.d_juris_endem_id IS NULL) THEN 'BOTH NULL' /* If both fields are null, then ?nulls */
                WHEN (est.d_endemism_id = 2) THEN 'Probable' /* If subnational level value means probable, then ?probable */
                WHEN (est.d_endemism_id > 2 OR core.taxon_global.d_juris_endem_id > 1) THEN 'N' /* If either one of the fields denote non-endemism, then no */
                ELSE 'Unusual entries, needs QC'
            END AS endemic
            FROM core.element_global AS egt
            LEFT OUTER JOIN core.element_national AS ent
                ON egt.element_global_id = ent.element_global_id
            LEFT OUTER JOIN core.element_subnational AS est
                ON ent.element_national_id = est.element_national_id
            LEFT OUTER JOIN core.taxon_global
                ON egt.element_global_id = core.taxon_global.element_global_id) AS endemism
            ON est.element_subnational_id = endemism.element_subnational_id
        LEFT OUTER JOIN (SELECT
            element_subnational_id, regexp_substr((agency_com)::TEXT, (E'\\d+')::TEXT) AS sgcn_num
            /* ,regexp_substr(AGENCY_NAME, '\d+') as sgcn_dt */
            FROM core.el_subnatl_agency_status AS s
            WHERE s.agency_name LIKE '%SGCN%' AND s.agency_name LIKE '%20%' AND s.agency_name NOT LIKE '%synonym%' AND (SELECT
                oracle.to_number(regexp_substr((s.agency_name)::TEXT, (E'\\d+')::TEXT))) = (SELECT
                MAX((SELECT
                    oracle.to_number(regexp_substr((s2.agency_name)::TEXT, (E'\\d+')::TEXT))))
                FROM core.el_subnatl_agency_status AS s2
                WHERE s2.agency_name LIKE '%SGCN%' AND s2.agency_name LIKE '%20%')) AS sgcn_info
            ON est.element_subnational_id = sgcn_info.element_subnational_id
        WHERE est.element_subnational_id IN (19420, 16080, 18160, 21203, 21612, 22237, 22384, 22296, 23622, 30322, 16105))
    /* sci_name(est.ELEMENT_SUBNATIONAL_ID) in ('Caupolicana electa','Colletes longifacies','Hesperapis oraria','Stelis ater','Euthyonidiella trita','Holothuria parvula','Oculina varicosa') */
    AS var_sbq_2;

