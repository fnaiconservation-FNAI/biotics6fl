CREATE OR REPLACE  VIEW ext.bdcs_eo_subset_1_vw (eo_id, elcode_bcd, element_global_id, eo_num, subnation_code, gname, gcomname, g_rank, rounded_g_rank, usesa_cd, usesa_global_interp, usesa_state_interp, usesa_eo_interp, usesa_function, eorank, last_obs_date, rep_accuracy) AS
SELECT
    core.eo.eo_id, egt.elcode_bcd, egt.element_global_id, core.eo.eo_num, sn.subnation_code, gname.scientific_name, egt.g_primary_common_name, egt.g_rank, egt.rounded_g_rank, domain.d_usesa.usesa_cd, tg.interpreted_usesa, ts.state_interpreted_usesa, core.eo.eo_interpreted_usesa_status, shared.eo_usesa(eo_id), eorank.basic_eo_rank_cd, core.eo.last_obs_date, ra.est_rep_accuracy_desc
    FROM core.eo
    INNER JOIN core.shape
        ON core.eo.shape_id = core.shape.shape_id
    INNER JOIN core.element_subnational AS est
        ON core.eo.element_subnational_id = est.element_subnational_id
    INNER JOIN core.element_national AS ent
        ON est.element_national_id = ent.element_national_id
    INNER JOIN core.element_global AS egt
        ON ent.element_global_id = egt.element_global_id
    INNER JOIN core.scientific_name AS gname
        ON egt.gname_id = gname.scientific_name_id
    INNER JOIN domain.subnation AS sn
        ON est.subnation_id = sn.subnation_id
    LEFT OUTER JOIN core.taxon_global AS tg
        ON egt.element_global_id = tg.element_global_id
    LEFT OUTER JOIN domain.d_usesa
        ON tg.d_usesa_id = domain.d_usesa.d_usesa_id
    LEFT OUTER JOIN domain.d_basic_eo_rank AS eorank
        ON core.eo.d_basic_eo_rank_id = eorank.d_basic_eo_rank_id
    LEFT OUTER JOIN core.taxon_subnational AS ts
        ON est.element_subnational_id = ts.element_subnational_id
    LEFT OUTER JOIN domain.d_id_confirmed AS id
        ON core.eo.d_id_confirmed_id = id.d_id_confirmed_id
    LEFT OUTER JOIN domain.d_est_rep_accuracy AS ra
        ON core.eo.d_est_rep_accuracy_id = ra.d_est_rep_accuracy_id
    WHERE egt.inactive_ind = 'N' AND
    /* excludes animal assemblages and other botanical elements */
    gname.d_name_category_id IN (1, 2, 4, 5, 6, 19) AND
    /* excludes sub EOs */
    core.eo.principal_eo_shape_id IS NULL AND
    /* has a GIS record - MAPPABLE */
    core.shape.has_shape_ind = 'Y' AND
    /* not falsely identified criteria */
    (id.id_confirmed_cd <> 'N' OR id.id_confirmed_cd IS NULL) AND
    /* select criteria for BDCS EO subset 1 */
    ((shared.eo_usesa(eo_id) IS NOT NULL) OR ((egt.rounded_g_rank IN ('G1', 'G2')) OR ((egt.rounded_g_rank IN ('T1', 'T2')) AND ((oracle.substr(egt.g_rank, 2, 1) = '1') OR (oracle.substr(egt.g_rank, 2, 1) = '2')))));

