CREATE OR REPLACE  VIEW ext.fnai_tracking_status_fullview (element_id, sort_order, element_group, sci_name, comm_name, grank, srank, federal, state, nbr_eors, counties_with_eos, eos_on_mas, mas_with_eos, a_ranks, b_ranks, c_ranks, d_ranks, e_ranks, qe_ranks, x_ranks, not_ranked, endemic) AS
SELECT
    est.element_subnational_id AS element_id, MIN(ext.elgroup_sort_order(est.element_subnational_id)) AS sort_order, MIN(ext.elgroup_name(est.element_subnational_id)) AS element_group,
    /* min(substr(sn.scientific_name,1,50)) sci_name, */
    /* min(substr(est.s_primary_common_name,1,50)) comm_name, */
    MIN(sn.scientific_name) AS sci_name, MIN(est.s_primary_common_name) AS comm_name, MIN(oracle.substr(egt.g_rank, 1, 12)) AS grank, MIN(oracle.substr(est.s_rank, 1, 12)) AS srank,
    /* min(case when est_usesa(est.element_subnational_id) is null then 'N' */
    /* else substr(est_usesa(est.element_subnational_id),1,12) */
    /* end) as federal, */
    MIN(CASE
        WHEN ext.federal(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(ext.federal(est.element_subnational_id), 1, 12)
    END) AS federal, MIN(CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 5)
    END) AS state, COUNT(DISTINCT (core.eo.eo_id)) AS nbr_eors, COUNT(DISTINCT (core.eo_county.d_county_id)) AS counties_with_eos, COUNT(DISTINCT (eoma.eo_id)) AS eos_on_mas, COUNT(DISTINCT (eoma.managed_area_id)) AS mas_with_eos, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', 'eo.d_basic_eo_rank_id in (1,2,3) and eo.element_subnational_id = ', est.element_subnational_id))) AS a_ranks, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', 'eo.d_basic_eo_rank_id in (4,5,6,7) and eo.element_subnational_id = ', est.element_subnational_id))) AS b_ranks, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', 'eo.d_basic_eo_rank_id in (8,9,10,11) and eo.element_subnational_id = ', est.element_subnational_id))) AS c_ranks, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', 'eo.d_basic_eo_rank_id in (12,13) and eo.element_subnational_id = ', est.element_subnational_id))) AS d_ranks, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', 'eo.d_basic_eo_rank_id in (14) and eo.element_subnational_id = ', est.element_subnational_id))) AS e_ranks, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', 'eo.d_basic_eo_rank_id in (15,16,18,19,20) and eo.element_subnational_id = ', est.element_subnational_id))) AS qe_ranks, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', 'eo.d_basic_eo_rank_id = 17 and eo.element_subnational_id = ', est.element_subnational_id))) AS x_ranks, MIN(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id) FROM eo WHERE ', 'eo.principal_eo_shape_id is null and ', '(eo.d_basic_eo_rank_id in (21,22) or eo.d_basic_eo_rank_id is null) ', 'and eo.element_subnational_id = ', est.element_subnational_id))) AS not_ranked, MIN(CASE
        WHEN est.d_endemism_id = 1 THEN 'Y'
        WHEN est.d_endemism_id = 2 THEN 'P'
        WHEN est.d_endemism_id = 3 THEN 'Y(B)'
        WHEN est.d_endemism_id = 4 THEN 'N'
        ELSE
        CASE
            WHEN tg.d_juris_endem_id = 1 THEN 'Y'
            WHEN tg.d_juris_endem_id IN (2, 6) THEN 'Y(B)'
            WHEN tg.d_juris_endem_id IN (3, 4, 5) THEN 'N'
            ELSE 'U'
        END
    END) AS endemic
    FROM core.element_global AS egt, core.scientific_name AS sn, core.element_national AS ent
    LEFT OUTER JOIN core.taxon_global AS tg
        ON (tg.element_global_id = ent.element_global_id), core.element_subnational AS est
    LEFT OUTER JOIN core.eo
        ON (core.eo.element_subnational_id = est.element_subnational_id)
    LEFT OUTER JOIN core.eo_county
        ON (core.eo_county.eo_id = core.eo.eo_id)
    LEFT OUTER JOIN core.eo_managed_area AS eoma
        ON (eoma.eo_id = core.eo.eo_id)
    WHERE core.eo.principal_eo_shape_id IS NULL AND /* include only principal EOs */ est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND est.sname_id = sn.scientific_name_id AND est.d_eo_track_status_id = 1
    /* (it's a tracked species, i.e.track all extant and selected historical EOs) */
    /* and est.element_subnational_id <> 18691   \* line from testing * / */
    /* and elgroup_sort_order(est.element_subnational_id) = '700' \* line from testing * / */
    /* and rownum < 5  \* line from testing * / */
    GROUP BY est.element_subnational_id
    ORDER BY sort_order, sci_name;

