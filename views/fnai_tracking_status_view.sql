CREATE OR REPLACE  VIEW ext.fnai_tracking_status_view (element_id, sort_order, element_group, sci_name, formatted_sci_name, comm_name, grank, srank, federal, state, nbr_eors, counties_with_eos, eos_on_mas, mas_with_eos, x_ranks, endemic) AS
SELECT
    est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, sn.scientific_name AS sci_name, sn.formatted_scientific_name AS formatted_sci_name, est.s_primary_common_name AS comm_name, oracle.substr(egt.g_rank, 1, 12) AS grank, oracle.substr(est.s_rank, 1, 12) AS srank,
    CASE
        WHEN ext.federal(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(ext.federal(est.element_subnational_id), 1, 12)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 8)
    END AS state, eos.eo_cnt AS nbr_eors, county_cnt AS counties_with_eos, eo_on_ma_cnt AS eos_on_mas, ma_with_eo_cnt AS mas_with_eos, x_eo_cnt AS x_ranks,
    CASE
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
    END AS endemic
    FROM core.element_global AS egt
    LEFT OUTER JOIN core.element_national AS ent
        ON egt.element_global_id = ent.element_global_id
    LEFT OUTER JOIN core.element_subnational AS est
        ON ent.element_national_id = est.element_national_id
    LEFT OUTER JOIN core.taxon_global AS tg
        ON egt.element_global_id = tg.element_global_id
    LEFT OUTER JOIN core.scientific_name AS sn
        ON est.sname_id = sn.scientific_name_id
    LEFT OUTER JOIN (SELECT
        element_subnational_id, COUNT(DISTINCT (core.eo.eo_id)) AS eo_cnt
        FROM core.eo
        WHERE core.eo.principal_eo_shape_id IS NULL
        GROUP BY element_subnational_id) AS eos
        ON est.element_subnational_id = eos.element_subnational_id
    LEFT OUTER JOIN (SELECT
        element_subnational_id, COUNT(DISTINCT (core.eo.eo_id)) AS x_eo_cnt
        FROM core.eo
        WHERE core.eo.principal_eo_shape_id IS NULL AND core.eo.d_basic_eo_rank_id = 17
        GROUP BY element_subnational_id) AS x_eos
        ON est.element_subnational_id = x_eos.element_subnational_id
    LEFT OUTER JOIN (SELECT
        element_subnational_id, COUNT(DISTINCT (core.eo_county.d_county_id)) AS county_cnt
        FROM core.eo
        LEFT OUTER JOIN core.eo_county
            ON core.eo.eo_id = core.eo_county.eo_id
        WHERE core.eo.principal_eo_shape_id IS NULL
        GROUP BY element_subnational_id) AS counties
        ON est.element_subnational_id = counties.element_subnational_id
    LEFT OUTER JOIN (SELECT
        element_subnational_id, COUNT(DISTINCT (eoma.eo_id)) AS eo_on_ma_cnt
        FROM core.eo
        LEFT OUTER JOIN core.eo_managed_area AS eoma
            ON core.eo.eo_id = eoma.eo_id
        WHERE core.eo.principal_eo_shape_id IS NULL
        GROUP BY element_subnational_id) AS eos_on_mas
        ON est.element_subnational_id = eos_on_mas.element_subnational_id
    LEFT OUTER JOIN (SELECT
        element_subnational_id, COUNT(DISTINCT (eoma.managed_area_id)) AS ma_with_eo_cnt
        FROM core.eo
        LEFT OUTER JOIN core.eo_managed_area AS eoma
            ON core.eo.eo_id = eoma.eo_id
        WHERE core.eo.principal_eo_shape_id IS NULL
        GROUP BY element_subnational_id) AS mas_with_eos
        ON est.element_subnational_id = mas_with_eos.element_subnational_id
    WHERE est.d_eo_track_status_id = 1 AND egt.inactive_ind <> 'Y'
    /* (it's a tracked species, i.e.track all extant and selected historical EOs) */
    /* and est.element_subnational_id = 16946   \* line for testing * / */
    /* and elgroup_sort_order(est.element_subnational_id) = '700' \* line for testing * / */
    /* and rownum < 5  \* line for testing * / */
    ORDER BY sort_order, sci_name;

